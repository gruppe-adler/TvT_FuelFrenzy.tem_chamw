params ["_vehicle", "_offset"];

private _bbr = 0 boundingBoxReal _vehicle;
_bbr params ["_p1", "_p2"];    
private _maxHeight = abs ((_p2 select 2) - (_p1 select 2));
private _offsetZ = _offset select 2; // might be -1.5, we need some 
private _normalizedOffset = _maxHeight/2 + _offsetZ;
private _heightInModel = _normalizedOffset/_maxHeight;

_heightInModel