#include "component.hpp"

private _playerSide = [player] call BIS_fnc_objectSide; // JIP/init proof alternative to playerSide

switch (_playerSide) do {
    case (WEST): {
        player setVariable ["wr_waitCondition", {!GVAR(WAVERESPAWNBLU)}];
        player setVariable ["wr_interruptCondition", compile ([missionConfigFile >> "missionsettings","bluforInterruptCondition","false"] call BIS_fnc_returnConfigEntry)];
        player setVariable ["wr_playersLeft", {GVAR(WAVERESPAWNPLAYERSLEFTBLU)}];
        player setVariable ["wr_waveTimeLeft", {GVAR(WAVERESPAWNTIMELEFTBLU)}];
        player setVariable ["wr_waveSize", {GVAR(BLUFORWAVESIZE)}];
    };
    case (EAST): {
        player setVariable ["wr_waitCondition", {!GVAR(WAVERESPAWNOPF)}];
        player setVariable ["wr_interruptCondition", compile ([missionConfigFile >> "missionsettings","opforInterruptCondition","false"] call BIS_fnc_returnConfigEntry)];
        player setVariable ["wr_playersLeft", {GVAR(WAVERESPAWNPLAYERSLEFTOPF)}];
        player setVariable ["wr_waveTimeLeft", {GVAR(WAVERESPAWNTIMELEFTOPF)}];
        player setVariable ["wr_waveSize", {GVAR(OPFORWAVESIZE)}];
    };
    case (INDEPENDENT): {
        player setVariable ["wr_waitCondition", {!GVAR(WAVERESPAWNIND)}];
        player setVariable ["wr_interruptCondition", compile ([missionConfigFile >> "missionsettings","indepInterruptCondition","false"] call BIS_fnc_returnConfigEntry)];
        player setVariable ["wr_playersLeft", {GVAR(WAVERESPAWNPLAYERSLEFTIND)}];
        player setVariable ["wr_waveTimeLeft", {GVAR(WAVERESPAWNTIMELEFTIND)}];
        player setVariable ["wr_waveSize", {GVAR(INDEPWAVESIZE)}];
    };
    case (CIVILIAN): {
        player setVariable ["wr_waitCondition", {!GVAR(WAVERESPAWNCIV)}];
        player setVariable ["wr_interruptCondition", compile ([missionConfigFile >> "missionsettings","civInterruptCondition","false"] call BIS_fnc_returnConfigEntry)];
        player setVariable ["wr_playersLeft", {GVAR(WAVERESPAWNPLAYERSLEFTCIV)}];
        player setVariable ["wr_waveTimeLeft", {GVAR(WAVERESPAWNTIMELEFTCIV)}];
        player setVariable ["wr_waveSize", {GVAR(CIVWAVESIZE)}];
    };
    default {
        ERROR_1("Playerside is %1",_playerSide);
    };
};

player setVariable ["wr_playerRespawnTimeLeft", GVAR(WAVERESPAWNTIMEPLAYER)];
player setVariable ["wr_interrupted", false];
player setVariable ["wr_isFreeRespawn", false];
player setVariable ["wr_playerCountdownDone", false];
player setVariable ["wr_waveCountdownDone", false];
player setVariable ["wr_cvCheckDone", false];
