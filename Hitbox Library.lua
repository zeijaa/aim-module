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

            if (Humanoid and Humanoid.Health > 0 and HumanoidRootPart) then

                HumanoidRootPart.CanCollide = false --// Protection

                HumanoidRootPart.Anchored = false

                HumanoidRootPart.Transparency = Transparency

                HumanoidRootPart.Size = Size

            elseif (Humanoid.Health == 0 or Humanoid.Health < 0) then
                HumanoidRootPart.Size = Vector3.new(2,2,1)
            end
        end
    end
end

function hitboxlibrary:HitboxPlayer(Player, Size, Transparency)
    if (Player and Player.Character) then
        local Character = Player.Character

        local Humanoid = Character:FindFirstChild('Humanoid')

        local HumanoidRootPart = Character:FindFirstChild('HumanoidRootPart')

        if (Humanoid and Humanoid.Health > 0 and HumanoidRootPart) then

            HumanoidRootPart.Massless = false --// Protection

            HumanoidRootPart.CanCollide = false --// Protection

            HumanoidRootPart.Transparency = Transparency

            HumanoidRootPart.Size = Size

        elseif (Humanoid.Health == 0 or Humanoid.Health < 0 or Humanoid == nil) then
            HumanoidRootPart.Size = Vector3.new(2,2,1)
        end
    end
end

function hitboxlibrary:ChangeSize(value)
    hitboxlibrary.Size = value
end

return hitboxlibrary
