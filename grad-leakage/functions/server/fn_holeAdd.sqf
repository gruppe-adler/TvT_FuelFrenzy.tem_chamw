params ["_vehicle", "_offset"];

private _holes = _vehicle getVariable ["GRAD_leakage_holesExisting", []];
_holes pushBackUnique _offset;
_vehicle setVariable ["GRAD_leakage_holesExisting", _holes, true];