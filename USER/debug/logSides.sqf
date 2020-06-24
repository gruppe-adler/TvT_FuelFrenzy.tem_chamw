params ["_name", "_encryption", "_ffOriginalSide", "_technicalSide", "_didjip"];

diag_log format ["------------------ FF TFAR RADIOS RECEIVED BEGIN ------------------"];
diag_log format ["name player: %1", _name];
diag_log format ["radio code: %1", _encryption];
diag_log format ["FF originalSide: %1", _ffOriginalSide];
diag_log format ["technical side (should be east): %1", _technicalSide];
diag_log format ["client JIP: %1", _didjip];
diag_log format ["------------------ FF TFAR RADIOS RECEIVED END ------------------"];