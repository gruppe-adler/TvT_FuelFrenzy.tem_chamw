waitUntil {
  visibleMap
};

// create controls, delete old stuff for debug
private _mapDisplay = findDisplay 12;

(_mapDisplay displayCtrl 51) ctrlRemoveAllEventHandlers "Draw";
{
    private _ctrlIcon = _x getVariable ['FF_iconAssigned', controlNull];
    private _ctrlFuelBar = _x getVariable ['FF_fuelBarAssigned', controlNull];
    private _ctrlFuelBarBG = _x getVariable ['FF_fuelBarBGAssigned', controlNull];
    ctrlDelete _ctrlIcon;
    ctrlDelete _ctrlFuelBar;
    ctrlDelete _ctrlFuelBarBG;
    ctrlDelete _x;
} forEach ((uiNamespace getVariable ["FF_allVehicleControls", []]) + (uiNamespace getVariable ["FF_allFuelStationControls", []]));


private _allVehicles = (
        (missionNamespace getVariable ['FF_fuelTrucks', []]) +
        (missionNamespace getVariable ['FF_fuelTrucksNoRespawn', []])
    );

private _allFuelStations = missionNamespace getVariable ['FF_fuelStations', []];

private _sidePlayer = player getVariable ['FF_originalSide', sideUnknown];
private _color = [_sidePlayer, false] call BIS_fnc_sideColor;
// private _font = 'RobotoCondensedBold';
// private _fontSize = 0.3;

private _allVehicleControls = [];

{
    private _fuelBarBG = _mapDisplay ctrlCreate ["RscText", -1];
    _fuelBarBG ctrlsetText "";
    _fuelBarBG ctrlSetPosition [0,0,0.05,0.025];
    _fuelBarBG ctrlSetBackgroundColor [0,0,0,1];
    _fuelBarBG ctrlCommit 0;

    private _fuelBar = _mapDisplay ctrlCreate ["RscText", -1];
    _fuelBar ctrlsetText "";
    _fuelBar ctrlSetPosition [0,0,0.05,0.025];
    _fuelBar ctrlSetBackgroundColor [0.2,0.8,0.2,1];
    _fuelBar ctrlCommit 0;

    private _vehicleLabel = _mapDisplay ctrlCreate ["RscText", -1];
    _vehicleLabel ctrlsetText "BLABLA";
    _vehicleLabel ctrlSetPosition [0,0,0.05,0.03];
    _vehicleLabel ctrlSetBackgroundColor [0,0,0,1];
    _vehicleLabel ctrlSetFontHeight 0.025;
    _vehicleLabel ctrlsetFont 'RobotoCondensedBold';
    _vehicleLabel ctrlCommit 0;


    private _vehicleIcon = _mapDisplay ctrlCreate ["RscPicture", -1];
    _vehicleIcon ctrlsetText (getMissionPath 'USER\refuel\fuelbus.paa');
    _vehicleIcon ctrlSetPosition [0,0,0.05,0.05*4/3];
    _vehicleIcon ctrlSetBackgroundColor [0,0,0,1];
    _vehicleIcon ctrlSetTextColor _color;
    _vehicleIcon ctrlCommit 0;

    _vehicleLabel setVariable ["FF_vehicleAssigned", _x];
    _vehicleLabel setVariable ["FF_iconAssigned", _vehicleIcon];
    _vehicleLabel setVariable ["FF_fuelBarBGAssigned", _fuelBarBG];
    _vehicleLabel setVariable ["FF_fuelBarAssigned", _fuelBar];

    _allVehicleControls pushBackUnique _vehicleLabel;

} forEach _allVehicles;

{
    _x ctrlShow false;
    private _ctrlIcon = _x getVariable ['FF_iconAssigned', controlNull];
    private _ctrlFuelBar = _x getVariable ['FF_fuelBarAssigned', controlNull];
    private _ctrlFuelBarBG = _x getVariable ['FF_fuelBarBGAssigned', controlNull];
    _ctrlIcon ctrlShow false;
    _ctrlFuelBar ctrlShow false;
    _ctrlFuelBarBG ctrlShow false;
} forEach _allVehicleControls;

uiNamespace setVariable ["FF_allVehicleControls", _allVehicleControls];



private _allFuelStationControls = [];

