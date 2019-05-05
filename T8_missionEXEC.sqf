/*
 =======================================================================================================================

	T8 Units Script

	File:		T8_missionEXEC.sqf
	Author:		T-800a
	E-Mail:		t-800a@gmx.net

	This file creates the Units, kind of
	

	This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
	To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or send a letter to 
	Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

 =======================================================================================================================
*/


// include the few macros we use ...
#include <T8\MACRO.hpp>

// wait until everything is initalized correctly
waitUntil { !isNil "T8U_var_useHC" };
waitUntil { !isNil "T8U_var_InitDONE" };

// cancel execute if not server / hc
__allowEXEC(__FILE__);


sleep 5;

//////////////////////////////////////  CUSTOM FUNCTION  //////////////////////////////////////
//
//			This function is called for every unit in a group 
//			where it is defined in the groups definiton below
//

T8U_fnc_rmNVG_TEST = 
{
	_this spawn
	{
		sleep 5;
	
		private ["_i"];
		_i = true;
		switch ( side _this ) do 
		{ 
			case WEST:			{ _this unlinkItem "NVGoggles"; };
			case EAST:			{ _this unlinkItem "NVGoggles_OPFOR"; };
			case RESISTANCE:	{ _this unlinkItem "NVGoggles_INDEP";  };
			default				{ _i = false; };
		};
		
		if ( _i ) then 
		{
			_this removePrimaryWeaponItem "acc_pointer_IR";
			_this addPrimaryWeaponItem "acc_flashlight";
		};
			
		sleep 1;
		group _this enableGunLights "forceon";
	};
};

//////////////////////////////////////  UNIT SETUP  //////////////////////////////////////

// Pre-defined Arrays for Groups ( group setup )
_FireTeam = [ "rhs_msv_emr_sergeant", "rhs_msv_emr_grenadier", "rhs_msv_emr_medic", "rhs_msv_emr_rifleman" ];
_FullTeam = [ "rhs_msv_emr_officer", "rhs_msv_emr_grenadier_rpg", "rhs_msv_emr_machinegunner", "rhs_msv_emr_engineer", "rhs_msv_emr_sergeant", "rhs_msv_emr_grenadier", "rhs_msv_emr_medic", "rhs_msv_emr_rifleman" ];
_groupArrayMiniPat = [ "rhs_msv_emr_junior_sergeant", "rhs_msv_emr_medic", "rhs_msv_emr_rifleman" ];
_groupArrayFullPat = [ "rhs_msv_emr_officer", "rhs_msv_emr_grenadier_rpg", "rhs_msv_emr_machinegunner", "rhs_msv_emr_sergeant", "rhs_msv_emr_medic", "rhs_msv_emr_rifleman" ];
// _groupArrayIfritPat = [ "rhs_tigr_sts_msv", "rhs_tigr_sts_msv" ];
_groupArrayIfritPat = [ "rhs_tigr_sts_msv", "rhs_kamaz5350_msv" ];
_groupArrayW_APC = [ "rhs_bmp1_msv" ];
_groupArrayT_APC = [ "rhs_Ob_681_2" ];
_groupArraySniperTeam = [ "rhs_msv_emr_marksman", "rhs_msv_emr_marksman" ];

_groupArrayGurTeam = [ "I_soldier_TL_F", "I_medic_F", "I_soldier_F", "I_soldier_F", "I_soldier_F", "I_soldier_AR_F" ];
_groupArrayBluTeam = [ "rhsusf_army_ucp_officer", "rhsusf_army_ucp_medic", "rhsusf_army_ucp_rifleman", "rhsusf_army_ucp_rifleman", "rhsusf_army_ucp_rifleman", "rhsusf_army_ucp_autorifleman" ];

_groupArrayCIV		= [ "C_man_1", "C_man_polo_1_F_asia", "C_man_1_1_F", "C_man_1_2_F", "C_man_1_3_F", "C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F", "C_man_polo_6_F", "C_man_p_fugitive_F", "C_man_p_fugitive_F_afro", "C_man_p_fugitive_F_euro" ];
_groupArrayCivsmall = [ "C_man_1", "C_man_1_1_F", "C_man_1_2_F", "C_man_1_3_F", "C_man_polo_1_F", "C_man_polo_2_F" ];

// Groups, available for HALO, ... support!  - this means EAST has two groups with 4 man, which are available as HALP Drop
T8U_var_SupportUnitsEAST = [ _FireTeam, _FireTeam ];
T8U_var_SupportUnitsWEST = [];
T8U_var_SupportUnitsRESISTANCE = [];


