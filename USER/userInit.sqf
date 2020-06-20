/*  Wird zum Missionsstart auf Server und Clients ausgeführt.
*   Funktioniert wie die init.sqf.
*/

[
    {
        !(isNil "bis_fnc_init")
    },
    {
        [] execVM "USER\initFueling.sqf";
    },
    []
] call CBA_fnc_waitUntilAndExecute;


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
    default {}; 
};

[   
    player,
    [player] call refuel_fnc_getFace,
    "Male01ENGB",
    1.0,
    name player
] remoteExec [
    "BIS_fnc_setIdentity",
    0,
    true
];


if (isServer) then {
    TIME_OF_DAY = ["TIME_OF_DAY", 10] call BIS_fnc_getParamValue;
    publicVariable "TIME_OF_DAY";

    WEATHER_OVERCAST = ["WEATHER_OVERCAST", -1] call BIS_fnc_getParamValue;
    publicVariable "WEATHER_OVERCAST";

    WEATHER_FOG = ["WEATHER_FOG", -1] call BIS_fnc_getParamValue;
    publicVariable "WEATHER_FOG";

    WEATHER_WIND = ["WEATHER_WIND", -1] call BIS_fnc_getParamValue;
    publicVariable "WEATHER_WIND";

    setCustomWeather = {

    // get random shit
    if (str WEATHER_OVERCAST isEqualTo "-1") then {
    WEATHER_OVERCAST = [[
    0.0,
    0.1,
    0.2,
    0.3,
    0.4,
    0.5,
    0.6,
    0.7,
    0.8,
    0.9,
    1.0
    ], [
    0.3,
    0.3,
    0.1,
    0.1,
    0.05,
    0.025,
    0.025,
    0.025,
    0.025,
    0.025,
    0.025]] call BIS_fnc_selectRandomWeighted;
    };

    if (str WEATHER_FOG isEqualTo "-1") then {
    WEATHER_FOG = [[
    0.0,
    0.05,
    0.1,
    0.2,
    0.3,
    0.4,
    0.5,
    0.6,
    0.7,
    0.8,
    1.0
    ], [
    0.5,
    0.3,
    0.1,
    0.075,
    0.01,
    0.005,
    0.005,
    0.004,
    0.003,
    0.002,
    0.001]] call BIS_fnc_selectRandomWeighted;
    };

    if (str WEATHER_WIND isEqualTo "-1") then {
    WEATHER_WIND = (random 2) - (random 4);
    };

    diag_log format ["FF setup: setting wind to %1", WEATHER_WIND];

    // basics
    10 setOvercast WEATHER_OVERCAST;
    10 setFog WEATHER_FOG;
    setWind [WEATHER_WIND, WEATHER_WIND, true];
    10 setWindForce 0.1;

    // add specials dependent on values
    if (WEATHER_OVERCAST > 0.5 && WEATHER_OVERCAST < 0.8) then {
    10 setRain 0.5;
    10 setRainbow 0.8;
    };

    if (WEATHER_OVERCAST >= 0.8) then {
    10 setRain 1;
    10 setLightnings 0.8;
    };

    // enforce changes
    forceWeatherChange;
    };


    // allow view distance to be up to 10k

    // set to full moon date
    setDate [2015, 2, 1, TIME_OF_DAY, 1]; // set to 5:00 for perfect full moon

    call setCustomWeather;
};
