

//Recruit AI System
[] execVM "bon_recruit_units\init.sqf";
//SA AI Revive
//parameters are default ones
execVM "Functions\MGI_fnc_AICareandRevive.sqf";

/////////////USER VARIABLES//////////
// define chopper call sign
callsign = "Romeo";
////////////DO////////NOT////////EDIT//////BELOW//////////HERE
call compile preprocessFile "support\suptFunc.sqf";
helisup = [player,"helo_taxi"] call BIS_fnc_addCommMenuItem;
null = [] spawn LF_fnc_heliInit;


cost = false;