// this groups of units are spawned directly at mission start
spawnUnits =
[
 [ [ _FireTeam, "EOSzone1" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone1" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone1" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone1" ], [ "PATROL_URBAN" ] ]
];

spawnUnits2 =
[
 [ [ _FireTeam, "EOSzone2" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone2" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone2" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone2" ], [ "PATROL_URBAN" ] ]
];

spawnUnits3 =
[
 [ [ _FireTeam, "EOSzone3" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone3" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone3" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone3" ], [ "PATROL_URBAN" ] ]
];

spawnUnits4 =
[
 [ [ _FireTeam, "EOSzone4" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone4" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone4" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone4" ], [ "PATROL_URBAN" ] ]
];

spawnUnits5 =
[
 [ [ _FireTeam, "EOSzone5" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone5" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone5" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone5" ], [ "PATROL_URBAN" ] ]
];

spawnUnits6 =
[
 [ [ _FireTeam, "EOSzone6" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone6" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone6" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone6" ], [ "PATROL_URBAN" ] ]
];

spawnUnits7 =
[
 [ [ _FireTeam, "EOSzone7" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone7" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone7" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone7" ], [ "PATROL_URBAN" ] ]
];

spawnUnits8 =
[
 [ [ _FireTeam, "EOSzone8" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone8" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone8" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone8" ], [ "PATROL_URBAN" ] ]
];

spawnUnits9 =
[
 [ [ _FireTeam, "EOSzone9" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone9" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone9" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone9" ], [ "PATROL_URBAN" ] ]
];

spawnUnits10 =
[
 [ [ _FireTeam, "EOSzone10" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone10" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone10" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone10" ], [ "PATROL_URBAN" ] ]
];

spawnUnits11 =
[
 [ [ _FireTeam, "EOSzone11" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone11" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone11" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone11" ], [ "PATROL_URBAN" ] ]
];

spawnUnits12 =
[
 [ [ _FireTeam, "EOSzone12" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone12" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone12" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone12" ], [ "PATROL_URBAN" ] ]
];

spawnUnits13 =
[
 [ [ _FireTeam, "EOSzone13" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone13" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone13" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone13" ], [ "PATROL_URBAN" ] ]
];

spawnUnits14 =
[
 [ [ _FireTeam, "EOSzone14" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone14" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone14" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone14" ], [ "PATROL_URBAN" ] ]
];

spawnUnits15 =
[
 [ [ _FireTeam, "EOSzone15" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone15" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone15" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone15" ], [ "PATROL_URBAN" ] ]
];

spawnUnits16 =
[
 [ [ _FireTeam, "EOSzone16" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone16" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone16" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone16" ], [ "PATROL_URBAN" ] ]
];

spawnUnits17 =
[
 [ [ _FireTeam, "EOSzone17" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone17" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone17" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone17" ], [ "PATROL_URBAN" ] ]
];

spawnUnits18 =
[
 [ [ _FireTeam, "EOSzone18" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone18" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone18" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone18" ], [ "PATROL_URBAN" ] ]
];

spawnUnits19 =
[
 [ [ _FireTeam, "EOSzone19" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone19" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone19" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone19" ], [ "PATROL_URBAN" ] ]
];

spawnUnits20 =
[
 [ [ _FireTeam, "EOSzone20" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone20" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone20" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone20" ], [ "PATROL_URBAN" ] ]
];

spawnUnits21 =
[
 [ [ _FireTeam, "EOSzone21" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone21" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone21" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone21" ], [ "PATROL_URBAN" ] ]
];

spawnUnits22 =
[
 [ [ _FireTeam, "EOSzone22" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone22" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone22" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone22" ], [ "PATROL_URBAN" ] ]
];

spawnUnits23 =
[
 [ [ _FireTeam, "EOSzone23" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone23" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone23" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone23" ], [ "PATROL_URBAN" ] ]
];

spawnUnits24 =
[
 [ [ _FireTeam, "EOSzone24" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone24" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone24" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone24" ], [ "PATROL_URBAN" ] ]
];

spawnUnits25 =
[
 [ [ _FireTeam, "EOSzone25" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone25" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone25" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone25" ], [ "PATROL_URBAN" ] ]
];

spawnUnits26 =
[
 [ [ _FireTeam, "EOSzone26" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone26" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone26" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone26" ], [ "PATROL_URBAN" ] ]
];

spawnUnits27 =
[
 [ [ _FireTeam, "EOSzone27" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone27" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone27" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone27" ], [ "PATROL_URBAN" ] ]
];

spawnUnits28 =
[
 [ [ _FireTeam, "EOSzone28" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone28" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone28" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone28" ], [ "PATROL_URBAN" ] ]
];

spawnUnits29 =
[
 [ [ _FireTeam, "EOSzone29" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone29" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone29" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone29" ], [ "PATROL_URBAN" ] ]
];

spawnUnits30 =
[
 [ [ _FireTeam, "EOSzone30" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone30" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone30" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone30" ], [ "PATROL_URBAN" ] ]
];

spawnUnits31 =
[
 [ [ _FireTeam, "EOSzone31" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone31" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone31" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone31" ], [ "PATROL_URBAN" ] ]
];

spawnUnits32 =
[
 [ [ _FireTeam, "EOSzone32" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone32" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone32" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone32" ], [ "PATROL_URBAN" ] ]
];

spawnUnits33 =
[
 [ [ _FireTeam, "EOSzone33" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone33" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone33" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone33" ], [ "PATROL_URBAN" ] ]
];

spawnUnits34 =
[
 [ [ _FireTeam, "EOSzone34" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone34" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone34" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone34" ], [ "PATROL_URBAN" ] ]
];

spawnUnits35 =
[
 [ [ _FireTeam, "EOSzone35" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone35" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone35" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone35" ], [ "PATROL_URBAN" ] ]
];

spawnUnits36 =
[
 [ [ _FireTeam, "EOSzone36" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone36" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone36" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone36" ], [ "PATROL_URBAN" ] ]
];

spawnUnits37 =
[
 [ [ _FireTeam, "EOSzone37" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone37" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone37" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone37" ], [ "PATROL_URBAN" ] ]
];

spawnUnits38 =
[
 [ [ _FireTeam, "EOSzone38" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone38" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone38" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone38" ], [ "PATROL_URBAN" ] ]
 ];

spawnUnits39 =
[
 [ [ _FireTeam, "EOSzone39" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone39" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone39" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone39" ], [ "PATROL_URBAN" ] ]
];

spawnUnits40 =
[
 [ [ _FireTeam, "EOSzone40" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone40" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone40" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone40" ], [ "PATROL_URBAN" ] ]
];

spawnUnits41 =
[
 [ [ _FireTeam, "EOSzone41" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone41" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone41" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone41" ], [ "PATROL_URBAN" ] ]
];

spawnUnits42 =
[
 [ [ _FireTeam, "EOSzone42" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone42" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone42" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone42" ], [ "PATROL_URBAN" ] ]
];

spawnUnits43 =
[
 [ [ _FireTeam, "EOSzone43" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone43" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone43" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone43" ], [ "PATROL_URBAN" ] ]
];

spawnUnits44 =
[
 [ [ _FireTeam, "EOSzone44" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone44" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone44" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone44" ], [ "PATROL_URBAN" ] ]
];

spawnUnits45 =
[
 [ [ _FireTeam, "EOSzone45" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone45" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone45" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone45" ], [ "PATROL_URBAN" ] ]
];

spawnUnits46 =
[
 [ [ _FireTeam, "EOSzone46" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone46" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone46" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone46" ], [ "PATROL_URBAN" ] ]
];

spawnUnits47 =
[
 [ [ _FireTeam, "EOSzone47" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone47" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone47" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone47" ], [ "PATROL_URBAN" ] ]
];

spawnUnits48 =
[
 [ [ _FireTeam, "EOSzone48" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone48" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone48" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone48" ], [ "PATROL_URBAN" ] ]
];

spawnUnits49 =
[
 [ [ _FireTeam, "EOSzone49" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone49" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone49" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone49" ], [ "PATROL_URBAN" ] ]
];

spawnUnits50 =
[
 [ [ _FireTeam, "EOSzone50" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone50" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone50" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone50" ], [ "PATROL_URBAN" ] ]
];

spawnUnits51 =
[
 [ [ _FireTeam, "EOSzone51" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone51" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone51" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone51" ], [ "PATROL_URBAN" ] ]
];

spawnUnits52 =
[
 [ [ _FireTeam, "EOSzone52" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone52" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone52" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone52" ], [ "PATROL_URBAN" ] ]
];

spawnUnits53 =
[
 [ [ _FireTeam, "EOSzone53" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone53" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone53" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone53" ], [ "PATROL_URBAN" ] ]
];

spawnUnits54 =
[
 [ [ _FireTeam, "EOSzone54" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone54" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone54" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone54" ], [ "PATROL_URBAN" ] ]
];

spawnUnits55 =
[
 [ [ _FireTeam, "EOSzone55" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone55" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone55" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone55" ], [ "PATROL_URBAN" ] ]
];

spawnUnits56 =
[
 [ [ _FireTeam, "EOSzone56" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone56" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone56" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone56" ], [ "PATROL_URBAN" ] ]
];

spawnUnits57 =
[
 [ [ _FireTeam, "EOSzone57" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone57" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone57" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone57" ], [ "PATROL_URBAN" ] ]
];

spawnUnits58 =
[
 [ [ _FireTeam, "EOSzone58" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone58" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone58" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone58" ], [ "PATROL_URBAN" ] ]
];

spawnUnits59 =
[
 [ [ _FireTeam, "EOSzone59" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone59" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone59" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone59" ], [ "PATROL_URBAN" ] ]
];

spawnUnits60 =
[
 [ [ _FireTeam, "EOSzone60" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone60" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone60" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone60" ], [ "PATROL_URBAN" ] ]
];

spawnUnits61 =
[
 [ [ _FireTeam, "EOSzone61" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone61" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone61" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone61" ], [ "PATROL_URBAN" ] ]
];

spawnUnits62 =
[
 [ [ _FireTeam, "EOSzone62" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone62" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone62" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone62" ], [ "PATROL_URBAN" ] ]
];

spawnUnits63 =
[
 [ [ _FireTeam, "EOSzone63" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone63" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone63" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone63" ], [ "PATROL_URBAN" ] ]
];

spawnUnits64 =
[
 [ [ _FireTeam, "EOSzone64" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone64" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone64" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone64" ], [ "PATROL_URBAN" ] ]
];

spawnUnits65 =
[
 [ [ _FireTeam, "EOSzone65" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone65" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone65" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone65" ], [ "PATROL_URBAN" ] ]
];

spawnUnits66 =
[
 [ [ _FireTeam, "EOSzone66" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone66" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone66" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone66" ], [ "PATROL_URBAN" ] ]
];

spawnUnits67 =
[
 [ [ _FireTeam, "EOSzone67" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone67" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone67" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone67" ], [ "PATROL_URBAN" ] ]
];

spawnUnits68 =
[
 [ [ _FireTeam, "EOSzone68" ], [ "GARRISON" ] ],
 [ [ _FireTeam, "EOSzone68" ], [ "DEFEND" ] ],
 [ [ _FullTeam, "EOSzone68" ], [ "PATROL" ] ],
 [ [ _FireTeam, "EOSzone68" ], [ "PATROL_URBAN" ] ]
];







[ "spawnUnits", "EOSzone1", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits2", "EOSzone2", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits3", "EOSzone3", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits4", "EOSzone4", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits5", "EOSzone5", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits6", "EOSzone6", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits7", "EOSzone7", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits8", "EOSzone8", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits9", "EOSzone9", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits10", "EOSzone10", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits11", "EOSzone11", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits12", "EOSzone12", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits13", "EOSzone13", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits14", "EOSzone14", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits15", "EOSzone15", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits16", "EOSzone16", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits17", "EOSzone17", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits18", "EOSzone18", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits19", "EOSzone19", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits20", "EOSzone20", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits21", "EOSzone21", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits22", "EOSzone22", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits23", "EOSzone23", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits24", "EOSzone24", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits25", "EOSzone25", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits26", "EOSzone26", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits27", "EOSzone27", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits28", "EOSzone28", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits29", "EOSzone29", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits30", "EOSzone30", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits31", "EOSzone31", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits32", "EOSzone32", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits33", "EOSzone33", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits34", "EOSzone34", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits35", "EOSzone35", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits36", "EOSzone36", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits37", "EOSzone37", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits38", "EOSzone38", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits39", "EOSzone39", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits40", "EOSzone40", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits41", "EOSzone41", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits42", "EOSzone42", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits43", "EOSzone43", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits44", "EOSzone44", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits45", "EOSzone45", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits46", "EOSzone46", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits47", "EOSzone47", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits48", "EOSzone48", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits49", "EOSzone49", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits50", "EOSzone50", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits51", "EOSzone51", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits52", "EOSzone52", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits53", "EOSzone53", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits54", "EOSzone54", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits55", "EOSzone55", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits56", "EOSzone56", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits57", "EOSzone57", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits58", "EOSzone58", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits59", "EOSzone59", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits60", "EOSzone60", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits61", "EOSzone61", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits62", "EOSzone62", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits63", "EOSzone63", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits64", "EOSzone64", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits65", "EOSzone65", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits66", "EOSzone66", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits67", "EOSzone67", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;
[ "spawnUnits68", "EOSzone68", "EAST", "WEST", 800 ] spawn T8U_fnc_Zone;




// ------------------------------------------------ THE END ---------------------------------------------------
