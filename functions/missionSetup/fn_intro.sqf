/*  Displays Gruppe Adler logo and mission name at start of game
*
*   executed on players via init.sqf
*/

#include "component.hpp"

if (!hasInterface) exitWith {};
[{!isNull player}, {

    [] execVM "USER\intro\intro.sqf";
    /*
    [{
        _missionName = getMissionConfigValue ["onLoadName", "NAME NOT FOUND"];
        _text = format ["<img size= '6' style='vertical-align:middle' shadow='false' image='data\gruppe-adler.paa'/><br/><t size='.9' color='#FFFFFF'>%1</t>", _missionName];
        [_text,0,0,2,2] spawn BIS_fnc_dynamicText;
    }, [], 3] call CBA_fnc_waitAndExecute;
    */
}, []] call CBA_fnc_waitUntilAndExecute;
