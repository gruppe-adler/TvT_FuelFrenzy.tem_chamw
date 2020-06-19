params ["_side", "_pos", "_dir"];

["RDS_Ikarus_Civ_02",[["Land_RailwayCar_01_tank_F",[-0.0856934,-2.81958,1.91202],[[-0.00169315,-0.999999,0],[0,0,1]]],["Land_RailwayCar_01_tank_F",[-0.119873,1.97656,1.93297],[[-0.00169315,-0.999999,0],[0,0,1]]],["Land_TreeGuard_01_F",[-1.04663,-5.70093,0.180649],[[0.0628952,-0.99802,0],[0,0,1]]],["Land_TreeGuard_01_F",[1.27612,-5.56958,-0.0716858],[[0.0628952,-0.99802,0],[0,0,1]]],["Land_TreeGuard_01_F",[-1.10181,4.65869,0.366852],[[0.0628952,-0.99802,0],[0,0,1]]],["Land_TreeGuard_01_F",[1.09521,4.7605,0.235931],[[0.0628952,-0.99802,0],[0,0,1]]],["Truck_01_Rack_tropic_F",[-0.498047,-3.12427,-0.052887],[[-0.0507227,-0.998704,-0.00412591],[0.99739,-0.0508677,0.0512492]]],["Truck_01_Rack_tropic_F",[0.502197,-3.05103,0.0573273],[[0.0508565,-0.998702,0.00278888],[-0.998393,-0.0509102,-0.0248762]]],["Truck_01_Rack_tropic_F",[-0.459473,2.27393,0.265869],[[0.0225556,0.999737,-0.00412592],[-0.998427,0.0227376,0.0512492]]],["Land_Plank_01_4m_F",[1.27783,2.03882,0.812225],[[-0.00102353,-0.999929,-0.0118424],[-0.998473,0.000367761,0.0552477]]],["Land_Plank_01_4m_F",[1.33496,2.00317,0.106079],[[-0.00102353,-0.999929,-0.0118424],[-0.998473,0.000367761,0.0552477]]],["Land_Plank_01_4m_F",[1.3562,2.03345,-0.642151],[[-0.00102353,-0.999929,-0.0118424],[-0.998473,0.000367761,0.0552477]]],["Land_BackAlley_01_l_1m_F",[0.620361,5.11694,0.34169],[[0.0628952,-0.99802,0],[0,0,1]]],["Land_Tank_rust_F",[-0.137939,-0.338379,3.45096],[[1,-0.000523485,0],[0,0,1]]]]] params ["_vehicleType", "_objectsArray"];

private _bus = createVehicle [_vehicleType, _pos, [], 0, "NONE"];
_bus setDir _dir;

{
  _x params ["_type", "_offset", "_vectorDirAndUp"];

  private _attachment = _type createVehicle [0,0,0];
  _attachment attachTo [_bus, _offset];
  _attachment setVectorDirAndUp _vectorDirAndUp;

  if (_type == "Land_Tank_rust_F") then {
        [_bus, _attachment, 0] remoteExec ["GRAD_leakage_fnc_registerHit", 0, true];
  };
  
} forEach _objectsArray;

[_bus, 0] call ace_refuel_fnc_makeSource; 
[_bus, 0] call ace_refuel_fnc_setfuel;
_bus setVariable ["ace_refuel_fuelMaxCargo", 2000, true];
_bus setVariable ["ace_refuel_nozzle", _bus, true]; // hack to hide CONNECT action to make all actions equally distinctive

_bus setVariable ["FF_originalSide", _side, true];
_bus setVariable ["FF_trackedForSide", _side, true];

private _existingBusses = missionNamespace getVariable ["FF_fuelTrucks", []];
_existingBusses pushBackUnique _bus;
missionNamespace setVariable ["FF_fuelTrucks", _existingBusses, true];

[_bus] remoteExec ["refuel_fnc_fuelBusAddActions", [0,-2] select isDedicated, true];

[{
    params ["_bus"];
    !((_bus getVariable ["FF_trackedForSide",sideUnknown]) isEqualTo (_bus getVariable ["FF_originalSide",sideUnknown])) ||
    !alive _bus
},{
     params ["_bus", "_side", "_pos", "_dir"];

     [_side, _pos, _dir] call refuel_fnc_fuelBusSpawn;
}, [_bus, _side, _pos, _dir]] call CBA_fnc_waitUntilAndExecute;

// call (uiNamespace getVariable ["ace_refuel_cacheRefuelClasses", {[[],[]]}]); 