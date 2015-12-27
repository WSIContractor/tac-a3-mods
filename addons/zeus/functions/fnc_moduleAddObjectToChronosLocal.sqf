/*
 * Author: Jonpas
 * Adds an object to Chronos persistence (executed locally on client who placed the module).
 *
 * Arguments:
 * 0: The module logic <OBJECT>
 * 1: Synchronized units <ARRAY> (Unused)
 * 2: Activated <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_logic", "", "_activated"];

if !(_activated && local _logic) exitWith {};

(missionNamespace getVariable ["bis_fnc_curatorObjectPlaced_mouseOver", [""]]) params ["_mouseOverType", "_mouseOverUnit"];

if (isNil "ChronosLoaded" || {!isNil "ChronosLoaded" && {!(ChronosLoaded isEqualTo "true")}}) then {
    [LSTRING(EnableChronos)] call ACE_Common_fnc_displayTextStructured;
} else {
    if (_mouseOverType != "OBJECT" || {_mouseOverUnit isKindOf "CAManBase"}) then {
        [LSTRING(PlaceOnObject)] call ACE_Common_fnc_displayTextStructured;
    } else {
        if !((_mouseOverUnit getVariable ["vehicleChronosID", "None"]) isEqualTo "None") then {
            [LSTRING(AlreadyInChronos)] call ACE_Common_fnc_displayTextStructured;
        } else {
            ["AddObjectToChronos", _mouseOverUnit] call ACE_Common_fnc_serverEvent;
        };
    };
};

deleteVehicle _logic;