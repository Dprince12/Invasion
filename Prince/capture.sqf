if (markerColor "EOSzone1" == "colorRed") then {hint "Objective Not Captured"};
if (markerColor "EOSzone1" == "colorGreen") then {hint "Objective Captured" = taskState ("Capture_Eginio") == "SUCCEEDED"};
