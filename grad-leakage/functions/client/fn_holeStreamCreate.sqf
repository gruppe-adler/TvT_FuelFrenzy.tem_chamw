params ["_vehicle", "_hole", "_dir"];

// systemChat "entering holeStreamCreate";
diag_log "entering holeStreamCreate";

private _stream = "#particlesource" createVehicleLocal [0,0,0];
_stream setParticleRandom [0, [0, 0, 0], [0, 0, 0], 0, 0, [0, 0, 0, 0], 0, 0];
_stream setDropInterval 0.1;

_stream attachTo [_hole, [0,0,0]];

_stream setParticleParams [
    ["a3\data_f\RainDrop.p3d", 1, 0, 1], "", "SpaceObject",1,3,[0,0,0],
  [sin _dir,cos _dir,0.1],0,1,0.01,0.0001,[1,1,1],
  [[1,1,1,0.5]],[0],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]
];
_stream setDropInterval 0.01;

_stream
