local loadAnimDict = function(name)
    RequestAnimDict(name)
    while (not HasAnimDictLoaded(name)) do Wait(250) end
end

local sniff = function(playerPed)
    loadAnimDict("anim@mp_player_intcelebrationmale@face_palm")
    TaskPlayAnim(playerPed,"anim@mp_player_intcelebrationmale@face_palm","face_palm",8.0,8.0, -1, 0, 0, true, true, true)
    Wait(2500)
    ClearPedTasks(playerPed)
end

local pill = function(playerPed)
    loadAnimDict("mp_suicide")
    TaskPlayAnim(playerPed,"mp_suicide","pill",8.0,8.0, -1, 0, 0, true, true, true)
    Wait(2500)
    ClearPedTasks(playerPed)
end

local syringe = function(playerPed)
    loadAnimDict("rcmpaparazzo1ig_4")
    TaskPlayAnim(playerPed,"rcmpaparazzo1ig_4","miranda_shooting_up",8.0,8.0, -1, 16, 0, true, true, true)

    local hash = GetHashKey("prop_syringe_01")
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(0) end
    local prop = CreateObject(hash, GetEntityCoords(playerPed), true, true, false)
    SetModelAsNoLongerNeeded(hash)
    AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.03, 0.03, 143.0, 30.0, 0.0, true, true, false, false, 1, true)
    Wait(13000)
    AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 28422), -0.02, 0.01, -0.02, 1.0, 0, 0.0, true, true, false, false, 1, true)
    Wait(15000)
    DetachEntity(prop, 0, 0)
    DeleteEntity(prop)
    ClearPedTasks(playerPed)
end

local smoke = function(playerPed)
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Wait(10000)
    ClearPedTasks(playerPed)
end

local removeEveryEffect = function()
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsDrivingOut")
    StopScreenEffect("DrugsDrivingIn")
    SetExtraTimecycleModifier("")
    SetTimecycleModifier("")
    SetTimeScale(1.0)
    StopScreenEffect("FocusIn")
    StopScreenEffect("PPGreenOut")
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    SetSwimMultiplierForPlayer(PlayerId(), 1.0)
    SetPedMotionBlur(PlayerPedId(), false)
    ResetPedMovementClipset(PlayerPedId())
    SetPedIsDrunk(PlayerPedId(), false)
    ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.0)
end

local drugUsage = 0;
local usingDrug = false;

RegisterNetEvent('dt-useDrug', function(drugName)
    if usingDrug then return end
    if not Config.drugs[drugName] then return end

    usingDrug = true;

    local playerPed = PlayerPedId();
    drugUsage += 1;

    if drugUsage > Config.drugs[drugName].maxUsage then
        removeEveryEffect();
        drugUsage = 0;
        usingDrug = false;
        SetEntityHealth(playerPed, 0);
        return;
    end

    if Config.drugs[drugName].type == 'smoke' then
        smoke(playerPed);
    elseif Config.drugs[drugName].type == 'syringe' then
        syringe(playerPed);
    elseif Config.drugs[drugName].type == 'sniff' then
        sniff(playerPed);
    elseif Config.drugs[drugName].type == 'pill' then
        pill(playerPed);
    end

    Config.drugs[drugName].effect();

    Wait(Config.drugs[drugName].duration * 1000);
    removeEveryEffect();
    usingDrug = false;
end)

-- TEST COMMAND (UNCOMMENT TO USE)

-- RegisterCommand('testDrug', function()
--     TriggerEvent('dt-useDrug', 'mdma');
-- end)
