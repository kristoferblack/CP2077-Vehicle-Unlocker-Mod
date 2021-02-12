--      ___           ___           ___           ___                                   ___           ___                 
--     /  /\         /  /\         /  /\         /__/\        ___           ___        /  /\         /  /\          ___   
--    /  /::\       /  /::\       /  /:/         \  \:\      /  /\         /  /\      /  /:/_       /  /:/         /  /\  
--   /  /:/\:\     /  /:/\:\     /  /:/           \__\:\    /  /:/        /  /:/     /  /:/ /\     /  /:/         /  /:/  
--  /  /:/~/::\   /  /:/~/:/    /  /:/  ___   ___ /  /::\  /__/::\       /  /:/     /  /:/ /:/_   /  /:/  ___    /  /:/   
-- /__/:/ /:/\:\ /__/:/ /:/___ /__/:/  /  /\ /__/\  /:/\:\ \__\/\:\__   /  /::\    /__/:/ /:/ /\ /__/:/  /  /\  /  /::\   
-- \  \:\/:/__\/ \  \:\/:::::/ \  \:\ /  /:/ \  \:\/:/__\/    \  \:\/\ /__/:/\:\   \  \:\/:/ /:/ \  \:\ /  /:/ /__/:/\:\  
--  \  \::/       \  \::/~~~~   \  \:\  /:/   \  \::/          \__\::/ \__\/  \:\   \  \::/ /:/   \  \:\  /:/  \__\/  \:\ 
--   \  \:\        \  \:\        \  \:\/:/     \  \:\          /__/:/       \  \:\   \  \:\/:/     \  \:\/:/        \  \:\
--    \  \:\        \  \:\        \  \::/       \  \:\         \__\/         \__\/    \  \::/       \  \::/          \__\/
--     \__\/         \__\/         \__\/         \__\/                                 \__\/         \__\/                 
-------------------------------------------------------------------------------------------------------------------------------
-- This mod was created by Architect from CP2077 Modding Tools Discord. 
-- https://github.com/specik/CP2077-Vehicle-Unlocker-Mod
--
-- You are free to use this mod as long as you follow the following license guidelines:
--    * It may not be uploaded to any other site without my express permission.
--    * Using any code contained herein in another mod requires full credits.
--    * You may not fork this code and make your own competing version of this mod available for download.
--
-- Full license available at https://github.com/specik/CP2077-Vehicle-Unlocker-Mod/blob/main/LICENSE
-------------------------------------------------------------------------------------------------------------------------------

local VehicleSpawner = { 
    description = "",
    drawWindow = false,

    Spawner = require "spawner",
    UI = require "ui/ui"
}

function VehicleSpawner:new()


    -- START Hotkeys -------------------------------------------------------------------------

    registerHotkey("VehicleSpawner", "Toggle Window", function()
        VehicleSpawner.drawWindow = not VehicleSpawner.drawWindow
    end)


    -- START Events --------------------------------------------------------------------------
    
    registerForEvent("onInit", function()
        -- VehicleSpawner.Spawner.Populate()
    end)
      
    registerForEvent("onUpdate", function(deltaTime)
        VehicleSpawner.Spawner.Tick(deltaTime)
    end)

    registerForEvent("onOverlayOpen", function()
        VehicleSpawner.drawWindow = true
    end)
      
    registerForEvent("onOverlayClose", function()
        VehicleSpawner.drawWindow = false
    end)

    registerForEvent("onDraw", function()
        if VehicleSpawner.drawWindow then

            VehicleSpawner.UI.Create()

        end
    end)    
end

return VehicleSpawner:new()