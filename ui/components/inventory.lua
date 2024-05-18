local inventory = {}
inventory.itemSlots = {}
inventory.visible = false

-- Number of slots in the inventory
local slotsCount = 10

-- Initialize the inventory
function inventory.init()
    for i = 1, slotsCount do
        inventory.itemSlots[i] = {
            image = nil,  -- No item initially
            x = (i - 1) * 50,
            y = 0
        }
    end
end

-- Function to draw the inventory
function inventory.draw()
    if not inventory.visible then return end

    for i, slot in ipairs(inventory.itemSlots) do
        if slot.image then
            love.graphics.draw(slot.image, slot.x, slot.y)
        else
            -- Draw an empty slot
            love.graphics.rectangle("line", slot.x, slot.y, 48, 48)
        end
    end
end

-- Function to add items to the inventory
function inventory.addItem(index, imagePath)
    if index < 1 or index > slotsCount then
        error("Index out of bounds")
    end
    local image = love.graphics.newImage(imagePath)
    inventory.itemSlots[index].image = image
end

-- Function to toggle inventory visibility
function inventory.toggleVisibility()
    inventory.visible = not inventory.visible
end

inventory.init()

return inventory
