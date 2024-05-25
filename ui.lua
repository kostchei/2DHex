-- ui.lua

local ui = {}
ui.currentUI = "menu"  -- Start with the menu

-- UI Components
local menu = require("ui.components.menu")
local characterSheet = require("ui.components.character_sheet")
local hexmap = require("ui.components.hexmap")

-- Reference to the current active UI component
local currentUI = menu  -- Start with the menu

function ui.initialize()
    -- Initialize UI components
    menu.initialize()
    characterSheet.initialize()
    hexmap.initialize()

    -- Show the default UI
    ui.showMenu()
end

function ui.showMenu()
    ui.currentUI = "menu"
    currentUI = menu
    menu.show()
end

function ui.showCharacterSheet()
    ui.currentUI = "character_sheet"
    currentUI = characterSheet
    characterSheet.show()
end

function ui.showHexMap()
    ui.currentUI = "hexmap"
    currentUI = hexmap
    hexmap.show()
end

-- Input Handling
function ui.keypressed(key)
    if key == "escape" and ui.currentUI ~= "menu" then
        ui.showMenu()
    elseif key == "c" and ui.currentUI ~= "character_sheet" then
        ui.showCharacterSheet()
    end
end

function ui.mousepressed(x, y, button, istouch, presses)
    if currentUI and currentUI.mousepressed then
        currentUI.mousepressed(x, y, button, istouch, presses)
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
end

return ui
