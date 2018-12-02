/*
if shit gets weird you can use this command to try and reset the support menu. It terminates support script removes all objects/markers and tries to return helo to base
call with resetsup = [player,"reset_helo"] call BIS_fnc_addCommMenuItem;
*/
//declare and get variables
		private ["_helo", "_plName"];

		_helo = _this select 0;
		_basepad = _this select 1;
		_callsign = _this select 2;
		_pilot = driver _helo;
		_helogroup = group _helo;
		_plName = name player;//not sure if in mp this will be the player who called action or different for each player
		crashed = false;
		
		hint "WIP";
// kill support script		
		terminate LF_taxiScript;
		player sideChat format["This is %1 to HQ, somethings gone FUBAR with the comms support system, please advise",_plName];
		sleep 2;

		[west, "HQ"] sideChat format["This is HQ to %1, message confirmed, please hold, we're going to try turning it off and on again",_plName];
		sleep 2;
//clean out heli waypoints, actions and nav objects
		while {(count (waypoints _helogroup)) > 0} do
				{deleteWaypoint ((waypoints _helogroup) select 0);};
		//delete all the objects
		deleteVehicle helipad1;
		deleteVehicle helipad2;
		deleteMarker str(StartMk);
		deleteMarker str(EndMk);
// tell the helo to RTB
		if (_basepad distance _helo > 100) then {
				[west, "HQ"] sideChat format["This is HQ, we are calling %1 to RTB",_callsign];
				sleep 2;
	
				_helo vehicleChat format["This is %1, roger that, we are RTB",_callsign];	
				_wp = _helogroup addWaypoint [_basePad,0];   
				_wp setWaypointType "MOVE";
				waitUntil {_basePad distance _helo < 200  or (vehicle _pilot == _pilot or !alive _pilot)}; // wait until the helo is near the ground
// IF THE PILOT IS DEAD OR CHOPPA DOWN  **************
				[_pilot] call LF_fnc_deadCheck;
				if (crashed) Exitwith {
						[_pilot, _plName, _callsign,1] call LF_fnc_deadClean;
				};
				_helo land "LAND";
				_time = Time;
				waitUntil {(getpos _helo select 2 < 4 && _helo distance _basePad<20)  or (vehicle _pilot == _pilot or !alive _pilot) or (Time > _time + 60)};
				[west, "HQ"] sideChat format["This is HQ to %1, %2 is back at base and ready for ops", _plName, _callsign];
// IF THE PILOT IS DEAD OR CHOPPA DOWN  **************
				[_pilot] call LF_fnc_deadCheck;
				if (crashed) Exitwith {
						[_pilot, _plName, _callsign,1] call LF_fnc_deadClean;
				};
			} else {
// IF THE PILOT IS DEAD OR CHOPPA DOWN  **************
				[_pilot] call LF_fnc_deadCheck;
				if (crashed) Exitwith {
						[_pilot, _plName, _callsign,1] call LF_fnc_deadClean;
				};
				_helo land "LAND";
		};
// IF THE PILOT IS DEAD OR CHOPPA DOWN  **************
		[_pilot] call LF_fnc_deadCheck;
		if (crashed) Exitwith {
				[_pilot, _plName, _callsign,1] call LF_fnc_deadClean;
		};
//final reset if choppa ain't dead
		_helo land "LAND";
		_helo setDammage 0;
		_helo Setfuel 1;
		sleep 5;
		
		helisup = [player,"helo_taxi"] call BIS_fnc_addCommMenuItem;
		sleep 2;

		[west, "HQ"] sideChat format["HQ to %1, erm... did that fix the problem?",_plName];