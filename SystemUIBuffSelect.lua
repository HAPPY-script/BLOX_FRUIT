local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local gui = player.PlayerGui:WaitForChild("AutoBuffSelectionGui")
-- StarterPlayerScripts / AutoBuffSelection.client.lua
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local gui = player.PlayerGui:WaitForChild("AutoBuffSelectionGui")
local main = gui.Main
local list = main.List
local exec = main.Execution
local closeBtn = main.TitleFrame.Close

-- ================== CONFIG ==================
local TWEEN_TIME = 0.18
local EASING = Enum.EasingStyle.Quad
local EASING_DIR = Enum.EasingDirection.Out

local EXEC_ANCHOR = Vector2.new(0.5, 0)
local EXEC_X = 0.5
local EXEC_FIRST_Y = 0.015
local EXEC_STEP_Y = 0.07

local LIST_ANCHOR = Vector2.new(0, 0)
local LIST_X = 0.02
local LIST_FIRST_Y = 0.02
local LIST_STEP_Y = 0.07

local SELECT_DELAY = 0.1   -- thời gian giữa mỗi lựa chọn trong preset (giây)
local FIND_TIMEOUT = 0.25  -- thời gian retry để tìm nút trước khi báo lỗi (giây)

local UTIL_SHOW_POS = UDim2.new(1.2, 0, 0.55, 0)
local UTIL_HIDE_POS = UDim2.new(1.15, 0, 0.55, 0)
-- ============================================

-- default state
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 2, 0)
main.Visible = false

local busy = false
local isOpen = false

local executionOrder = {}
local originalMeta = {}

-- mapping button -> original index (number)
local originalIndex = {}
local maxOriginalIndex = 0

-- selection control
local selectionToken = 0 -- increments to cancel running presets
local selecting = false

-- presets (tuỳ chỉnh)
local presetMap = {
	["Sword"] = {"HYPER!", "Sword", "Fortress", "Lifesteal", "Armor", "Defense", "Race Meter", "Overflow", "Shadow", "All Cooldowns", "Melee", "Fruit", "Fruit M1 Speed"},
	["Melee"] = {"HYPER!", "Melee", "Fortress", "Lifesteal", "Armor", "Defense", "Race Meter", "Overflow", "Shadow", "All Cooldowns", "Sword", "Fruit", "Fruit M1 Speed"},
	["Fruit"] = {"Fruit M1 Speed", "Fruit", "Fortress", "Lifesteal", "Armor", "Defense", "Race Meter", "Overflow", "Shadow", "All Cooldowns", "Sword", "Melee", "HYPER!"},
}

-- ============ helpers =============
local function trim(s)
	if not s then return "" end
	return (tostring(s):match("^%s*(.-)%s*$") or tostring(s))
end

local function posYKey(btn)
	local p = btn.Position
	return p.Y.Scale + (p.Y.Offset / 100000)
end

-- record original meta for restore if needed
local function record(btn)
	if not originalMeta[btn] then
		originalMeta[btn] = {
			parent = btn.Parent,
			pos = btn.Position,
			anchor = btn.AnchorPoint
		}
	end
end

local function restoreOriginal(btn)
	local m = originalMeta[btn]
	if not m then return end
	btn.Parent = m.parent
	btn.Position = m.pos
	btn.AnchorPoint = m.anchor
end

local function tweenPosition(guiObj, newPos)
	if not guiObj or not guiObj:IsA("GuiObject") then return end
	local info = TweenInfo.new(TWEEN_TIME, EASING, EASING_DIR)
	local ok, t = pcall(function() return TweenService:Create(guiObj, info, {Position = newPos}) end)
	if ok and t then
		t:Play()
	else
		guiObj.Position = newPos
	end
end

-- ============ ordering =============
local function captureOriginalOrder()
	local buttons = {}
	for _, d in ipairs(list:GetDescendants()) do
		if d:IsA("TextButton") then
			table.insert(buttons, d)
		end
	end

	table.sort(buttons, function(a, b)
		local ay = posYKey(a)
		local by = posYKey(b)
		if ay == by then return a.Name < b.Name end
		return ay < by
	end)

	for i, btn in ipairs(buttons) do
		originalIndex[btn] = i
		maxOriginalIndex = math.max(maxOriginalIndex, i)
		btn:SetAttribute("ui_original_index", i)
	end
end

