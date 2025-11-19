-- Defensive Vorp 3.3-compatible initialization
local VORP = nil
local VorpInv = nil

-- Try to get Vorp via exports first (common in Vorp 3.3 setups)
if exports and exports.vorp_core then
    pcall(function()
        VORP = exports.vorp_core and exports.vorp_core:vorpAPI()
    end)
end

-- Fallback to legacy getCore event if exports not available
if not VORP then
    TriggerEvent("getCore", function(core)
        VORP = core
    end)
end

-- Inventory export (defensive)
if exports and exports.vorp_inventory then
    pcall(function()
        VorpInv = exports.vorp_inventory and exports.vorp_inventory:vorp_inventoryApi()
    end)
end

-- Helper: safe user getter that supports both new exports and legacy core
local function safeGetUser(id)
    if VORP and VORP.getUser then
        local ok, user = pcall(function() return VORP.getUser(id) end)
        if ok then return user end
    end
    -- legacy variable name compatibility
    if VorpCore and type(VorpCore.getUser) == "function" then
        local ok, user = pcall(function() return VorpCore.getUser(id) end)
        if ok then return user end
    end
    return nil
end

function contains(tbl, element)
    if tbl and type(tbl) == "table" then
        for k, v in pairs(tbl) do
            if v == element then
                return true
            end
        end
    end
    return false
end

RegisterServerEvent("skrievo_alert:sendalert")
AddEventHandler("skrievo_alert:sendalert", function(players, job,alert,blip,doctor)
    local _source = source
    local players = GetPlayers()
    if contains(job, "doctor") then 
        local doctors = 0 
        for z, m in pairs(players) do
            local User = safeGetUser(m)
            local used = User and User.getUsedCharacter
            if used and used.job == "doctor" then
                doctors = doctors + 1 
                local ply = tonumber(m)
                if ply then
                    TriggerClientEvent("vorp:TipRight", ply, alert , 50000)
                    TriggerClientEvent("skrievo_alert:createblip", ply, blip, doctor, tonumber(_source))
                end
            end
        end
        if doctors == 0 then 
            TriggerClientEvent("skrievo_alert:cantalert",_source)
        end
    else
        for z, m in pairs(players) do
            local User = safeGetUser(m)
            local used = User and User.getUsedCharacter
            if used then
                for k,v in pairs(job) do 
                    if used.job == v then
                        local ply = tonumber(m)
                        if ply then
                            TriggerClientEvent("vorp:TipRight", ply, alert , 50000)
                            TriggerClientEvent("skrievo_alert:createblip", ply, blip, doctor, tonumber(_source))
                        end
                    end
                end
            end
        end 
    end
end)

RegisterServerEvent("skrievo_alert:inform")
AddEventHandler("skrievo_alert:inform", function(player)
    local _source = source
    TriggerClientEvent("skrievo_alert:recresp",player)
end)