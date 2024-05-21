-- Add the path to your package path
package.path = package.path .. ";D:/Code/2DHex/plugins/sqlite3/?.lua" --;D:/Code/2DHex/plugins/sqlite3/?/init.lua"
--package.cpath = package.cpath .. ";D:/Code/2DHex/plugins/sqlite3/?.dll"

local sqlite3 = require("sqlite3")
local world = {}

-- Function to initialize the database
function world.initDatabase()
    local db = sqlite3.open("world.db")
    
    -- Example: Create a table for a specific zone and tier
    db:exec[[
        CREATE TABLE IF NOT EXISTS forest_tier1 (
            x INTEGER,
            y INTEGER,
            features TEXT,
            PRIMARY KEY (x, y)
        );
    ]]
    
    db:close()
end

-- Function to create a new zone and tier
function world.createZone(zone, tier)
    local db = sqlite3.open("world.db")
    local tableName = zone .. "_tier" .. tier
    
    -- Create table if it doesn't exist
    db:exec("CREATE TABLE IF NOT EXISTS " .. tableName .. [[ (
        x INTEGER,
        y INTEGER,
        features TEXT,
        PRIMARY KEY (x, y)
    );]])
    
    -- Populate the table with new data
    for i = 1, 1000 do
        for j = 1, 1000 do
            local features = "trees,water"  -- Example features
            local stmt = db:prepare("INSERT OR REPLACE INTO " .. tableName .. " VALUES (?, ?, ?)")
            stmt:bind_values(i, j, features)
            stmt:step()
            stmt:finalize()
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
        hexes[row.x][row.y] = { features = row.features }
    end
    
    db:close()
    world.hexes = hexes
    print("Zone loaded: " .. tableName)
end

-- Function to update a hex with new features
function world.updateHex(zone, tier, x, y, newFeatures)
    local db = sqlite3.open("world.db")
    local tableName = zone .. "_tier" .. tier
    
    -- Update hex features
    local stmt = db:prepare("INSERT OR REPLACE INTO " .. tableName .. " VALUES (?, ?, ?)")
    stmt:bind_values(x, y, table.concat(newFeatures, ","))
    stmt:step()
    stmt:finalize()
    
    db:close()
    print("Hex updated in " .. tableName .. ": (" .. x .. ", " .. y .. ")")
end

function world.update(dt)
    -- Placeholder update function
end

function world.draw()
    -- Placeholder draw function
end

return world
