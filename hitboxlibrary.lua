local Workspace = cloneref(game:GetService('Workspace'))

local Camera = Workspace.CurrentCamera

local UserInputService = cloneref(game:GetService('UserInputService'))

local Players = cloneref(game:GetService('Players'))

local LocalPlayer = Players.LocalPlayer

local hitboxlibrary = {
    Size = 0
}

hitboxlibrary.__index = hitboxlibrary

function hitboxlibrary:HitboxAll(Size, Transparency)
    for _ , v in next, Players:GetPlayers() do
        if (v ~= LocalPlayer and v and v.Character) then
            local Character = v.Character

            local Humanoid = Character:FindFirstChild('Humanoid')

            local HumanoidRootPart = Character:FindFirstChild('HumanoidRootPart')

            if (Humanoid ~= nil and Humanoid.Health > 0 and HumanoidRootPart ~= nil) then

                HumanoidRootPart.CanCollide = false --// Protection

                HumanoidRootPart.Anchored = false

                HumanoidRootPart.Transparency = Transparency

                HumanoidRootPart.Size = Size
            end
        end
    end
end

function hitboxlibrary:HitboxPlayer(Character, Size, Transparency)
    if (Character) then

        local Character = Character

        local Humanoid = Character:FindFirstChild('Humanoid') or Character:WaitForChild('Humanoid')

        local HumanoidRootPart = Character:FindFirstChild('HumanoidRootPart') or Character:WaitForChild('HumanoidRootPart')

        if (Humanoid ~= nil and Humanoid.Health > 0 and HumanoidRootPart ~= nil) then

            HumanoidRootPart.Massless = false --// Protection

            HumanoidRootPart.CanCollide = false --// Protection

            HumanoidRootPart.Transparency = Transparency

            HumanoidRootPart.Size = Size
        end
    end
end

function hitboxlibrary:ChangeSize(value)
    hitboxlibrary.Size = value
end

return hitboxlibrary
