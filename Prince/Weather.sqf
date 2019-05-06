// Script by Zonekiller  -- http://www.zonekiller.net --    -- zonekiller@live.com.au --


//Set All the weather settings to manual and full in the mission editor of your mission

sleep 1;



//  ARRAY SETTINGS [fog,gusts,(wind dir),(wind force),overcast,rain]

// Weather Types

_clear = [(Random 1),0,0,0,0,0];
_clearwindy = [(Random 1),(.5 + (Random .5)),(Random 360),(.5 + (Random .5)),0,0];
_windy = [(Random 1),(.5 + (Random .5)),(Random 360),(.5 + (Random .5)),(.1 + (Random .9)),0];
_stillrain = [(Random 1),0,0,0,(.45 + (Random .55)),(.1 + (Random .9))];
_storm = [(Random 1),(.5 + (Random .5)),(Random 360),(.5 + (Random .5)),(.5 + (Random .5)),(.5 + (Random .5))];

_weatherpattern = [_clear,_clearwindy,_windy,_stillrain,_storm];
_weather = (_weatherpattern select (floor(random (count _weatherpattern))));

_fog = (_weather select 0);
_gust = (_weather select 1);
_dir = (_weather select 2);
_force = (_weather select 3);
_oc = (_weather select 4);
_rain = (_weather select 5);

// only foggy in the mornings

if ((daytime > 4) && (daytime < 5)) then 
{
0 setFog _fog;
}else{0 setFog 0};

0 setGusts _gust;
0 setWindDir _dir;
0 setWindForce _force;
0 setOvercast _oc;
0 setRain _rain;

sleep 120;

while {true} do
{

_weather = (_weatherpattern select (floor(random (count _weatherpattern))));

_fog = (_weather select 0);
_gust = (_weather select 1);
_dir = (_weather select 2);
_force = (_weather select 3);
_oc = (_weather select 4);
_rain = (_weather select 5); 

if ((daytime > 4) && (daytime < 6)) then 
{
(200 + (Random 1000)) setFog _fog;
_foggy = 0;
}else{
if (_foggy == 0) then {_foggy = 1;(120 + (Random 1680)) setFog 0};
};

(120 + (Random 1680)) setGusts _gust;
(120 + (Random 1680)) setWindDir _dir;
(120 + (Random 1680)) setWindForce _force;
(120 + (Random 1680)) setOvercast _oc;
(120 + (Random 1680)) setRain _rain;

sleep 1800; 

};
