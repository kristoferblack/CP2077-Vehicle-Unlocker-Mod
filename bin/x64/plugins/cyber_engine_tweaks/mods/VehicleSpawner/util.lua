local VehicleSpawnerUtil = {

}

function VehicleSpawnerUtil.IsA(kind, value)
    if type(value) == kind then
        return true
    end

    if value == nil or (type(value) ~= "userdata" and type(value) ~= "table") then
        return false
    end

    if value["IsA"] then
        return value:IsA(kind)
    end

    if value["ToString"] then
        return value:ToString() == kind
    end

    return false
end

function VehicleSpawnerUtil.IfArrayHasValue(items, val)
    local innerVal = val

    if not val then return end

    if type(val) ~= "string" then innerVal = val:ToString() end

    for index, value in ipairs(items) do
        if value == innerVal then
            return true
        end
    end

    return false
end

return VehicleSpawnerUtil