local function getOriginalIndex(btn)
	if originalIndex[btn] then return originalIndex[btn] end
	local attr = btn:GetAttribute("ui_original_index")
	if type(attr) == "number" then
		originalIndex[btn] = attr
		maxOriginalIndex = math.max(maxOriginalIndex, attr)
		return attr
	end
	maxOriginalIndex = maxOriginalIndex + 1
	originalIndex[btn] = maxOriginalIndex
	btn:SetAttribute("ui_original_index", maxOriginalIndex)
	return maxOriginalIndex
end

local function updateExecPos()
	for i, btn in ipairs(executionOrder) do
		btn.AnchorPoint = EXEC_ANCHOR
		local newPos = UDim2.new(EXEC_X, 0, EXEC_FIRST_Y + (i-1)*EXEC_STEP_Y, 0)
		tweenPosition(btn, newPos)
	end
end

local function updateListPos()
	local buttons = {}
	for _, d in ipairs(list:GetDescendants()) do
		if d:IsA("TextButton") then table.insert(buttons, d) end
	end

	for _, btn in ipairs(buttons) do getOriginalIndex(btn) end

	table.sort(buttons, function(a, b)
		local ia = getOriginalIndex(a)
		local ib = getOriginalIndex(b)
		if ia == ib then return a.Name < b.Name end
		return ia < ib
	end)

	for i, btn in ipairs(buttons) do
		btn.AnchorPoint = LIST_ANCHOR
		local newPos = UDim2.new(LIST_X, 0, LIST_FIRST_Y + (i-1)*LIST_STEP_Y, 0)
		tweenPosition(btn, newPos)
	end
end

-- ============ exec operations ============
local function addExec(btn)
	if not btn or not btn:IsA("TextButton") then return end
	record(btn)
	-- remove existing duplicate in executionOrder
	for i, v in ipairs(executionOrder) do
		if v == btn then table.remove(executionOrder, i); break end
	end
	table.insert(executionOrder, btn)
	btn.Parent = exec
	updateListPos()
	updateExecPos()
end

local function removeExec(btn)
	for i, v in ipairs(executionOrder) do
		if v == btn then table.remove(executionOrder, i); break end
	end
	btn.Parent = list
	updateListPos()
	updateExecPos()
end

local function clearAllExec()
	-- copy because removeExec modifies executionOrder
	local copy = {}
	for i, v in ipairs(executionOrder) do copy[i] = v end
	for _, btn in ipairs(copy) do
		if btn and btn.Parent == exec then
			removeExec(btn)
		end
	end
end

-- ============ find/select helpers ============
-- matches check (Text, attribute buff_name, Name), all trimmed + lowercased
local function matchesButton(btn, targetLower)
	if not btn or not btn:IsA("TextButton") then return false end
	local txt = string.lower(trim(btn.Text or ""))
	if txt == targetLower then return true end
	local attr = btn:GetAttribute("buff_name")
	if type(attr) == "string" and string.lower(trim(attr)) == targetLower then return true end
	if string.lower(trim(btn.Name or "")) == targetLower then return true end
	return false
end

-- search descendants of list then exec
local function findButtonByNameAnywhere(name)
	if not name then return nil end
	local target = string.lower(trim(name))
	-- search list descendants first
	for _, d in ipairs(list:GetDescendants()) do
		if matchesButton(d, target) then return d end
	end
	-- then search exec descendants
	for _, d in ipairs(exec:GetDescendants()) do
		if matchesButton(d, target) then return d end
	end
	return nil
end

-- retry find with timeout (returns button or nil)
local function findButtonWithRetry(name, timeout)
	local deadline = tick() + (timeout or FIND_TIMEOUT)
	while tick() <= deadline do
		local btn = findButtonByNameAnywhere(name)
		if btn then return btn end
		task.wait(0.02)
	end
	return nil
end

local function selectBuff(name)
	local btn = findButtonWithRetry(name, FIND_TIMEOUT)
	if not btn then
		-- debug list of available buttons for easier diagnosis
		local available = {}
		for _, d in ipairs(list:GetDescendants()) do
			if d:IsA("TextButton") then table.insert(available, trim(d.Text or d.Name or "")) end
		end
		for _, d in ipairs(exec:GetDescendants()) do
			if d:IsA("TextButton") then table.insert(available, trim(d.Text or d.Name or "")) end
		end
		warn(("[AutoSelect] Can't find '%s' (after %.2fs). Available: %s"):format(tostring(name), FIND_TIMEOUT, table.concat(available, ", ")))
		return false
	end

	-- if already in exec or descendant of exec, consider selected
	if btn.Parent == exec or btn:IsDescendantOf(exec) then
		return true
	end

	addExec(btn)
	return true
