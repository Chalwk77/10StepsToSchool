-- data_handler.lua for 10StepsToSchool
local json = require('json')
local data = {}
local defaultData = {}
local path = system.pathForFile('data_handler.json', system.DocumentsDirectory)

local function dataCopy(t)
    local copy = {}
    for k, v in pairs(t) do
        if type(k) == 'string' then
            if type(v) == 'number' or type(v) == 'string' or type(v) == 'boolean' then
                copy[k] = v
            else
                print('data_handler: Values of type "' .. type(v) .. '" are not supported.')
            end
        end
    end
    return copy
end

local function saveDataState()
    local file = io.open(path, 'w')
    if file then
        file:write(json.encode(data))
        io.close(file)
    end
end

local function loadDataState()
    local file = io.open(path, 'r')
    if file then
        data = json.decode(file:read('*a'))
        io.close(file)
    else
        data = dataCopy(defaultData)
        saveDataState()
    end
end

local mt = {
    __index = function(t, k)
        return data[k]
    end,
    __newindex = function(t, k, value)
        data[k] = value
        saveDataState()
    end,
    __call = function(t, value)
        if type(value) == 'table' then
            defaultData = dataCopy(value)
        end
        loadDataState()
    end
}

local _M = {}
setmetatable(_M, mt)
return _M
