params ["_vehicle", "_hole"];

// systemChat "entering holeStreamCreate";
// diag_log "entering holeStreamCreate";
private _dir = _vehicle getDir _hole;

private _stream = "#particlesource" createVehicleLocal [0,0,0];
_stream attachTo [_hole, [0,0,0]];

_stream setParticleParams [
    ["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,4,[0,0,0],
    [sin (_dir) * 1,cos (_dir) * 1,0],0,1.5,1,0.1,[0.05,0.2,0.5],[[0.8,0.7,0.2,0.3], [0.8,0.7,0.2,0.7]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]];

private _streamPuddle = "#particlesource" createVehicleLocal [0,0,0];
_stream attachTo [_hole, [0,0,0]];

_streamPuddle setParticleParams [
            ["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,4,[0,0,0],
            [sin (_dir) * 1,cos (_dir) * 1,0],0,1.5,1,0.1,[0.05,0.2,0.5],[[0.8,0.7,0.2,0.3], [0.8,0.7,0.2,0.7]],[1],1,0,"","Grad-leakage\functions\client\fn_puddleCreate.sqf",_streamPuddle,0,true,0.1,[[0.8,0.7,0.2,0]]];

[{
    params ["_args", "_handle"];
    _args params ["_vehicle", "_hole", "_stream", "_streamPuddle"];

    private _dir = _vehicle getDir _hole;

    if (!(_hole getVariable ["GRAD_leakage_holeActive", false])) then { 
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    _stream setParticleParams [
    ["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,4,[0,0,0],
    [sin (_dir) * 1,cos (_dir) * 1,0],0,1.5,1,0.1,[0.05,0.2,0.5],[[0.8,0.7,0.2,0.3], [0.8,0.7,0.2,0.7]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]];

    _streamPuddle setParticleParams [
            ["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,4,[0,0,0],
            [sin (_dir) * 1,cos (_dir) * 1,0],0,1.5,1,0.1,[0.05,0.2,0.5],[[0.8,0.7,0.2,0.3], [0.8,0.7,0.2,0.7]],[1],1,0,"","Grad-leakage\functions\client\fn_puddleCreate.sqf",_streamPuddle,0,true,0.1,[[0.8,0.7,0.2,0]]];
    
}, 1, [_vehicle, _hole, _stream, _streamPuddle]] call CBA_fnc_addPerFrameHandler;

// suppress leaking too early
[{
    params ["_hole", "_stream", "_streamPuddle"];

    if (_hole getVariable ["GRAD_leakage_holeActive", false]) then {
        _stream setDropInterval 0.01;
        _streamPuddle setDropInterval 3;
    };

}, [_hole, _stream, _streamPuddle], 1] call CBA_fnc_waitAndExecute;

[_stream, _streamPuddle]


