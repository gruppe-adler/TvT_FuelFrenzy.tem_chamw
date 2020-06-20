if (missionNamespace getVariable ["grad_linearSD_linearSDActive",false]) exitWith {};

[false] call ace_spectator_fnc_setSpectator;

if (([missionConfigFile >> "missionsettings","waveRespawnEnabled",0] call BIS_fnc_returnConfigEntry) == 1) then {
    _this call grad_waverespawn_fnc_onPlayerRespawn;
};