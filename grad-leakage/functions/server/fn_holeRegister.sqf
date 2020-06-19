params ["_vehicle", "_offset", "_relDir"];

private _bus = _vehicle getVariable ["FF_parentBus", objNull];

if (random 3 > 1) then {
    ["GRAD_leakage_holeSpall", [_vehicle, _offset]] call CBA_fnc_globalEvent;
} else {
    private _hole = createVehicle ["Sign_Sphere10cm_F", [0,0,0], [], 0, "CAN_COLLIDE"];
    _hole attachTo [_vehicle, _offset];
    _hole setVariable ["GRAD_leakage_holeOffset", _offset];
    _hole setObjectMaterialGlobal [0, "\A3\soft_F\Offroad_01\Data\Offroad_01_ext_destruct.rvmat"];
    _hole setObjectTextureGlobal [0, "#(rgb,8,8,3)color(0,0,0,1)"];

    private _holes = _bus getVariable ["GRAD_leakage_holes", []];
    _holes pushBackUnique _hole;
    _bus setVariable ["GRAD_leakage_holes", _holes, true];

    ["GRAD_leakage_holeFXinit", [_bus, _vehicle, _hole, _relDir]] call CBA_fnc_globalEvent;
};
