local VehicleSpawnerCore = {
    SpawnDistance = 10,

    ValidVehicleTypes = {
        "vehicleCarBaseObject",
        "vehicleBikeBaseObject",
        "vehicleAVBaseObject"
    }
}

function VehicleSpawnerCore.Spawn(id)
    if not id then return end

	local player = Game.GetPlayer()
	local worldForward = player:GetWorldForward()
	local offset = Vector3.new(worldForward.x * VehicleSpawnerCore.SpawnDistance, worldForward.y * VehicleSpawnerCore.SpawnDistance, 1)

	local spawnTransform = player:GetWorldTransform()
	local spawnPosition = spawnTransform.Position:ToVector4(spawnTransform.Position)

	spawnTransform:SetPosition(spawnTransform, Vector4.new(spawnPosition.x + offset.x, spawnPosition.y + offset.y, spawnPosition.z + offset.z, spawnPosition.w))

    local vehicleTDBID = TweakDBID.new(id)

	Game.GetPreventionSpawnSystem():RequestSpawn(vehicleTDBID, 1, spawnTransform)

    return true
end

function VehicleSpawnerCore.Despawn()
    local player = Game.GetPlayer()
    local target = Game.GetTargetingSystem():GetLookAtObject(player, false, false)
    local targetTDBID = target:GetEntityID()

    Game.GetPreventionSpawnSystem():RequestDespawn(targetTDBID)

    player:SetWarningMessage("Look away from vehicle to despawn")
end

return VehicleSpawnerCore