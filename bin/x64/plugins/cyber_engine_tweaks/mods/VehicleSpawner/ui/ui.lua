local VehicleSpawnerUI = {
    deltaTime = 0,

    Theme = require "ui/theme",
    Data = require "data",
    Spawner = require "spawner",

    VehicleFilterText = "",

    SelectedVehicle = "",
    SelectedVehiclePrettyName = ""
}

function VehicleSpawnerUI.Create()

    VehicleSpawnerUI.Theme.Start()

    ImGui.SetNextWindowPos(0, 500, ImGuiCond.FirstUseEver)
    ImGui.SetNextWindowSize(350, 400, ImGuiCond.Appearing)

    if ImGui.Begin("Vehicle Spawner") then

        ImGui.SetWindowFontScale(1)

        ImGui.TextWrapped("Search or choose a vehicle from the list below, then click Spawn button.")

        VehicleSpawnerUI.Theme.Spacing(3)


        VehicleSpawnerUI.Theme.DisplayLabel("Search Vehicles")
        ImGui.PushItemWidth(-1)
        VehicleSpawnerUI.VehicleFilterText = ImGui.InputText("##VehicleListFilter", VehicleSpawnerUI.VehicleFilterText, 100)
        local filterTextEsc = VehicleSpawnerUI.VehicleFilterText:gsub('([^%w])', '%%%1')
        ImGui.PopItemWidth()


        if ImGui.ListBoxHeader("##VehicleList", -1, 200) then
            for i, vehicle in ipairs(VehicleSpawnerUI.Data.Read()) do

                local prettyName = Game.GetLocalizedTextByKey(Game['TDB::GetLocKey;TweakDBID'](TweakDBID.new(vehicle ..'.displayName')))
                
                if vehicle:find(filterTextEsc) then
                    if ImGui.Selectable(string.gsub(vehicle, "Vehicle.", ""), (vehicle == VehicleSpawnerUI.SelectedVehicle)) then
                        VehicleSpawnerUI.SelectedVehicle = vehicle
                        
                        if prettyName == "" then 
                            VehicleSpawnerUI.SelectedVehiclePrettyName = vehicle
                        else
                            VehicleSpawnerUI.SelectedVehiclePrettyName = prettyName
                        end
                    end
                end

                if ImGui.IsItemHovered() and prettyName ~= "" then
                    ImGui.SetTooltip(prettyName)
                end
                
            end
        end
        ImGui.ListBoxFooter()

        if VehicleSpawnerUI.SelectedVehicle ~= "" then
            if ImGui.Button("Spawn Vehicle", -1, 25) then
                VehicleSpawnerUI.Spawner.Spawn(VehicleSpawnerUI.SelectedVehicle)
            end
        end

        if VehicleSpawnerUI.Spawner.CheckValid() then
            if ImGui.Button("Despawn Vehicle", -1, 25) then
                VehicleSpawnerUI.Spawner.Despawn()
            end

            if ImGui.IsItemHovered() then
                ImGui.SetTooltip("Look at vehicle you want to despawn, then click button.\r\nLook away from vehicle to complete despawn.")
            end
        end

        if ImGui.Button("Add Veh List", -1, 25) then

            local vehicles = VehicleSpawnerUI.Data.Read()
            local vehiclesList = TweakDB:GetFlat(TweakDBID.new("Vehicle.vehicle_list.list"))

            for i=1, #vehiclesList do
                table.remove(vehiclesList, 1)
            end
               
            TweakDB:Update(vehiclesList)

            for i, vehicle in ipairs(VehicleSpawnerUI.Data.Read()) do
                table.insert(vehiclesList, TweakDBID.new(tostring(vehicle)))
            end
            
            TweakDB:SetFlat(TweakDBID.new("Vehicle.vehicle_list.list"), vehiclesList)
            TweakDB:Update(vehiclesList)


            for i, veh in ipairs(vehList) do
                print(i, veh)
            end
        end

        if ImGui.Button("Veh List", -1, 25) then

            local vehList = TweakDB:GetFlat(TweakDBID.new("Vehicle.vehicle_list.list"))

            for i, veh in ipairs(vehList) do
                print(i, veh)
            end
        end

    end
    ImGui.End()

    VehicleSpawnerUI.Theme.End()
    
end

return VehicleSpawnerUI