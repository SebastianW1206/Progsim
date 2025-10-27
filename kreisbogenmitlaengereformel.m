function d = kreisbogenmitlaengereformel(lat1, lon1, lat2, lon2, precision)
    % Berechnet die Großkreisdistanz zwischen zwei GPS-Punkten 
    % (lat1, lon1) und (lat2, lon2) unter Verwendung des sphärischen Kosinussatzes.
    
 if strcmp(precision,'single')
        lat1 = single(lat1); lat2 = single(lat2);
        lon1 = single(lon1); lon2 = single(lon2);
end
    
    R = 6371; % Mittlerer Erdradius in km
    
    % Kreisbogenmethode (Sphärischer Kosinussatz)
    
    % 1. Konvertierung von Grad in Radiant
    phi1 = deg2rad(lat1);      % Breite des ersten Punktes
    phi2 = deg2rad(lat2);      % Breite des zweiten Punktes
    lambda1 = deg2rad(lon1);   % Länge des ersten Punktes
    lambda2 = deg2rad(lon2);   % Länge des zweiten Punktes
    
    % 2. Berechnung des zentralen Winkels (delta_sigma) in Radiant
    % Formel: cos(delta_sigma) = sin(phi1)sin(phi2) + cos(phi1)cos(phi2)cos(lambda2 - lambda1)
    cos_delta_sigma = sin(phi1).*sin(phi2) + cos(phi1).*cos(phi2).*cos(lambda2 - lambda1);
    
    % Sicherstellen, dass der Wert im acos-Argumentbereich [-1, 1] liegt, 
    % um Rundungsfehler zu korrigieren.
    cos_delta_sigma(cos_delta_sigma > 1) = 1;
    cos_delta_sigma(cos_delta_sigma < -1) = -1;
    
    delta_sigma = acos(cos_delta_sigma);
    
    % 3. Berechnung der Distanz (Bogenlänge)
    % Formel: d = R * delta_sigma
    d = R * delta_sigma;
end