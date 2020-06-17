params ["_vehicle", "_side"];

if (!isServer) exitWith {};

_vehicle setVariable ["FF_originalSide", _side, true];
_vehicle setVariable ["FF_trackedForSide", _side, true];

_vehicle addEventHandler ["Killed", {
        params ["_unit", "_killer", "_instigator", "_useEffects"];

        private _side = _unit getVariable ["FF_originalSide", sideUnknown];
        private _sideKiller = _killer getVariable ["FF_originalSide", sideUnknown];
        if (_side != _sideKiller) then {
            _newPoints = [_sideKiller, 200, "VEHICLEKILLED"] call grad_points_fnc_addPoints;
        };
}];

if (typeOf _vehicle == "gm_pl_army_ural375d_refuel") then {
    [_vehicle, 0] call ace_refuel_fnc_makeSource;
    [_vehicle, 0] call ace_refuel_fnc_setFuel;
};
