local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JukeUI"
ScreenGui.Parent = Players.LocalPlayer.PlayerGui
local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.22, 0, 0.12, 0)
TextButton.Position = UDim2.new(0.4, 0, 0.75, 0)
TextButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TextButton.Text = "Juke (F)"
TextButton.TextScaled = true
TextButton.Font = Enum.Font.GothamBold
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BorderSizePixel = 2
TextButton.Parent = ScreenGui
TextButton.Active = true
TextButton.AutoButtonColor = false
local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 0.3, 0)
TextLabel.Position = UDim2.new(0, 0, 0.75, 0)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "Made by JDarks"
TextLabel.TextScaled = true
TextLabel.Font = Enum.Font.Gotham
TextLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
TextLabel.Parent = TextButton
local TextLabel_2 = Instance.new("TextLabel")
TextLabel_2.Size = UDim2.new(0.3, 0, 0.05, 0)
TextLabel_2.Position = UDim2.new(0.35, 0, 0.65, 0)
TextLabel_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.BackgroundTransparency = 0.3
TextLabel_2.Text = "Nameless Enhancements"
TextLabel_2.TextScaled = true
TextLabel_2.Font = Enum.Font.GothamBold
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.Parent = ScreenGui
task.spawn(function()
task.wait(5)
TextLabel_2:Destroy()
error("timeout")
end)
local Connection = TextButton.InputBegan:Connect(function(Input, GameProcessed)
end)
local Connection_2 = TextButton.InputChanged:Connect(function(Input, GameProcessed)
end)
local Connection_3 = TextButton.MouseButton1Click:Connect(function()
local BodyVelocity = Instance.new("BodyVelocity")
BodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
BodyVelocity.Velocity = Vector3.new(0, 0, 0)
BodyVelocity.Parent = workspace.Football
error("timeout")
end)
local Connection_4 = UserInputService.InputBegan:Connect(function(Input, GameProcessed)
end)
