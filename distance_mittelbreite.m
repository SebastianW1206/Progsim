function d = distance_mittelbreite(b1, l1, b2, l2, R)
% Abstand mit Mittelbreitenformel
d = R * sqrt((b2 - b1).^2 + ((l2 - l1) .* cos((b1 + b2)/2)).^2);
end