local character = {}
local characterData = {}

local setDefaultAttributes  -- Forward declaration

local function tableToString(tbl)
    local result = "{"
    for k, v in pairs(tbl) do
        -- Assuming keys are strings and values are basic data types
        local key = k
        if type(k) == "string" then
            key = string.format("%q", k)
        end
        local value = v
        if type(v) == "string" then
            value = string.format("%q", v)
        elseif type(v) == "table" then
            value = tableToString(v)  -- Recursive call for nested tables
        end
        result = result .. "[" .. key .. "]=" .. value .. ","
    end
    result = result .. "}"
    return result
end

function character.createCharacter()
    local newCharacter = {
        name = "New Character",
        HP_Max = 100,
        HP_Current = 100,
        AC = 10,
        attacks = {
            {description = "Attack 1", toHit = "+5", damage = "1d8+3"},
            {description = "Attack 2", toHit = "+4", damage = "1d6+2"},
            {description = "Attack 3", toHit = "+6", damage = "1d10+4"}
        },
        movement = "30 feet",
        actions = {"Action 1", "Action 2"},
        attributes = {
            Strength = 10,
            Intelligence = 10,
            Wisdom = 10
        }
    }
    setDefaultAttributes(newCharacter)
    characterData.selectedCharacter = newCharacter
    print("New character created.")
end

function character.loadCharacterData()
    local files = love.filesystem.getDirectoryItems("toons")
    for _, file in ipairs(files) do
        if file:match("%.lua$") then
            local path = "toons/" .. file
            local success, data = pcall(love.filesystem.load, path)
            if success and data then
                local loadedData = data()
                if loadedData then
                    print("Loaded data for:", file)
                    characterData.selectedCharacter = loadedData
                    setDefaultAttributes(characterData.selectedCharacter)
                    return  -- Stop after the first successful load
                end
            else
                print("Error loading character data for file:", file, data)
            end
        end
    end
    print("No valid Lua files found in 'toons' directory.")
    character.createCharacter()  -- Create a new character if none are loaded
end

function character.getSelectedCharacter()
    return characterData.selectedCharacter
end

-- Define the setDefaultAttributes function after its forward declaration
setDefaultAttributes = function(char)
    char.HP_Max = char.HP_Max or 100
    char.HP_Current = char.HP_Current or 100
    char.AC = char.AC or 10
    char.attacks = char.attacks or {
        {description = "Attack 1", toHit = "+5", damage = "1d8+3"},
        {description = "Attack 2", toHit = "+4", damage = "1d6+2"},
        {description = "Attack 3", toHit = "+6", damage = "1d10+4"}
    }
    char.movement = char.movement or "30 feet"
    char.actions = char.actions or {"Action 1", "Action 2"}
    char.attributes = char.attributes or {
        Strength = 10,
        Intelligence = 10,
        Wisdom = 10
    }
end

function character.updateCharacterData(newData)
    for k, v in pairs(newData) do
        characterData.selectedCharacter[k] = v
    end
end

function character.saveCharacterData()
    local path = "toons/" .. characterData.selectedCharacter.name .. ".lua"
    local contents = "return " .. tableToString(characterData.selectedCharacter)
    local success, message = love.filesystem.write(path, contents)
    if not success then
        print("Failed to save character data:", message)
    else
        print("Character data saved successfully.")
    end
end

-- Placeholder update function
function character.update(dt)
    -- Placeholder logic for updating character
end

-- Placeholder draw function
function character.draw()
    -- Placeholder logic for drawing character
end

return character -- Return the module table at the end
