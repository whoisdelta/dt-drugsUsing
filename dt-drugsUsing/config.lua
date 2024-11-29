Config = Config or {};

Config.drugs = { 
    ['cocaine'] = {
        name = "Cocaine",
        description = "Cocaine is a powerful stimulant that can cause euphoria and paranoia.",
        weight = 0.8,

        type = 'sniff',
        maxUsage = 5,
        duration = 130, 

        ['effect'] = function()
            local playerPed = PlayerPedId()

            StartScreenEffect("DrugsMichaelAliensFight", 0, true) 
            SetTimecycleModifier("cinema")
            SetExtraTimecycleModifier("rply_contrast_neg") 
            ShakeGameplayCam("ROAD_VIBRATION_SHAKE", 1.0) 
        
            SetRunSprintMultiplierForPlayer(PlayerId(), 1.8) 
            SetSwimMultiplierForPlayer(PlayerId(), 1.5) 
        
            RequestAnimSet("MOVE_M@QUICK") 
            while not HasAnimSetLoaded("MOVE_M@QUICK") do
                Citizen.Wait(100)
            end
            SetPedMovementClipset(playerPed, "MOVE_M@QUICK", 0.5)
        
            PlaySoundFrontend(-1, "FocusIn", "HintCamSounds", 1)
            CreateThread(function()
                local endTime = GetGameTimer() + (Config.drugs['cocaine'].duration * 1000)
                while GetGameTimer() < endTime do
                    SetFlash(0, 0, 100, 255, 100)
                    Wait(5000) 
                end
            end)
        
            SetTimeScale(1.4) 
        end
    },

    ['marijuana'] = {
        type = 'smoke',
        maxUsage = 3,
        duration = 60,
        name = "Marijuana",
        description = "Marijuana is a psychoactive drug derived from the cannabis plant.",
        weight = 0.7,

        ['effect'] = function()
            local playerPed = PlayerPedId()
            local player = PlayerId()

            StartScreenEffect("DrugsDrivingOut", 0, true)
            SetTimecycleModifier("drug_flying_01") 

            SetPedMotionBlur(playerPed, true);
            SetTimeScale(0.8)
            ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.5)

            RequestAnimSet("MOVE_M@DRUNK@MODERATEDRUNK") 
            while not HasAnimSetLoaded("MOVE_M@DRUNK@MODERATEDRUNK") do
                Citizen.Wait(100)
            end
            SetPedMovementClipset(playerPed, "MOVE_M@DRUNK@MODERATEDRUNK", 0.2)
        end
    },

    ['heroin'] = {
        name = "Heroin",
        description = "Heroin is a highly addictive drug that can cause severe physical and psychological dependence.",
        weight = 0.5,
        type = 'syringe',
        maxUsage = 3,
        duration = 180,

        ['effect'] = function()
            local playerPed = PlayerPedId()

            StartScreenEffect("PPGreenOut", 0, true) 
            SetTimecycleModifier("spectator5") 
            SetExtraTimecycleModifier("Bloom") 
            ShakeGameplayCam("DRUNK_SHAKE", 0.1)
        
            SetTimeScale(0.6) 
        
            RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK") 
            while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
                Citizen.Wait(100)
            end
            SetPedMovementClipset(playerPed, "MOVE_M@DRUNK@VERYDRUNK", 0.8)
        
            PlaySoundFrontend(-1, "On_Call_Player_Join", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1) 
        
            CreateThread(function()
                local endTime = GetGameTimer() + (Config.drugs['heroin'].duration * 1000)
                while GetGameTimer() < endTime do
                    ShakeGameplayCam("ROAD_VIBRATION_SHAKE", 0.1) 
                    SetEntityHealth(playerPed, GetEntityHealth(playerPed) - 5)
                    
                    Wait(5000)
                end
            end)
        end
    },

    ['mdma'] = {
        name = "Ecstasy",
        description = "Ecstasy is a psychedelic drug that can cause hallucinations and euphoria.",
        weight = 0.5,
        type = 'pill',
        maxUsage = 3,
        duration = 3,

        ['effect'] = function()
            local playerPed = PlayerPedId();
            local player = PlayerId();

            StartScreenEffect("DrugsMichaelAliensFight", 0, true)
            SetTimecycleModifier("spectator5") 
            ShakeGameplayCam("DRUNK_SHAKE", 0.4)

            AnimpostfxPlay("DrugsDrivingIn", 180000, false);
            AnimpostfxPlay("DrugsMichaelAliensFight", 180000, false);
            
            SetTimecycleModifierStrength(0.5);
            ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.4);

            SetRunSprintMultiplierForPlayer(player, 1.29);
            SetSwimMultiplierForPlayer(player, 1.1);
            
            RequestAnimSet("MOVE_M@BRAVE@A");
            while not HasAnimSetLoaded("MOVE_M@BRAVE@A") do Wait(250) end
            SetPedMovementClipset(playerPed, "MOVE_M@BRAVE@A", true);

            SetPedMotionBlur(playerPed, true);

            CreateThread(function()
                local endTime = GetGameTimer() + (Config.drugs['mdma'].duration * 1000)
                while GetGameTimer() < endTime do
                    SetEntityHealth(playerPed, GetEntityHealth(playerPed) - 10);
                    Wait(10000);
                end
            end)
        end
    }
}
