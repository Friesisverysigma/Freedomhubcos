-- Freedom Hub UI with Token Auto Farm Integration (Enhanced UI)

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
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Size = UDim2.new(0, 350, 0, 250)
Frame.Position = UDim2.new(0.5, -175, 0.5, -125)
Frame.Visible = true
Frame.BorderSizePixel = 2
Frame.BorderColor3 = Color3.fromRGB(255, 105, 180)

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
TokenFarmToggle.Size = UDim2.new(0, 60, 0, 30)
TokenFarmToggle.Position = UDim2.new(0.5, -30, 0.5, -15)
TokenFarmToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
TokenFarmToggle.BorderSizePixel = 2
TokenFarmToggle.BorderColor3 = Color3.fromRGB(255, 105, 180)
TokenFarmToggle.AutoButtonColor = false

-- Toggle Indicator (Sliding Circle)
ToggleIndicator.Parent = TokenFarmToggle
ToggleIndicator.Size = UDim2.new(0, 26, 0, 26)
ToggleIndicator.Position = UDim2.new(0, 2, 0, 2)
ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
ToggleIndicator.BorderSizePixel = 0

-- Toggle Function with Smooth Slide Effect
TokenFarmToggle.MouseButton1Click:Connect(function()
    enabledTokenAutoFarm = not enabledTokenAutoFarm
    local newPosition = enabledTokenAutoFarm and UDim2.new(1, -28, 0, 2) or UDim2.new(0, 2, 0, 2)
    local tween = TweenService:Create(ToggleIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = newPosition})
    tween:Play()
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
