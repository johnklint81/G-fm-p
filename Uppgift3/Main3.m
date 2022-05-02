constantLength = 10e-2;
slitDistance = 10e-6;
numberOfSlits = [2, 3, 10, 30];
numberOfSlitElements = length(numberOfSlits);
wavelengthList = [450, 500, 700] * 1e-9;
wavelengthNameList = ["blue", "green", "red"];
numberOfColors = length(wavelengthList);
aList = 10 * [250, 500, 1000] * 1e-9;
numberOfSlitWidths = length(aList);
xMin = -3;
xMax = 3;
numberOfDetectorPositions = 1000;
detectorPositionList = linspace(xMin, xMax, numberOfDetectorPositions) * 1e-2;

for iSlitElement = 1:numberOfSlitElements
    figure
    slitPositionList = SlitPositions(slitDistance, numberOfSlits(iSlitElement));
    for iColor = 1:numberOfColors
        wavefunction = @(x, y, l) exp(2i * pi * sqrt(l^2 + (x - y).^2) / ...
            wavelengthList(iColor)) / a;
        for iWidth = 1:numberOfSlitWidths
            SCumulative = 0;
            a = aList(iWidth);
            for iSlit = 1:numberOfSlits(iSlitElement)
            S = @(x, l) integral(@(y) wavefunction(detectorPositionList, ... 
                y, constantLength), (-a / 2 + slitPositionList(iSlit)), ...
                (a / 2 + slitPositionList(iSlit)), 'ArrayValued', true);
            SCumulative = SCumulative + S(detectorPositionList, constantLength);
            end
            intensity = abs(SCumulative).^2;
            normalisedIntensity = intensity / max(intensity);

            subplot(numberOfColors, numberOfSlitWidths, ((iColor - 1) * numberOfSlitWidths) + iWidth)
            plot(detectorPositionList * 1e2, normalisedIntensity, wavelengthNameList(iColor))
            title("a: " + a * 1e6 + "um")
            sgt = sgtitle("Slits: " + numberOfSlits(iSlitElement) + " , slit distance: " + slitDistance *1e6 + " um");
            sgt.FontSize = 24;

            if iColor == numberOfColors
                        xlabel("Position [cm]")
            end
            if iWidth == 1
            ylabel("Intensity [a.u]")
            end
        end
        xlim([xMin, xMax]);
        ylim([0, 1]);
        saveas(gcf, "slits_" + numberOfSlits(iSlitElement) + ".png")
    end
end