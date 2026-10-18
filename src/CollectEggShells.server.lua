-- CollectEggShells.server.lua

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local EggShells = {}

-- Function to handle egg shell collection
local function onEggShellTouched(otherPart)
    local character = otherPart.Parent
    local player = Players:GetPlayerFromCharacter(character)
    
    if player then
        EggShells[player] = (EggShells[player] or 0) + 1
        print(player.Name .. " collected an egg shell. Total: " .. EggShells[player])
    
        -- Remove the egg shell from the workspace
        otherPart:Destroy()
    end
end

-- Connect the touch event to the egg shells
local function onPlayerAdded(player)
    local eggShells = workspace:WaitForChild("EggShells")
    
    for _, eggShell in ipairs(eggShells:GetChildren()) do
        if eggShell:IsA("BasePart") then
            eggShell.Touched:Connect(onEggShellTouched)
        end
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)

-- Function to get the number of egg shells a player has
function getEggShells(player)
    return EggShells[player] or 0
end

-- Expose the function to the client
ReplicatedStorage:WaitForChild("GetEggShells"):SetAsync(getEggShells)