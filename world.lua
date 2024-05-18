local world = {}

function world.generateMap()
    print("Map generated!")
    -- Your map generation logic
end

function world.update(dt)
    -- World update logic
end

function world.draw()
    love.graphics.print("Hello from the World module!", 100, 100)
end

return world -- This line makes the module's contents available to other files
