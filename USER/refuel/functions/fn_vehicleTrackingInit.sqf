if (isDedicated) exitWith {};

{
    _x addEventHandler ["GetInMan", {
        params ["_unit", "_role", "_vehicle", "_turret"];

        if (_role == "driver") then {
            private _side = _unit getVariable ["FF_originalSide", sideUnknown];
            _vehicle setVariable ["FF_trackedForSide", _side, true];
            systemChat ("Marked Vehicle for side " + str _side);
        };
    }];

} forEach playableUnits + switchableUnits;

execVM "USER\refuel\functions\fn_vehicleTrackingLoop.sqf";