% Computes the distance for the ray
% numberOfSlits = N (antal spalter)
% distanceList = d_j(x)
% constantLength = l (avstånd till detektorn)
function distanceList = Distances(slitPositionList, detectorPosition, ...
    constantLength)

numberOfSlits = length(slitPositionList);
distanceList = NaN(numberOfSlits, 1);

for iSlit = 1:numberOfSlits
    distanceList(iSlit) = sqrt(constantLength^2 + ...
        (detectorPosition - slitPositionList(iSlit))^2);
end

end
