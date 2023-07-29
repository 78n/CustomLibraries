local cloneref = cloneref or function(...)
    return ...
end

local Players = getgenv and getgenv().Players or cloneref(game:GetService("Players"))
local lp = cloneref(Players.LocalPlayer)
local CharacterHandler = {}

local function CheckIsA(obj: any,CheckString: string): any
    if typeof(obj) == "Instance" then
        return obj:IsA(CheckString) and obj or nil
    end
end

function CharacterHandler:getchar(plr: Player): Model
    return CheckIsA(plr,"Player") and plr.Character or lp.Character
end

function CharacterHandler:gethumanoid(plr: Player | Model): Humanoid
    local char: Model = CheckIsA(plr,"Model") or self:getchar(plr)
    return char and char:FindFirstChildWhichIsA("Humanoid")
end

function CharacterHandler:getroot(plr: Player | Humanoid | Model): BasePart
    local char: Model = CheckIsA(plr,"Model") or self:getchar(plr)
    local Humanoid: Humanoid = CheckIsA(plr,"Humanoid") or self:gethumanoid(char)

    return (Humanoid and Humanoid.RootPart) or char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
end

return CharacterHandler
