local VehicleSpawnerData = {
    jsonFile = "vehicles.json",
    jsonData = {}
}

function VehicleSpawnerData.Read() 

    local file = io.open(VehicleSpawnerData.jsonFile, "r")

    VehicleSpawnerData.jsonData = json.decode(file:read("*all"))

    io.close(file)

    return VehicleSpawnerData.jsonData

end

return VehicleSpawnerData