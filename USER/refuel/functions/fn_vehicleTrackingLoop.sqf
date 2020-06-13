waitUntil {
  visibleMap
};

// create controls, delete old stuff for debug
private _mapDisplay = findDisplay 12;

(_mapDisplay displayCtrl 51) ctrlRemoveAllEventHandlers "Draw";
{ 
    private _ctrlIcon = _x getVariable ['FF_iconAssigned', controlNull];
    ctrlDelete _ctrlIcon;
    ctrlDelete _x;
} forEach ((uiNamespace getVariable ["FF_allVehicleControls", []]) + (uiNamespace getVariable ["FF_allFuelStationControls", []]));


private _allVehicles = missionNamespace getVariable ['FF_fuelTrucks', []];
private _allFuelStations = missionNamespace getVariable ['FF_fuelStations', []];

private _sidePlayer = player getVariable ['FF_originalSide', sideUnknown];
private _color = [_sidePlayer, false] call BIS_fnc_sideColor;
// private _font = 'RobotoCondensedBold';
// private _fontSize = 0.3;

private _allVehicleControls = [];

{
    private _vehicleLabel = _mapDisplay ctrlCreate ["RscStructuredText", -1]; 
    _vehicleLabel ctrlsetText "BLABLA";
    _vehicleLabel ctrlSetPosition [0,0,0.05,0.03];
    _vehicleLabel ctrlSetBackgroundColor [0,0,0,1];
    _vehicleLabel ctrlSetFontHeight 0.03;
    _vehicleLabel ctrlsetFont 'RobotoCondensedBold';
    _vehicleLabel ctrlCommit 0;


    private _vehicleIcon = _mapDisplay ctrlCreate ["RscPicture", -1];
    _vehicleIcon ctrlsetText (getMissionPath 'USER\refuel\fueltruck2.paa');
    _vehicleIcon ctrlSetPosition [0,0,0.05,0.05*4/3];
    _vehicleIcon ctrlSetBackgroundColor [0,0,0,1];
    _vehicleIcon ctrlSetTextColor _color;
    _vehicleIcon ctrlCommit 0;    

    _vehicleLabel setVariable ["FF_vehicleAssigned", _x];
    _vehicleLabel setVariable ["FF_iconAssigned", _vehicleIcon];

    _allVehicleControls pushBackUnique _vehicleLabel;
} forEach _allVehicles;

uiNamespace setVariable ["FF_allVehicleControls", _allVehicleControls];



private _allFuelStationControls = [];

{
    private _fuelStation = _x;
    private _vehicleLabel = _mapDisplay ctrlCreate ["RscStructuredText", -1]; 
    _vehicleLabel ctrlsetText "BLABLA";
    _vehicleLabel ctrlSetPosition [0,0,0.05,0.03];
    _vehicleLabel ctrlSetBackgroundColor [0,0,0,1];
    _vehicleLabel ctrlSetFontHeight 0.03;
    _vehicleLabel ctrlsetFont 'RobotoCondensedBold';
    _vehicleLabel ctrlCommit 0;

    private _vehicleIcon = _mapDisplay ctrlCreate ["RscPicture", -1];
    _vehicleIcon ctrlsetText '\A3\ui_f\data\map\mapcontrol\fuelstation_ca.paa';
    _vehicleIcon ctrlSetPosition [0,0,0.05,0.05*4/3];
    _vehicleIcon ctrlSetBackgroundColor [0,0,0,1];
    _vehicleIcon ctrlSetTextColor [1,1,1,1];
    _vehicleIcon ctrlCommit 0;    

    _vehicleLabel setVariable ["FF_vehicleAssigned", _fuelStation];
    _vehicleLabel setVariable ["FF_iconAssigned", _vehicleIcon];

    _allFuelStationControls pushBackUnique _vehicleLabel;
} forEach _allFuelStations;

uiNamespace setVariable ["FF_allFuelStationControls", _allFuelStationControls];





