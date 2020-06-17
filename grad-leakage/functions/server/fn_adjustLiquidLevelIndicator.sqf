params ["_vehicle", "_indicator", "_level"];

systemChat str _level;
_indicator attachTo [_vehicle, [3,0,_level]];