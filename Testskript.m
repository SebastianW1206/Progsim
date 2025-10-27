%Test Skript
clc; close all; clear;
%% Einlesen der Exele
% Excel-Datei laden
filename = 'Koordinaten_Hafen';

%%definition Koordinaten Häfen
haefen = readtable(filename);
Hamburg=haefen(2,:);
Rotterdam= haefen(6,:);
Sydney= haefen(10,:);
LA=haefen(8,:);
SanAntonio=haefen(3,:); 
%% In google Maps gemessenen Abstände
d_GM_Hamburg_Rotterdam= 413.44 ;   %Abstand  Hamburg Rotterdam in km (Kurzstrecke)
d_GM_Hamburg_Sydney= 16275.9;       %Abstand Hamburg Sydney in km (Langstrecke)
d_GM_LA_SanAntonio= 8542.43 ;   %Abstand LA San Antonio in km (Mittelstrecke)

%% Bestimmen der Entfernung mit 3 Methoden in Double Precion für Hamburg Rooterdam
lat_H=Hamburg(1,3);
lon_H=Hamburg(1,2);
lat_R=Rotterdam(1,3);
lon_R= Rotterdam(1,2);
fprintf('\n--- Double Precision(Hamburg Rotterdam) ---\n');
d_kreisbogen_D = kreisbogen(lat_H, lon_H, lat_R, lon_R, 'double');
d_mittelbreite_D = distance_mittelbreite(lat_H, lon_H, lat_R, lon_R, 'double');
d_haversine_D = haversine(lat_H, lon_H, lat_R, lon_R, 'double');
fprintf('Kreisbogen: %.3f km\n', d_kreisbogen_D);
fprintf('Mittelbreite: %.3f km\n', d_mittelbreite_D);
fprintf('Haversine: %.3f km\n', d_haversine_D);

%%  Bestimmen der Entfernung mit 3 Methoden in Single Precion
fprintf('\n--- Single Precision ---\n');
lat_H=Hamburg(1,3);
lon_H=Hamburg(1,2);
lat_R=Rotterdam(1,3);
lon_R= Rotterdam(1,2);
d_kreisbogen_S = kreisbogen(lat_H, lon_H, lat_R, lon_R, 'single');
d_mittelbreite_S = distance_mittelbreite(lat_H, lon_H, lat_R, lon_R, 'single');
d_haversine_S = haversine(lat_H, lon_H, lat_R, lon_R, 'single');
fprintf('Kreisbogen: %.3f km\n', d_kreisbogen_S);
fprintf('Mittelbreite: %.3f km\n', d_mittelbreite_S);
fprintf('Haversine: %.3f km\n', d_haversine_S);
%% Berechnung der Fehler 


