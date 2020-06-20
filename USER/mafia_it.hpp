class mafia_it {
    class AllUnits {
        uniform[] = {"rds_uniform_Functionary1"};
        vest = "rhsgref_chicom";
        backpack = "B_AssaultPack_blk";
        headgear[] = {"H_Hat_brown", "H_Hat_grey", "H_StrawHat_dark", "H_Hat_tan", "H_Hat_checker"};
        goggles = "G_Aviator";

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
            uniform= "U_Marshal";
        };
    };

    class Rank {
        class LIEUTENANT {
        };
    };
};