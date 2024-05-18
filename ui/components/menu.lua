-- ui/components/menu.lua

local menu = {}

-- Overlay settings
menu.overlay = {}
menu.overlay.isVisible = true
menu.overlay.draw = function()
    -- Draw a semi-transparent background to cover the screen
    love.graphics.setColor(0, 0, 0, 128)  -- Semi-transparent black
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
end  -- Missing 'end' added here

-- New World Button
menu.newWorldButton = {}  -- Assuming declaration is needed
menu.newWorldButton.onClick = function()
    -- Logic for creating a new world
end

-- Additional button setups could be structured similarly:
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

return menu