{
    private _fuelStation = _x;

    private _fuelBarBG = _mapDisplay ctrlCreate ["RscText", -1];
    _fuelBarBG ctrlsetText "";
    _fuelBarBG ctrlSetPosition [0,0,0.05,0.025];
    _fuelBarBG ctrlSetBackgroundColor [0,0,0,1];
    _fuelBarBG ctrlCommit 0;

    private _fuelBar = _mapDisplay ctrlCreate ["RscText", -1];
    _fuelBar ctrlsetText "";
    _fuelBar ctrlSetPosition [0,0,0.05,0.025];
    _fuelBar ctrlSetBackgroundColor [0.2,0.8,0.2,1];
    _fuelBar ctrlCommit 0;

    private _vehicleLabel = _mapDisplay ctrlCreate ["RscText", -1];
    _vehicleLabel ctrlsetText "BLABLA";
    _vehicleLabel ctrlSetPosition [0,0,0.05,0.025];
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
    _vehicleLabel setVariable ["FF_fuelBarBGAssigned", _fuelBarBG];
    _vehicleLabel setVariable ["FF_fuelBarAssigned", _fuelBar];

    _allFuelStationControls pushBackUnique _vehicleLabel;
} forEach _allFuelStations;

uiNamespace setVariable ["FF_allFuelStationControls", _allFuelStationControls];


private _fuelSellPointControls = [];

{
    private _fuelSellPoint = _x;

    // dont create control points of other factions
    if (_sidePlayer == (_x getVariable ['FF_sellingPoint', sideUnknown])) then {


        private _vehicleLabel = _mapDisplay ctrlCreate ["RscText", -1];
        _vehicleLabel ctrlsetText "BLABLA";
        _vehicleLabel ctrlSetPosition [0,0,0.05,0.025];
        _vehicleLabel ctrlSetBackgroundColor [0,0,0,1];
        _vehicleLabel ctrlSetFontHeight 0.03;
        _vehicleLabel ctrlsetFont 'RobotoCondensedBold';
        _vehicleLabel ctrlCommit 0;

        private _vehicleIcon = _mapDisplay ctrlCreate ["RscPicture", -1];
        _vehicleIcon ctrlsetText '\A3\ui_f\data\map\mapcontrol\fuelstation_ca.paa';
        _vehicleIcon ctrlSetPosition [0,0,0.05,0.05*4/3];
        _vehicleIcon ctrlSetBackgroundColor [0,0,0,1];
        _vehicleIcon ctrlSetTextColor _color;
        _vehicleIcon ctrlCommit 0;

        _vehicleLabel setVariable ["FF_vehicleAssigned", _fuelSellPoint];
        _vehicleLabel setVariable ["FF_iconAssigned", _vehicleIcon];

        _fuelSellPointControls pushBackUnique _vehicleLabel;
    };
} forEach [
    fuelSellPoint_west,
    fuelSellPoint_east,
    fuelSellPoint_independent,
    fuelSellPoint_civilian
];

uiNamespace setVariable ["FF_fuelSellPointControls", _fuelSellPointControls];


