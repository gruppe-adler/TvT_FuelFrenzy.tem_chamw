params ["_vehicle", "_hole", "_dir"];

// systemChat "entering holeStreamCreate";
// diag_log "entering holeStreamCreate";


private _stream = "#particlesource" createVehicleLocal [0,0,0];
_stream attachTo [_hole, [0,0,0]];

_stream setParticleParams [
    ["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,4,[0,0,0],
    [sin (_dir) * 1,cos (_dir) * 1,0],0,1.5,1,0.1,[0.05,0.2,0.5],[[0.8,0.7,0.2,0.3], [0.8,0.7,0.2,0.7]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]];

_stream setDropInterval 0.01;



private _streamPuddle = "#particlesource" createVehicleLocal [0,0,0];
_stream attachTo [_hole, [0,0,0]];

_streamPuddle setParticleParams [
            ["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,4,[0,0,0],
            [sin (_dir) * 1,cos (_dir) * 1,0],0,1.5,1,0.1,[0.05,0.2,0.5],[[0.8,0.7,0.2,0.3], [0.8,0.7,0.2,0.7]],[1],1,0,"","Grad-leakage\functions\client\fn_puddleCreate.sqf",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]];

_streamPuddle setDropInterval 3;


[_stream, _streamPuddle]
