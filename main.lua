-- main.lua

local world = require("world")
local character = require("character")
local encounter = require("encounter")
local ui = require("ui")

function love.load()
    -- Set window title
    love.window.setTitle("Champion")
    
    -- Set window size 
    love.window.setMode(1920, 1080, {fullscreen = false, resizable = true, vsync = true})
    
    print("Main module loaded")
    if world.generateMap then
        world.generateMap()
    end
    if character.createCharacter then
        character.createCharacter()
    end
    -- encounter.initialize() removed as player dependent
    ui.initialize()

    -- Set background color (buff or off-white)
    love.graphics.setBackgroundColor(240/255, 234/255, 214/255) -- RGB values for buff color
end

function love.update(dt)
    if world.update then
        world.update(dt)
    end
    if character.update then
        character.update(dt)
    end
    if encounter.update then
        encounter.update(dt)
    end
    if ui.update then
        ui.update(dt)
    end
end

function love.draw()
    if world.draw then
        world.draw()
    end
    if character.draw then
        character.draw()
    end
    if encounter.draw then
        encounter.draw()
    end
    if ui.draw then
        ui.draw()
    end
end