(_mapDisplay displayCtrl 51) ctrlAddEventHandler ["Draw","
    params ['_map'];

    if (visibleMap) then {
        private _allVehicles = missionNamespace getVariable ['FF_fuelTrucks', []];
        private _sidePlayer = player getVariable ['FF_originalSide', sideUnknown];

        {
            private _group = _x;
            private _sideGroup = (leader _group) getVariable ['FF_originalSide', sideUnknown];
            private _color = [_sideGroup, false] call BIS_fnc_sideColor;

            if (_sideGroup isEqualTo _sidePlayer) then {
                _map drawIcon [
                        getMissionPath 'USER\refuel\mafia.paa',
                        _color,
                        getPos leader _group,
                        64,
                        64,
                        0,
                        groupId _group,
                        2,
                        0.03,
                        'RobotoCondensedBold',
                        'center'
                    ];
            };
            
        } forEach allGroups;


        
        private _allVehicleControls = uiNamespace getVariable ['FF_allVehicleControls', []];

        {   
            private _vehicleLabel = _x;
            private _vehicle = _vehicleLabel getVariable ['FF_vehicleAssigned', objNull];
            private _ctrlIcon = _vehicleLabel getVariable ['FF_iconAssigned', controlNull];
            private _sideVehicle = _vehicle getVariable ['FF_trackedForSide', sideUnknown];

            private _ctrlPosition = _map ctrlMapWorldToScreen (position _vehicle);
            _ctrlPosition params ['_ctrlPositionX', '_ctrlPositionY'];

            if (_sideVehicle isEqualTo _sidePlayer) then {         

                private _fuelCargo = _vehicle getVariable ['ace_refuel_currentFuelCargo', 0];
                private _maxCargo = _vehicle getVariable ['ace_refuel_fuelMaxCargo', 0];
                private _vehicleEmpty = isNull (driver _vehicle);
                private _groupName = if (_vehicleEmpty) then { ('Empty') } else { (groupId (group (driver _vehicle))) };
                private _fuelTruckEntry = (_groupName + '  ' + (str _fuelCargo + '|' + str _maxCargo));
                private _color = [_sidePlayer, false] call BIS_fnc_sideColor;
                if (_vehicleEmpty) then {
                    _color = [0,0,0,1];
                };
               
                if (!(ctrlshown _vehicleLabel)) then {
                    _vehicleLabel ctrlShow true;
                    _ctrlIcon ctrlShow true;
                };

                _vehicleLabel ctrlSetText _fuelTruckEntry;
                            
                _vehicleLabel ctrlSetPosition [ 
                    _ctrlPositionX-(ctrlTextWidth _vehicleLabel)/2, 
                    _ctrlPositionY + 0.06*4/3,
                    ctrlTextWidth _vehicleLabel,
                    ctrlTextHeight _vehicleLabel
                ];
                _vehicleLabel ctrlCommit 0;

                _ctrlIcon ctrlSetPosition [_ctrlPositionX-0.04, _ctrlPositionY, 0.08, 0.08*4/3];
                _ctrlIcon ctrlSetTextColor _color;
                _ctrlIcon ctrlCommit 0;
               
            } else {
                if (ctrlshown _vehicleLabel) then {
                    _vehicleLabel ctrlShow false;
                    _ctrlIcon ctrlShow false;
                };
            };            
        } forEach _allVehicleControls;


        private _allFuelStationControls = uiNamespace getVariable ['FF_allFuelStationControls', []];
        {
            private _fuelStationLabel = _x;
            private _fuelStation = _x getVariable ['FF_vehicleAssigned', objNull];
            private _side = _sidePlayer;
            private _fuelStationIcon = _fuelStationLabel getVariable ['FF_iconAssigned', controlNull];
            private _fuelKnownFormat = format ['ace_refuel_currentFuelKnown_%1', _side];
            private _fuelKnownTimeFormat = format ['ace_refuel_currentFuelKnownTime_%1', _side];

            private _fuelKnown = _fuelStation getVariable [_fuelKnownFormat, 0];
            private _fuelKnownTime = _fuelStation getVariable [_fuelKnownTimeFormat, '00:00'];
            private _fuelStationEntry = (str _fuelKnown + ' | ' + _fuelKnownTime);
            
            private _ctrlPosition = _map ctrlMapWorldToScreen (position _fuelStation);
            _ctrlPosition params ['_ctrlPositionX', '_ctrlPositionY'];

            _fuelStationLabel ctrlsetText _fuelStationEntry;
            _fuelStationLabel ctrlSetPosition [_ctrlPositionX - (ctrlTextWidth _fuelStationLabel/2), _ctrlPositionY + 0.06*4/3, ctrlTextWidth _fuelStationLabel, ctrlTextHeight _fuelStationLabel];
            _fuelStationLabel ctrlCommit 0;           

            _fuelStationIcon ctrlSetPosition  [_ctrlPositionX - 0.025, _ctrlPositionY];
            _fuelStationIcon ctrlCommit 0;
            
        } forEach _allFuelStationControls;
        
    };
"];

// // private _fuelTruckEntry = (groupId (group (driver _vehicle)) + ' | ' + (str _fuelCargo + '/' + str _maxCargo));
/*
  _map drawRectangle [
                    _belowIconPosition,
                    20,
                    10,
                    0,
                    [0,0,0,1],
                    ""
                ];*/


/*
 _map drawRectangle [
                    _position,
                    _fuelTruckEntry getTextWidth [_font, _fontSize],
                    _fontSize,
                    0,
                    [0,0,0,1],
                    ""
                ];
*/

/*
if (_sideVehicle isEqualTo _sidePlayer) then {

                    private _fuelCargo = _vehicle getVariable ['ace_refuel_currentFuelCargo', 0];
                    private _maxCargo = _vehicle getVariable ['ace_refuel_fuelMaxCargo', 0];
                    // private _fuelTruckEntry = (groupId (group (driver _vehicle)) + ' | ' + (str _fuelCargo + '/' + str _maxCargo));

                    private _fuelTruckEntry = 'bla';

                    _map drawRectangle [
                        _position,
                        _fuelTruckEntry getTextWidth [_font, _fontSize],
                        _fontSize,
                        0,
                        [0,0,0,1],
                        ""
                    ];

                    _map drawIcon [
                        '',
                        [1,1,1,1],
                        _position,
                        0,
                        0,
                        0,
                        _fuelTruckEntry,
                        2,
                        _fontSize,
                        _font,
                        'center'
                    ];
                
                    _map drawIcon [
                        getMissionPath 'USER\refuel\fueltruck2.paa',
                        _color,
                        _position,
                        64,
                        64,
                        0,
                        '',
                        2,
                        _fontSize,
                        _font,
                        'center'
                    ];
            };
            */


/*
{   
            private _vehicle = _x;
            private _position = position _vehicle;
            private _sideVehicle = _vehicle getVariable ['FF_trackedForSide', sideUnknown];            
            
            systemChat str _sideVehicle;
            
            if (_sideVehicle isEqualTo _sidePlayer) then {

                    private _fuelCargo = _vehicle getVariable ['ace_refuel_currentFuelCargo', 0];
                    private _maxCargo = _vehicle getVariable ['ace_refuel_fuelMaxCargo', 0];
                    // private _fuelTruckEntry = (groupId (group (driver _vehicle)) + ' | ' + (str _fuelCargo + '/' + str _maxCargo));

                    private _fuelTruckEntry = 'bla';

                    _map drawRectangle [
                        _position,
                        _fuelTruckEntry getTextWidth [_font, _fontSize],
                        _fontSize,
                        0,
                        [0,0,0,1],
                        ""
                    ];

                    _map drawIcon [
                        '',
                        [1,1,1,1],
                        _position,
                        0,
                        0,
                        0,
                        _fuelTruckEntry,
                        2,
                        _fontSize,
                        _font,
                        'center'
                    ];
                
                    _map drawIcon [
                        getMissionPath 'USER\refuel\fueltruck2.paa',
                        _color,
                        _position,
                        64,
                        64,
                        0,
                        '',
                        2,
                        _fontSize,
                        _font,
                        'center'
                    ];
            };
        } forEach _allVehicles;
*/



/*
{
            private _group = _x;
            private _sideGroup = (leader _group) getVariable ['FF_originalSide', sideUnknown];

            if (_sideGroup isEqualTo _sidePlayer) then {
                _map drawIcon [
                        getMissionPath 'USER\refuel\mafia2.paa',
                        _color,
                        getPos leader _group,
                        64,
                        64,
                        0,
                        groupId _group,
                        2,
                        _fontSize,
                        _font,
                        'center'
                    ];
            };
            
        } forEach allGroups;

        private _allFuelStations = missionNamespace getVariable ['FF_fuelStations', []];
        {
            private _fuelStation = _x;
            private _side = _sidePlayer;
            private _fuelKnownFormat = format ['ace_refuel_currentFuelKnown_%1', _side];
            private _fuelKnownTimeFormat = format ['ace_refuel_currentFuelKnownTime_%1', _side];

            private _fuelKnown = _fuelStation getVariable [_fuelKnownFormat, 0];
            private _fuelKnownTime = _fuelStation getVariable [_fuelKnownTimeFormat, '00:00'];
            private _fuelStationEntry = (str _fuelKnown + ' | ' + _fuelKnownTime);
            
            _map drawRectangle [
                getPos _fuelStation,
                _fuelStationEntry getTextWidth [_font, _fontSize],
                _fontSize,
                0,
                [0,0,0,1],
                ""
            ];

            _map drawIcon [
                    '\A3\ui_f\data\map\mapcontrol\fuelstation_ca.paa',
                    [1,1,1,1],
                    getPos _fuelStation,
                    32,
                    32,
                    0,
                    _fuelStationEntry,
                    2,
                    _fontSize,
                    _font,
                    'center'
                ];
            
            
        } forEach _allFuelStations;
*/