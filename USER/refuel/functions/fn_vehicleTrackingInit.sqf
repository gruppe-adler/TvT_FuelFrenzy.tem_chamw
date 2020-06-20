if (isDedicated) exitWith {};

{
    _x addEventHandler ["GetInMan", {
        params ["_unit", "_role", "_vehicle", "_turret"];

        if (_role == "driver") then {
            private _side = _vehicle getVariable ["FF_originalSide", sideUnknown];
            private _trackedForSide = _vehicle getVariable ["FF_trackedForSide", sideUnknown];

            if (_side != _trackedForSide && local _unit) then {
                hintSilent parseText ("<t color='#FFFFFF'><t size='1'><t align='center'>Taking vehicle into possession for your side.</t>");
                _vehicle setVariable ["FF_trackedForSide", _side, true];

                ["Your fuel truck was stolen."] remoteExec ["hintSilent", _side];
                _vehicle setVariable ["FF_originalSide", _side, true];
            };
        };
    }];

} forEach playableUnits + switchableUnits;

execVM "USER\refuel\functions\fn_vehicleTrackingLoop.sqf";