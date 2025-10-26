function d = kreisbogen(lat1, lon1, lat2, lon2, precision)
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
    delta_sigma = acos(sin(phi1).*sin(phi2) + cos(phi1).*cos(phi2).*cos(lambda2 - lambda1));
    d = R * delta_sigma;