% all units in SI
close all;
slitDistance = 10e-6;
numberOfSlits = [2, 3, 10, 30];
numberOfSlitElements = length(numberOfSlits);
constantLength = 10e-2;
wavelengthList = [450, 500, 700] * 1e-9;
wavelengthNameList = ["blue", "green", "red"];
numberOfColors = length(wavelengthList);
xMin = -1;
xMax = 1;
numberOfDetectorPositions = 1000;
detectorPositionList = linspace(xMin, xMax, numberOfDetectorPositions) * 1e-2;
amplitude = zeros(numberOfDetectorPositions, 1);
wavelengthIndex = 3;
figure(3)

for iColor = 1:numberOfColors
    for iSlit = 1:numberOfSlitElements
        
        slitPositionList = SlitPositions(slitDistance, numberOfSlits(iSlit));
        
        for iDetector = 1:length(detectorPositionList)
            
            distanceList = Distances(slitPositionList, ...
                detectorPositionList(iDetector), constantLength);
            wavefunction = Wavefunction(distanceList, wavelengthList(iColor));
            amplitude(iDetector) = abs(wavefunction);
        end
        
        maxAmplitude = max(amplitude);
        normalizedAmplitude = amplitude / maxAmplitude;
        
        % plot the normalized amplitude at detector position (in cm)
        
        subplot(numberOfColors, numberOfSlitElements, ((iColor - 1) * numberOfSlitElements) + iSlit)
        plot(detectorPositionList * 1e2, normalizedAmplitude, wavelengthNameList(iColor))
        if iSlit == 1
            ylabel("Amplitude [a.u.]")
        end
        if iColor == numberOfColors
                    xlabel("x [cm]")
        end
        title("Slits: " +numberOfSlits(iSlit))
        xlim([xMin, xMax]);
        ylim([0, 1]);
    end
    sgt = sgtitle("Slit distance: " + slitDistance * 1e6 + " micrometer");
    sgt.FontSize = 24;  
end

