local Workspace = cloneref(game:GetService('Workspace'))

local Camera = Workspace.CurrentCamera

local UserInputService = cloneref(game:GetService('UserInputService'))

local Players = cloneref(game:GetService('Players'))

local LocalPlayer = Players.LocalPlayer

local library = {
    Unloaded_State = false,

    Horozontal_Prediction = 0,

    Vertical_Prediction = 0,
}

library.__index = library

local Configuration = {

    Mode = 'Mouse',

    TweenTime = 1, 

    Radius = 90,

    Aim_Parts = {
        "Head",
        "UpperTorso",
        "LowerTorso",
        "HumanoidRootPart",
        "RightUpperArm",
        "LeftUpperArm",
        "LeftLowerArm",
        "RightLowerArm",
        "LeftHand",
        "RightHand",
        "RightUpperLeg",
        "LeftUpperLeg",
        "RightLowerLeg",
        "LeftLowerLeg",
        "RightFoot",
        "LeftFoot",
    }
}

Configuration.__index = Configuration

local Circle = nil

function library:Mode(value)
    if (value == 'Mouse') then
        return 'Mouse'
    elseif (value == 'Camera') then
        return 'Camera'
    elseif (value == 'Auto') then
        return 'Auto'
    end
end

function library:TweenTime(value)
    Configuration.TweenTime = value
    return value
end

function library:DrawCircle(Radius, Sides, Transparency, Filled, Color)
    if (Circle == Drawing.new('Circle')) then
        Circle:Remove()
    end

    Circle = Drawing.new('Circle')

    Circle.Visible = true

    Circle.Transparency = Transparency

    Circle.Radius = Radius

    Circle.NumSides = Sides

    Circle.Filled = Filled

    Circle.Color = Color

    Configuration.Radius = Radius
end

function library:UpdateCirclePosition()
    local Mouse_Pos = UserInputService:GetMouseLocation()

    Circle.Position = Mouse_Pos
end
function library:MoveMouse(value)
    mousemoverel(value, value)
    print(value)
end

function library:GetClosestPlayer(TeamCheck)

    local Mouse_Position = UserInputService:GetMouseLocation()

    local Distance = math.huge

    local ClosestPlayer = nil

    pcall(function()
        for _ , value in next, Players:GetPlayers() do
            if (value ~= LocalPlayer and value ~= nil and value.Character ~= nil) then
    
                local Character = value.Character
    
                local Humanoid = Character:FindFirstChild('Humanoid')
    
                local HumanoidRootPart = Character:FindFirstChild('HumanoidRootPart')
    
                if (TeamCheck) then
    
                    if (value.TeamColor ~= LocalPlayer.TeamColor) then
            
                        if (Humanoid and Humanoid.Health >= 0 and HumanoidRootPart) then
            
                            local Vector, OnScreen = Camera:WorldToViewportPoint(HumanoidRootPart.Position)
            
                            if (OnScreen) then
                                local Magnitude = (Mouse_Position - Vector2.new(Vector.X, Vector.Y)).Magnitude
            
                                if (Magnitude < Distance and Magnitude < Configuration.Radius) then
                                    Distance = Magnitude
            
                                    ClosestPlayer = value
                                end
                            end
                        end
                    end
                else
                    if (Humanoid and Humanoid.Health >= 0 and HumanoidRootPart) then
        
                        local Vector, OnScreen = Camera:WorldToViewportPoint(HumanoidRootPart.Position)
        
                        if (OnScreen) then
                            local Magnitude = (Mouse_Position - Vector2.new(Vector.X, Vector.Y)).Magnitude
        
                            if (Magnitude < Distance and Magnitude < Configuration.Radius) then
                                Distance = Magnitude
        
                                ClosestPlayer = value
                            end
                        end
                    end
                end
            end
        end
    end)
    return ClosestPlayer
end

function library:GetClosestPart(Player)

    local Distance = math.huge

    local Plr = Player

    local Character = Plr.Character

    local Aim_Parts = Configuration.Aim_Parts

    local Mouse_Position = UserInputService:GetMouseLocation()

    local ClosestPart = nil

    for _ , v in ipairs(Aim_Parts) do

        local Part = Character:FindFirstChild(v)

        if (Part) then
            local Vector, OnScreen = Camera:WorldToViewportPoint(Part.Position)

            if (OnScreen) then
                local Magnitude = (Mouse_Position - Vector2.new(Vector.X, Vector.Y)).Magnitude

                if (Magnitude < Distance and Magnitude < Configuration.Radius) then
                    
                    Distance = Magnitude

                    ClosestPart = Part
                end
            end
        end
    end
    return ClosestPart
end

function library:UpdatePrediction(Horozontal, Vertical, Vertical_Offset, Vertical_Offset_Value)

    library.Horozontal_Prediction = Horozontal

    library.Vertical_Prediction = Vertical

    if (Vertical_Offset) then
        library.Vertical_Prediction = Vertical - Vertical_Offset_Value
    end
end

function library:MoveCamera(value)
    local Camera_Position = Camera.CFrame.Position

    Camera.CFrame = Camera.CFrame:Lerp(CFrame.lookAt(Camera_Position, value), Configuration.TweenTime)
end

function library:Unload()
    
    Circle:Remove()

    library.Unloaded_State = true
end

return library
