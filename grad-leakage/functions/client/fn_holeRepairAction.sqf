params ["_hole"];

// add action to repair

private _repairAction = [
    "RepairHole",
    "Repair Hole",
    "\A3\ui_f\data\igui\cfg\actions\repair_ca.paa",
    {
        [_target] call GRAD_leakage_fnc_holeRepair;
    }, {
        ((player distance _target) < 6)
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;

{
    [_hole, 0, ["ACE_MainActions"], _repairAction] call ace_interact_menu_fnc_addActionToObject;
} forEach [_fillCargoTankAction, _returnNozzleAction, _refuelReplacementAction];
