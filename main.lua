-- main.lua

local world = require("world")
local character = require("character")
local encounter = require("encounter")
local ui = require("ui")

function love.load()
    print("Main module loaded") 
    world.generateMap()
    character.createCharacter()
    --encounter.initialize() removed as player dependant
    ui.initialize()
end

function love.update(dt)
    world.update(dt)
    character.update(dt)
    encounter.update(dt)
    ui.update(dt)
end

function love.draw()
    world.draw()
    character.draw()
    encounter.draw()
    ui.draw()
end