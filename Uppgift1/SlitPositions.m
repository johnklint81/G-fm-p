function slitPositionList = SlitPositions(slitDistance, numberOfSlits)

slitPositionList = NaN(numberOfSlits, 1);
if mod(numberOfSlits, 2) == 0
    for iSlit=1:numberOfSlits
        slitPositionList(iSlit) = - slitDistance / 2 - ...
            numberOfSlits / 2 * slitDistance + (iSlit) * slitDistance;
    end
else
    for iSlit=1:numberOfSlits
        slitPositionList(iSlit) = - (numberOfSlits - 1) / 2 * ...
        slitDistance + (iSlit - 1) * slitDistance;
    end
end