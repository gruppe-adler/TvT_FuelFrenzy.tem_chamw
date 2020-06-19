if (!isServer) exitWith {};

private _fuelStations = nearestObjects [[worldsize/2, worldsize/2], ["Land_fs_feed_F"], worldsize/2];
private _allFuelTrucks = missionNamespace getVariable ["FF_fuelTrucks", []];

[{

    params ["_args", "_handle"];
    _args params ["_allFuelTrucks", "_fuelStations"];

    private _fuelStationsAreEmpty = true;
    private _allFuelTrucksDestroyedOrEmpty = false;
    private _allTrucksDestroyed = count (_allFuelTrucks select { (!(canMove _x)) })  == count _allFuelTrucks;

    {
        if (_x getVariable ["ace_refuel_currentFuelCargo", 0] > 1) exitWith {
        // if ([_x] call ace_refuel_fnc_getFuel > 1) exitWith {
            _fuelStationsAreEmpty = false;
        };
    } forEach _fuelStations;

    if (_allTrucksDestroyed) exitWith {
         ["USER\winstats\showStats.sqf"] remoteExec ["execVM", 0, true];
        systemChat "all trucks destroyed or empty";
        diag_log "all trucks destroyed or empty";
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    if (_fuelStationsAreEmpty) then {
        systemChat "all fuel stations are empty";
        diag_log "all fuel stations are empty";

        private _trucksStillRunning = count (_allFuelTrucks select { (canMove _x) && (_x getVariable ["ace_refuel_currentFuelCargo", 0] > 1) }) > 0;
        
        if (!_trucksStillRunning) then {
            ["USER\winstats\showStats.sqf"] remoteExec ["execVM", 0, true];
            systemChat "all trucks destroyed or empty";
            diag_log "all trucks destroyed or empty";
            [_handle] call CBA_fnc_removePerFrameHandler;
        };
    };
    
}, 1, [_allFuelTrucks, _fuelStations]] call CBA_fnc_addPerFramehandler;