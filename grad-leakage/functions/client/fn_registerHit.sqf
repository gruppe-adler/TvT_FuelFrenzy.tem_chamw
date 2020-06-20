params ["_bus", "_busTank", ["_liquidLevel", 1]];

_busTank setVariable ["FF_parentBus", _bus, true];

if (hasInterface) then {
	_busTank addEventHandler ["HitPart", {
	    (_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];

	    if (isNull _shooter) exitWith {}; // probably an explosion
	    if (!_isDirect) exitWith {}; // ricochet
	    private _position = ASLToAGL _position; // HitPart position is ASL
		private _modelOffset = _target worldToModelVisual _position; // calculate locally for precision
		// private _relDir = _target getRelDir _shooter;
		// systemChat "local hit";
		// dont make every hit count
	    ["GRAD_leakage_holeRegister", [_target, _modelOffset]] call CBA_fnc_serverEvent;
	}];
};


if (isServer) then {
	if (GRAD_LEAKAGE_DEBUG) then {
		private _liquidLevelIndicator = "Sign_Sphere10cm_F" createVehicle [0,0,0];
		_liquidLevelIndicator attachTo [_busTank, [0,0,0]];

		[{
			params ["_args", "_handle"];
			_args params ["_bus", "_busTank", "_liquidLevelIndicator"];

			private _fuelCargo = _bus getVariable ["ace_refuel_currentFuelCargo", 0];
			private _fuelMaxCargo = _bus getVariable ["ace_refuel_fuelMaxCargo", 0];

			private _liquidLevel = linearConversion [0, _fuelMaxCargo, _fuelCargo, 0, 1, true];
			[_busTank, _liquidLevelIndicator, _liquidLevel] call GRAD_leakage_fnc_adjustLiquidLevelIndicator;


			private _holes = _bus getVariable ["GRAD_leakage_holes", []];
			{
				private _hole = _x;
				if ([_busTank, _hole, _liquidLevel] call GRAD_leakage_fnc_isLeaking) then {
					// _fuelCargo = _fuelCargo - GRAD_LEAKAGE_SPEED;
					_fuelCargo = _fuelCargo - (GRAD_LEAKAGE_SPEED * sqrt (20 * _fuelCargo));
					_bus setVariable ["ace_refuel_currentFuelCargo", _fuelCargo, true];

					// only broadcast if not already set
					if (!(_hole getVariable ["GRAD_leakage_holeActive", false])) then {
						_hole setVariable ["GRAD_leakage_holeActive", true, true];
					};
				} else {
					_hole setVariable ["GRAD_leakage_holeActive", false, true];
				};
			} forEach _holes;

		}, 1, [_bus, _busTank, _liquidLevelIndicator]] call CBA_fnc_addPerFrameHandler;
	};
};
