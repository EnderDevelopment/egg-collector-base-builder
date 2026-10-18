-- CombineEggShells.server.lua

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Function to handle egg shell combination
local function onCombineEggShells(player)
    local eggShells = ReplicatedStorage:WaitForChild("GetEggShells"):InvokeServer(player)
    
    if eggShells >= 10 then
        -- Combine the egg shells
        eggShells = eggShells - 10
        print(player.Name .. " combined 10 egg shells. Remaining: " .. eggShells)
        
        -- Update the player's egg shells
        ReplicatedStorage:WaitForChild("UpdateEggShells"):FireServer(player, eggShells)
    else
        print(player.Name .. " does not have enough egg shells to combine.")
    end
end

-- Connect the remote event to the combine function
ReplicatedStorage:WaitForChild("CombineEggShells"):OnServerEvent:Connect(onCombineEggShells)