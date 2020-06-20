class mafia_ger {
    class AllUnits {
        uniform[] = {"U_BG_Guerilla3_1", "U_Marshal", "U_BG_Guerilla2_2", "U_BG_Guerrilla_6_1", "U_BG_Guerilla2_3", "U_I_C_Soldier_Bandit_3_F", "grad_u_combatCasual_khaki_grey", "grad_u_combatCasual_ranger_grey"};
        vest = "V_Chestrig_blk";
        backpack = "grad_kitbag_black";
        headgear[] = {"H_Watchcap_blk", "H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_khk", "H_Beret_blk", "rhs_beanie_green", "H_Watchcap_blk", "H_Watchcap_blk"};
        goggles[] = {"TRYK_Beard", "TRYK_Beard", "TRYK_Beard_BW", "TRYK_Beard2", "TRYK_Beard_BW2"};

        primaryWeapon = "rhsusf_weap_MP7A2";
        primaryWeaponOptics = "";
        primaryWeaponMagazine = "rhsusf_mag_40Rnd_46x30_FMJ";
        primaryWeaponPointer = "";
        primaryWeaponMuzzle = "";
        primaryWeaponUnderbarrel = "";
        primaryWeaponUnderbarrelMagazine = "";

        secondaryWeapon = "";
        secondaryWeaponMagazine = "";

        handgunWeapon = "rhs_weap_cz99";
        handgunWeaponMagazine = "rhssaf_mag_15Rnd_9x19_FMJ";

        binoculars = "Binocular";
        map = "ItemMap";
        compass = "ItemCompass";
        watch = "ItemWatch";
        gps = "ItemGPS";
        radio = "tf_fadak";
        nvgoggles = "";

        addItemsToUniform[] = {
            LIST_6("ACE_fieldDressing"),
            LIST_4("ACE_morphine"),
            LIST_3("ACE_CableTie"),
            "ACE_epinephrine",
            "ACE_Flashlight_KSF1",
            "ACE_MapTools",
            "ACE_key_lockpick",
            "ACE_key_east"
        };
        addItemsToVest[] = {};
        addItemsToBackpack[] = {};
    };
    class Type {
        //Rifleman
        class man_1 {
            addItemsToBackpack[] = {
                LIST_7("rhsusf_mag_40Rnd_46x30_FMJ"),
                LIST_2("rhs_mag_rdg2_white"),
                LIST_2("rhs_mag_rgd5")
            };
        };

        //Asst. Autorifleman
        class man_sport_1_F: man_1 {
            addItemsToVest[] = {
                LIST_7("rhsusf_mag_40Rnd_46x30_FMJ"),
                LIST_2("rhs_mag_rgd5"),
                LIST_1("rhs_mag_rdg2_white")
            };
            addItemsToBackpack[] = {
                LIST_6("rhs_30Rnd_545x39_AK_green")
            };
        };

        //Autorifleman
        class man_sport_2_F: man_1 {
            primaryWeapon = "rhs_weap_aks74u";
            primaryWeaponMagazine = "rhs_30Rnd_545x39_AK_green";
            addItemsToBackpack[] = {
                LIST_6("rhs_30Rnd_545x39_AK_green")
            };
        };

        //Combat Life Saver
        class man_p_beggar_F: man_1 {
            addItemsToVest[] = {
                LIST_15("ACE_fieldDressing"),
                LIST_8("ACE_morphine"),
                LIST_8("ACE_epinephrine"),
                LIST_1("ACE_salineIV_500"),
                LIST_1("ACE_salineIV_250")
            };
        };

        //Rifleman (AT)
        class man_sport_3_F: man_1 {
            secondaryWeapon = "rhs_weap_rpg26";
        };

        //Squad Leader
        class Man_casual_1_F: man_1 {

            addItemsToBackpack[] = {
                LIST_7("rhsusf_mag_40Rnd_46x30_FMJ"),
                LIST_2("rhs_mag_rdg2_white"),
                LIST_2("rhs_mag_rgd5")
            };
        };

        //Team Leader
        class Man_casual_2_F: Man_casual_1_F {
            uniform = "rhsgref_uniform_gorka_1_f";
        };
    };

    class Rank {
        class LIEUTENANT {
        };
    };
};