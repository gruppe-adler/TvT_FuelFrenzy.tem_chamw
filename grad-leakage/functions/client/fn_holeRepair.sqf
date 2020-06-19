params ["_vehicle"];

[5, [_vehicle], {
  (_this select 0) params ["_args", "_onFinish", "_onFail", "_condition", "_player", "_startTime", "_totalTime", "_exceptions"];
  _args params ["_vehicle"];
  ["GRAD_leakage_holeRepairing", [_vehicle]] call CBA_fnc_serverEvent;
  Hint "Holes repaired!"
}, {
  hint "Aborted repair."
}, "Repairing Hole"] call ace_common_fnc_progressBar;
