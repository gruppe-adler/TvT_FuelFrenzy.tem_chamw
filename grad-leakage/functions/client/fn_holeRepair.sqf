params ["_hole"];

[5, [_hole], {
  (_this select 0) params ["_args", "_onFinish", "_onFail", "_condition", "_player", "_startTime", "_totalTime", "_exceptions"];
  _args params ["_hole"];
  ["GRAD_leakage_holeRepairing", [_hole]] call CBA_fnc_serverEvent;
  Hint "Hole repaired!"
}, {
  hint "Aborted repair."
}, "Repairing Hole"] call ace_common_fnc_progressBar;
