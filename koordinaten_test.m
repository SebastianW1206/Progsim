%% Hauptprogramm: Abstand zwischen zwei Häfen
clc; clear;

% Excel-Datei laden
filename = 'Koordinaten_Hafen';
haefen = readtable(filename);

% Liste aller Häfen anzeigen
disp('Verfügbare Häfen:');
disp(haefen.Hafen);

% Benutzer wählt zwei Häfen
idx1 = input('Geben Sie Index von den ersten Hafen von 1 bis 10: ');
idx2 = input('Geben Sie Index von den zweiten Hafen von 1 bis 10: ');

% Überprüfung das index ist gültig
if idx1 < 1 || idx1 > 10
    fprintf('Fehler: Index 1 liegt außerhalb des gültigen Bereichs (1 bis 10).\n');
end

if idx2 < 1 || idx2 > 10
    fprintf('Fehler: Index 2 liegt außerhalb des gültigen Bereichs (1 bis 10).\n');
end

    

lat1 = haefen.Breite(idx1);
lon1 = haefen.Laenge(idx1);
lat2 = haefen.Breite(idx2);
lon2 = haefen.Laenge(idx2);

%% Berechnung in Double Precision
fprintf('\n--- Double Precision ---\n');
d_kreisbogen_D = kreisbogenmitlaengereformel(lat1, lon1, lat2, lon2, 'double');
d_mittelbreite_D = distance_mittelbreite(lat1, lon1, lat2, lon2, 'double');
d_haversine_D = haversine(lat1, lon1, lat2, lon2, 'double');
fprintf('kreisbogenmitlaengereformel: %.3f km\n', d_kreisbogen_D);
fprintf('Mittelbreite: %.3f km\n', d_mittelbreite_D);
fprintf('Haversine: %.3f km\n', d_haversine_D);

%% Berechnung in Single Precision
fprintf('\n--- Single Precision ---\n');
d_kreisbogen_S = kreisbogenmitlaengereformel(lat1, lon1, lat2, lon2, 'single');
d_mittelbreite_S = distance_mittelbreite(lat1, lon1, lat2, lon2, 'single');
d_haversine_S = haversine(lat1, lon1, lat2, lon2, 'single');
fprintf('kreisbogenmitlaengereformel: %.3f km\n', d_kreisbogen_S);
fprintf('Mittelbreite: %.3f km\n', d_mittelbreite_S);
fprintf('Haversine: %.3f km\n', d_haversine_S);

%% Differenzen ausgeben
fprintf('\n--- Differenzen (Double - Single) ---\n');
fprintf('Kreisbogen: %.6f km\n', d_kreisbogen_D - d_kreisbogen_S);
fprintf('Mittelbreite: %.6f km\n', d_mittelbreite_D - d_mittelbreite_S);
fprintf('Haversine: %.6f km\n', d_haversine_D - d_haversine_S);

