//helitaxi
[[player,[("<t color=""#efe92b"">" + ("Helo Transport") + "</t>"),{_this execVM "support\taxi\helotaxi.sqf"},[player],0,false,true, "",'player ==_target and (_target distance getMarkerPos ''safezone'') >= 250']],"addAction",true,true,false] call BIS_fnc_MP;

// Add it back when you die/respawn.

player addEventHandler
[
	"respawn",
	{
		insertion = [[player,[("<t color=""#efe92b"">" + ("Helo Transport") + "</t>"),{_this execVM "support\taxi\helotaxi.sqf"},[player],0,false,true, "",'player ==_target and (_target distance getMarkerPos ''safezone'') >= 250']],"addAction",true,true,false] call BIS_fnc_MP;

	}
];
