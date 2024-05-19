-- ui.lua

local ui = {}
ui.currentUI = "menu"  -- Start with the menu

-- UI Components
local menu = require("ui.components.menu")
-- local characterSheet = require("ui.components.character_sheet")
-- local inventory = require("ui.components.inventory")
-- local hexmap = require("ui.components.hex_map")
-- local combatGrid = require("ui.components.combat_grid")

-- Reference to the current active UI component
local currentUI = menu  -- Start with the menu

function ui.initialize()
    -- Initialize UI components
    menu.initialize()
    -- characterSheet.initialize()
    -- inventory.initialize()
    -- hexmap.initialize()
    -- combatGrid.initialize()

    -- Show the default UI
    ui.showMenu()
end

-- Functions to show different UI components
function ui.showMenu()
    ui.currentUI = "menu"
    currentUI = menu
    menu.show()
end

-- function ui.showCharacterSheet() -- example lazy intialisation
--     ui.currentUI = "character_sheet"
--     currentUI = characterSheet
--     if not characterSheet.isInitialized then
--         characterSheet.initialize()
--         characterSheet.isInitialized = true
--     end
--     characterSheet.show()
-- end

-- function ui.showInventory()
--     ui.currentUI = "inventory"
--     currentUI = inventory
--     inventory.show()
-- end

-- function ui.showHexMap()
--     ui.currentUI = "hex_map"
--     currentUI = hexmap
--     hexmap.show()
-- end

-- function ui.showCombatGrid()
--     ui.currentUI = "combat_grid"
--     currentUI = combatGrid
--     combatGrid.show()
-- end

-- Input Handling
function love.keypressed(key)
    if key == "escape" and ui.currentUI ~= "menu" then
        ui.showMenu()
    -- elseif key == "c" and ui.currentUI ~= "character_sheet" then
    --     ui.showCharacterSheet()
    -- elseif key == "i" and ui.currentUI ~= "inventory" then
    --     ui.showInventory()
    end
end

-- Update and Draw
function ui.update(dt)
    if currentUI and currentUI.update then
        currentUI.update(dt)
    end
end

function ui.draw()
    if currentUI and currentUI.draw then
        currentUI.draw()
    end
    -- if characterSheet.isVisible then
    --     characterSheet.draw()
    -- end
end

return ui
