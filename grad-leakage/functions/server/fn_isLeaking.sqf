params ["_vehicle", "_hole", "_liquidLevel"];

private _isLeaking = false;

private _offset = _hole getVariable ["GRAD_leakage_holeOffset", [0,0,0]];
private _height = [_vehicle, _offset] call GRAD_leakage_fnc_getHeightInModel;

if (_height < _liquidLevel) then {
    _isLeaking = true;
};

systemChat ("height: " + str _height + " / liquid: " + str _liquidLevel + " / isLeaking: " + str _isLeaking);

_isLeaking