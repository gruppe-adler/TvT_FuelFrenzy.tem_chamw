GRAD_LEAKAGE_DEBUG = true;
GRAD_LEAKAGE_SPEED = 0.005;

// CLIENT EH
if (hasInterface) then {

    ["GRAD_leakage_holeSpall", {
        params ["_busTank", "_offset"];

        diag_log format ["holeSpall"];
        [_busTank, _offset] call GRAD_leakage_fnc_holeSpall;
    }] call CBA_fnc_addEventHandler;

    ["GRAD_leakage_holeFX", {
        params ["_bus", "_busTank", "_hole"];

        diag_log format ["holeFX"];
        [_bus, _busTank, _hole] call GRAD_leakage_fnc_holeFXinit;
        [_busTank, _offset] call GRAD_leakage_fnc_holeSpall;
    }] call CBA_fnc_addEventHandler;
};

// SERVER EH
if (isServer) then {

    ["GRAD_leakage_holeRegister", {
        params ["_vehicle", "_offset"];

        [_vehicle, _offset] call GRAD_leakage_fnc_holeRegister;

    }] call CBA_fnc_addEventHandler;

    ["GRAD_leakage_holeRepairing", {
        params ["_bus"];

        private _holes = _bus getVariable ["GRAD_leakage_holes", []];
        {
            deleteVehicle _x;
        } forEach _holes;
        _bus setVariable ["GRAD_leakage_holes", [], true];

    }] call CBA_fnc_addEventHandler;
};