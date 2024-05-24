-- ui/components/hexmap.lua

local hexmap = {}

-- Configuration
local hexSize = 50
local gridWidth = 10
local gridHeight = 10

function hexmap.draw(hexes)
    local startX = love.graphics.getWidth() / 2 - (gridWidth * hexSize * 0.75) / 2
    local startY = love.graphics.getHeight() / 2 - (gridHeight * hexSize * 0.866) / 2
    
    for x, column in pairs(hexes) do
        for y, hex in pairs(column) do
            local hexX = startX + (x - 1) * hexSize * 0.75
            local hexY = startY + (y - 1) * hexSize * 0.866 + (x % 2) * hexSize * 0.433

            -- Ensure the terrain field is valid
            if hex.terrain then
                local terrainImagePath = "images/" .. hex.terrain .. ".png"
                local terrainImage = love.graphics.newImage(terrainImagePath)
                love.graphics.draw(terrainImage, hexX, hexY)
            else
                -- Optional: Draw a placeholder or log an error if terrain is missing
                print("Missing terrain for hex at (" .. x .. ", " .. y .. ")")
            end
        end
    end
end

return hexmap
