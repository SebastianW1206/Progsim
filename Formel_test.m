%Test Skript
clc; close all; clear;
%% Einlesen der Exele
% Excel-Datei laden
filename = 'Koordinaten_Hafen';

%%definition Koordinaten Häfen
haefen = readtable(filename);
Hamburg     = haefen(2,:);
Rotterdam   = haefen(6,:);
Sydney      = haefen(10,:);
LA          = haefen(8,:);
SanAntonio  = haefen(3,:);
%% Auswahl Häfen
 Auswahl= input('Strecke Wählen',"s")

 if strcmp(Auswahl, 'Kurz')
    lat1 = Hamburg.Breite;
    lon1 = Hamburg.Laenge;
    lat2 = Rotterdam.Breite;
    lon2 = Rotterdam.Laenge;

elseif strcmp(Auswahl, 'Lang')
    lat1 = Hamburg.Breite;
    lon1 = Hamburg.Laenge;
    lat2 = Sydney.Breite;
    lon2 = Sydney.Laenge;

elseif strcmp(Auswahl, 'Mittel')
    lat1 = SanAntonio.Breite;
    lon1 = SanAntonio.Laenge;
    lat2 = LA.Breite;
    lon2 = LA.Laenge;
end

%% Tatsächliche Berechnung
d_kurz_single=kreisbogen_kurz(lat1, lon1, lat2, lon2, 'single');
d_kurz_double=kreisbogen_kurz(lat1, lon1, lat2, lon2, 'double');
delta_kurz=d_kurz_single-d_kurz_double;
d_lang_single= kreisbogen_lang(lat1, lon1, lat2, lon2, 'single');
d_lang_double=kreisbogen_lang(lat1, lon1, lat2, lon2, 'double');

%% Ausgabe
fprintf('\n--- Single Precision ---\n');
fprintf('Kreisbogen Kurzformel Single: %.6f km\n', d_kurz_single);
fprintf('Kreisbogen Langformel Single: %.6f km\n', d_lang_single);
fprintf('\n--- Double Precision ---\n');
fprintf('Kreisbogen Kurzformel Double: %.6f km\n', d_kurz_double);
fprintf('Kreisbogen Langformel Double: %.6f km\n', d_lang_double);

%% Funktion Kreisbogen Kurzformel
function d = kreisbogen_kurz(lat1, lon1, lat2, lon2, precision)
    if strcmp(precision,'single')
        lat1 = single(lat1); lat2 = single(lat2);
        lon1 = single(lon1); lon2 = single(lon2);
    end
    
    R = 6371; % Erdradius in km
    
    % Kreisbogenmethode
    phi1 = deg2rad(lat1);
    phi2 = deg2rad(lat2);
    lambda1 = deg2rad(lon1); 
    lambda2 = deg2rad(lon2);
    delta_sigma = sin(phi1).*sin(phi2) + cos(phi1).*cos(phi2).*cos(lambda2 - lambda1);
    d = R * acos(delta_sigma);
end


%% Funktion Kreisbogen Langformel
function d = kreisbogen_lang(lat1, lon1, lat2, lon2, precision)
    if strcmp(precision,'single')
        lat1 = single(lat1); lat2 = single(lat2);
        lon1 = single(lon1); lon2 = single(lon2);
    end
    
    R = 6371; % Erdradius in km
    
    % Kreisbogenmethode
    phi1 = deg2rad(lat1);
    phi2 = deg2rad(lat2);
    lambda1 = deg2rad(lon1); 
    lambda2 = deg2rad(lon2);
    delta_sigma = (sin(lambda2-lambda1))^2*(cos(phi2))^2*(cos(phi1))^2+(sin(phi1))^2*(cos(phi2))^2+(sin(phi2))^2*(cos(phi1))^2-2*cos(lambda2-lambda1)*sin(phi1)*cos(phi1)*sin(phi2)*cos(phi2);
    d = R * acos(delta_sigma);
end









