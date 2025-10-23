function d = distance_kreisbogen(b1, l1, b2, l2, R)
% Abstand auf der Erdkugel mit der Kreisbogenformel (arccos)
qb = sin(b1) .* sin(b2) + cos(b1) .* cos(b2) .* cos(l2 - l1);
qb = min(max(qb, -1), 1); % numerisch stabil halten
d = R * acos(qb);
end