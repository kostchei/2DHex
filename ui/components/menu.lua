-- ui/components/menu.lua

local menu = {}

-- Define colors
local colors = {
    background = {240/255, 234/255, 214/255},  -- Buff color
    text = {45/255, 34/255, 24/255},          -- Very dark brown for text
    edges = {139/255, 69/255, 19/255}         -- Pale brown for edges
}

-- New World Button
menu.newWorldButton = {}
menu.newWorldButton.onClick = function()
    -- Logic for creating a new world
end

-- Load World Button
menu.loadWorldButton = {}
menu.loadWorldButton.onClick = function()
    -- Logic for loading a world
end

-- Select Character Button
menu.selectCharacterButton = {}
menu.selectCharacterButton.onClick = function()
    -- Logic for selecting a character
end

-- Save Button
menu.saveButton = {}
menu.saveButton.onClick = function()
    -- Logic for saving
end

-- Exit Button
menu.exitButton = {}
menu.exitButton.onClick = function()
    -- Logic for exiting
end

menu.listOfWorlds = {}

local function loadWorldsAndCharacters()
    local gamesPath = "games"
    local toonsPath = "toons"

    local worlds = love.filesystem.getDirectoryItems(gamesPath)
    for _, worldFile in ipairs(worlds) do
        if worldFile:match("%.json$") then
            local worldName = worldFile:sub(1, -6)  -- remove '.json' extension
            local worldEntry = { name = worldName, characters = {} }
            
            local characterFiles = love.filesystem.getDirectoryItems(toonsPath)
            for _, charFile in ipairs(characterFiles) do
                if charFile:match("^" .. worldName .. "%..+%.json$") then
                    local charName = charFile:match("^" .. worldName .. "%.(.+)%.json$")
                    table.insert(worldEntry.characters, charName)
                end
            end
            
            table.insert(menu.listOfWorlds, worldEntry)
        end
    end
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

-- Draw the menu
function menu.draw()
    -- Set background color for the menu area
    love.graphics.clear(colors.background)

    -- Draw the list of worlds and their characters
    love.graphics.setColor(colors.text)
    local y = 50
    for _, world in ipairs(menu.listOfWorlds) do
        love.graphics.print("World: " .. world.name, 50, y)
        y = y + 20
        for _, character in ipairs(world.characters) do
            love.graphics.print("  Character: " .. character, 70, y)
            y = y + 20
        end
    end

    -- Draw basic shapes for visual confirmation
    love.graphics.setColor(colors.edges)
    love.graphics.rectangle("line", 40, 40, 300, 200)  -- Example rectangle for menu edges
end

return menu
