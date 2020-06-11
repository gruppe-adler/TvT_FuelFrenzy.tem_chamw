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
                        getText (configFile >> 'CfgVehicles' >> typeOf _x >> 'Icon'),
                        [_sidePlayer, false] call BIS_fnc_sideColor,
                        _position,
                        24,
                        24,
                        getDir _x,
                        groupId group driver _x + ' | ' + (str _fuelCargo + '/' + str _maxCargo),
                        2,
                        0.03,
                        'TahomaB',
                        'center'
                    ];
                };
        } forEach _allVehicles;


        {
            private _sideGroup = (leader _x) getVariable ['FF_originalSide', sideUnknown];
            private _group = _x;

            if (_sideGroup isEqualTo _sidePlayer && isNull (objectParent leader _group)) then {
                ((findDisplay 12) displayCtrl 51) drawIcon [
                        [_group] call ace_common_fnc_getMarkerType,
                        [_sidePlayer, false] call BIS_fnc_sideColor,
                        _position,
                        24,
                        24,
                        0,
                        groupId _group,
                        2,
                        0.03,
                        'TahomaB',
                        'center'
                    ];
            };
            
        } forEach allGroups;
    };
"];