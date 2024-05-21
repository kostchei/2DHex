-- ui/components/menu.lua
package.path = package.path .. ";D:/Code/2DHex/plugins/sqlite3/?.lua;" --D:/Code/2DHex/plugins/sqlite3/?/init.lua"
--package.cpath = package.cpath .. ";D:/Code/2DHex/plugins/sqlite3/?.dll"

local sqlite3 = require("sqlite3")
local world = require("world") -- Assuming you have the world module as previously discussed
local menu = {}

-- Define colors
local colors = {
    background = {240/255, 234/255, 214/255},  -- Buff color
    text = {45/255, 34/255, 24/255},          -- Very dark brown for text
    edges = {139/255, 69/255, 19/255}         -- Pale brown for edges
}

-- Define button actions
menu.newWorldButton = {}
menu.newWorldButton.onClick = function()
    -- Logic for creating a new world
    print("New World button clicked")
    world.createZone("forest", 1) -- Example of creating a new zone and tier
end

menu.loadWorldButton = {}
menu.loadWorldButton.onClick = function()
    -- Logic for loading a world
    print("Load World button clicked")
    world.loadZone("forest", 1) -- Example of loading a specific zone and tier
end

menu.selectCharacterButton = {}
menu.selectCharacterButton.onClick = function()
    -- Logic for selecting a character
    print("Select Character button clicked")
end

menu.saveButton = {}
menu.saveButton.onClick = function()
    -- Logic for saving
    print("Save button clicked")
    world.saveWorld() -- Assuming you have a saveWorld function
end

menu.exitButton = {}
menu.exitButton.onClick = function()
    -- Logic for exiting
    love.event.quit()
end

menu.buttons = {
    {label = "New World", action = menu.newWorldButton.onClick},
    {label = "Load World", action = menu.loadWorldButton.onClick},
    {label = "Select Character", action = menu.selectCharacterButton.onClick},
    {label = "Save", action = menu.saveButton.onClick},
    {label = "Exit", action = menu.exitButton.onClick}
}

menu.listOfWorlds = {}

local function loadWorldsAndCharacters()
    local db = sqlite3.open("world.db")
    local zonesAndTiers = {}

    -- Query to get distinct zones and tiers from the database
    for row in db:nrows("SELECT DISTINCT name FROM sqlite_master WHERE type='table' AND name LIKE '%_tier%'") do
        table.insert(zonesAndTiers, row.name)
    end
    
    db:close()
    menu.listOfWorlds = zonesAndTiers
end

-- Initialize the menu
function menu.initialize()
    -- Load existing worlds and their characters
    loadWorldsAndCharacters()
end

-- Show the menu
function menu.show()
    -- Show logic if needed
end

-- Update the menu
function menu.update(dt)
    -- Update logic if needed
end

-- Handle mouse press events
function menu.mousepressed(x, y, button, istouch, presses)
    if button == 1 then  -- left mouse button
        local buttonYStart = 100  -- Adjust as needed
        local buttonWidth = 200    -- Adjust as needed
        local buttonHeight = 50    -- Adjust as needed
        local buttonSpacing = 20   -- Adjust as needed
        
        local bx = 100  -- Button x-position, adjust as needed
        local by = buttonYStart
        
        for _, btn in ipairs(menu.buttons) do
            if x >= bx and x <= bx + buttonWidth and y >= by and y <= by + buttonHeight then
                btn.action()
            end
            by = by + buttonHeight + buttonSpacing
        end
    end
end

-- Draw the menu
function menu.draw()
    local buttonYStart = 100  -- Adjust as needed
    local buttonWidth = 200    -- Adjust as needed
    local buttonHeight = 50    -- Adjust as needed
    local buttonSpacing = 20   -- Adjust as needed
    
    -- Set background color for the menu area
    love.graphics.clear(colors.background)

    -- Draw buttons
    love.graphics.setColor(colors.edges)
    local y = buttonYStart
    for _, button in ipairs(menu.buttons) do
        love.graphics.rectangle("line", 100, y, buttonWidth, buttonHeight)  -- Draw button rectangle
        love.graphics.printf(button.label, 100, y + (buttonHeight / 4), buttonWidth, "center")  -- Draw button label
        y = y + buttonHeight + buttonSpacing
    end

    -- Draw the list of worlds and their characters
    love.graphics.setColor(colors.text)
    y = buttonYStart + #menu.buttons * (buttonHeight + buttonSpacing) + buttonSpacing
    for _, worldName in ipairs(menu.listOfWorlds) do
        love.graphics.print("World: " .. worldName, 50, y)
        y = y + 20
    end
end

return menu
