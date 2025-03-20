-- Freedom Hub UI with Token Auto Farm Integration

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TokenFarmButton = Instance.new("TextButton")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.Visible = true

TokenFarmButton.Parent = Frame
TokenFarmButton.Text = "Toggle Token Auto Farm"
TokenFarmButton.Size = UDim2.new(0, 200, 0, 50)
TokenFarmButton.Position = UDim2.new(0.5, -100, 0.5, -25)
TokenFarmButton.BackgroundColor3 = Color3.fromRGB(255, 0, 127)
TokenFarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TokenFarmButton.MouseButton1Click:Connect(function()
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
end)
