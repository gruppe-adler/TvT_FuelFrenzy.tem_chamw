/*

    [cursorObject, cursorObject, 0] execVM "Grad-leakage\functions\client\fn_holeFXTest.sqf";

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
private _streamPuddle = "#particlesource" createVehicleLocal [0,0,0];

// get outwards dir
private _dir = (_vehicle getRelDir _hole);

_stream setPosASL _intersectPosASL;
_streamPuddle setPosASL _intersectPosASL;
private _positionHoleOffset = cursorObject worldToModelVisual getPos _hole;
_hole attachTo [cursorObject, _positionHoleOffset];


[cursorObject, _hole, _stream, _streamPuddle, _dir] spawn {
    params ["_vehicle", "_hole", "_stream", "_streamPuddle", "_dir"];

        _stream setParticleParams [
            ["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,4,[0,0,0],
            [sin (_dir) * 1,cos (_dir) * 1,0],0,1.5,1,0.1,[0.05,0.2,0.5],[[0.8,0.7,0.2,0.3], [0.8,0.7,0.2,0.7]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]];

        _stream setDropInterval 0.01;

        _streamPuddle setParticleParams [
            ["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,4,[0,0,0],
            [sin (_dir) * 1,cos (_dir) * 1,0],0,1.5,1,0.1,[0.05,0.2,0.5],[[0.8,0.7,0.2,0.3], [0.8,0.7,0.2,0.7]],[1],1,0,"","Grad-leakage\functions\client\fn_puddleCreate.sqf",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]];

        _streamPuddle setDropInterval 1;

    sleep 60;

    deleteVehicle _stream;
    deleteVehicle _streamPuddle;
};

[{
    params ["_args", "_handle"];
    _args params ["_vehicle", "_stream", "_streamPuddle", "_hole"];

    if (isNull _stream) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    private _positionASL = getPosASLVisual _hole;
    _stream setPosASL _positionASL;
    _streamPuddle setPosASL _positionASL;

}, 0, [cursorObject, _stream, _streamPuddle, _hole]] call CBA_fnc_addPerFrameHandler;



/*


    createSimpleObject [shapeName, positionWorld, local]
    createSimpleObject ["a3\data_f\krater.p3d", position player]
*/
