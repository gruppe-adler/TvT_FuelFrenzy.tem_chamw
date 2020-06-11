/*

    draws on map positions of vehicles

*/

(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw","

    if (visibleMap) then {
        private _allVehicles = missionNamespace getVariable ['FF_fuelTrucks', []];
        private _sidePlayer = player getVariable ['FF_originalSide', sideUnknown];

        {
            private _position = position _x;
            private _sideVehicle = _x getVariable ['FF_trackedForSide', sideUnknown];            
            
                if (_sideVehicle isEqualTo _sidePlayer) then {

                    private _fuelCargo = _x getVariable ['currentFuelCargo', 0];
                    private _maxCargo = _x getVariable ['ace_refuel_fuelMaxCargo', 0];
                
                    ((findDisplay 12) displayCtrl 51) drawIcon [
                        getMissionPath 'USER\refuel\fueltruck2.paa',
                        [_sidePlayer, false] call BIS_fnc_sideColor,
                        _position,
                        64,
                        64,
                        0,
                        '<br/><br/><br/><br/>' + groupId group driver _x + ' | ' + (str _fuelCargo + '/' + str _maxCargo),
                        2,
                        0.03,
                        'TahomaB',
                        'center'
                    ];
                };
        } forEach _allVehicles;


        {
            private _group = _x;
            private _sideGroup = (leader _group) getVariable ['FF_originalSide', sideUnknown];

            if (_sideGroup isEqualTo _sidePlayer) then {
                ((findDisplay 12) displayCtrl 51) drawIcon [
                        getMissionPath 'USER\refuel\mafia2.paa',
                        [_sidePlayer, false] call BIS_fnc_sideColor,
                        getPos leader _group,
                        64,
                        64,
                        0,
                        '<br/>' + groupId _group,
                        2,
                        0.03,
                        'TahomaB',
                        'center'
                    ];
            };
            
        } forEach allGroups;
    };
"];