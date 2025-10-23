function d = distance_haversine(b1, l1, b2, l2, R)
% Abstand mit der Haversine-Formel
delta_b = b2 - b1;
delta_l = l2 - l1;

a = sin(delta_b/2).^2 + cos(b1).*cos(b2).*sin(delta_l/2).^2;
c = 2 * atan2(sqrt(a), sqrt(1 - a));
d = R * c;
end