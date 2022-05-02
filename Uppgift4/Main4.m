
% close all
numberOfSlits = [2, 3, 10, 30];
numberOfSlitElements = length(numberOfSlits);
delta_x = 2e-6;
padding = zeros(100, 1);
colorList = ["black", "cyan", "yellow", "magenta"];
discretisationFrequency = 5;   % if even symmetric fft, otherwise not

for i = 1:numberOfSlitElements
    slitPositions = zeros((numberOfSlits(i) - 1) * discretisationFrequency, 1);
    intervalLength = length(slitPositions);
    for j = 1:(numberOfSlits(i) * discretisationFrequency)
        if mod(j - 1, discretisationFrequency) == 0
            slitPositions(j) = 1;
        end
    end
    slitPositions = [padding' slitPositions' padding']';
    freqStep = discretisationFrequency / length(slitPositions);
    if mod(numberOfSlits(i), 2) == 0
        xVector = (-(length(padding) + intervalLength / 2): ...
            (length(padding) + intervalLength / 2));
        N = length(slitPositions) / 2 + 1;
    else
        xVector = (-(length(padding) + intervalLength / 2): ...
            (length(padding) + intervalLength / 2));
        N = length(slitPositions) / 2 + 1;
    end
    
    figure(1)
    hold on
    subplot(numberOfSlitElements, 1, i)
    plot(xVector, slitPositions, linewidth=2, color=colorList(i))
    xlabel("x [um]")
    xlim([min(xVector), max(xVector)])
    sgt = sgtitle("Slit position");
    sgt.FontSize = 36;
    figure(2)
    spectralFunction = abs(fft(slitPositions));
    spectralFunction = fftshift(spectralFunction);
    spectralFunction = spectralFunction / max(spectralFunction);
    xVector = xVector * 1e-2;
    subplot(numberOfSlitElements, 1, i)
    plot(xVector, spectralFunction, linewidth=2, color=colorList(i))
%     xlim([-1, 1])
    label = strcat('Slits: ', num2str(numberOfSlits(i)));
    legend(label)
    sgt = sgtitle("Spectral Function");
    sgt.FontSize = 36;
    
    binVector = linspace(0, freqStep * N, length(slitPositions));
    binVector = binVector - (freqStep * N / 2);
    figure(4)
    subplot(numberOfSlitElements, 1, i)
    plot(binVector, spectralFunction, linewidth=2, color=colorList(i))
%     xlim([-1, 1])
    sgt = sgtitle("Spectral Function");
    sgt.FontSize = 36;
    label = strcat('Slits: ', num2str(numberOfSlits(i)));
    legend(label)
end


