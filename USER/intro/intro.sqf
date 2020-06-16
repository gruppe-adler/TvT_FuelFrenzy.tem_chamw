// dont display for JIP
if (didJIP) exitWith {};
titleText ["","BLACK FADED",999];
waitUntil {!isNull player};
waitUntil {time > 0};
player setVariable ["tf_voiceVolume", 0, true];
diwako_dui_main_toggled_off = true;
showChat false;

titleText ["","BLACK FADED",999];

waitUntil {CBA_missionTime > 5};

playSound "glitch2";
uiSleep 2;

private _display = findDisplay 46;
private _pic = _display ctrlCreate ["RscPictureKeepAspect", -1];
private _sleep = 0.01;

FF_showGlitchIntro = true;

[{  
    FF_showGlitchIntro = false;
}, [], 16] call CBA_fnc_waitAndExecute;

while {FF_showGlitchIntro} do {
    for "_i" from 1 to 20 do {
        _pic ctrlSetPosition [0,0,1,1];
        _pic ctrlCommit 0;
        _pic ctrlSetText (getMissionPath ("USER\intro\" + (str _i) + ".jpg"));
        _pic ctrlCommit 0;
        uisleep _sleep;
    };
};

ctrlDelete  _pic;

cutText [" ", "BLACK IN", 2];
/*
private _camera = "camera" camCreate (getpos player);
_camera cameraeffect ["terminate", "back"];
camDestroy _camera;
*/

STHud_UIMode = 1;


titleText ["", "BLACK IN", 0];
player setVariable ["tf_voiceVolume", 1, true];
diwako_dui_main_toggled_off = false;
showChat true;