params ["_bus"];

[_bus] call GRAD_leakage_fnc_holeRepairAction;

private _fillCargoTankAction = [
    "RefuelStorage",
    "Fill vehicle fuel cargo",
    "",
    {
        private _virtualPosASL = (eyePos player) vectorAdd (positionCameraToWorld [0,0,0.6]) vectorDiff (positionCameraToWorld [0,0,0]);
        [
            player,
            _target,
            _virtualPosASL,
            player getVariable ["ace_refuel_nozzle", objNull]
        ] call refuel_fnc_connectAndRefuelCargo;
    }, {
        private _nozzle = player getVariable ["ace_refuel_nozzle", objNull];
        !(isNull _nozzle) && !(_nozzle getVariable ["ace_refuel_isConnected", false])
    }
] call ace_interact_menu_fnc_createAction;

private _refuelReplacementAction = [
    "RefuelTank",
    "Refuel vehicle itself",
    "",
    {
        private _virtualPosASL = (eyePos player) vectorAdd (positionCameraToWorld [0,0,0.6]) vectorDiff (positionCameraToWorld [0,0,0]);
        [
            player,
            _target,
            _virtualPosASL,
            player getVariable ["ace_refuel_nozzle", objNull]
        ] call refuel_fnc_connectAndRefuelVehicleTank;
    }, {
        private _nozzle = player getVariable ["ace_refuel_nozzle", objNull];
        !(isNull _nozzle) && 
        !(_nozzle getVariable ["ace_refuel_isConnected", false]) &&
        isNull (_target getVariable ["ff_refuel_nozzle", objNull])
    }
] call ace_interact_menu_fnc_createAction;

private _returnNozzleAction = [
    "ReturnNozzle",
    "Return Nozzle to Bus",
    "",
    {
        [player, _target] call ace_refuel_fnc_returnNozzle
    }, {
        [player, _target] call ace_refuel_fnc_canReturnNozzle
}] call ace_interact_menu_fnc_createAction;

private _nudgeBus = [
    "NudgeBus",
    "Nudge Bus",
    "",
    {
        private _vectorDir = vectorDir player;
        _target setVelocity (_vectorDir vectorMultiply 3);
    }, {
        true
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;

{
    [_bus, 0, ["ACE_MainActions", "ace_refuel_Refuel"], _x] call ace_interact_menu_fnc_addActionToObject;
} forEach [_fillCargoTankAction, _returnNozzleAction, _refuelReplacementAction];

[_bus, 0, ["ACE_MainActions"], _nudgeBus] call ace_interact_menu_fnc_addActionToObject;