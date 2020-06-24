
[] call refuel_fnc_addRefuelCargoAction;
grad_refuel_rate = 10;

private _refuelingSoundPath = getMissionPath "USER\sounds\fueling.ogg";
private _refuelingSoundPathEnd = getMissionPath "USER\sounds\fueling_end.ogg";
missionNamespace setVariable ["FF_fuelingSound", _refuelingSoundPath];
missionNamespace setVariable ["FF_fuelingSoundEnd", _refuelingSoundPathEnd];

if (hasInterface) then {
    [] call grad_linearSD_fnc_transferRadiosAcrossRespawn;

    // JIP relevant
    private _westGroup = missionNamespace getVariable ["FF_groupWest", grpNull];
    private _eastGroup = missionNamespace getVariable ["FF_groupEast", grpNull];
    private _independentGroup = missionNamespace getVariable ["FF_groupIndependent", grpNull];
    private _civilianGroup = missionNamespace getVariable ["FF_groupCivilian", grpNull];

    private _originalSide = [player, true] call BIS_fnc_objectSide;
    player setVariable ["FF_originalSide", _originalSide, true];

    switch (_originalSide) do {
        case west : {  [player] joinSilent _westGroup; }; 
        case east : {  [player] joinSilent _eastGroup; }; 
        case independent : {  [player] joinSilent _independentGroup; }; 
        case civilian : {  [player] joinSilent _civilianGroup; }; 
        default {diag_log "client: error in originalSide: none of the sides!"; }; 
    };

    
    [
        player, [player] call refuel_fnc_getFace
    ] remoteExec [
        "setFace",
        0,
        true
    ];
    
    
    

    ["ff",{
        params ["_commandType"];

        private _availableCommands = [
            "endMission"
        ];

        private _fnc_default = {
            systemChat format ["%1 is not a ff chatcommand.",_commandType];
            systemChat format ["Available commands are %1",_availableCommands];
        };

        private _endMission = {
                ["USER\winstats\showStats.sqf"] remoteExec ["execVM", 0, true];
        };

        switch (toLower _commandType) do {
            case ("endmission"): _endMission;
            default _fnc_default;
        };

    },"admin"] call CBA_fnc_registerChatCommand;

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

    ["ace_common_fuelSoundLoop", {
        params ["_sourceObject"];

        private _refuelingSoundPath = missionNamespace getVariable ["FF_fuelingSound", ""];
        playSound3D [_refuelingSoundPath, _sourceObject, false, getPos _sourceObject, 10, 1, 100];

    }] call CBA_fnc_addEventHandler;

    ["ace_common_fuelSoundFinished", {
        params ["_sourceObject"];

        // play satisfying sound
        private _refuelingSoundPathEnd = missionNamespace getVariable ["FF_fuelingSoundEnd", ""];
        playSound3D [_refuelingSoundPathEnd, _sourceObject, false, getPos _sourceObject, 10, 1, 100];

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

    {
        _x params ["_area", "_side"];
        private _playerSide = [player, true] call BIS_fnc_objectSide;
        if (_playerSide == _side) then {
            _area setMarkerBrushLocal "FDiagonal";
            _area setMarkerColorLocal "ColorGreen";
        } else {
            _area setMarkerBrushLocal "SolidBorder";
            _area setMarkerColorLocal "ColorPink";
        };
        [_area, _side] execVM "USER\safezone\createSafeZone.sqf";
    } forEach [
        ["mrk_safeZone_west", west],
        ["mrk_safeZone_east", east],
        ["mrk_safeZone_independent", independent],
        ["mrk_safeZone_civilian", civilian]
    ];

};


if (isServer) then {

        // [fuelSellPoint_east, 0] call ace_refuel_fnc_makeSource;
        fuelSellPoint_east setVariable ["ace_refuel_fuelMaxCargo", 1000000, true];
        fuelSellPoint_east setVariable ["ace_refuel_cargoRate", 200, true];
        fuelSellPoint_east setVariable ["FF_sellingPoint", east, true];

        // [fuelSellPoint_west, 0] call ace_refuel_fnc_makeSource;
        fuelSellPoint_west setVariable ["ace_refuel_fuelMaxCargo", 1000000, true];
        fuelSellPoint_west setVariable ["ace_refuel_cargoRate", 200, true];
        fuelSellPoint_west setVariable ["FF_sellingPoint", west, true];

        // [fuelSellPoint_independent, 0] call ace_refuel_fnc_makeSource;
        fuelSellPoint_independent setVariable ["ace_refuel_fuelMaxCargo", 1000000, true];
        fuelSellPoint_independent setVariable ["ace_refuel_cargoRate", 200, true];
        fuelSellPoint_independent setVariable ["FF_sellingPoint", independent, true];

        // [fuelSellPoint_civilian, 0] call ace_refuel_fnc_makeSource;
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
            private _existingFuel = _fuelStation getVariable ["ace_refuel_currentFuelCargo", -1];
            private _position = position _fuelStation;
            private _fuelCargo = random [_fuelCargoMin, _fuelCargoMid, _fuelCargoMax]; // randomize fuel

            if (_existingFuel > 0) then {
                _fuelCargo = _existingFuel;
            };

            // fill up
            _fuelStation setVariable ["ace_refuel_fuelMaxCargo", _fuelCargo, true];
            _fuelStation setVariable ["ace_refuel_currentFuelCargo", _fuelCargo, true];
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
        missionNamespace setVariable ["FF_groupWest", _westGroup, true];
        publicVariable "FF_groupWest";
        private _eastGroup = createGroup east;
        missionNamespace setVariable ["FF_groupEast", _eastGroup, true];
        publicVariable "FF_groupEast";
        private _independentGroup = createGroup east;
        missionNamespace setVariable ["FF_groupIndependent", _independentGroup, true];
        publicVariable "FF_groupIndependent";
        private _civilianGroup = createGroup east;
        missionNamespace setVariable ["FF_groupCivilian", _civilianGroup, true];
        publicVariable "FF_groupCivilian";

        {
            private _originalSide = [_x, true] call BIS_fnc_objectSide;
            _x setVariable ["FF_originalSide", _originalSide, true];

            switch (_originalSide) do {
                case west : {  [_x] joinSilent _westGroup; }; 
                case east : {  [_x] joinSilent _eastGroup; }; 
                case independent : {  [_x] joinSilent _independentGroup; }; 
                case civilian : {  [_x] joinSilent _civilianGroup; }; 
                default {diag_log "server:error in originalSide: none of the sides!"; }; 
            };

        } forEach (playableUnits + switchableUnits);
};
