//_RTB = _helo addAction ["<t color='#00b7ff'>RTB</t>", "support\taxi\RTB.sqf", [], 0, true, true, "", "true"];
//requires helotaxi.sqf to have started, moves end point to new location
		private ["_helo", "_caller","_RTB", "_helotype", "_plName", "_pilot", "_helogroup", "_currentPos", "_dropPos", "_oldDZ"];
		_helo = _this select 0;
		_caller = _this select 1;
		_RTB = _this select 2;
		_helotype = typeOf _helo;
		_plName = name _caller;
		_pilot = driver _helo;
		_helogroup = group _pilot;
		_currentPos = getPos _helo;
		_dropPos = helipad0;
		_oldDZ = getPos helipad2;
//delete old waypoint and objects
		while {(count (waypoints _helogroup)) > 0} do
		{
			deleteWaypoint ((waypoints _helogroup) select 0);
		};
        deleteVehicle helipad1;
		deleteVehicle helipad2;
		deleteMarker str (EndMk); 
 //open map to click new Dz
		_helo VehicleChat format["OK %1, We are RTB", _plName];
		//openMap [true, false];
		[_helotype, 2, "DZ"];
		_dropPos;
		if (cost) then {
				_helo VehicleChat format["OK %1, we'll just run through the numbers and work that route cost out for you...", _plName];
				sleep 3;
	
				_cancelDis = _currentPos distance _oldDZ;
				_tripDis = _currentPos distance _dropPos;
				_refund = [_cancelDis*0.1, 2]call BIS_fnc_cutDecimals;
				_tripCost = [_TripDis*0.1, 2]call BIS_fnc_cutDecimals;
				funds = funds + _refund;
				funds = funds - _tripCost;
				if (funds < 0) Then {funds = 0;};
				publicVariable  "funds";
				[west, "HQ"] sideChat format["HQ to %1, change of route confirmed, new Insertion Point found. We've been refunded %2 Euro's and charged %3 Euro's for the new route of %4 meters. we have %5 Euro's remaining", _plName, _refund, _tripCost, _tripDis, str funds];
		};
		_wp = _helogroup addWaypoint [_dropPos,0];
		_wp setWaypointType "MOVE";
		[_helogroup, 1] setWaypointCombatMode "BLUE";