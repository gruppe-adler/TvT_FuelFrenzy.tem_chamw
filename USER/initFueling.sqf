
[] call refuel_fnc_addRefuelCargoAction;
grad_refuel_rate = 10;

private _refuelingSoundPath = getMissionPath "USER\sounds\fueling.ogg";
private _refuelingSoundPathEnd = getMissionPath "USER\sounds\fueling_end.ogg";
missionNamespace setVariable ["FF_fuelingSound", _refuelingSoundPath];
missionNamespace setVariable ["FF_fuelingSoundEnd", _refuelingSoundPathEnd];

["ace_common_displayTextStructured", {
    params [["_array",[]]];

    _array params ["_string"];
        
    if (isDedicated) exitWith {}; // just to make sure

    if (_string isEqualTo (localize "STR_ACE_refuel_Hint_RemainingFuel") || _string isEqualTo (localize "STR_ACE_refuel_Hint_Empty")) then {
        
        private _fuelStations = missionNamespace getVariable ["FF_fuelStations", []];
        private _suspectedFuelStation = objNull;
        private _distanceTo = 14000;

        {   
            private _distanceActual = _x distance2D player;
            if (_distanceActual < _distanceTo) then {
                _suspectedFuelStation = _x;
                _distanceTo = _distanceActual;
            };
        } forEach _fuelStations;

        if (_distanceActual > 30) exitWith { diag_log "checking fuel too far away from next fuel station"; };


        private _side = player getVariable ["FF_originalSide", sideUnknown];
        private _fuelKnownFormat = format ['ace_refuel_currentFuelKnown_%1', _side];
        private _fuelKnownTimeFormat = format ['ace_refuel_currentFuelKnownTime_%1', _side];
        private _currentTime = [dayTime, "HH:MM"] call BIS_fnc_timeToString;
        private _fuelLeft = [_suspectedFuelStation] call ace_refuel_fnc_getFuel;
        _suspectedFuelStation setVariable [_fuelKnownFormat, _fuelLeft, true];
        _suspectedFuelStation setVariable [_fuelKnownTimeFormat, _currentTime, true];

        diag_log ("logging fuel for station: " + str _fuelLeft);
    };
}] call CBA_fnc_addEventHandler;


["ace_common_fueling", {
    params ["_sourceObject", "_amount", "_sinkObject", "_unit"];

    private _fuelLeft = [_sourceObject] call ace_refuel_fnc_getFuel;
    private _side = _unit getVariable ["FF_originalSide", sideUnknown];
    private _fuelKnownFormat = format ['ace_refuel_currentFuelKnown_%1', _side];
    private _fuelKnownTimeFormat = format ['ace_refuel_currentFuelKnownTime_%1', _side];
    private _currentTime = [dayTime, "HH:MM"] call BIS_fnc_timeToString;
    _sourceObject setVariable [_fuelKnownFormat, _fuelLeft, true];
    _sourceObject setVariable [_fuelKnownTimeFormat, _currentTime, true];


    private _liters = [_sinkObject] call ace_refuel_fnc_getFuel;

    hintSilent composeText [ 
        parseText ("<t color='#FF0000'><t size='2'><t align='center'>" + (str (floor _liters)) + "</t><br/>"), 
        parseText ("<t color='#ffffff'><t size='1'><t align='center'>Liters transferred</t><br/>"), 
        parseText ("<t color='#ffffff'><t size ='0.7'><t align='center'>" + (str (round _fuelLeft)) + " liters fuel left</t><br/>")
    ];

    private _refuelingSoundPath = missionNamespace getVariable ["FF_fuelingSound", ""];
    playSound3D [_refuelingSoundPath, _sourceObject, false, getPos _sourceObject, 10, 1, 100];
}] call CBA_fnc_addEventHandler;

