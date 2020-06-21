params ["_busTank", "_offset"];

private _bus = _busTank getVariable ["FF_parentBus", objNull];

if (random 20 > 1) then {
    ["GRAD_leakage_holeSpall", [_busTank, _offset]] call CBA_fnc_globalEvent;
} else {
    private _hole = createVehicle ["Sign_Sphere10cm_F", [0,0,0], [], 0, "CAN_COLLIDE"];
    _hole attachTo [_busTank, _offset];
    _hole setVariable ["GRAD_leakage_holeOffset", _offset];
    _hole setObjectMaterialGlobal [0, "\A3\soft_F\Offroad_01\Data\Offroad_01_ext_destruct.rvmat"];
    _hole setObjectTextureGlobal [0, "#(rgb,8,8,3)color(0,0,0,1)"];
    _hole setVariable ["GRAD_leakage_holeActive", true, true];

    private _holes = _bus getVariable ["GRAD_leakage_holes", []];
    _holes pushBackUnique _hole;
    _bus setVariable ["GRAD_leakage_holes", _holes, true];

    ["GRAD_leakage_holeFX", [_bus, _busTank, _hole]] call CBA_fnc_globalEvent;
};