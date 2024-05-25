package.path = package.path .. ";D:/Code/2DHex/plugins/sqlite3/?.lua"
local sqlite3 = require("sqlite3")
local hexmap = require("ui.components.hexmap")
local world = {}

-- Function to initialize the database
function world.initDatabase()
    local db = sqlite3.open("world.db")
    db:exec[[
        CREATE TABLE IF NOT EXISTS forest_tier1 (
            x INTEGER,
            y INTEGER,
            terrain TEXT,
            PRIMARY KEY (x, y)
        );
    ]]
    db:close()
end

-- Helper function for terrain choice
function world.chooseTerrain(terrainTypes)
    local rand = math.random()
    local cumulative = 0
    for terrain, probability in pairs(terrainTypes) do
        cumulative = cumulative + probability
        if rand <= cumulative then
            return terrain
        end
    end
    return "forest"  -- default return value if none selected
end

-- Function to create a new zone with terrain generation
function world.createZone(zone, tier)
    local db = sqlite3.open("world.db")
    local tableName = zone .. "_tier" .. tier

    db:exec("CREATE TABLE IF NOT EXISTS " .. tableName .. [[ (
        x INTEGER,
        y INTEGER,
        terrain TEXT,
        PRIMARY KEY (x, y)
    );]])

    local terrainTypes = {
        forest = 0.75,
        open = 0.10,
        hill = 0.10,
        water = 0.03,
        settlement = 0.02
    }
    
    for i = 1, 10 do
        for j = 1, 10 do
            local terrain = world.chooseTerrain(terrainTypes)
            local stmt = db:prepare("INSERT OR REPLACE INTO " .. tableName .. " VALUES (?, ?, ?)")
            stmt:bind_values(i, j, terrain)
            stmt:step()
            stmt:finalize()
            print("Set terrain for (" .. i .. ", " .. j .. "): " .. terrain)  -- Debug print
        end
    end

    db:close()
    print("New zone and tier created: " .. tableName)
end

-- Function to load a specific zone and tier
function world.loadZone(zone, tier)
    local db = sqlite3.open("world.db")
    local tableName = zone .. "_tier" .. tier
    local hexes = {}
    
    for row in db:nrows("SELECT * FROM " .. tableName) do
        if not hexes[row.x] then
            hexes[row.x] = {}
        end
        hexes[row.x][row.y] = { terrain = row.terrain }
        print("Loaded terrain for (" .. row.x .. ", " .. row.y .. "): " .. tostring(row.terrain))  -- Debug print
    end
    
    db:close()
    world.hexes = hexes
    print("Zone loaded: " .. tableName)
end

-- Function to update a hex with new features
function world.updateHex(zone, tier, x, y, newFeatures)
    local db = sqlite3.open("world.db")
    local tableName = zone .. "_tier" .. tier
    
    local stmt = db:prepare("INSERT OR REPLACE INTO " .. tableName .. " VALUES (?, ?, ?)")
    stmt:bind_values(x, y, table.concat(newFeatures, ","))
    stmt:step()
    stmt:finalize()
    
    db:close()
    print("Hex updated in " .. tableName .. ": (" .. x .. ", " .. y .. ")")
end

-- Real function to update the world
function world.update(dt)
    -- Example: Update all entities in the world (if any)
    -- This could involve moving characters, handling game logic, etc.
    for x, column in pairs(world.hexes) do
        for y, hex in pairs(column) do
            -- Example update logic (e.g., moving entities, updating state)
            -- print("Updating hex at (" .. x .. ", " .. y .. ") with terrain: " .. hex.terrain)
            -- Perform updates on each hex or entities within the hex
        end
    end
end

-- Function to draw the world
function world.draw()
    if world.hexes then
        hexmap.drawHexes(world.hexes)
    end
end

return world
