
[] call refuel_fnc_addRefuelCargoAction;
grad_refuel_rate = 10;

private _refuelingSoundPath = getMissionPath "USER\sounds\fueling.ogg";
private _refuelingSoundPathEnd = getMissionPath "USER\sounds\fueling_end.ogg";
missionNamespace setVariable ["FF_fuelingSound", _refuelingSoundPath];
missionNamespace setVariable ["FF_fuelingSoundEnd", _refuelingSoundPathEnd];

["ace_common_fueling", {
    params ["_sourceObject", "_amount", "_sinkObject"];

    private _liters = [_sinkObject] call ace_refuel_fnc_getFuel;
    hintSilent parseText ("<t color='#FF0000'><t size='2'><t align='center'>" + (str (floor _liters)) + "<br/><br/><t align='center'><t size='1'><t color='#ffffff'>Liter");

    private _refuelingSoundPath = missionNamespace getVariable ["FF_fuelingSound", ""];
    playSound3D [_refuelingSoundPath, _sourceObject, false, getPos _sourceObject, 10, 1, 100];
}] call CBA_fnc_addEventHandler;

["ace_common_addCargoFuelFinished", {
    // systemChat str _this;
    // diag_log str _this;
    params ["_sourceObject", "_startFuel", "_newFuel"];
    private _newPoints = _newFuel - _startFuel;
    private _refuelingSoundPathEnd = missionNamespace getVariable ["FF_fuelingSoundEnd", ""];
    playSound3D [_refuelingSoundPathEnd, _sourceObject, false, getPos _sourceObject, 10, 1, 100];

    systemChat ("made " + (str (_points + _newPoints)) + " points");

    if (_sourceObject == fuelSellPoint_west || _sourceObject == fuelSellPoint_east) then {
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
    

        private _fuelTrucksEast = [worldsize/2, worldsize/2] nearEntities ["O_G_Van_01_fuel_F",14000];
        private _fuelTrucksWest = [worldsize/2, worldsize/2] nearEntities ["RHS_Ural_Fuel_VDV_01",14000];
        private _fuelTrucksIndependent = [worldsize/2, worldsize/2] nearEntities ["C_Truck_02_fuel_F",14000];
        private _fuelTrucksCivilian = [worldsize/2, worldsize/2] nearEntities ["gm_gc_army_ural375d_refuel",14000];
        private _fuelTrucks = _fuelTrucksEast + _fuelTrucksWest + _fuelTrucksIndependent + _fuelTrucksCivilian;

        {
          [_x, 0] call ace_refuel_fnc_setfuel;
          _x setVariable ["ace_refuel_fuelMaxCargo", 3000, true];
        } forEach _fuelTrucks;


        // private _fuelStations = nearestTerrainObjects [[worldSize/2, worldSize/2], ["Fuelstation"], worldSize/2] select { !isObjectHidden _x};
        
        private _fuelStations = nearestObjects [[worldsize/2, worldsize/2], ["Land_fs_feed_F"], worldsize/2];

        {
            private _fuelStation = _x;
            private _fuelCargo = 3000;
            private _position = position _fuelStation;
            _fuelStation setVariable ["ace_refuel_fuelMaxCargo", 3000, true];
            _fuelStation setVariable ["ace_refuel_currentFuelCargo", 3000, true];

            
            private _marker = createMarker [format ["fuelstation_%1", _position], _position];
            _marker setMarkerShape "ICON";
            _marker setMarkerType "hd_dot";
            
        } forEach _fuelStations;

        [] execVM "USER\winstats\checkWinConditions.sqf";
        [] execVM "USER\loadout\changeLoadoutFactions.sqf";

        private _westGroup = createGroup west;
        private _eastGroup = createGroup west;
        private _independentGroup = createGroup west;
        private _civilianGroup = createGroup west;
        {
            _x setVariable ["FF_originalSide", [_x] call BIS_fnc_objectSide, true];

            switch ([_x] call BIS_fnc_objectSide) do { 
                case west : {  [_x] joinSilent _westGroup; }; 
                case east : {  [_x] joinSilent _eastGroup; }; 
                case independent : {  [_x] joinSilent _independentGroup; }; 
                case civilian : {  [_x] joinSilent _civilianGroup; }; 
                default {}; 
            };
        } forEach playableUnits + switchableUnits;
};
