/*

    [cursorObject, cursorObject, 0] execVM "Grad-leakage\functions\client\fn_holeFX.sqf";
*/

params ["_bus", "_vehicle", "_hole"];

private _sound = (selectRandom [
    "leakage_hit1",
    "leakage_hit2",
    "leakage_hit3",
    "leakage_hit4"
]);

_hole say3d _sound;

if (player == driver _bus) then {
    playSound _sound;
    hintSilent "fuel tank hit!";
};

[_bus, _vehicle, _hole] call GRAD_leakage_fnc_holeFXcreate;