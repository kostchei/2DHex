-- main.lua

local ui = require("ui")

function love.load()
    -- Set window title
    love.window.setTitle("Champion")
    
    -- Set window size 
    love.window.setMode(1920, 1080, {fullscreen = false, resizable = true, vsync = true})
    
    print("Main module loaded")

    -- Initialize UI
    ui.initialize()

    -- Set background color (buff or off-white)
    love.graphics.setBackgroundColor(240/255, 234/255, 214/255) -- RGB values for buff color
end

function love.update(dt)
    ui.update(dt)
end

function love.draw()
    ui.draw()
end

function love.keypressed(key)
    ui.keypressed(key)
end

function love.mousepressed(x, y, button, istouch, presses)
    ui.mousepressed(x, y, button, istouch, presses)
end