end

-- ============ preset logic ============
local function selectPreset(presetName)
	local preset = presetMap[presetName]
	if not preset then
		warn("[AutoSelect] selectPreset: preset not found:", tostring(presetName))
		return
	end

	selectionToken = selectionToken + 1
	local myToken = selectionToken
	selecting = true

	-- reset exec then allow a short frame to settle
	clearAllExec()
	task.wait(0.03)

	for i, buffName in ipairs(preset) do
		if myToken ~= selectionToken then
			selecting = false
			return
		end

		local ok = selectBuff(buffName)
		if not ok then
			warn(("[AutoSelect] Buff '%s' not found while applying preset '%s' (step %d)"):format(buffName, presetName, i))
		end

		-- short cancelable wait
		local waited = 0
		while waited < SELECT_DELAY do
			if myToken ~= selectionToken then
				selecting = false
				return
			end
			local dt = task.wait(0.02)
			waited = waited + (dt or 0.02)
		end
	end

	selecting = false
end

-- expose globally if needed
_G.selectBuff = selectBuff
_G.selectPreset = selectPreset

-- ============ attach logic ============
local function attach(btn)
	if not btn or not btn:IsA("TextButton") or btn:GetAttribute("ui_attached") then return end
	btn:SetAttribute("ui_attached", true)
	record(btn)
	if btn:IsDescendantOf(list) then
		getOriginalIndex(btn)
	end

	btn.MouseButton1Click:Connect(function()
		if busy or not main.Visible then return end
		-- cancel any running preset
		selectionToken = selectionToken + 1
		selecting = false

		if btn:IsDescendantOf(exec) then
			removeExec(btn)
		else
			addExec(btn)
		end
	end)
end

-- attach existing descendants
task.defer(function()
	RunService.Heartbeat:Wait()
	captureOriginalOrder()
	for _, d in ipairs(list:GetDescendants()) do if d:IsA("TextButton") then attach(d) end end
	for _, d in ipairs(exec:GetDescendants()) do if d:IsA("TextButton") then attach(d) end end
	updateListPos()
	updateExecPos()
end)

-- handle dynamically added buttons anywhere under list/exec
list.DescendantAdded:Connect(function(d)
	if d:IsA("TextButton") then
		attach(d)
		getOriginalIndex(d)
		updateListPos()
	end
end)
exec.DescendantAdded:Connect(function(d)
	if d:IsA("TextButton") then
		attach(d)
		updateExecPos()
		updateListPos()
	end
end)

-- handle removals to relayout
list.DescendantRemoving:Connect(function()
	updateListPos()
end)
exec.DescendantRemoving:Connect(function()
	updateExecPos()
	updateListPos()
end)

-- ============ AutoSelectFrame wiring ============
local utilitiesBtn = main.TitleFrame:FindFirstChild("Utilities")
local autoSelectFrame = main:FindFirstChild("AutoSelectFrame")
local statusLabel = autoSelectFrame and autoSelectFrame:FindFirstChild("StatusLabel")

local utilBusy = false
local utilOpen = false

local function openUtilities()
	if utilBusy or utilOpen then return end
	utilBusy = true

	autoSelectFrame.Position = UTIL_HIDE_POS
	autoSelectFrame.Visible = true

	local t = TweenService:Create(
		autoSelectFrame,
		TweenInfo.new(TWEEN_TIME, EASING, EASING_DIR),
		{Position = UTIL_SHOW_POS}
	)
	t:Play()
	t.Completed:Wait()

	utilOpen = true
	utilBusy = false
end

local function closeUtilities()
	if utilBusy or not utilOpen then return end
	utilBusy = true

	local t = TweenService:Create(
		autoSelectFrame,
		TweenInfo.new(TWEEN_TIME, EASING, EASING_DIR),
		{Position = UTIL_HIDE_POS}
	)
	t:Play()
	t.Completed:Wait()

	autoSelectFrame.Visible = false
	utilOpen = false
	utilBusy = false
end

