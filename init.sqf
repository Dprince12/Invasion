//EOS SYSTEM
[]execVM "eos\OpenMe.sqf";
/////////////USER VARIABLES//////////
// define chopper call sign
callsign = "Rabid Chaffinch";
////////////DO////////NOT////////EDIT//////BELOW//////////HERE
call compile preprocessFile "support\suptFunc.sqf";
helisup = [player,"helo_taxi"] call BIS_fnc_addCommMenuItem;
null = [] spawn LF_fnc_heliInit;
cost=false;
[] execVM "bon_recruit_units\init.sqf";
[] execVM "Prince\capture.sqf";
[] execVM "params.ext";


