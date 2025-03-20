-- Freedom Hub UI with Sidebar & Enhanced Design

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Sidebar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TokenFarmSection = Instance.new("Frame")
local TokenFarmToggle = Instance.new("TextButton")
local ToggleIndicator = Instance.new("Frame")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local enabledTokenAutoFarm = false

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main UI Frame
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.Visible = true
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 105, 180)
MainFrame.BackgroundTransparency = 0.1
MainFrame.ClipsDescendants = true
MainFrame.Active = true

-- Sidebar
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Sidebar.Size = UDim2.new(0, 120, 1, 0)
Sidebar.Position = UDim2.new(0, 0, 0, 0)
Sidebar.BorderSizePixel = 0

-- Title
Title.Parent = Sidebar
Title.Text = "Freedom Hub"
Title.Size = UDim2.new(1, 0, 0.1, 0)
Title.TextColor3 = Color3.fromRGB(255, 105, 180)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

-- Token Farm Section
TokenFarmSection.Parent = MainFrame
TokenFarmSection.Size = UDim2.new(1, -120, 0.3, 0)
TokenFarmSection.Position = UDim2.new(0, 120, 0.3, 0)
TokenFarmSection.BackgroundTransparency = 1

-- Toggle Button (Switch Style)
TokenFarmToggle.Parent = TokenFarmSection
TokenFarmToggle.Text = ""
TokenFarmToggle.Size = UDim2.new(0, 80, 0, 40)
TokenFarmToggle.Position = UDim2.new(0.5, -40, 0.5, -20)
TokenFarmToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TokenFarmToggle.BorderSizePixel = 2
TokenFarmToggle.BorderColor3 = Color3.fromRGB(255, 105, 180)
TokenFarmToggle.AutoButtonColor = false

-- Toggle Indicator (Sliding Circle)
ToggleIndicator.Parent = TokenFarmToggle
ToggleIndicator.Size = UDim2.new(0, 36, 0, 36)
ToggleIndicator.Position = UDim2.new(0, 2, 0, 2)
ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
ToggleIndicator.BorderSizePixel = 0

-- Toggle Function with Smooth Slide Effect
TokenFarmToggle.MouseButton1Click:Connect(function()
    enabledTokenAutoFarm = not enabledTokenAutoFarm
    local newPosition = enabledTokenAutoFarm and UDim2.new(1, -38, 0, 2) or UDim2.new(0, 2, 0, 2)
    local colorGoal = enabledTokenAutoFarm and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(255, 105, 180)
    
    local slideTween = TweenService:Create(ToggleIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = newPosition})
    slideTween:Play()
    
    local colorTween = TweenService:Create(ToggleIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = colorGoal})
    colorTween:Play()
    
    if enabledTokenAutoFarm then
        loadstring([[
            local function TP(Target, Duration)
                local TI = TweenInfo.new(Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                local Tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TI, {CFrame = Target})
                Tween:Play()
                Tween.Completed:Wait()
            end
            
            task.spawn(function()
                if game.Players.LocalPlayer.Character then
                    local OP = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    while task.wait(1) do
                        pcall(function()
                            if game.Players.LocalPlayer.Character then
                                for _, v in workspace.Interactions.SpringTokens:GetChildren() do
                                    if v:GetChildren()[1] then
                                        TP(v.CFrame, 3)
                                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ClaimSpringMeadowsTokenRemote"):InvokeServer(v.Name)     
                                        task.wait(1)
                                        v:Destroy()
                                        TP(OP, 3)
                                        break
                                    end
                                end 
                            end
                        end)
                    end
                end
            end)
        ]])()
    end
end)

-- Load Freedom Hub UI
loadstring(game:HttpGet("https://raw.githubusercontent.com/Friesisverysigma/Freedomhubcos/main/FreedomHub.lua"))()
