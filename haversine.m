%% Funktion zur Abstandberechnung
function d = haversine(lat1, lon1, lat2, lon2, precision)
    if strcmp(precision,'single')
        lat1 = single(lat1); lat2 = single(lat2);
        lon1 = single(lon1); lon2 = single(lon2);
    end
    
    R = 6371; % Erdradius in km
    phi1 = deg2rad(lat1);
    phi2 = deg2rad(lat2);
    lambda1 = deg2rad(lon1); 
    lambda2 = deg2rad(lon2);

% Haversine
    delta_phi = phi2 - phi1;
    delta_lambda = lambda2 - lambda1;
    a = sin(delta_phi/2)^2 + cos(phi1)*cos(phi2)*sin(delta_lambda/2)^2;
    c = 2 * atan2(sqrt(a), sqrt(1-a));
    d = R * c;
end