(_mapDisplay displayCtrl 51) ctrlAddEventHandler ["Draw","
    params ['_map'];

    if (visibleMap) then {
        private _allVehicles = 
            (
                (missionNamespace getVariable ['FF_fuelTrucks', []]) +
                (missionNamespace getVariable ['FF_fuelTrucksNoRespawn', []])
            );
        private _sidePlayer = player getVariable ['FF_originalSide', sideUnknown];

        private _allVehicleControls = uiNamespace getVariable ['FF_allVehicleControls', []];

        {
            private _vehicleLabel = _x;
            private _vehicle = _vehicleLabel getVariable ['FF_vehicleAssigned', objNull];
            private _ctrlIcon = _vehicleLabel getVariable ['FF_iconAssigned', controlNull];
            private _sideVehicle = _vehicle getVariable ['FF_trackedForSide', sideUnknown];
            private _fuelBarBG = _vehicleLabel getVariable ['FF_fuelBarBGAssigned', controlNull];
            private _fuelBar = _vehicleLabel getVariable ['FF_fuelBarAssigned', controlNull];
            private _position = (position _vehicle);

            private _ctrlPosition = _map ctrlMapWorldToScreen _position;
            _ctrlPosition params ['_ctrlPositionX', '_ctrlPositionY'];

            if (_sideVehicle isEqualTo _sidePlayer) then {

                private _fuelCargo = _vehicle getVariable ['ace_refuel_currentFuelCargo', 0];
                private _maxCargo = _vehicle getVariable ['ace_refuel_fuelMaxCargo', 0];
                private _vehicleEmpty = isNull (driver _vehicle);
                private _groupName = if (_vehicleEmpty) then { ('Empty') } else { (groupId (group (driver _vehicle))) };
                private _fuelTruckEntry = (_groupName + '  ' + (str (round _fuelCargo) + '|' + str _maxCargo));
                private _color = [_sidePlayer, false] call BIS_fnc_sideColor;
                if (_vehicleEmpty) then {
                    _color = [0,0,0,1];
                };

                if (!(ctrlshown _vehicleLabel)) then {
                    _vehicleLabel ctrlShow true;
                    _fuelBar ctrlShow true;
                    _fuelBarBG ctrlShow true;
                    _ctrlIcon ctrlShow true;
                };

                private _fuelBarOffsetY = _ctrlPositionY-0.025;
                private _fuelBarMaxHeight = 0.03*4/3;

                _fuelBarBG ctrlSetPosition [_ctrlPositionX + 0.04, _fuelBarOffsetY, 0.005, _fuelBarMaxHeight];
                _fuelBarBG ctrlCommit 0;

                private _fuelBarHeight = linearConversion [0, _maxCargo, _fuelCargo, 0, _fuelBarMaxHeight, true];
                _fuelBar ctrlSetPosition [_ctrlPositionX + 0.04, _fuelBarOffsetY + _fuelBarMaxHeight - _fuelBarHeight, 0.005, _fuelBarHeight];
                _fuelBar ctrlCommit 0;

                private _positionMouseInWorld = _map ctrlMapScreenToWorld getMousePosition;

                if (_positionMouseInWorld distance2D _position < 70 || !_vehicleEmpty) then {
                    _vehicleLabel ctrlShow true;
                } else {
                    _vehicleLabel ctrlShow false;
                };

                _vehicleLabel ctrlSetText _fuelTruckEntry;

                _vehicleLabel ctrlSetPosition [
                    _ctrlPositionX-(ctrlTextWidth _vehicleLabel)/2,
                    _ctrlPositionY + 0.02*4/3,
                    ctrlTextWidth _vehicleLabel,
                    ctrlTextHeight _vehicleLabel
                ];
                _vehicleLabel ctrlCommit 0;

                _ctrlIcon ctrlSetPosition [_ctrlPositionX-0.04, _ctrlPositionY-0.04*4/3, 0.08, 0.08*4/3];
                _ctrlIcon ctrlSetTextColor _color;
                _ctrlIcon ctrlCommit 0;

            } else {
                if (ctrlshown _vehicleLabel) then {
                    _vehicleLabel ctrlShow false;
                    _fuelBar ctrlShow false;
                    _fuelBarBG ctrlShow false;
                    _ctrlIcon ctrlShow false;
                };
            };
        } forEach _allVehicleControls;


        private _allFuelStationControls = uiNamespace getVariable ['FF_allFuelStationControls', []];
        {
            private _fuelStationLabel = _x;
            private _fuelStation = _x getVariable ['FF_vehicleAssigned', objNull];
            private _position = position _fuelStation;

            private _fuelStationIcon = _fuelStationLabel getVariable ['FF_iconAssigned', controlNull];
            private _fuelBarBG = _fuelStationLabel getVariable ['FF_fuelBarBGAssigned', controlNull];
            private _fuelBar = _fuelStationLabel getVariable ['FF_fuelBarAssigned', controlNull];
            private _fuelKnownFormat = format ['ace_refuel_currentFuelKnown_%1', _sidePlayer];
            private _fuelKnownTimeFormat = format ['ace_refuel_currentFuelKnownTime_%1', _sidePlayer];
            private _fuelKnown = _fuelStation getVariable [_fuelKnownFormat, 0];
            
            private _fuelMax = _fuelStation getVariable ['ace_refuel_fuelMaxCargo', 0];
            private _fuelKnownTime = _fuelStation getVariable [_fuelKnownTimeFormat, '00:00'];
            private _fuelStationEntry = (str (round _fuelKnown) + ' | ' + _fuelKnownTime);

            private _ctrlPosition = _map ctrlMapWorldToScreen _position;
            _ctrlPosition params ['_ctrlPositionX', '_ctrlPositionY'];


            private _fuelBarOffsetY = _ctrlPositionY-0.025;
            private _fuelBarMaxHeight = 0.04*4/3;

            _fuelBarBG ctrlSetPosition [_ctrlPositionX + 0.02, _fuelBarOffsetY, 0.005, _fuelBarMaxHeight];
            _fuelBarBG ctrlCommit 0;

            private _fuelBarHeight = linearConversion [0, _fuelMax, _fuelKnown, 0, _fuelBarMaxHeight, true];
            _fuelBar ctrlSetPosition [_ctrlPositionX + 0.02, _fuelBarOffsetY + _fuelBarMaxHeight - _fuelBarHeight, 0.005, _fuelBarHeight];
            _fuelBar ctrlCommit 0;


            private _positionMouseInWorld = _map ctrlMapScreenToWorld getMousePosition;

            if (_positionMouseInWorld distance2D _position < 70) then {
                _fuelStationLabel ctrlShow true;
            } else {
                _fuelStationLabel ctrlShow false;
            };

            _fuelStationLabel ctrlsetText _fuelStationEntry;
            _fuelStationLabel ctrlSetPosition [_ctrlPositionX - (ctrlTextWidth _fuelStationLabel/2), _ctrlPositionY + 0.02*4/3, ctrlTextWidth _fuelStationLabel, ctrlTextHeight _fuelStationLabel];
            _fuelStationLabel ctrlCommit 0;

            if (_fuelKnown == 0) then {
                _fuelStationIcon ctrlSetTextColor [0.8,0.2,0.2,1];
            };

            _fuelStationIcon ctrlSetPosition  [_ctrlPositionX - 0.025, _ctrlPositionY-0.031];
            _fuelStationIcon ctrlCommit 0;

        } forEach _allFuelStationControls;


        private _fuelSellPointControls = uiNamespace getVariable ['FF_fuelSellPointControls', []];

        {
            private _fuelSellPointLabel = _x;
            private _fuelSellPoint = _x getVariable ['FF_vehicleAssigned', objNull];
            private _position = position _fuelSellPoint;

            private _fuelSellPointIcon = _fuelSellPointLabel getVariable ['FF_iconAssigned', controlNull];
            private _fuelCargo = _fuelSellPoint getVariable ['ace_refuel_currentFuelCargo', 0];

            private _ctrlPosition = _map ctrlMapWorldToScreen _position;
            _ctrlPosition params ['_ctrlPositionX', '_ctrlPositionY'];

            private _positionMouseInWorld = _map ctrlMapScreenToWorld getMousePosition;

            if (_positionMouseInWorld distance2D _position < 70) then {
                _fuelSellPointLabel ctrlShow true;
            } else {
                _fuelSellPointLabel ctrlShow false;
            };

            _fuelSellPointLabel ctrlsetText str (round _fuelCargo);
            _fuelSellPointLabel ctrlSetPosition [_ctrlPositionX - (ctrlTextWidth _fuelSellPointLabel/2), _ctrlPositionY + 0.02*4/3, ctrlTextWidth _fuelSellPointLabel, ctrlTextHeight _fuelSellPointLabel];
            _fuelSellPointLabel ctrlCommit 0;

            _fuelSellPointIcon ctrlSetPosition  [_ctrlPositionX - 0.025, _ctrlPositionY-0.05];
            _fuelSellPointIcon ctrlCommit 0;

        } forEach _fuelSellPointControls;

        {
            private _group = _x;
            private _sideGroup = (leader _group) getVariable ['FF_originalSide', sideUnknown];
            private _color = [_sideGroup, false] call BIS_fnc_sideColor;

            if (_sideGroup isEqualTo _sidePlayer && isNull (objectParent (leader _group))) then {
                _map drawIcon [
                        getMissionPath 'USER\refuel\mafia.paa',
                        _color,
                        getPos leader _group,
                        64,
                        64,
                        0,
                        groupId _group,
                        0,
                        0.05,
                        'RobotoCondensedBold',
                        'center'
                    ];
            };

        } forEach allGroups;

    };
"];
