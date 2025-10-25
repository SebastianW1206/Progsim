%% Hauptprogramm: Abstand zwischen zwei Häfen
clc; clear;

% Excel-Datei laden
filename = 'Haefen.xlsx';
haefen = readtable(filename);

% Liste aller Häfen anzeigen
disp('Verfügbare Häfen:');
disp(haefen.Name);

% Benutzer wählt zwei Häfen
idx1 = input('Index Hafen 1: ');
idx2 = input('Index Hafen 2: ');

lat1 = haefen.Latitude(idx1);
lon1 = haefen.Longitude(idx1);
lat2 = haefen.Latitude(idx2);
lon2 = haefen.Longitude(idx2);

%% Berechnung in Double Precision
fprintf('\n--- Double Precision ---\n');
[d_kreisbogen_D, d_mittelbreite_D, d_haversine_D] = berechneAbstand(lat1, lon1, lat2, lon2, 'double');
fprintf('Kreisbogen: %.3f km\n', d_kreisbogen_D);
fprintf('Mittelbreite: %.3f km\n', d_mittelbreite_D);
fprintf('Haversine: %.3f km\n', d_haversine_D);

%% Berechnung in Single Precision
fprintf('\n--- Single Precision ---\n');
[d_kreisbogen_S, d_mittelbreite_S, d_haversine_S] = berechneAbstand(lat1, lon1, lat2, lon2, 'single');
fprintf('Kreisbogen: %.3f km\n', d_kreisbogen_S);
fprintf('Mittelbreite: %.3f km\n', d_mittelbreite_S);
fprintf('Haversine: %.3f km\n', d_haversine_S);

%% Differenzen ausgeben
fprintf('\n--- Differenzen (Double - Single) ---\n');
fprintf('Kreisbogen: %.6f km\n', d_kreisbogen_D - d_kreisbogen_S);
fprintf('Mittelbreite: %.6f km\n', d_mittelbreite_D - d_mittelbreite_S);
fprintf('Haversine: %.6f km\n', d_haversine_D - d_haversine_S);

%% Funktion zur Abstandberechnung
function [d_kreisbogen, d_mittelbreite, d_haversine] = berechneAbstand(lat1, lon1, lat2, lon2, precision)
    if strcmp(precision,'single')
        lat1 = single(lat1); lat2 = single(lat2);
        lon1 = single(lon1); lon2 = single(lon2);
    end
    
    R = 6371; % Erdradius in km
    
    % Kreisbogenmethode
    phi1 = deg2rad(lat1); phi2 = deg2rad(lat2);
    lambda1 = deg2rad(lon1); lambda2 = deg2rad(lon2);
    delta_sigma = acos(sin(phi1).*sin(phi2) + cos(phi1).*cos(phi2).*cos(lambda2 - lambda1));
    d_kreisbogen = R * delta_sigma;
    
    % Mittelbreite
    phi_m = (phi1 + phi2)/2;
    d_lambda = lambda2 - lambda1;
    d_phi = phi2 - phi1;
    d_mittelbreite = R * sqrt(d_phi^2 + (cos(phi_m)*d_lambda)^2);
    
    % Haversine
    delta_phi = phi2 - phi1;
    delta_lambda = lambda2 - lambda1;
    a = sin(delta_phi/2)^2 + cos(phi1)*cos(phi2)*sin(delta_lambda/2)^2;
    c = 2 * atan2(sqrt(a), sqrt(1-a));
    d_haversine = R * c;
end
