%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vollständiges und korrigiertes Test-Skript zur Distanzberechnung
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1. INITIALISIERUNG UND DATENDEFINITION
clc; clear;

% ANMERKUNG: Die Funktionen (kreisbogen, distance_mittelbreite, haversine) 
% MÜSSEN als separate .m-Dateien im MATLAB-Pfad verfügbar sein.

% 1.1 Koordinaten der Häfen (Breite, Länge)
haefen = struct();
haefen.Hamburg = [53.5511, 9.9937];
haefen.Rotterdam = [51.9244, 4.4777];
haefen.Sydney = [-33.8688, 151.2093];
haefen.LosAngeles = [34.0522, -118.2437]; 
haefen.SanAntonio = [29.4241, -98.4936];  

% 1.2 Die zu testenden Strecken
test_strecken = {
    'Hamburg-Rotterdam', haefen.Hamburg, haefen.Rotterdam;
    'Hamburg-Sydney', haefen.Hamburg, haefen.Sydney;
    'Los Angeles-San Antonio', haefen.LosAngeles, haefen.SanAntonio
};
num_strecken = size(test_strecken, 1);

% 1.3 Referenzdistanzen (ungefähre Luftlinie/Großkreis, Google Maps)
ref_distanzen = [412; 16120; 2029]; % Reihenfolge: HH-RT, HH-SYD, LA-SA

% 1.4 Initialisierung der Datenstrukturen für die Plots
% Plot 1: [Ref_Dist, Kreisbogen(D), Mittelbreite(D), Haversine(D)]
plot_data_double = zeros(num_strecken, 4); 
% Plot 2: [Diff_Kreis(D-S), Diff_Mittel(D-S), Diff_Haversine(D-S)]
plot_data_diff = zeros(num_strecken, 3);
strecken_labels = cell(num_strecken, 1);


%% 2. BERECHNUNGEN UND KONSOLENAUSGABE
fprintf('=== Ergebnisse der Distanzberechnungen ===\n');
fprintf('==========================================\n');

for i = 1:num_strecken
    
    strecke_name = test_strecken{i, 1};
    coord1 = test_strecken{i, 2};
    coord2 = test_strecken{i, 3};
    
    lat1 = coord1(1); lon1 = coord1(2);
    lat2 = coord2(1); lon2 = coord2(2);
    
    fprintf('\n** Strecke: %s **\n', strecke_name);
    strecken_labels{i} = strecke_name;

    % Zuweisung des Referenzwertes
    ref_D = ref_distanzen(i);

    %% Berechnung in Double Precision
    d_kreisbogen_D = kreisbogen(lat1, lon1, lat2, lon2, 'double');
    d_mittelbreite_D = distance_mittelbreite(lat1, lon1, lat2, lon2, 'double');
    d_haversine_D = haversine(lat1, lon1, lat2, lon2, 'double');
    
    % Speichern für Plot 1
    plot_data_double(i, 1) = ref_D;
    plot_data_double(i, 2) = d_kreisbogen_D;
    plot_data_double(i, 3) = d_mittelbreite_D;
    plot_data_double(i, 4) = d_haversine_D;

    %% Berechnung in Single Precision
    d_kreisbogen_S = kreisbogen(lat1, lon1, lat2, lon2, 'single');
    d_mittelbreite_S = distance_mittelbreite(lat1, lon1, lat2, lon2, 'single');
    d_haversine_S = haversine(lat1, lon1, lat2, lon2, 'single');
    
    % Speichern für Plot 2 (Absolute Differenz)
    plot_data_diff(i, 1) = abs(d_kreisbogen_D - d_kreisbogen_S);
    plot_data_diff(i, 2) = abs(d_mittelbreite_D - d_mittelbreite_S);
    plot_data_diff(i, 3) = abs(d_haversine_D - d_haversine_S);

    % Tabellarische Ausgabe der Ergebnisse
    T = table(...
        {'Referenz (Google)'; 'Kreisbogen'; 'Mittelbreite'; 'Haversine'}, ...
        [ref_D; d_kreisbogen_D; d_mittelbreite_D; d_haversine_D], ...
        [NaN; d_kreisbogen_S; d_mittelbreite_S; d_haversine_S], ...
        'VariableNames', {'Formel', 'Double_km', 'Single_km_Vergleich'});
    
    disp(T);
    % Differenzen ausgeben
    fprintf('   Differenz (Double - Single) für Rundungsfehleranalyse:\n');
    fprintf('   Kreisbogen: %.6f km\n', plot_data_diff(i, 1));
    fprintf('   Mittelbreite: %.6f km\n', plot_data_diff(i, 2));
    fprintf('   Haversine: %.6f km\n', plot_data_diff(i, 3));
    
end

%----------------------------------------------------------------------
%% 3. PLOT 1: Double Precision vs. Referenz (Eignungsvergleich)
%----------------------------------------------------------------------

figure('Name', 'Plot 1: Eignungsvergleich'); 
b1 = bar(plot_data_double);

% Achsenbeschriftungen, Titel und Legende
xticks(1:num_strecken);
xticklabels(strecken_labels);
xlabel('Strecke');
ylabel('Distanz (km)');
title('Vergleich: Formeln (Double Precision) vs. Google Maps Referenz');

% Legende für die 4 Datenreihen
legend({ ...
    'Referenz (Google Maps)', ...
    'Kreisbogen', 'Mittelbreite', 'Haversine' ...
}, 'Location', 'northwest');
grid on;

% Werte über den Balken anzeigen (Verwendung von num2str statt string)
for k = 1:size(plot_data_double, 2) 
    xtips = b1(k).XEndPoints;
    ytips = b1(k).YEndPoints;
    % num2str zur Umwandlung von Zahl in String
    labels = num2str(round(b1(k).YData(:))); 
    text(xtips, ytips, labels, ...
         'HorizontalAlignment', 'center', ...
         'VerticalAlignment', 'bottom', ...
         'FontSize', 8);
end

fprintf('\n\n** PLOT 1 (Double vs. Referenz) generiert. **\n');

%----------------------------------------------------------------------
%% 4. PLOT 2: Vergleich der Single- vs. Double-Precision (Stabilitätsvergleich)
%----------------------------------------------------------------------

figure('Name', 'Plot 2: Präzisionsvergleich'); 
b2 = bar(plot_data_diff);

% Achsenbeschriftungen, Titel und Legende
xticks(1:num_strecken);
xticklabels(strecken_labels); 
xlabel('Strecke');
ylabel('Absolute Differenz |Double - Single| (km)');
title('Rundungsfehler durch Verwendung von Single Precision');
legend({'Kreisbogen', 'Mittelbreite', 'Haversine'}, 'Location', 'northeast');
grid on;

% Werte über den Balken anzeigen (Verwendung von num2str statt string)
for k = 1:size(plot_data_diff, 2)
    xtips = b2(k).XEndPoints;
    ytips = b2(k).YEndPoints;
    % num2str mit Format-Argument zur Umwandlung von Zahl in String
    labels = num2str(b2(k).YData, '%.3g'); 
    text(xtips, ytips, labels, ...
         'HorizontalAlignment', 'center', ...
         'VerticalAlignment', 'bottom', ...
         'FontSize', 8);
end

fprintf('\n\n** PLOT 2 (Präzisionsvergleich) generiert. **\n');