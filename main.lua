local ui = require("ui")
local world = require("world")
local hexmap = require("ui.components.hexmap")

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

    -- Initialize the world database and create a zone
    world.initDatabase()
    world.createZone("forest", 1)
    world.loadZone("forest", 1)
end

function love.update(dt)
    ui.update(dt)
    world.update(dt)  -- Call update for the world (if needed)
end

function love.draw()
    ui.draw()
    
    -- Draw the hex map if it is loaded
    if world.hexes then
        hexmap.draw(world.hexes)
    end
end

function love.keypressed(key)
    ui.keypressed(key)
end

function love.mousepressed(x, y, button, istouch, presses)
    ui.mousepressed(x, y, button, istouch, presses)
end
