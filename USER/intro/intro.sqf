// dont display for JIP
if (didJIP) exitWith {};
waitUntil {!isNull player};
waitUntil {time > 0};
player setVariable ["tf_voiceVolume", 0, true];
diwako_dui_main_toggled_off = true;
showChat false;

titleText ["","BLACK FADED",999];

playSound "glitch2";

private _display = findDisplay 46;
private _pic = _display ctrlCreate ["RscPictureKeepAspect", -1];
private _sleep = 0.0335;

for "_i" from 1 to 20 do {
    _pic ctrlSetPosition [0,0,1,1];
    _pic ctrlCommit 0;
    _pic ctrlSetText (getMissionPath ("USER\intro\" + (str _i) + ".jpg"));
    _pic ctrlCommit 0;
    uisleep _sleep;
};

for "_i" from 1 to 20 do {
    _pic ctrlSetPosition [0,0,1,1];
    _pic ctrlCommit 0;
    _pic ctrlSetText (getMissionPath ("USER\intro\" + (str _i) + ".jpg"));
    _pic ctrlCommit 0;
    uisleep _sleep;
};

for "_i" from 1 to 20 do {
    _pic ctrlSetPosition [0,0,1,1];
    _pic ctrlCommit 0;
    _pic ctrlSetText (getMissionPath ("USER\intro\" + (str _i) + ".jpg"));
    _pic ctrlCommit 0;
    uisleep _sleep;
};

for "_i" from 1 to 20 do {
    _pic ctrlSetPosition [0,0,1,1];
    _pic ctrlCommit 0;
    _pic ctrlSetText (getMissionPath ("USER\intro\" + (str _i) + ".jpg"));
    _pic ctrlCommit 0;
    uisleep _sleep;
};

for "_i" from 1 to 20 do {
    _pic ctrlSetPosition [0,0,1,1];
    _pic ctrlCommit 0;
    _pic ctrlSetText (getMissionPath ("USER\intro\" + (str _i) + ".jpg"));
    _pic ctrlCommit 0;
    uisleep _sleep;
};

for "_i" from 1 to 20 do {
    _pic ctrlSetPosition [0,0,1,1];
    _pic ctrlCommit 0;
    _pic ctrlSetText (getMissionPath ("USER\intro\" + (str _i) + ".jpg"));
    _pic ctrlCommit 0;
    uisleep _sleep;
};

for "_i" from 1 to 20 do {
    _pic ctrlSetPosition [0,0,1,1];
    _pic ctrlCommit 0;
    _pic ctrlSetText (getMissionPath ("USER\intro\" + (str _i) + ".jpg"));
    _pic ctrlCommit 0;
    uisleep _sleep;
};

for "_i" from 1 to 20 do {
    _pic ctrlSetPosition [0,0,1,1];
    _pic ctrlCommit 0;
    _pic ctrlSetText (getMissionPath ("USER\intro\" + (str _i) + ".jpg"));
    _pic ctrlCommit 0;
    uisleep _sleep;
};

for "_i" from 1 to 20 do {
    _pic ctrlSetPosition [0,0,1,1];
    _pic ctrlCommit 0;
    _pic ctrlSetText (getMissionPath ("USER\intro\" + (str _i) + ".jpg"));
    _pic ctrlCommit 0;
    uisleep _sleep;
};

for "_i" from 1 to 20 do {
    _pic ctrlSetPosition [0,0,1,1];
    _pic ctrlCommit 0;
    _pic ctrlSetText (getMissionPath ("USER\intro\" + (str _i) + ".jpg"));
    _pic ctrlCommit 0;
    uisleep _sleep;
};

for "_i" from 1 to 10 do {
    _pic ctrlSetPosition [0,0,1,1];
    _pic ctrlCommit 0;
    _pic ctrlSetText (getMissionPath ("USER\intro\" + (str _i) + ".jpg"));
    _pic ctrlCommit 0;
    uisleep _sleep;
};

ctrlDelete  _pic;

cutText [" ", "BLACK IN", 3];
private _camera = "camera" camCreate (getpos player);
_camera cameraeffect ["terminate", "back"];
camDestroy _camera;

STHud_UIMode = 1;


titleText ["", "BLACK IN", 0];
player setVariable ["tf_voiceVolume", 1, true];
diwako_dui_main_toggled_off = false;
showChat true;