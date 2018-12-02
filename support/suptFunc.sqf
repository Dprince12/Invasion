/*
Dependent global variables:
cost = boolian;
clicked = false;
clickedPos = [x,y,z];
inVeh = boolian;
crashed = boolian;
StartMk = marker;
EndMk = marker;
helipad0 = base pad (placed in EDEN);
helipad1 = start pad (spawned);
helipad2 = end pad (spawned);
helisup = supportmenu handle

*/


////////////////////////MENU SUPPORT ITEMS



MENU_SUPPORT_1 =
[
	["Support Menu",false],
	["Transport", [2], "#USER:MENU_TRANSPORT_1", -5, [], "1", "1"],
	["Supplies", [3], "#USER:MENU_SUPPLY_1", -5, [], "1", "1"],
	["Orders", [4], "#USER:MENU_ORDERS_1", -5, [], "1", "1"]
];
MENU_TRANSPORT_1 =
[
	// First array: "User menu" This will be displayed under the menu, bool value: has Input Focus or not.
	// Note that as to version Arma2 1.05, if the bool value set to false, Custom Icons will not be displayed.
	["Transport",false],
	// Syntax and semantics for following array elements:
	// ["Title_in_menu", [assigned_key], "Submenu_name", CMD, [["expression",script-string]], "isVisible", "isActive" <, optional icon path> ]
	// Title_in_menu: string that will be displayed for the player
	// Assigned_key: 0 - no key, 1 - escape key, 2 - key-1, 3 - key-2, ... , 10 - key-9, 11 - key-0, 12 and up... the whole keyboard
	// Submenu_name: User menu name string (eg "#USER:MY_SUBMENU_NAME" ), "" for script to execute.
	// CMD: (for main menu:) CMD_SEPARATOR -1; CMD_NOTHING -2; CMD_HIDE_MENU -3; CMD_BACK -4; (for custom menu:) CMD_EXECUTE -5
	// script-string: command to be executed on activation.  (_target=CursorTarget,_pos=CursorPos) 
	// isVisible - Boolean 1 or 0 for yes or no, - or optional argument string, eg: "CursorOnGround"
	// isActive - Boolean 1 or 0 for yes or no - if item is not active, it appears gray.
	// optional icon path: The path to the texture of the cursor, that should be used on this menuitem.
	["chopper transport", [2], "", -5, [["expression", "LF_taxiScript = [helitaxi, helipad0, callsign] execVM 'support\taxi\helotaxi.sqf'"]], "1", "1"],
	["Transport RTB", [3], "", -5, [["expression", "LF_taxiScript = [helitaxi, helipad0, callsign] execVM 'support\taxi\heloRTB.sqf';"]], "1", "1"],
	["engineer callout", [4], "", -5, [["expression", "hint '(planned) chopper brings a scripted engineer out to your position to fix your shit up';"]], "1", "1"]
];
MENU_SUPPLY_1 =
[
	["Supplies",false],
	["weapons drop", [2], "", -5, [["expression", "hint '(planned) chopper will go into cargo config and fly out with a couple of weapons crates';"]], "1", "1"],
	["supplies drop", [3], "", -5, [["expression", "hint '(planned) chopper will go into cargo config and fly out with a sling loaded supply box';"]], "1", "1"],
	["vehicle drop", [4], "", -5, [["expression", "hint '(planned) chopper will sling load a quad or jetski to you';"]], "1", "1"]
];
MENU_ORDERS_1 =
[
	["Orders",false],
	["move chopper", [2], "", -5, [["expression", "hint '(planned) chopper will move to clicked position, land and wait';"]], "1", "1"],
	["RTB", [3], "", -5, [["expression", "hint '(planned) chopper will return to base pad';"]], "1", "1"],
	["CAS", [4], "", -5, [["expression", "hint '(planned) chopper will go into combat config, fly to clicked position and shoot the shit out of stuff';"]], "1", "1"]
];
////////////////INIT///////////////INIT///////////////////INIT///////////////INIT///////////////////
//usually found in init.sqf or the like, included here for possible spawning from module etc
/*
cost = false;
helisup = [player,"helo_taxi"] call BIS_fnc_addCommMenuItem;
*/
///////////////////////////FUNCTIONS////////////////////////////////FUNCTIONS///////////////////////////////////////////////////
// function to open map and log click position to, creates pads and markers ,requires ref class [_helotype, 1, "LZ"] call LF_fnc_mapClick;
LF_fnc_mapClick = {
		private ["_helo"];
		_helo = _this select 0;
		_state = _this select 1;
		_mkRef = _this select 2;
		_basePos = getPos helipad0;
		_xtrct_pnt = [];
		_timer = 999;
		_max_dist = 100;

		clicked = false;

		if (_state == 3) exitWith {
				openMap [true, false];
				StartMk = format["%1%2",_mkRef,_basePos]; // Define marker name
				_StrtMk = createMarker [str(StartMk), _basePos];
				_StrtMk setMarkerShape "ICON";
				str(StartMk) setMarkerType "hd_end";
				str(StartMk) setMarkerColor "ColorGreen";
				str(StartMk) setMarkerText _mkRef;
				helipad1 = createVehicle ["Land_HelipadEmpty_F", _basePos, [], 0, "NONE"];
		};
		if (_State == 0) then {} else {
				if (_state == 1) then {openMap [true, false];};
				OnMapSingleClick "clickedPos = _pos; clicked = true;";
				while {_timer> 0} do {
						if (clicked) then { // player has clicked the map
								while{ count _xtrct_pnt < 1 } do {
										_xtrct_pnt = clickedPos findEmptyPosition[0 , _max_dist , _helo ];
										_max_dist = _max_dist + 50;
								}; // find a valid pos
								onMapSingleClick "";
								_timer = 0;
						};//close map and declare _pos
				};
				if (_state == 1) then {
						StartMk = format["%1%2",_mkRef,_xtrct_pnt]; // Define marker name
						_StrtMk = createMarker [str(StartMk), _xtrct_pnt];
						_StrtMk setMarkerShape "ICON";
						str(StartMk) setMarkerType "hd_end";
						str(StartMk) setMarkerColor "ColorGreen";
						str(StartMk) setMarkerText _mkRef;
						helipad1 = createVehicle ["Land_HelipadEmpty_F", _xtrct_pnt, [], 0, "NONE"]; 
				};
				if (_State == 2) then {
						EndMk = format["%1%2",_mkRef,_xtrct_pnt]; // Define marker name
						_EdMk = createMarker [str(EndMk), _xtrct_pnt];
						_EdMk setMarkerShape "ICON";
						str(EndMk) setMarkerType "hd_end";
						str(EndMk) setMarkerColor "ColorGreen";
						str(EndMk) setMarkerText _mkRef;	
						helipad2 = createVehicle ["Land_HelipadEmpty_F", _xtrct_pnt, [], 0, "NONE"]; 	
						};
				sleep 2;
				if (_state == 2) then {openMap [false, false];
				};
		};
		_timer = 999;
		clicked = false;

};

