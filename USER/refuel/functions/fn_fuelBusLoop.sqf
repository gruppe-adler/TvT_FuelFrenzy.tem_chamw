{
    _x params ["_spawnHelper", "_side"];
    private _position = getPos _spawnHelper;
    private _dir = getDir _spawnHelper;

    private _bus = [_side, _position, _dir] call refuel_fnc_fuelBusSpawn;
} forEach [
    [fuelBusSpawn_west, west],
    [fuelBusSpawn_east, east],
    [fuelBusSpawn_independent, independent],
    [fuelBusSpawn_civilian, civilian]
];