#include "component.hpp"

params ["",["_oldUnit",objNull]];

private _playerSide = [player] call BIS_fnc_objectSide; // JIP/init proof alternative to playerSide
[_oldUnit,_playerSide] remoteExec [QFUNC(removeFromWave),2,false];
[_oldUnit,_playerSide,false] remoteExec [QFUNC(addToWaiting),2,false];

setPlayerRespawnTime 99999;

hint "";

[] call FUNC(resetPlayerVars);
