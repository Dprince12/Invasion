_emrgncyLand = _helo addAction ["<t color='#00b7ff'>Land here</t>", "support\taxi\LandHere.sqf", [], 0, true, true, "", "true"];

	waitUntil {helipad2 distance _helo < 200  or (vehicle _pilot == _pilot or !alive _pilot)}; // wait until the helo is near the lz
	_helo vehicleChat format["wake up %1! we're approaching your location for drop off, get your shit together",_plName];
// IF THE PILOT IS DEAD OR CHOPPA DOWN  **************
	[_pilot] call LF_fnc_deadCheck;
	if (crashed) Exitwith {
		[_pilot, _plName, _callsign,1] call LF_fnc_deadClean;	
	};
//pilot commits to landing
	_helo land "LAND";
	sleep 5;
	_helo removeAction _emrgncyLand;

_RTB = _helo addAction ["<t color='#ff000'>RTB</t>", "support\taxi\RTB.sqf", [], 0, true, true, "", "true"];
  
    waitUntil {helipad0 distance _helo < 200}; //Wait till near LZ
    _helo vehicleChat format["%1! Wake up! We are about Home! CO wants to see you when we land!]
//pilot commits to landing
    _helo land "LAND";
    sleep 5;
    _helo removeAction _RTB;
    
        