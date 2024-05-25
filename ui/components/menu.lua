-- ui/components/menu.lua

local menu = {}

-- Button properties
local buttons = {
    {text = "New World", action = function() print("New World clicked") end},
    {text = "Load World", action = function() print("Load World clicked") end},
    {text = "Select Character", action = function() print("Select Character clicked") end},
    {text = "Save", action = function() print("Save clicked") end},
    {text = "Exit", action = function() love.event.quit() end}
}
local buttonHeight = 50
local buttonWidth = 4 * buttonHeight
local buttonSpacing = 20
local buttonX = 860
local buttonYStart = 100

function menu.initialize()
    print("Menu initialized")
end

function menu.show()
    -- Code to show the menu
end

function menu.update(dt)
    -- Update code for the menu
end

function menu.draw()
    -- Draw buttons
    for i, button in ipairs(buttons) do
        local buttonY = buttonYStart + (buttonHeight + buttonSpacing) * (i - 1)
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill", buttonX, buttonY, buttonWidth, buttonHeight)
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("line", buttonX, buttonY, buttonWidth, buttonHeight)
        love.graphics.printf(button.text, buttonX, buttonY + (buttonHeight / 4), buttonWidth, "center")
    end

    -- Draw the world list under the "Load World" button
    local loadWorldButtonY = buttonYStart + (buttonHeight + buttonSpacing) * 1
    local worldListX = buttonX
    local worldListY = loadWorldButtonY + buttonHeight + 10
    local worldListWidth = buttonWidth
    local worldListHeight = 100

    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.rectangle("line", worldListX, worldListY, worldListWidth, worldListHeight)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", worldListX, worldListY, worldListWidth, worldListHeight)
    love.graphics.setColor(0, 0, 0)
    for i, world in ipairs({"forest_tier1"}) do  -- Replace with dynamic world list
        love.graphics.printf(world, worldListX + 10, worldListY + 10 + (i - 1) * 20, worldListWidth - 20, "left")
    end
end

function menu.mousepressed(x, y, button, istouch, presses)
    for i, btn in ipairs(buttons) do
        local buttonY = buttonYStart + (buttonHeight + buttonSpacing) * (i - 1)
        if x > buttonX and x < buttonX + buttonWidth and y > buttonY and y < buttonY + buttonHeight then
            btn.action()
        end
    end
end

return menu
