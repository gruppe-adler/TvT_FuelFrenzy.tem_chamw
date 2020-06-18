params ["_vehicle", "_hole", "_relDir"];

_hole setVariable ["GRAD_leakage_holeActive", true];

[_hole] call GRAD_leakage_fnc_holeRepairAction;

_hole say3d (selectRandom [
    "leakage_hit1",
    "leakage_hit2",
    "leakage_hit3",
    "leakage_hit4",
    "leakage_hit5"
]);


private _stream = "#particlesource" createVehicleLocal [0,0,0];
_stream setParticleRandom [0,[0.004,0.004,0.004],[0.01,0.01,0.01],30,0.01,[0,0,0,0],0,0.02,360];
_stream setDropInterval 0.1;

// get outwards dir
private _dir = _vehicle getRelDir _hole;


_stream attachTo [_hole, [0,0,0]];

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

[_vehicle, _hole, _stream, _dir] spawn {
    params ["_vehicle", "_hole", "_stream", "_dir"];
    while {!isNull _hole && {_hole getVariable ["GRAD_leakage_holeActive", false]}} do {
        private _fuelLevel = _vehicle getVariable ["GRAD_fuelLeak_fuelLevel", 1];
        _stream setParticleParams [["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,3,[0,0,0],[sin (_dir) * (1/_fuelLevel),cos (_dir) * (1/_fuelLevel),0.1],0,1,0.01,0.0001,[0.04,0.09,0.15],[[0.7,0.7,0.8,0.5],[0.7,0.7,0.8,0.5],[0.7,0.8,0.8,0.1]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]] ;
        sleep 0.02;
    };

    deleteVehicle _stream;
};
