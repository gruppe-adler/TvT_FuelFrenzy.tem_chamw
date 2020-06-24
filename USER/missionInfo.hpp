/*  Allgemeine Info über die Mission.
*   Ist in description.ext eingebunden, kann also auch für andere Configs benutzt werden.
*/

author = "nomisum für Gruppe Adler";                                               //Missionsersteller (Du)
onLoadName = "TVT Fuel Frenzy";                                                    //Name der Mission
onLoadMission = "";                                                             //Beschreibung der Mission (wird im Ladebildschirm unterhalb des Ladebildes angezeigt)
loadScreen = "USER\intro\loading.jpg";                                                //Ladebild


class CfgHints
{
   class HintRefuel
   {
       displayName = "Refuel System";

       class fillFuelTruck
       {
           // Hint title, filled by arguments from 'arguments' param
          displayName = "Refuel System how to";
          // Optional hint subtitle, filled by arguments from 'arguments' param
          displayNameShort = "";
          // Structured text, filled by arguments from 'arguments' param
          description = "Hello %11! Here a quick how to fill your fuel truck cargo with that juicy liquid.";
          // Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
          tip = "Access the fuel station with %3ACE-interact%4 , take fuel nozzle. %1 Move to fuel truck, ACE Interact on it. %1 Choose 'Fill fuel cargo'.; ";
          arguments[] = {
            "str player" // Simple string will be simply compiled and called, String can also link to localization database in case it starts by str_
          };
          // Optional image
          image = "";
          // optional parameter for not showing of image in context hint in mission (default false))
          noImage = false;
          // -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
          // if a dlc's appID Number is used ( see getDLCs ) and the user does not have the required dlc installed then the advHint will be replaced with
          // configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
          dlc = -1;
       };

       class sellFuel
       {
           // Hint title, filled by arguments from 'arguments' param
          displayName = "Sell Fuel how to";
          // Optional hint subtitle, filled by arguments from 'arguments' param
          displayNameShort = "";
          // Structured text, filled by arguments from 'arguments' param
          description = "Hello %11! Sell your fuel to get points for your team.";
          // Optional structured text, filled by arguments from 'arguments' param (first argument is %11, see notes bellow), grey color of text
          tip = "Access the fuel truck with %3ACE-interact%4 , take fuel nozzle. %1 Move to fuel tower in your base, ACE Interact on it. %1 Choose 'Sell fuel cargo'.; ";
          arguments[] = {
            "str player" // Simple string will be simply compiled and called, String can also link to localization database in case it starts by str_
          };
          // Optional image
          image = "";
          // optional parameter for not showing of image in context hint in mission (default false))
          noImage = false;
          // -1 Creates no log in player diary, 0 Creates diary log ( default when not provided )
          // if a dlc's appID Number is used ( see getDLCs ) and the user does not have the required dlc installed then the advHint will be replaced with
          // configfile >> "CfgHints" >> "DlcMessage" >> "Dlc#"; where # is this properties ( dlc appID ) number
          dlc = -1;
       };
   };
};