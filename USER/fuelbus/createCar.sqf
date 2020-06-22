params ["_type", "_pos", "_dir"];

_pos params ["_posX", "_posY"];

private _vehicle = createVehicle [_type, [_posX, _posY, 2], [], 0, "CAN_COLLIDE"];
_vehicle setDir _dir;