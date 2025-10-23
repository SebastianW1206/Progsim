
%Progsim uebung Koordinaten Abstände und numerische Stabilität

%% ==========================================================
% Programm: Abstandsberechnung auf der Erdkugel
% Autor: Tomás Tauss, Sebastian Wetzka
% Datum: 23.10.25
% ==========================================================
% Anforderungen:
% 1) Abstand zwischen zwei Punkten berechnen
% 2) Daten aus Excel einlesen
% 3) Drei Rechenoptionen: Kreisbogen, Mittelbreite, Haversine
% 4) Numerische Stabilitätsprüfung (double/single)
% 5) Einfacher Aufbau
% 6) Fehlerprüfung der Eingaben
% ==========================================================

clear; clc; close all;

%% -----------------------------
% 1. Parameter und Datei
% -----------------------------
R = 6371000;  % Erdradius in Metern
filename = 'Koordinaten_Hafen'; % Excel-Datei mit Spalten: Ort | Breite | Länge

% -----------------------------
% 2. Daten aus Excel lesen
% -----------------------------
try
    data = readtable(filename);
catch
    error('Excel-Datei "%s" konnte nicht gelesen werden. Stelle sicher, dass sie im selben Ordner liegt.', filename);
end

if width(data) < 3
    error('Die Excel-Datei muss mindestens drei Spalten enthalten: Ort, Breite, Länge.');
end

orte = string(data{:,1});
breite = data{:,2};
laenge = data{:,3};

% -----------------------------
% 3. Nutzer gibt zwei Ortsnamen ein
% -----------------------------
fprintf('Verfügbare Orte:\n');
disp(orte);

ort1 = string(input('Geben Sie den Namen des ersten Ortes ein: ', 's'));
ort2 = string(input('Geben Sie den Namen des zweiten Ortes ein: ', 's'));

% Überprüfung der Eingaben
i1 = find(strcmpi(orte, ort1));
i2 = find(strcmpi(orte, ort2));

if isempty(i1) || isempty(i2)
    error('Mindestens einer der eingegebenen Orte wurde nicht gefunden.');
end

% -----------------------------
% 4. Umrechnen in Bogenmaß
% -----------------------------
b1 = deg2rad(breite(i1));
b2 = deg2rad(breite(i2));
l1 = deg2rad(laenge(i1));
l2 = deg2rad(laenge(i2));

% -----------------------------
% 5. Abstandsberechnungen
% -----------------------------
fprintf('\n--- Abstand zwischen %s und %s ---\n', ort1, ort2);

% Variante 1: Kreisbogen
d_kreis = distance_kreisbogen(b1, l1, b2, l2, R);

% Variante 2: Mittelbreite
d_mittel = distance_mittelbreite(b1, l1, b2, l2, R);

% Variante 3: Haversine
d_hav = distance_haversine(b1, l1, b2, l2, R);

fprintf('Kreisbogen:     %.2f km\n', d_kreis/1000);
fprintf('Mittelbreite:   %.2f km\n', d_mittel/1000);
fprintf('Haversine:      %.2f km\n', d_hav/1000);

% -----------------------------
% 6. Numerische Stabilitätsprüfung
% -----------------------------
b1_s = single(b1); b2_s = single(b2);
l1_s = single(l1); l2_s = single(l2);

d_kreis_s = distance_kreisbogen(b1_s, l1_s, b2_s, l2_s, single(R));
abweichung = abs(double(d_kreis) - double(d_kreis_s));

fprintf('\nUnterschied (double - single): %.6f m\n', abweichung);

disp('Berechnung abgeschlossen.');

