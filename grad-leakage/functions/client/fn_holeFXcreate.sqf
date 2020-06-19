// perpetuum mobile to create fuel FX on a hole

params ["_bus", "_vehicle", "_hole"];

// get outwards dir
private _dir = _vehicle getRelDir _hole;

// wait - maybe hole is inactive bc no fuel inside
[{
    params ["_bus", "_vehicle", "_hole", "_dir"];
    isNull _hole || (_hole getVariable ["GRAD_leakage_holeActive", false])
},{
    params ["_bus", "_vehicle", "_hole", "_dir"];

    if (isNull _hole) exitWith {
        diag_log "hole is null, exiting stream";
    }; // if hole is repaired

    private _stream = [_vehicle, _hole, _dir] call GRAD_leakage_fnc_holeStreamCreate;

    [{
        params ["_stream", "_bus", "_vehicle", "_hole", "_dir"];
        isNull _hole || !(_hole getVariable ["GRAD_leakage_holeActive", false])
    },{
        params ["_stream", "_bus", "_vehicle", "_hole", "_dir"];
        deleteVehicle _stream;
        diag_log "deleting stream";
        if (isNull _hole) exitWith {
            diag_log "hole is null, exiting stream";
        }; // if hole is repaired, not run empty

        [_bus, _vehicle, _hole] call GRAD_leakage_fnc_holeFXcreate;

    }, [_stream, _bus, _vehicle, _hole, _dir]] call CBA_fnc_waitUntilAndExecute;
}, [_bus, _vehicle, _hole, _dir]] call CBA_fnc_waitUntilAndExecute;
