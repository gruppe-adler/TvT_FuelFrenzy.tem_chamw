/*  Hier können eigene Funktionen eingebunden werden.
*   Ist in CfgFunctions included.
*/
class refuel
   {
       class all
       {
           file = "USER\refuel\functions";
           class addRefuelCargoAction;
           class connectAndRefuelCargo;
           class connectAndRefuelVehicleTank;
           class fuelBusAddActions;
           class fuelBusLoop;
           class fuelBusSpawn;
           class refuelCargo;
           class refuelVehicleTank;
           class canTurnOn;
           class vehicleTrackingInit { postInit = 1; };
           class vehicleTrackingLoop;
       };


       class faces
       {
           file = "USER\faces";
           class getFace;
       };
};