-- Freedom Hub UI with Token Auto Farm Integration (Enhanced UI with Animations & Styling)

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TokenFarmSection = Instance.new("Frame")
local TokenFarmToggle = Instance.new("TextButton")
local ToggleIndicator = Instance.new("Frame")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local enabledTokenAutoFarm = false

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main UI Frame
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.Size = UDim2.new(0, 400, 0, 300)
Frame.Position = UDim2.new(0.5, -200, 0.5, -150)
Frame.Visible = true
Frame.BorderSizePixel = 2
Frame.BorderColor3 = Color3.fromRGB(255, 105, 180)
Frame.BackgroundTransparency = 0.2
Frame.ClipsDescendants = true
Frame.Active = true

-- UI Fade In Animation
Frame.Size = UDim2.new(0, 0, 0, 0)
local fadeTween = TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 400, 0, 300)})
fadeTween:Play()

-- Title
Title.Parent = Frame
Title.Text = "Freedom Hub"
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.TextColor3 = Color3.fromRGB(255, 105, 180)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

-- Token Farm Section
TokenFarmSection.Parent = Frame
TokenFarmSection.Size = UDim2.new(1, 0, 0.3, 0)
TokenFarmSection.Position = UDim2.new(0, 0, 0.3, 0)
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
TokenFarmToggle.ClipsDescendants = true
TokenFarmToggle.Rounded = true

-- Toggle Indicator (Sliding Circle)
ToggleIndicator.Parent = TokenFarmToggle
ToggleIndicator.Size = UDim2.new(0, 36, 0, 36)
ToggleIndicator.Position = UDim2.new(0, 2, 0, 2)
ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
ToggleIndicator.BorderSizePixel = 0
ToggleIndicator.Rounded = true

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
