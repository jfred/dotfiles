local Debugger = require("hotswitch-hs/lib/common/Debugger")
local Model = require("hotswitch-hs/lib/model/Model")

local SETTING_KEY = "hotswitch-hs"

--[[
data format:

settings = {
    {
        app = "com.apple.Safari",
        keys = {
            "s",
            "f",
        }
    },
    {
        app = "com.apple.mail",
        keys = {
            "m",
        }
    },
    {
        app = "com.apple.iCal",
        keys = {
            "c",
        }
    }
}
]]

local SettingModel = {}
SettingModel.new = function()
    local obj = Model.new()

    obj.get = function()
        local settings = hs.settings.get(SETTING_KEY)
        if settings == nil then
            settings = {}
        end
        return settings
    end

    obj.set = function(value)
        hs.settings.set(SETTING_KEY, value)
    end

    obj.clear = function()
        hs.settings.clear(SETTING_KEY)
    end

    return obj
end
return SettingModel