params ["_vehicle", "_helper"];

private _addSpawnAction = [
    "AddSpawn",
    "Spawn Fuel Bus",
    "",
    {
        params ["_target", "_player", "_params"];
        _params params ["_helper"];
        [getPos _helper, getDir _helper] execVM "USER\fuelbus\createFuelBus.sqf";
    }, {
        (player distance _target) <= 4
    }, {}, [_helper]
] call ace_interact_menu_fnc_createAction;


[_vehicle, 0, ["ACE_MainActions"], _addSpawnAction] call ace_interact_menu_fnc_addActionToObject;