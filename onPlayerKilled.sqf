if (missionNamespace getVariable ["grad_linearSD_linearSDActive",false]) exitWith {
    [] call grad_linearSD_fnc_onPlayerKilled;
};

//WAVE RESPAWN
if (([missionConfigFile >> "missionsettings","waveRespawnEnabled",0] call BIS_fnc_returnConfigEntry) == 1) then {
    [] call grad_waverespawn_fnc_onPlayerKilled;


//NORMAL RESPAWN
} else {
    _respawnTimeVar = switch (playerSide) do {
        case (WEST): {"respawntimeBlu"};
        case (EAST): {"respawntimeOpf"};
        case (INDEPENDENT): {"respawntimeInd"};
        case (CIVILIAN): {"respawntimeCiv"};
        default {"respawntimeBlu"};
    };
    _respawnTime = [missionConfigFile >> "missionsettings",_respawnTimeVar,10] call BIS_fnc_returnConfigEntry;

    if (_respawnTime > 1800) then {
        [[west, east, independent, civilian], []] call ace_spectator_fnc_updateSides;
        [true] call ace_spectator_fnc_setSpectator;
    } else {
        private _side = player getVariable ["FF_originalSide", sideUnknown];
        private _playersOfSide = [];
        private _unitsOfSide = { 
            if (_x getVariable ["FF_originalSide", sideUnknown] == _side) then { _playersOfSide pushBackUnique _x; };
        } count (playableUnits + switchableUnits);
        [_playersOfSide, []] call ace_spectator_fnc_updateUnits;
        [true] call ace_spectator_fnc_setSpectator;
    };

    setPlayerRespawnTime _respawnTime;
    forceRespawn player;
};
