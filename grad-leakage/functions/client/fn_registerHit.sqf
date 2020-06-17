params ["_vehicle", ["_liquidLevel", 1]];

if (hasInterface) then {
	_vehicle addEventHandler ["HitPart", {
	    (_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];

	    if (isNull _shooter) exitWith {}; // probably an explosion
	    if (!_isDirect) exitWith {}; // ricochet
	    private _position = ASLToAGL _position; // HitPart position is ASL
		private _modelOffset = _target worldToModelVisual _position; // calculate locally for precision
		private _relDir = _target getRelDir _shooter;
		// systemChat str _relDir;
		// dont make every hit count
	    ["GRAD_leakage_holeRegister", [_target, _modelOffset, _relDir]] call CBA_fnc_serverEvent;
	}];
};


if (isServer) then {
	// doublecheck fuel is maxed out at 1
	_vehicle setVariable ["GRAD_leakage_liquidLevel", _liquidLevel, true];

	if (GRAD_LEAKAGE_DEBUG) then {
		private _liquidLevelIndicator = "Sign_Arrow_Large_Cyan_F" createVehicle [0,0,0];
		_liquidLevelIndicator attachTo [_vehicle, [0,0,0]];

		[{
			params ["_args", "_handle"];
			_args params ["_vehicle", "_liquidLevelIndicator"];

			private _fuelCargo = _vehicle getVariable ["ace_refuel_fuelCargo", 0];
			private _fuelMaxCargo = _vehicle getVariable ["ace_refuel_fuelMaxCargo", 0];

			private _liquidLevel = linearConversion [0, _fuelMaxCargo, _fuelCargo, 0, 1, true]; // _vehicle getVariable ["GRAD_leakage_liquidLevel", 1];

			if (!(_liquidLevel > 0)) exitWith { systemChat "liquid 0"; };

			// systemChat str _liquidLevel;

			[_vehicle, _liquidLevelIndicator, _liquidLevel] call GRAD_leakage_fnc_adjustLiquidLevelIndicator;


			private _existingHoles = _vehicle getVariable ["GRAD_leakage_holes", []];
			{
				private _liquidLevel = _vehicle getVariable ["GRAD_leakage_liquidLevel", 1];
				if ([_vehicle, _x, _liquidLevel] call GRAD_leakage_fnc_isLeaking) then {
					_liquidLevel = _liquidLevel - GRAD_LEAKAGE_SPEED;
					private _fuelCargo = linearConversion [0, 1, _liquidLevel, 0, _fuelMaxCargo, true];
					// systemChat str _liquidLevel;
					_vehicle setVariable ["ace_refuel_fuelCargo", 0, true];
					_vehicle setVariable ["GRAD_leakage_liquidLevel", _liquidLevel];
				} else {
					_x setVariable ["GRAD_leakage_holeActive", false, true];
				};
			} forEach _existingHoles;

		}, 1, [_vehicle, _liquidLevelIndicator]] call CBA_fnc_addPerFrameHandler;
	};
};