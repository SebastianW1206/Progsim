%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Test Routine
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vereinfachtes Testskript zur Distanzberechnung

clc; clear;

% 1. Koordinaten abgelesen und festgelegt (als Platzhalter für Ihre Excel-Werte)
% (Breite, Länge)
haefen = struct();
haefen.Hamburg = [53.5511, 9.9937];
haefen.Rotterdam = [51.9244, 4.4777];
haefen.Sydney = [-33.8688, 151.2093];
haefen.LosAngeles = [34.0522, -118.2437]; % Beachten Sie das negative Vorzeichen für West-Länge
haefen.SanAntonio = [29.4241, -98.4936];  % Beachten Sie das negative Vorzeichen für West-Länge

% 2. Die zu testenden Strecken
test_strecken = {
    'Hamburg-Rotterdam', haefen.Hamburg, haefen.Rotterdam;
    'Hamburg-Sydney', haefen.Hamburg, haefen.Sydney;
    'Los Angeles-San Antonio', haefen.LosAngeles, haefen.SanAntonio
};

num_strecken = size(test_strecken, 1);

fprintf('=== Ergebnisse der Distanzberechnungen ===\n');
fprintf('==========================================\n');

for i = 1:num_strecken
    
    strecke_name = test_strecken{i, 1};
    coord1 = test_strecken{i, 2};
    coord2 = test_strecken{i, 3};
    
    lat1 = coord1(1); lon1 = coord1(2);
    lat2 = coord2(1); lon2 = coord2(2);
    
    fprintf('\n** Strecke: %s **\n', strecke_name);
    
    %% Berechnung in Double Precision
    d_kreisbogen_D = kreisbogen(lat1, lon1, lat2, lon2, 'double');
    d_mittelbreite_D = distance_mittelbreite(lat1, lon1, lat2, lon2, 'double');
    d_haversine_D = haversine(lat1, lon1, lat2, lon2, 'double');
    
    %% Berechnung in Single Precision
    d_kreisbogen_S = kreisbogen(lat1, lon1, lat2, lon2, 'single');
    d_mittelbreite_S = distance_mittelbreite(lat1, lon1, lat2, lon2, 'single');
    d_haversine_S = haversine(lat1, lon1, lat2, lon2, 'single');
    
    
    % Tabellarische Ausgabe der Ergebnisse
    T = table(...
        {'Kreisbogen'; 'Mittelbreite'; 'Haversine'}, ...
        [d_kreisbogen_D; d_mittelbreite_D; d_haversine_D], ...
        [d_kreisbogen_S; d_mittelbreite_S; d_haversine_S], ...
        'VariableNames', {'Formel', 'Double_km', 'Single_km'});
    
    disp(T);

    % Optional: Differenzen ausgeben
    fprintf('   Differenz (Double - Single) für Rundungsfehleranalyse:\n');
    fprintf('   Kreisbogen: %.6f km\n', d_kreisbogen_D - d_kreisbogen_S);
    fprintf('   Mittelbreite: %.6f km\n', d_mittelbreite_D - d_mittelbreite_S);
    fprintf('   Haversine: %.6f km\n', d_haversine_D - d_haversine_S);
    
end
