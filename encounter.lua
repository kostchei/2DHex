-- encounter.lua

local encounter = {}
local character = require("character") -- Load the character module

-- Function to calculate encounter XP based on character level
function encounter.calculateEncounterXP(characterLevel)
    -- Your logic for determining XP based on level
    -- (e.g., base XP + level scaling, etc.)
    return 100 + characterLevel * 20 -- Example calculation
end

-- Function to select monsters based on XP target
function encounter.selectMonsters(zone, targetXP)
    local monsters = require("zones/" .. zone) -- Load zone monsters
    local selectedMonsters = {}
    local currentXP = 0

    while currentXP < targetXP do
        local randomIndex = love.math.random(#monsters)
        local monster = monsters[randomIndex]

        if currentXP + monster.xp <= targetXP then
            table.insert(selectedMonsters, monster)
            currentXP = currentXP + monster.xp
        end
    end

    return selectedMonsters
end

-- Function to generate an encounter
function encounter.generateEncounter(zone)
    local currentCharacter = character.getSelectedCharacter()
    local targetXP = encounter.calculateEncounterXP(currentCharacter.level)
    local monsters = encounter.selectMonsters(zone, targetXP)

    -- Do something with the generated monster group (e.g., initiate combat)
    return monsters
end

return encounter