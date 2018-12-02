fn_medicRelease = {
  _medic = _this;
  _medic setVariable ["MGImedic",false];
  [_medic] joinSilent (_medic getVariable ["grp",grpNull]);
  _medic doFollow leader _medic;
  _medic setSpeedMode (speedMode group _medic);
  {_medic enableAI _x} count ["target","autotarget","autocombat","suppression"];
  _medic allowFleeing (1 - (_medic getVariable ["flee",0.5]));
};

MGI_fnc_AICareandRevive = {
  if (isServer) then {
    MGI_react = "react" call BIS_fnc_getParamValue;
    MGI_BleedOut = "bleedOut" call BIS_fnc_getParamValue;
    MGI_AiRevive = "NoReviveforAi" call BIS_fnc_getParamValue;
    MGI_AIKit = "AIKit" call BIS_fnc_getParamValue;
    MGI_AIMedic = "AIMedic" call BIS_fnc_getParamValue;
    MGI_bros = "bros" call BIS_fnc_getParamValue;
    if (MGI_react == 0) then {MGI_react = 120};
    if (MGI_BleedOut == 0) then {MGI_BleedOut = 120};
    if (MGI_AiRevive == 0) then {MGI_AiRevive = true};
    if (MGI_AIMedic == 0) then {MGI_AIMedic = false};
    if (MGI_bros == 0) then {MGI_bros = switchableUnits+playableUnits};

    params [["_react",MGI_react,[0]],["_bleedOut",MGI_BleedOut,[0]],["_AiRevive",MGI_AiRevive,[true]],["_kit",MGI_AIKit,[0]],["_AiMedic",MGI_AIMedic,[true]],["_MGI_bros",MGI_bros,[[],WEST]]];
    MGI_react = _react;
    MGI_BleedOut = _bleedOut;
    MGI_AiRevive = _AiRevive;
    MGI_AIKit = _kit;
    MGI_AIMedic = _AiMedic;
    if (_MGI_bros isEqualType WEST) then {_bros = allUnits select {side _x == _MGI_bros}; _MGI_bros = +_bros};
    MGI_bros = _MGI_bros;

    {
      _unit = _x;
      _unit addEventHandler ["HandleDamage", {
        _wnded = _this select 0;
        _dam = _this select 2;
        if (side _wnded != sideEnemy && _dam > 0.85) then {
          if (((!isMultiplayer or !isPlayer _wnded) && MGI_AiRevive)
           or (!isMultiplayer && isPlayer _wnded && !MGI_AiRevive))
                then {
            _wnded setUnconscious true;
            if (!isNull objectParent _wnded) then {
              _wnded setPos getpos vehicle _wnded
            };
          };
          _wnded spawn {
            _wnded = _this;
            _timerUnc = diag_tickTime;
            waitUntil {sleep 0.5; lifeState _wnded == "incapacitated" or diag_tickTime > _timerUnc + 2};
            if (lifeState _wnded == "incapacitated" && !(_wnded getVariable ["treat",false])) then {
              _wnded setVariable ["treat",true];
              _wnded setCaptive true;
              private _fellows = (MGI_bros select {
                _x isKindOf "CAManBase"
                && _x distanceSqr _wnded < 40000
                && alive _x
                && lifeState _x != "incapacitated"
                && !(_x getVariable ["MGImedic",false])}) - [_wnded];
              _fellows = _fellows select {
                [true,{_x == "FirstAidKit"} count (items _x) >0,{_x == "MediKit"} count (items _x) >0] select MGI_AIKit
                && [true,_x getUnitTrait "Medic"] select MGI_AIMedic
              };
              call {
                if ({behaviour _x != "COMBAT"} count _fellows > 0) exitWith {
                  uiSleep (MGI_react/4); _fellows = _fellows select {behaviour _x != "COMBAT"}};
                if ({(_x targets [true, 300]) isEqualTo []} count _fellows > 0) exitWith {
                  uiSleep (MGI_react/2); _fellows = _fellows select {(_x targets [true, 300]) isEqualTo []}};
              if ({{_x == "MediKit"} count (items _x) > 0} count _fellows > 0) exitWith {
                uiSleep MGI_react;_fellows = _fellows select {{_x == "MediKit"} count (items _x) > 0}};
                _fellows;
              };
              if (count _fellows > 0) then {
                _fellows = _fellows apply {[_x distance _wnded, _x]};
                _fellows sort true;
                _medic = _fellows select 0 select 1;

                _medic setVariable ["MGImedic",true];
                _medic setCaptive true;
                _medic setVariable ["flee",_medic skill "courage"];
                _medic setVariable ["grp", group _medic];
                [_medic] joinSilent grpNull;
                {_medic disableAI _x} count ["target","autotarget","autocombat","suppression"];
                group _medic setBehaviour "AWARE";
                _medic allowFleeing 0;
                _offset = [[0,0],[15, _wnded getRelDir _medic]] select (!isNull objectParent _medic);
                if (!isnull objectParent _medic) then {
                  _medic setVariable ["veh",vehicle _medic];
                  if (assignedDriver vehicle _medic != _medic) then {
                    unassignVehicle _medic;
                    doGetOut _medic;
                  };
                };
                _medic doMove (_wnded getpos _offset);
                sleep 1;
                if (isnull objectParent _medic) then {
                  group _medic setSpeedMode "FULL"
                } else {
                  group _medic setSpeedMode "LIMITED"
                };

                [_medic,_wnded] spawn {
                  params ["_medic","_wnded"];
                  _timerTreat = diag_tickTime;
                  vehicle _medic disableCollisionWith _wnded;
                  uisleep 1;
                  waitUntil {sleep 0.5; unitReady vehicle _medic or !alive _wnded or diag_tickTime > _timerTreat + MGI_BleedOut or  (unitReady vehicle _medic && canmove vehicle _medic && !isnull objectParent _medic)};

                  if ((diag_tickTime > _timerTreat + MGI_BleedOut) or !alive _wnded) then {
                    if (alive _wnded) then {
                      _wnded setUnconscious false;
                      _wnded setDamage 1
                    };
                    _medic call fn_medicRelease;
                    _wnded setVariable ["treat",false];
                    sleep 10;
                    _wnded setCaptive false;
                    _medic setCaptive false;
                  } else {
                    doStop _medic;
                    if (!isnull objectParent _medic) then {
                      unassignVehicle _medic;
                      doGetOut _medic;
                    };
                    _medic doMove getpos _wnded;
                    group _medic setSpeedMode "FULL";
                    Sleep 1;
                    waitUntil {sleep 0.5; unitReady _medic or !alive _wnded or diag_tickTime > _timerTreat + MGI_BleedOut};
                    if (alive _wnded && diag_tickTime < _timerTreat + MGI_BleedOut) then {
                      _azimuth = _medic getDir _wnded;
                      _medic setDir _azimuth;
                      _medic removeitem "FirstAidKit";
                      call {
                        if (!isPlayer _wnded) exitWith {
                          call {
                            if (unitPos _medic == "DOWN") exitWith {
                              _medic playMove "ainvppnemstpslaywrfldnon_medicother";
                            };
                            _medic playMove "ainvpknlmstpslaywrfldnon_medicother";
                          };
                          Sleep 4;
                          _wnded setUnconscious false;
                          _wnded setDamage 0;
                        };
                        _medic action ["HealSoldier", _wnded];
                        sleep 4;
                        [_wnded,{
                          _wnded = _this;
                          BIS_oldLifeState == "HEALTY";
                          _wnded setVariable ["#rev_state",0];
                          _wnded setVariable ["#rev_blood",1];
                          _wnded setVariable ["bis_revive_incapacitated",false];
                          _wnded setVariable ["#rev",0];
                          _wnded setVariable ["#revl",-1];
                          {inGameUISetEventHandler [_x, ""]} forEach ["PrevAction", "NextAction"];
                          _wnded setUnconscious false;
                          _wnded setDamage 0;
                        }] remoteExec ["call",_wnded];
                      };
                      _wnded setVariable ["treat",false];
                      _medic call fn_medicRelease;
                      if (!isnil {_medic getVariable "veh"}) then {
                        _medic assignAsDriver (_medic getVariable "veh");
                      };
                      sleep 10;
                      vehicle _medic enableCollisionWith _wnded;
                      _wnded setCaptive false;
                      _medic setCaptive false;
                    };
                  };
                };
              } else {
                _timerTreat = diag_tickTime;
                waitUntil {sleep 0.5; !alive _wnded or diag_tickTime > _timerTreat + MGI_BleedOut};
                if (alive _wnded) then {
                  _wnded setUnconscious false;
                  _wnded setDamage 1
                };
              };
            };
          };
          if ((((!isMultiplayer or !isPlayer _wnded) && MGI_AiRevive)
              or (!isMultiplayer && !MGI_AiRevive && isPlayer _wnded)) && !(_wnded getVariable ["treat",false])) then {_dam min 0.95} else {_dam};
        };
      }]
    } forEach _MGI_bros;
  };
};

[30,60,true,0,false,west] call MGI_fnc_AICareandRevive;