EOS_Spawn = compile preprocessfilelinenumbers "eos\core\eos_launch.sqf";Bastion_Spawn=compile preprocessfilelinenumbers "eos\core\b_launch.sqf";null=[] execVM "eos\core\spawn_fnc.sqf";onplayerConnected {[] execVM "eos\Functions\EOS_Markers.sqf";};
/* EOS 1.98 by BangaBob 
GROUP SIZES
 0 = 1
 1 = 2,4
 2 = 4,8
 3 = 8,12
 4 = 12,16
 5 = 16,20

EXAMPLE CALL - EOS
 null = [["MARKERNAME","MARKERNAME2"],[2,1,70],[0,1],[1,2,30],[2,60],[2],[1,0,10],[1,0,250,WEST]] call EOS_Spawn;
 null=[["M1","M2","M3"],[HOUSE GROUPS,SIZE OF GROUPS,PROBABILITY],[PATROL GROUPS,SIZE OF GROUPS,PROBABILITY],[LIGHT VEHICLES,SIZE OF CARGO,PROBABILITY],[ARMOURED VEHICLES,PROBABILITY], [STATIC VEHICLES,PROBABILITY],[HELICOPTERS,SIZE OF HELICOPTER CARGO,PROBABILITY],[FACTION,MARKERTYPE,DISTANCE,SIDE,HEIGHTLIMIT,DEBUG]] call EOS_Spawn;

EXAMPLE CALL - BASTION
 null = [["BAS_zone_1"],[3,1],[2,1],[2],[0,0],[0,0,EAST,false,false],[10,2,120,TRUE,TRUE]] call Bastion_Spawn;
 null=[["M1","M2","M3"],[PATROL GROUPS,SIZE OF GROUPS],[LIGHT VEHICLES,SIZE OF CARGO],[ARMOURED VEHICLES],[HELICOPTERS,SIZE OF HELICOPTER CARGO],[FACTION,MARKERTYPE,SIDE,HEIGHTLIMIT,DEBUG],[INITIAL PAUSE, NUMBER OF WAVES, DELAY BETWEEN WAVES, INTEGRATE EOS, SHOW HINTS]] call Bastion_Spawn;
*/
VictoryColor="colorGreen";	// Colour of marker after completion
hostileColor="colorRed";	// Default colour when enemies active
bastionColor="colorWhite";	// Colour for bastion marker
EOS_DAMAGE_MULTIPLIER=1;	// 1 is default
EOS_KILLCOUNTER=false;		// Counts killed units

null =[["EOSzone1"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone2"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone3"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone4"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone5"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone6"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone7"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone8"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone9"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone10"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone11"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone12"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone13"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone14"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone15"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone16"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone17"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone18"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone19"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone20"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone21"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone22"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone23"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone24"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone25"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone26"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone27"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone28"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone29"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone30"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone31"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone32"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone33"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone34"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone35"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone36"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone37"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone38"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone39"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone40"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone41"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone42"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone43"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone44"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone45"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone46"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone47"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone48"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone49"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone50"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone51"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone52"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone53"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone54"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone55"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone56"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone57"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone58"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone59"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone60"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone61"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone62"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone63"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone64"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone65"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone66"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone67"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
null =[["EOSzone68"],[1,2],[1,2],[0,0],[0],[0],[0],[5,2,100,EAST]] call EOS_Spawn;
