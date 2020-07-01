params ["_classname", "_vehicle", "_helper", "_side"];

private _addSpawnAction = [
    "AddSpawn",
    "Spawn Car",
    "",
    {
        params ["_target", "_player", "_params"];
        _params params ["_helper", "_classname", "_side"];
        [_classname, getPos _helper, getDir _helper, _side] execVM "USER\fuelbus\createCar.sqf";
    }, {
        (player distance _target) <= 4
    }, {}, [_helper, _classname, _side]
] call ace_interact_menu_fnc_createAction;


[_vehicle, 0, ["ACE_MainActions"], _addSpawnAction] call ace_interact_menu_fnc_addActionToObject;