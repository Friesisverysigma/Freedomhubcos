local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Credits = Instance.new("TextLabel")
local TokenAutoFarmSection = Instance.new("Frame")
local TokenAutoFarmSwitch = Instance.new("TextButton")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local enabledTokenAutoFarm = false
local uiVisible = true

-- UI Properties
ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 105, 180) -- Hot Pink
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 150)
MainFrame.BackgroundTransparency = 0.1

Title.Parent = MainFrame
Title.Text = "Freedom Hub"
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.TextColor3 = Color3.fromRGB(255, 105, 180) -- Hot Pink
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

Credits.Parent = MainFrame
Credits.Text = "Credits: Cokito"
Credits.Size = UDim2.new(1, 0, 0.1, 0)
Credits.Position = UDim2.new(0, 0, 0.15, 0)
Credits.TextColor3 = Color3.fromRGB(255, 20, 147) -- Deep Pink
Credits.BackgroundTransparency = 1
Credits.Font = Enum.Font.Gotham
Credits.TextScaled = true

-- Token Auto Farm Section
TokenAutoFarmSection.Parent = MainFrame
TokenAutoFarmSection.Size = UDim2.new(1, 0, 0.3, 0)
TokenAutoFarmSection.Position = UDim2.new(0, 0, 0.3, 0)
TokenAutoFarmSection.BackgroundTransparency = 1

TokenAutoFarmSwitch.Parent = TokenAutoFarmSection
TokenAutoFarmSwitch.Text = "Token Auto Farm: OFF"
TokenAutoFarmSwitch.Size = UDim2.new(1, 0, 1, 0)
TokenAutoFarmSwitch.BackgroundColor3 = Color3.fromRGB(255, 105, 180) -- Hot Pink
TokenAutoFarmSwitch.TextColor3 = Color3.fromRGB(0, 0, 0) -- Black
TokenAutoFarmSwitch.Font = Enum.Font.GothamBold
TokenAutoFarmSwitch.TextScaled = true
TokenAutoFarmSwitch.BorderSizePixel = 2
TokenAutoFarmSwitch.BorderColor3 = Color3.fromRGB(255, 20, 147) -- Deep Pink

-- Load Scripts
local function LoadScript(scriptPath)
    local success, err = pcall(function()
        loadstring(readfile(scriptPath))()
    end)
    if not success then
        warn("Error loading script:", err)
    end
end

-- UI Fade In/Out Function
local function ToggleUI()
    uiVisible = not uiVisible
    local transparencyGoal = uiVisible and 0.1 or 1
    local tween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = transparencyGoal})
    tween:Play()
    if not uiVisible then
        task.wait(0.5)
        MainFrame.Visible = false
    else
        MainFrame.Visible = true
    end
end

UIS.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.LeftControl and not gameProcessed then
        ToggleUI()
    end
end)

-- Toggle Functions with Sliding Effect
TokenAutoFarmSwitch.MouseButton1Click:Connect(function()
    enabledTokenAutoFarm = not enabledTokenAutoFarm
    TokenAutoFarmSwitch.Text = "Token Auto Farm: " .. (enabledTokenAutoFarm and "ON" or "OFF")
    local colorGoal = enabledTokenAutoFarm and Color3.fromRGB(255, 20, 147) or Color3.fromRGB(255, 105, 180)
    local tween = TweenService:Create(TokenAutoFarmSwitch, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = colorGoal})
    tween:Play()
    if enabledTokenAutoFarm then
        LoadScript("TokenAutoFarm.lua")
    end
end)
