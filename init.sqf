
//EOS SYSTEM
[]execVM "eos\OpenMe.sqf";
//Recruit AI System
[] execVM "bon_recruit_units\init.sqf";
//SA AI Revive
//parameters are default ones
execVM "Functions\MGI_fnc_AICareandRevive.sqf";

//////////////////////////HELO CRAP///////////////////////////////
/////////////USER VARIABLES//////////
// define chopper call sign
_callsign = "ROMEO";
////////////DO////////NOT////////EDIT//////BELOW//////////HERE
call compile preprocessFile "support\suptFunc.sqf";
helisup = [player,"helo_taxi"] call BIS_fnc_addCommMenuItem;
null = [] spawn LF_fnc_heliInit;
cost = false;
helitaxi addAction ["<t color='#00b7ff'>Talk to Pilot</t>",{[[],"support\taxi\helotaxi.sqf"] call BIS_fnc_MP;}, [], 0, true, true, "", "true", 5];
