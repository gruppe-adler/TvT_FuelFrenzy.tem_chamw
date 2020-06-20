class mafia_chin {
    class AllUnits {
        uniform[] = {"U_I_C_Soldier_Para_5_F", "U_I_C_Soldier_Bandit_4_F", "U_I_C_Soldier_Bandit_1_F", "U_I_C_Soldier_Bandit_5_F", "U_C_Poloshirt_blue", "U_C_Poloshirt_salmon", "rds_uniform_schoolteacher"};
        vest = "V_Chestrig_khk";
        backpack = "rhs_sidor";
        headgear[] = {"rhssaf_booniehat_woodland", "rhs_Booniehat_m81", "H_Hat_brown", "H_Hat_grey", "H_Booniehat_oli", "H_Booniehat_tan", "H_Booniehat_khk_hs", "H_Bandanna_sgg", "H_Bandanna_sand"};
        goggles[] = {"rhsusf_shemagh_od", "rhsusf_shemagh2_od", "rhsusf_shemagh2_grn", "rhsusf_shemagh_grn"};

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
        class Soldier_F {
            addItemsToBackpack[] = {
                LIST_7("rhsusf_mag_40Rnd_46x30_FMJ"),
                LIST_2("rhs_mag_rdg2_white"),
                LIST_2("rhs_mag_rgd5")
            };
        };

        //Asst. Autorifleman
        class soldier_AAR_F: Soldier_F {
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
        class soldier_AR_F: Soldier_F {
            primaryWeapon = "rhs_weap_aks74u";
            primaryWeaponMagazine = "rhs_30Rnd_545x39_AK_green";
            addItemsToBackpack[] = {
                LIST_6("rhs_30Rnd_545x39_AK_green")
            };
        };

        //Combat Life Saver
        class medic_F: Soldier_F {
            addItemsToVest[] = {
                LIST_15("ACE_fieldDressing"),
                LIST_8("ACE_morphine"),
                LIST_8("ACE_epinephrine"),
                LIST_1("ACE_salineIV_500"),
                LIST_1("ACE_salineIV_250")
            };
        };

        //Rifleman (AT)
        class soldier_LAT_F: Soldier_F {
            secondaryWeapon = "rhs_weap_rpg26";
        };

        //Team Leader
        class Soldier_TL_F: Soldier_F {
            
            primaryWeapon = "rhsusf_weap_MP7A2";

            addItemsToBackpack[] = {
                LIST_7("rhsusf_mag_40Rnd_46x30_FMJ"),
                LIST_2("rhs_mag_rdg2_white"),
                LIST_2("rhs_mag_rgd5")
            };
        };

        //Squad Leader
        class Soldier_SL_F: Soldier_TL_F {
            uniform= "U_I_C_Soldier_Para_2_F";
        };
    };

    class Rank {
        class LIEUTENANT {
        };
    };
};