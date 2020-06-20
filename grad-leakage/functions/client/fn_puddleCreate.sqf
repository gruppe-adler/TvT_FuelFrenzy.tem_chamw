

// systemChat str _this;

private _type = "WaterSpill_01_Small_Foam_F";

if (((nearestObjects [_this, [_type], 10]) find _type) < 0) then {
    private _puddle = _type createVehicleLocal _this;
    _puddle setDir (Random 360);
    _puddle setVectorUp surfaceNormal position _puddle;
};
