if (isDedicated) exitWith {};

{
    _x addEventHandler ["GetInMan", {
        params ["_unit", "_role", "_vehicle", "_turret"];

        if (_role == "driver") then {
            private _side = _unit getVariable ["FF_originalSide", sideUnknown];
            private _trackedForSide = _vehicle getVariable ["FF_trackedForSide", sideUnknown];

            if (_side != _trackedForSide && local _unit) then {
                ["Your fuel truck was stolen."] remoteExec ["hintSilent", _trackedForSide];

                hintSilent parseText ("<t color='#FFFFFF'><t size='1'><t align='center'>Taking vehicle into possession for your side.</t>");
                _vehicle setVariable ["FF_trackedForSide", _side, true];
            };
        };
    }];

} forEach playableUnits + switchableUnits;

execVM "USER\refuel\functions\fn_vehicleTrackingLoop.sqf";