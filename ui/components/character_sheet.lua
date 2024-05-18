-- Assuming 'character' module is correctly set up and functions as intended
local character = require("character")
character.loadCharacterData()  -- Loads the first Lua file from the 'toons' directory

local character_sheet = {}  -- Define character_sheet as a local table to hold the functions

function character_sheet.show()
    character.loadCharacterData()  -- Load data when the character sheet is shown
end

function character_sheet.update(dt)
    -- Handle any updates needed for the character sheet
end


function character_sheet.draw()
    local char = character.getSelectedCharacter()
    if char then  -- Safety check in case character data failed to load
        local y = 20
        local lineHeight = 20

        love.graphics.print("Name: " .. char.name, 10, y); y = y + lineHeight
        love.graphics.print("Level: " .. char.level, 10, y); y = y + lineHeight
        love.graphics.print("HP: " .. char.HP_Current .. "/" .. char.HP_Max, 10, y); y = y + lineHeight
        love.graphics.print("AC: " .. char.AC, 10, y); y = y + lineHeight

        -- Display attacks
        for i, attack in ipairs(char.attacks) do
            love.graphics.print("Attack " .. i .. ": " .. attack.description, 10, y); y = y + lineHeight
            love.graphics.print("To Hit: " .. attack.toHit, 30, y); y = y + lineHeight
            love.graphics.print("Damage: " .. attack.damage, 30, y); y = y + lineHeight
        end

        -- Display other attributes
        love.graphics.print("Movement: " .. char.movement, 10, y); y = y + lineHeight
        love.graphics.print("Actions: " .. table.concat(char.actions, ", "), 10, y); y = y + lineHeight
        love.graphics.print("Strength: " .. char.attributes.Strength, 10, y); y = y + lineHeight
        love.graphics.print("Intelligence: " .. char.attributes.Intelligence, 10, y); y = y + lineHeight
        love.graphics.print("Wisdom: " .. char.attributes.Wisdom, 10, y); y = y + lineHeight
    else
        love.graphics.print("Error: Character data not loaded.", 10, 20)
    end
end

return character_sheet  -- Return the character_sheet table to make it accessible where required

