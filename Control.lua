local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local cameraSubject = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = cameraSubject:WaitForChild("Humanoid")
local HumanoidRootPart = cameraSubject:WaitForChild("HumanoidRootPart")
local CurrentCamera = workspace.CurrentCamera
local Animator = Humanoid:WaitForChild("Animator")
local Animation = Instance.new("Animation")

Animation.AnimationId = "rbxassetid://125865269944406"

local track = Animator:LoadAnimation(Animation)
local ScreenGui = Instance.new("ScreenGui")

ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local TextButton = Instance.new("TextButton")

TextButton.Size = UDim2.new(0.2, 0, 0.1, 0)
TextButton.Position = UDim2.new(0.02, 0, 0.2, 0)
TextButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
TextButton.Text = "Aura Farm"
TextButton.Parent = ScreenGui

local controlZButton = Instance.new("TextButton")

controlZButton.Size = UDim2.new(0.15, 0, 0.08, 0)
controlZButton.Position = UDim2.new(0.1, 0, 0.8, 0)
controlZButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
controlZButton.Text = "Control (Z on pc) "
controlZButton.Parent = ScreenGui

local Frame = Instance.new("Frame")

Frame.Size = UDim2.new(0.3, 0, 0.12, 0)
Frame.Position = UDim2.new(0.35, 0, 0.6, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Visible = false
Frame.Parent = ScreenGui

local TextLabel = Instance.new("TextLabel")

TextLabel.Size = UDim2.new(1, 0, 0.3, 0)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "Speed - 70"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.Parent = Frame

local parent = Instance.new("Frame")

parent.Size = UDim2.new(0.9, 0, 0.4, 0)
parent.Position = UDim2.new(0.05, 0, 0.5, 0)
parent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
parent.Parent = Frame

local frame = Instance.new("Frame")

frame.Size = UDim2.new(0.05, 0, 1, 0)
frame.Position = UDim2.new(0.07, 0, 0, 0)
frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
frame.Parent = parent

local textLabel = Instance.new("TextLabel")

textLabel.Size = UDim2.new(0.3, 0, 0.1, 0)
textLabel.Position = UDim2.new(0.35, 0, 0.35, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "Nameless Enhancements"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextScaled = true
textLabel.Parent = ScreenGui
textLabel.Visible = false

local updateHeartbeatConnectionFlag = false
local visible = false
local updateHeartbeatConnectionNumber = 35
local secondaryParent = nil
local secondaryConnection = nil
local BodyVelocity = nil
local positionNumber = 2.5
local velocityNumber = 70

local function findFirstChild()
	return workspace:FindFirstChild("Football")
end
local function updateHeartbeatConnection()
	if secondaryParent and not visible then
		local sum = 0

		BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.Velocity = Vector3.new(0, 25, 0)
		BodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
		BodyVelocity.Parent = secondaryParent
		secondaryConnection = RunService.Heartbeat:Connect(function(dt)
			if updateHeartbeatConnectionFlag and (secondaryParent and secondaryParent.Parent and not visible) then
				sum = sum + 85 * dt

				local product = math.cos(sum) * 5
				local number = math.sin(sum) * 5

				secondaryParent.Velocity = (Vector3.new(HumanoidRootPart.Position.X + product, updateHeartbeatConnectionNumber + 12, HumanoidRootPart.Position.Z + number) - secondaryParent.Position).unit * 85

				return
			end

			if BodyVelocity then
				BodyVelocity:Destroy()
				BodyVelocity = nil
			end

			if secondaryConnection then
				secondaryConnection:Disconnect()
				secondaryConnection = nil
			end
		end)

		return
	end
end

RunService.Heartbeat:Connect(function()
	if updateHeartbeatConnectionFlag then
		if not (HumanoidRootPart.Position.Y < updateHeartbeatConnectionNumber) then
			HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)

			local MoveDirection = Humanoid.MoveDirection

			if MoveDirection.Magnitude > 0 then
				HumanoidRootPart.Position = HumanoidRootPart.Position + MoveDirection * positionNumber / 10
			end
		else
			HumanoidRootPart.Velocity = Vector3.new(0, 25, 0)
		end
	end
end)

local function createBodyVelocity()
	if secondaryParent then
		if secondaryConnection then
			secondaryConnection:Disconnect()
			secondaryConnection = nil
		end

		if BodyVelocity then
			BodyVelocity:Destroy()
			BodyVelocity = nil
		end

		CurrentCamera.CameraSubject = secondaryParent

		local bodyVelocity = Instance.new("BodyVelocity")

		bodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
		bodyVelocity.Parent = secondaryParent

		local connection = nil

		connection = RunService.Heartbeat:Connect(function()
			if visible and (secondaryParent and secondaryParent.Parent) then
				bodyVelocity.Velocity = CurrentCamera.CFrame.LookVector * velocityNumber

				return
			end

			bodyVelocity:Destroy()
			CurrentCamera.CameraSubject = cameraSubject

			if connection then
				connection:Disconnect()
			end
		end)

		return
	end
end

TextButton.MouseButton1Click:Connect(function()
	if not updateHeartbeatConnectionFlag then
		updateHeartbeatConnectionFlag = true
		TextButton.Text = "off"
		track:Play()
		secondaryParent = findFirstChild()

		if secondaryParent then
			updateHeartbeatConnection()
		end
	else
		updateHeartbeatConnectionFlag = false
		TextButton.Text = "Aura Farm"
		track:Stop()

		if secondaryConnection then
			secondaryConnection:Disconnect()
			secondaryConnection = nil
		end

		if BodyVelocity then
			BodyVelocity:Destroy()
			BodyVelocity = nil
		end
	end
end)
controlZButton.MouseButton1Click:Connect(function()
	if not secondaryParent then
		secondaryParent = findFirstChild()

		if not secondaryParent then
			warn("No Ball Found!")

			return
		end
	end

	visible = not visible
	controlZButton.BackgroundColor3 = visible and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
	Frame.Visible = visible

	if not visible then
		if updateHeartbeatConnectionFlag then
			updateHeartbeatConnection()
		end
	else
		createBodyVelocity()
	end
end)

local flag = false

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		flag = true
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		flag = false
	end
end)
RunService.RenderStepped:Connect(function()
	if flag then
		local X = UserInputService:GetMouseLocation().X
		local AbsolutePositionX = parent.AbsolutePosition.X
		local sum = AbsolutePositionX + parent.AbsoluteSize.X
		local quotient = (X - AbsolutePositionX) / (sum - AbsolutePositionX)

		frame.Position = UDim2.new(math.clamp(quotient, 0, 1) - 0.025, 0, 0, 0)
		velocityNumber = math.floor(10 + quotient * 240)
		TextLabel.Text = "Speed: " .. tostring(velocityNumber)
	end
end)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed then
		if input.KeyCode ~= Enum.KeyCode.Y then
			if input.KeyCode == Enum.KeyCode.Z then
				controlZButton.MouseButton1Click:Fire()
			end
		else
			TextButton.MouseButton1Click:Fire()
		end

		return
	end
end)

local function updatePositionFromInput(guiObject)
	local flag = nil
	local inputPosition = nil
	local position = nil

	guiObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			flag = true
			inputPosition = input.Position
			position = guiObject.Position
		end
	end)
	guiObject.InputChanged:Connect(function(input)
		if flag and input.UserInputType == Enum.UserInputType.MouseMovement then
			local difference = input.Position - inputPosition

			guiObject.Position = UDim2.new(position.X.Scale, position.X.Offset + difference.X, position.Y.Scale, position.Y.Offset + difference.Y)
		end
	end)
	guiObject.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			flag = false
		end
	end)
end

updatePositionFromInput(TextButton)
updatePositionFromInput(controlZButton)
updatePositionFromInput(Frame)
textLabel.Visible = true
wait(2)
textLabel.Visible = false
