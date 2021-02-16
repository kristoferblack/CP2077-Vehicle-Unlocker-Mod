local VehicleSpawnerCore = {
    DeltaTime = 0,
    SpawnDistance = 10,

    Util = require "util",

    ValidVehicleTypes = {
        "vehicleCarBaseObject",
        "vehicleTankBaseObject",
        "vehicleBikeBaseObject",
        "vehicleAVBaseObject"
    }
}

function VehicleSpawnerCore.Tick(deltaTime)
    VehicleSpawnerCore.DeltaTime = VehicleSpawnerCore.DeltaTime + deltaTime

    if VehicleSpawnerCore.DeltaTime > 1 then
        VehicleSpawnerCore.Monitor()

        VehicleSpawnerCore.DeltaTime = VehicleSpawnerCore.DeltaTime - 1
    end

end

function VehicleSpawnerCore.Monitor()
    local player = Game.GetPlayer()

    if player then
        local target = Game.GetTargetingSystem():GetLookAtObject(player, false, false)

        if VehicleSpawnerCore.Util.IfArrayHasValue(VehicleSpawnerCore.ValidVehicleTypes, target) then
            local vehicle = Game.GetTargetingSystem():GetLookAtObject(player, false, false)
            local vehiclePS = vehicle:GetVehiclePS()
            
            if vehiclePS:GetDoorInteractionState(1).value ~= "Available" then
                vehiclePS:UnlockAllVehDoors()
            end
        end
    end
end

function VehicleSpawnerCore.Spawn(id)
    if not id then return end

	local player = Game.GetPlayer()
	local worldForward = player:GetWorldForward()
	local offset = Vector3.new(worldForward.x * VehicleSpawnerCore.SpawnDistance, worldForward.y * VehicleSpawnerCore.SpawnDistance, 1)

	local spawnTransform = player:GetWorldTransform()
	local spawnPosition = spawnTransform.Position:ToVector4(spawnTransform.Position)

    local vehicleTDBID = TweakDBID.new(id)

	spawnTransform:SetPosition(spawnTransform, Vector4.new(spawnPosition.x + offset.x, spawnPosition.y + offset.y, spawnPosition.z + offset.z, spawnPosition.w))
	
    Game.GetPreventionSpawnSystem():RequestSpawn(vehicleTDBID, -1, spawnTransform)
end

function VehicleSpawnerCore.Despawn()

    local player = Game.GetPlayer()
    local target = Game.GetTargetingSystem():GetLookAtObject(player, false, false)

    if target then
        if VehicleSpawnerCore.Util.IfArrayHasValue(VehicleSpawnerCore.ValidVehicleTypes, target) then

            local targetTDBID = target:GetEntityID()
            Game.GetPreventionSpawnSystem():RequestDespawn(targetTDBID)
            -- target:Dispose()
        end
    end
end


function VehicleSpawnerCore.CheckValid()
    local player = Game.GetPlayer()
    local target = Game.GetTargetingSystem():GetLookAtObject(player, false, false)

    if VehicleSpawnerCore.Util.IfArrayHasValue(VehicleSpawnerCore.ValidVehicleTypes, target) then
        return true
    else
        return false
    end
end


return VehicleSpawnerCore