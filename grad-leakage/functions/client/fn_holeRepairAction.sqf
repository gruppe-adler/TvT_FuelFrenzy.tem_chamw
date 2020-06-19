params ["_vehicle"];

// add action to repair

private _repairAction = [
    "RepairHole",
    "Repair Holes",
    "\A3\ui_f\data\igui\cfg\actions\repair_ca.paa",
    {
        [_target] call GRAD_leakage_fnc_holeRepair;
    }, {
        count (_target getVariable ["GRAD_leakage_holes", []]) > 0
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;


[_vehicle, 0, ["ACE_MainActions"], _repairAction] call ace_interact_menu_fnc_addActionToObject;