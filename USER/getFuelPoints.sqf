params [
    ["_side", sideUnknown]
];
switch (_side) do {
    case west: {[fuelSellPoint_west] call ace_refuel_fnc_getFuel };
    case east: {[fuelSellPoint_east] call ace_refuel_fnc_getFuel };
    case independent: {[fuelSellPoint_independent] call ace_refuel_fnc_getFuel };
    case civilian: {[fuelSellPoint_civilian] call ace_refuel_fnc_getFuel };
    default {0};
};
