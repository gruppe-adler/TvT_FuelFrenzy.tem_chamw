if (isDedicated) exitWith {};

{
    _x addEventHandler ["GetInMan", {
        params ["_unit", "_role", "_vehicle", "_turret"];

        if (_role == "driver") then {
            private _side = _unit getVariable ["FF_originalSide", sideUnknown];
            _vehicle setVariable ["FF_trackedForSide", _side, true];
        };
    }];

} forEach playableUnits + switchableUnits;

call refuel_fnc_vehicleTrackingLoop;