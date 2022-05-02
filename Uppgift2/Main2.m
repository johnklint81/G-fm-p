constantLength = 10e-2;
wavelengthList = [450, 500, 700] * 1e-9;
wavelengthNameList = ["blue", "green", "red"];
numberOfColors = length(wavelengthList);
aList = 10 * [250, 500, 1000] * 1e-9;
numberOfSlitWidths = length(aList);
xMin = -3;
xMax = 3;
numberOfDetectorPositions = 1000;
detectorPositionList = linspace(xMin, xMax, numberOfDetectorPositions) * 1e-2;
figure

for iColor = 1:numberOfColors
    for iWidth = 1:numberOfSlitWidths
        
        a = aList(iWidth);
        wavefunction = @(x, y, l) exp(2i * pi * sqrt(l^2 + (x - y).^2) / wavelengthList(iColor)) / a;
        S = @(x, l) integral(@(y) wavefunction(detectorPositionList, y, constantLength), ...
            -a / 2, a / 2, 'ArrayValued', true);
        intensity = abs(S(detectorPositionList, constantLength)).^2;

        subplot(numberOfColors, numberOfSlitWidths, ((iColor - 1) * numberOfSlitWidths) + iWidth)
        plot(detectorPositionList * 1e2, intensity, wavelengthNameList(iColor))
        title("a: " + a * 1e6 + "um")
        sgt = sgtitle("Single slit");
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
end