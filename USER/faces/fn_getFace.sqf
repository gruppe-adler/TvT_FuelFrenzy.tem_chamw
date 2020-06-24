
params ["_unit"];

private _face = "LivonianHead_1";

switch (_unit getVariable ["FF_originalSide", sideUnknown]) do {
    // russians
    case west : {
        _face = selectRandom [
            "LivonianHead_1",
            "LivonianHead_2",
            "LivonianHead_3",
            "LivonianHead_4",
            "LivonianHead_5",
            "LivonianHead_6",
            "LivonianHead_7",
            "LivonianHead_8",
            "LivonianHead_9",
            "LivonianHead_10", 
            "RussianHead_1",
            "RussianHead_2",
            "RussianHead_3",
            "RussianHead_4",
            "RussianHead_5"
        ];

    };

    // italians
    case east : {
        _face = selectRandom [
            "PersianHead_A3_01",
            "PersianHead_A3_02",
            "PersianHead_A3_03",
            "GreekHead_A3_01",
            "GreekHead_A3_02",
            "GreekHead_A3_03",
            "GreekHead_A3_04",
            "GreekHead_A3_05",
            "GreekHead_A3_06",
            "GreekHead_A3_07", 
            "GreekHead_A3_08",
            "GreekHead_A3_09"
        ];
    };

    // asian
    case independent : {
        _face = selectRandom [
            "AsianHead_A3_01",   
            "AsianHead_A3_02",
            "AsianHead_A3_03",
            "AsianHead_A3_04",
            "AsianHead_A3_05",
            "AsianHead_A3_06",
            "AsianHead_A3_07",
            "AsianHead_A3_01_sick",
            "AsianHead_A3_02_sick",
            "AsianHead_A3_03_sick",
            "AsianHead_A3_04_sick",
            "AsianHead_A3_05_sick",
            "AsianHead_A3_06_sick",
            "AsianHead_A3_07_sick",
            "AsianHead_A3_02_sick",
            "TanoanHead_A3_01",
            "TanoanHead_A3_02",
            "TanoanHead_A3_03",
            "TanoanHead_A3_04",
            "TanoanHead_A3_05",
            "TanoanHead_A3_06",
            "TanoanHead_A3_07",
            "TanoanHead_A3_08",
            "TanoanBossHead"
        ];
    };

    // german
    case civilian : {
        _face = selectRandom [
            "WhiteHead_01",
            "WhiteHead_02",
            "WhiteHead_03",
            "WhiteHead_04",
            "WhiteHead_05",
            "WhiteHead_06",
            "WhiteHead_07",
            "WhiteHead_08",
            "WhiteHead_09",
            "WhiteHead_10", 
            "WhiteHead_11",
            "WhiteHead_12",
            "WhiteHead_13",
            "WhiteHead_14",
            "WhiteHead_15",
            "WhiteHead_16",
            "WhiteHead_17",
            "WhiteHead_18",
            "WhiteHead_19",
            "WhiteHead_20",
            "WhiteHead_21",
            "WhiteHead_22",
            "WhiteHead_23",
            "WhiteHead_24",
            "WhiteHead_25",
            "WhiteHead_26",
            "WhiteHead_27",
            "WhiteHead_28",
            "WhiteHead_29",
            "WhiteHead_30",
            "WhiteHead_31",
            "WhiteHead_32"
        ];
    };
    default {};
};

_face