["ace_common_addCargoFuelFinished", {
    // systemChat str _this;
    // diag_log str _this;
    params ["_sourceObject", "_startFuel", "_newFuel", "_unit"];

    // update map stuff
    private _side = _unit getVariable ["FF_originalSide", sideUnknown];
    private _fuelKnownFormat = format ['ace_refuel_currentFuelKnown_%1', _side];
    private _fuelKnownTimeFormat = format ['ace_refuel_currentFuelKnownTime_%1', _side];
    private _currentTime = [dayTime, "HH:MM"] call BIS_fnc_timeToString;
    _sourceObject setVariable [_fuelKnownFormat, _startFuel - _newFuel, true];
    _sourceObject setVariable [_fuelKnownTimeFormat, _currentTime, true];

    // assign points
    private _newPoints = _newFuel - _startFuel;

    // play satisfying sound
    private _refuelingSoundPathEnd = missionNamespace getVariable ["FF_fuelingSoundEnd", ""];
    playSound3D [_refuelingSoundPathEnd, _sourceObject, false, getPos _sourceObject, 10, 1, 100];

    systemChat ("made " + (str (_points + _newPoints)) + " points");

    // show hint if fuel is sold
    if (_sourceObject == fuelSellPoint_west ||
        _sourceObject == fuelSellPoint_east || 
        _sourceObject == fuelSellPoint_independent || 
        _sourceObject == fuelSellPoint_civilian
       ) then {
        [
            {
                private _fuelCount  = format ["%1", [player getVariable ["FF_originalSide", sideUnknown]] call (compile preprocessFileLineNumbers "USER\getFuelPoints.sqf")];
                private _totalPoints = format ["%1", [player getVariable ["FF_originalSide", sideUnknown]] call (compile preprocessFileLineNumbers "USER\getPoints.sqf")];
                hintSilent parseText ("
                        <t color='#009999'><t size='2'><t align='center'>" + _fuelCount + "<br/>
                        <t align='center'><t size='1'><t color='#ffffff'>L Treibstoff<br/><br/>
                        <t color='#009999'><t size='2'><t align='center'>" + _totalPoints + "<br/>
                        <t align='center'><t size='1'><t color='#ffffff'>Siegpunkte<br/><br/>");

            },
            [],
            1
        ] call CBA_fnc_waitAndExecute;
    };
}] call CBA_fnc_addEventHandler;

["SetCustomEncryption", "OnRadiosReceived", {
    params ["_unit", ["_radios", []]];
    private _customEncryption = player getVariable ["FF_originalSide", sideUnknown];
    [call TFAR_fnc_activeSwRadio, str _customEncryption] call TFAR_fnc_setSwRadioCode;
    player setVariable ["tf_receivingDistanceMultiplicator", 0.25];
    player setVariable ["tf_sendingDistanceMultiplicator", 4];
}, player] call TFAR_fnc_addEventHandler;


["mrk_safeZone_west", west] execVM "USER\safezone\createSafeZone.sqf";
["mrk_safeZone_east", east] execVM "USER\safezone\createSafeZone.sqf";
["mrk_safeZone_independent", independent] execVM "USER\safezone\createSafeZone.sqf";
["mrk_safeZone_civilian", civilian] execVM "USER\safezone\createSafeZone.sqf";

if (isServer) then {

        [fuelSellPoint_east, 0] call ace_refuel_fnc_makeSource;
        fuelSellPoint_east setVariable ["ace_refuel_fuelMaxCargo", 1000000, true];
        fuelSellPoint_east setVariable ["ace_refuel_cargoRate", 200, true];
        fuelSellPoint_east setVariable ["FF_sellingPoint", east, true];

        [fuelSellPoint_west, 0] call ace_refuel_fnc_makeSource;
        fuelSellPoint_west setVariable ["ace_refuel_fuelMaxCargo", 1000000, true];
        fuelSellPoint_west setVariable ["ace_refuel_cargoRate", 200, true];
        fuelSellPoint_west setVariable ["FF_sellingPoint", west, true];

        [fuelSellPoint_independent, 0] call ace_refuel_fnc_makeSource;
        fuelSellPoint_independent setVariable ["ace_refuel_fuelMaxCargo", 1000000, true];
        fuelSellPoint_independent setVariable ["ace_refuel_cargoRate", 200, true];
        fuelSellPoint_independent setVariable ["FF_sellingPoint", independent, true];

        [fuelSellPoint_civilian, 0] call ace_refuel_fnc_makeSource;
        fuelSellPoint_civilian setVariable ["ace_refuel_fuelMaxCargo", 1000000, true];
        fuelSellPoint_civilian setVariable ["ace_refuel_cargoRate", 200, true];
        fuelSellPoint_civilian setVariable ["FF_sellingPoint", civilian, true];
    

        [] call refuel_fnc_fuelBusLoop;

        // private _fuelStations = nearestTerrainObjects [[worldSize/2, worldSize/2], ["Fuelstation"], worldSize/2] select { !isObjectHidden _x};
        
        private _fuelStations = nearestObjects [[worldsize/2, worldsize/2], ["Land_fs_feed_F"], worldsize/2];

        {
            private _fuelStation = _x;
            private _fuelCargoMin = 3000;
            private _fuelCargoMid = 4000;
            private _fuelCargoMax = 5000;
            private _existingFuel = _fuelStation getVariable ["ace_refuel_fuelCargo", -1];
            private _position = position _fuelStation;
            private _fuelCargo = random [_fuelCargoMin, _fuelCargoMid, _fuelCargoMax]; // randomize fuel

            if (_existingFuel > 0) then {
                _fuelCargo = _existingFuel;
            };

            // fill up
            _fuelStation setVariable ["ace_refuel_fuelMaxCargo", _fuelCargo, true];
            _fuelStation setVariable ["ace_refuel_fuelCargo", _fuelCargo, true];
            [_fuelStation, _fuelCargo] call ace_refuel_fnc_setFuel;
            {   
                private _side = _x;
                private _fuelKnownFormat = format ["ace_refuel_currentFuelKnown_%1", _side];
                private _fuelKnownTimeFormat = format ["ace_refuel_currentFuelKnownTime_%1", _side];
                private _currentTime = [dayTime, "HH:MM"] call BIS_fnc_timeToString;
                _fuelStation setVariable [_fuelKnownFormat, _fuelCargo, true];
                _fuelStation setVariable [_fuelKnownTimeFormat, _currentTime, true];
            } forEach [west, east, independent, civilian];

            private _marker = createMarker [format ["fuelstation_%1", _position], _position];
            _marker setMarkerShape "ICON";
            _marker setMarkerType "hd_dot";
            
        } forEach _fuelStations;
        missionNamespace setVariable ["FF_fuelStations", _fuelStations, true];

        [] execVM "USER\winstats\checkWinConditions.sqf";
        [] execVM "USER\loadout\changeLoadoutFactions.sqf";

        private _westGroup = createGroup east;
        private _eastGroup = createGroup east;
        private _independentGroup = createGroup east;
        private _civilianGroup = createGroup east;
        {
            _x setVariable ["FF_originalSide", [_x] call BIS_fnc_objectSide, true];

            switch ([_x] call BIS_fnc_objectSide) do { 
                case west : {  [_x] joinSilent _westGroup; }; 
                case east : {  [_x] joinSilent _eastGroup; }; 
                case independent : {  [_x] joinSilent _independentGroup; }; 
                case civilian : {  [_x] joinSilent _civilianGroup; }; 
                default {}; 
            };

            [   
                _x,
                [_x] call refuel_fnc_getFace,
                "Male01ENGB",
                1.0,
                name player
            ] remoteExec [
                "BIS_fnc_setIdentity",
                0,
                true
            ];
        } forEach playableUnits + switchableUnits;
};
