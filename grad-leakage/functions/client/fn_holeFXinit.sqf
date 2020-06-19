/*

    [cursorObject, cursorObject, 0] execVM "Grad-leakage\functions\client\fn_holeFX.sqf";
*/

params ["_bus", "_vehicle", "_hole", "_relDir"];

_hole say3d (selectRandom [
    "leakage_hit1",
    "leakage_hit2",
    "leakage_hit3",
    "leakage_hit4"
]);

[_bus, _vehicle, _hole, _relDir] call GRAD_leakage_fnc_holeFXcreate;
