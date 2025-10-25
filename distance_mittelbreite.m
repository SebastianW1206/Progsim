function d = distance_mittelbreite(lat1, lon1, lat2, lon2, precision)
    if strcmp(precision,'single')
        lat1 = single(lat1); lat2 = single(lat2);
        lon1 = single(lon1); lon2 = single(lon2);
    end
    
    R = 6371; % Erdradius in km
    phi1 = deg2rad(lat1);
    phi2 = deg2rad(lat2);
     lambda1 = deg2rad(lon1); 
     lambda2 = deg2rad(lon2);
   % Mittelbreite
    phi_m = (phi1 + phi2)/2;
    d_lambda = lambda2 - lambda1;
    d_phi = phi2 - phi1;
    d = R * sqrt(d_phi^2 + (cos(phi_m)*d_lambda)^2);