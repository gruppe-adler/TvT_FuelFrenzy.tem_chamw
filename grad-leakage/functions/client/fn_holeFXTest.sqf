/*

    [cursorObject, cursorObject, 0] execVM "Grad-leakage\functions\client\fn_holeFX.sqf";

    only for debugging purposes of stream FX
*/

params ["_vehicle"];

private _ins = lineIntersectsSurfaces [
        AGLToASL positionCameraToWorld [0,0,0],
        AGLToASL positionCameraToWorld [0,0,1000],
        player
    ];
_ins params ["_intersectPos1"];
_intersectPos1 params ["_intersectPosASL"];

private _hole = createVehicle ["Sign_Sphere10cm_F", [0,0,0], [], 0, "CAN_COLLIDE"];
_hole setPosASL _intersectPosASL;


private _stream = "#particlesource" createVehicleLocal [0,0,0];
 // _stream setParticleRandom [0, [0, 0, 0], [0, 0, 0], 0, 0, [0, 0, 0, 0], 0, 0];
// _stream setParticleRandom [0,[0.004,0.004,0.004],[0.01,0.01,0.01],30,0.01,[0,0,0,0],0,0.02,360];
// _stream setParticleCircle [0, [0, 0, 0]];
// _stream setDropInterval 0.001;

// get outwards dir
private _dir = (player getRelDir _hole) - 180;

_stream setPosASL _intersectPosASL;
private _positionHoleOffset = cursorObject worldToModelVisual getPos _hole;
_hole attachTo [cursorObject, _positionHoleOffset];
// _stream attachTo [_hole, [0,0,0]];

/*
for "_i" from 0 to 1 step 0.01 do {
    _stream setParticleParams [["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,3,[0,0,0],[sin (_dir) * _i,cos (_dir) * _i,0],0,1.5,1,0.1,[0.02,0.02,0.1],[[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]] ;
    sleep 0.02;
    _full = _i;
    if (_fuelLevel > 0) then {
        _vehicle setVariable ["GRAD_fuelLeak_fuelLevel", (_fuelLevel - 0.01)];
    };
};
*/

[cursorObject, _hole, _stream, _dir] spawn {
    params ["_vehicle", "_hole", "_stream", "_dir"];


        /*
        _stream setParticleParams [
            ["Ca\Data\Cl_basic.p3d", 1, 0, 1], "", "Billboard", 1, 3,[0,0,0],
          [sin (_dir) * (1/1),cos (_dir) * (1/1),0.1],0,1,0.01,0.0001,[0.1],
          [[1,1,0.3,0.3]],[0],0,0,"","",0,0,true,0.1,[[0,0,0,0]]
        ];
        */
    _stream setParticleParams
[
    "\A3\Data_F_Mark\ParticleEffects\Universal\waterDrops",
    "", "SpaceObject", 1, 3, [0, 0, 0], [0, 0, -0.3], 0, 0.62, 0.15, 0.15,
    [0.01, 0.1], [[0.5, 0.5, 0.5, 1]], [0.01], 0.0, 0.0, "", "", ""
];
        _stream setDropInterval 0.01;

    sleep 60;

    deleteVehicle _stream;
};

[{
    params ["_args", "_handle"];
    _args params ["_vehicle", "_stream", "_hole"];

    if (isNull _stream) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    private _positionASL = getPosASLVisual _hole;
    _stream setPosASL _positionASL;

}, 0, [cursorObject, _stream, _hole]] call CBA_fnc_addPerFrameHandler;



/*


    createSimpleObject [shapeName, positionWorld, local]
    createSimpleObject ["a3\data_f\krater.p3d", position player]
*/
