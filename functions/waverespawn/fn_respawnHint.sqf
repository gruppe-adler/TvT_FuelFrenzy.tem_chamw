/*    Shows formatted hint during wave respawn time
*
*/
#include "component.hpp"

params ["_side","_status"];
private ["_status"];

_rule = parseText "<t align='center'><t color='#708090'>-----------------------------------------------------</t></t>";
_lineBreak = parseText "<br />";

if (isNil "_status") then {
    _status = switch (_side) do {
        case (WEST): {GVAR(WAVERESPAWNSTATUSBLU)};
        case (EAST): {GVAR(WAVERESPAWNSTATUSOPF)};
        case (INDEPENDENT): {GVAR(WAVERESPAWNSTATUSIND)};
        case (CIVILIAN): {GVAR(WAVERESPAWNSTATUSCIV)};
        default {"ERROR - UNKOWN SIDE"};
    };
};

private _status = parseText format ["<t align='center' size='1.4'>%1</t>",_status];

private _playerTimeLeft = player getVariable "wr_playerRespawnTimeLeft";
private _playerTimeLeftStr = parseText format ["<t align='center' size='1.4'>Player: <t color='%1'>%2</t></t>", if (_playerTimeLeft > 0) then {'#ffff00'} else {'#00ff00'},[_playerTimeLeft, "MM:SS"] call BIS_fnc_secondsToString];

private _waveTimeLeft = call (player getVariable "wr_waveTimeLeft");
private _timeLeftStr = [_waveTimeLeft, "MM:SS"] call BIS_fnc_secondsToString;
private _playersLeft = call (player getVariable "wr_playersLeft");
private _waveSize = call (player getVariable "wr_waveSize");
private _waveLeftStr = parseText format ["<t align='center' size='1.4'>Wave: <t color='%3'>%1/%2</t> - <t color ='%4'>%5</t></t>", _waveSize - _playersLeft, _waveSize, if (_playersLeft > 0) then {'#ffff00'} else {'#00ff00'},if (_waveTimeLeft > 0) then {'#ffff00'} else {'#00ff00'}, _timeLeftStr];

private _maxTime = parseText format ["<t align ='center' size='0.7'>Skipping waiting time in: %1.</t>", [GVAR(MAXRESPAWNTIME) - (time - (player getVariable ["wr_timeOfDeath",time])),"MM:SS"] call BIS_fnc_secondsToString];


private _hintArray = [
    _rule,
    _lineBreak,
    _playerTimeLeftStr,
    _lineBreak,
    _waveLeftStr,
    _lineBreak,
    _status,
    _lineBreak,
    _rule,
    _lineBreak,
    _maxTime
];

hintSilent composeText _hintArray;