//function to open and close side doors: _sideDoorClose = [vehicle, anim state]spawn LF_fnc_sideDoors;
LF_fnc_sideDoors = {
		private ["_helo", "_state"];

		_helo = _this select 0;
		_State = _this select 1;

		_helo animateDoor ['door_R', 0];
		sleep 3;
		_helo animateDoor ['door_L', 0];
};

LF_fnc_vehLoadOut = {
/*function to change the load out and functionality of MH-9 hummingbird
[_helo, _state, _lock, _load]call LF_fnc_vehLoadOut;
_helo is the mh-9 to change.
_state is 1 or 0
_outcome is which parts of script to call 1 = arming 2 = passenger/cargo 3 raise/lower benches
_loadbool is for lockCargo boolian 
*/
		private ["_helo", "_state", "_outcome"];
		_helo = _this select 0;
		_State = _this select 1;
		_outcome = _this select 2;
		if (_helo isKindOf "B_Heli_Light_01_F") then {
				if (_outcome == 1) then {
						_helo animateSource ["hiderockets",_State]; 
						_helo animateSource ["hideweapons",_State];
						_helo animateSource ["addBackseats",_State]; 
						_helo animateSource ["addTread",_State]; 
						_helo animateSource ["addBenches",_State]; 
						if (_state == 0) then {
								_state = 1;
								_helo animateSource ["addgunholder",_State];  
								_helo animateSource ["addholdingframe",_State];
								_helo lockCargo true;
						} else {
								_state = 0;
								_helo animateSource ["addgunholder",_State];  
								_helo animateSource ["addholdingframe",_State];
								_helo lockCargo false;
						};
				};
				if (_outcome == 2) then {
						_helo animateSource ["hiderockets",1]; 
						_helo animateSource ["hideweapons",1];
						_helo animateSource ["addgunholder",0]; 
						_helo animateSource ["addBackseats",_State]; 
						_helo animateSource ["addTread",_State]; 
						_helo animateSource ["addBenches",_State]; 
						if (_state == 0) then {
								_state = 1;
								_helo animateSource ["addholdingframe",_State];
								_helo lockCargo true;
						} else {
								_state = 0; 
								_helo animateSource ["addholdingframe",_State];
								_helo lockCargo false;
						};
				};
				if (_outcome == 3) then {
						_helo animateSource ["benchl_up",_state]; 
						_helo animateSource ["benchr_up",_state]; 
						if (_state == 0) then {
								_helo lockCargo false;
						} else {
								_helo lockCargo true;
						};
				};
		};
};
//original script by KIBOT [_helo] call LF_fnc_inVehChck; waitUntil {(inVeh)};
LF_fnc_inVehChck = {
		private ["_helo", "_pilot"];
		_helo = _this select 0;
		_pilot = driver _helo;
		_groupP = group player;
		inVeh = false;

		_inVehCheck = true;
	
		while {_inVehCheck} do {
	
		// wait until the player has gotten in
				waitUntil {(({_x in _helo} count units _groupP) == (count units _groupP))or (vehicle _pilot == _pilot or !alive _pilot)}; 
		
		// get out of the loop if choopa is down
				if (vehicle _pilot == _pilot or !alive _pilot) exitWith {};
	
		// check if player is inside choppa
				if (vehicle player != _helo) then {
						hint "get back in!"
				} else {
						_inVehCheck = false;
						inVeh = true;
				};
		};
};

