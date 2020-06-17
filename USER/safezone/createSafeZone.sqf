params ["_area", "_side"];

if (missionNamespace getVariable [format ["safeZoneSet_%1", _area], false]) exitWith { hint "already set"; };
missionNamespace setVariable [format ["safeZoneSet_%1", _area], true];

private _eventhandlerSet = format ["FF_firedEHSet_%1", _area];
private _eventhandlerIdentifier = format ["FF_safeZoneFiredEH_%1", _area];

[{
    params ["_args", "_handle"];
    _args params ["_area", "_eventhandlerSet", "_eventhandlerIdentifier", "_side"];

    if (!alive player) exitWith {};
    private _isInZone = (count ([player] inAreaArray _area) > 0);
    // systemChat str _isInZone;
    
    private _firedEHSet = player getVariable [_eventhandlerSet, false];
    

    if (_isInZone) exitWith {

            if (!_firedEHSet) then {

                player setVariable [_eventhandlerSet, true];

                private _firedEH = (vehicle player) addEventHandler ["fired", {deleteVehicle (_this select 6);}];
                player setVariable [_eventhandlerIdentifier, _firedEH];
                if (_side == player getVariable ["FF_originalSide", sideUnknown] && CBA_missionTime > 30) then {
                    hintSilent parseText "<t color='#009999'><t size='2'><t align='center'>Welcome<br/><br/><t align='center'><t size='1'><t color='#ffffff'>You are entering your base.";
                } else {
                    if (CBA_missionTime > 30) then {
                        hintSilent parseText "<t color='#ff0000'><t size='2'><t align='center'>Attention<br/><br/><t align='center'><t size='1'><t color='#ffffff'>You are entering an enemy base. Get away sucker.";
                    };
                };
                
            };
    };

    if (!_isInZone) then {

        if (_firedEHSet) then {         

            player setVariable [_eventhandlerSet, false];

            private _firedEH = player getVariable [_eventhandlerIdentifier, -1];
            player removeEventHandler ["fired", _firedEH];
            if (_side == player getVariable ["FF_originalSide", sideUnknown] && CBA_missionTime > 30) then {
                    hintSilent parseText "<t color='#FF0000'><t size='2'><t align='center'>Attention<br/><br/><t align='center'><t size='1'><t color='#ffffff'>You are leaving your base.";
                } else {
                    if (CBA_missionTime > 30) then {
                        hintSilent parseText "<t color='#FF0000'><t size='2'><t align='center'>Attention<br/><br/><t align='center'><t size='1'><t color='#ffffff'>You are leaving the enemy base. Good.";
                    };
                };
        };
    };
    
 }, 1, [_area, _eventhandlerSet, _eventhandlerIdentifier, _side]] call CBA_fnc_addPerFrameHandler;
 