local function setAutoSelectButtonsEnabled(enabled)
	if not autoSelectFrame then return end
	for _, child in ipairs(autoSelectFrame:GetDescendants()) do
		if child:IsA("TextButton") then
			child.AutoButtonColor = enabled
			child.Active = enabled
			child.ZIndex = enabled and 1 or 0
		end
	end
end

local function updateStatus(text)
	if statusLabel and statusLabel:IsA("TextLabel") then
		statusLabel.Text = tostring(text or "")
	end
end

if utilitiesBtn and autoSelectFrame then
	utilitiesBtn.MouseButton1Click:Connect(function()
		if utilOpen then
			closeUtilities()
		else
			openUtilities()
		end
	end)
end

if autoSelectFrame then
	for _, child in ipairs(autoSelectFrame:GetDescendants()) do
		if child:IsA("TextButton") then
			child.MouseButton1Click:Connect(function()
				-- determine preset key: priority Name -> Text -> case-insensitive match
				local key = nil
				if presetMap[child.Name] then
					key = child.Name
				else
					local t = trim(child.Text or "")
					for k,_ in pairs(presetMap) do
						if string.lower(k) == string.lower(t) or string.lower(k) == string.lower(child.Name or "") then
							key = k
							break
						end
					end
				end

				if not key then
					warn("[AutoSelect] No preset found for button '" .. child.Name .. "' / '" .. tostring(child.Text) .. "'")
					updateStatus("Preset not found: "..tostring(child.Text or child.Name))
					return
				end

				-- start preset selection (cancels any running selection)
				selectionToken = selectionToken + 1
				local myToken = selectionToken

				setAutoSelectButtonsEnabled(false)
				updateStatus("Applying "..key.."...")

				-- clear exec and give short time for GUI to settle
				clearAllExec()
				task.wait(0.03)

				-- apply
				local preset = presetMap[key]
				for i, buffName in ipairs(preset) do
					if myToken ~= selectionToken then
						updateStatus("Cancelled")
						setAutoSelectButtonsEnabled(true)
						return
					end

					local ok = selectBuff(buffName)
					if not ok then
						warn(("[AutoSelect] Buff '%s' not found while applying preset '%s' (step %d)"):format(buffName, key, i))
					end

					updateStatus(("Applying %s (%d/%d)"):format(buffName, i, #preset))

					local waited = 0
					while waited < SELECT_DELAY do
						if myToken ~= selectionToken then
							updateStatus("Cancelled")
							setAutoSelectButtonsEnabled(true)
							return
						end
						local dt = task.wait(0.02)
						waited = waited + (dt or 0.02)
					end
				end

				updateStatus("Done: "..key)
				setAutoSelectButtonsEnabled(true)
				task.delay(1.0, function()
					if myToken == selectionToken then updateStatus("") end
				end)
			end)
		end
	end
end

-- ============ open / close ============
local function openMain()
	if busy or isOpen then return end
	busy = true
	main.Visible = true
	main.Position = UDim2.new(0.5, 0, 2, 0)
	TweenService:Create(main, TweenInfo.new(TWEEN_TIME, EASING, EASING_DIR), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
	task.wait(TWEEN_TIME)
	isOpen = true
	busy = false
	updateListPos()
	updateExecPos()
end

local function closeMain()
	if busy or not isOpen then return end
	busy = true
	TweenService:Create(main, TweenInfo.new(TWEEN_TIME, EASING, EASING_DIR), {Position = UDim2.new(0.5, 0, 2, 0)}):Play()
	task.wait(TWEEN_TIME)
	main.Visible = false
	isOpen = false
	busy = false
end

closeBtn.MouseButton1Click:Connect(closeMain)

_G.ToggleBuffUI = function()
	if isOpen then closeMain() else openMain() end
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ev = ReplicatedStorage:FindFirstChild("BuffUIEvent") or Instance.new("BindableEvent", ReplicatedStorage)
ev.Name = "BuffUIEvent"
ev.Event:Connect(function(action)
	if action == "open" then openMain()
	elseif action == "close" then closeMain()
	elseif action == "toggle" then if isOpen then closeMain() else openMain() end end
end)

-- initial layout pass
updateListPos()
updateExecPos()

--[[
game.ReplicatedStorage.BuffUIEvent:Fire("open")
game.ReplicatedStorage.BuffUIEvent:Fire("close")
game.ReplicatedStorage.BuffUIEvent:Fire("toggle")
]]