LF_fnc_deadCheck = {
// IF THE PILOT IS DEAD OR CHOPPA DOWN [_pilot] spawn LF_fnc_deadCheck;
		_pilot = _this select 0;
		
		if (vehicle _pilot == _pilot or !alive _pilot) then {
				crashed = true;
				//call LF_fnc_heloRespawn;
		} else {crashed = false;}; 
};

LF_fnc_deadClean = {
// clean up mission [_pilot, _plName, _callsign] spawn LF_fnc_deadClean;
		private ["_pilot", "_plName", "_callsign", "_IsIt"];
		
		_pilot = _this select 0;
		_plName = _this select 1;
		_callsign = _this select 2;
		_IsIt = _this select 3;
		if (_IsIt ==0) then {
				_deRes = [player,resetsup] call BIS_fnc_removeCommMenuItem;
		};
		terminate LF_taxiScript;
		deleteVehicle helipad1;
		deleteVehicle helipad2;
		deleteMarker StartMk;
		deleteMarker EndMk;
		_deadHint = [west, "HQ"] sideChat format["This is HQ to %1, be advised, %2 is down, repeat %2 is down",_plName, _callsign];	
};

LF_fnc_heliInit = {
		sleep 1;
		null = [helitaxi, 1, 2] spawn LF_fnc_vehLoadOut;
		null = [helitaxi, 1, 3] spawn LF_fnc_vehLoadOut;		
};

//////BIG////OLE////DIRTY/////ARRAYS//////

		LFcallsigns = 
		[
				"Rabid Chaffinch"
		];

		LFSoundAdvice = 
		[
				"Don't get mauled by a rabbit",
				"Pet a snake for me",
				"Bring me back a tin of Tactical bacon",
				"If you see any women let me know, this relentless sausage fest is starting to get me down",
				"Don't go all crazy Rambo and get shot ok"
		];
		
		LFmedicsArr = [];
		
		LFengineerArr = [];
		
		LFHeloArr = [];