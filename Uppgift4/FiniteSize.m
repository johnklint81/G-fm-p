clear all
close all
numberOfSlits = [1, 3, 10, 30];
numberOfSlitElements = length(numberOfSlits);
slitWidth = 6e-6;
delta_x = 2e-6;
% delta_x_single = 2e-6;
padding = zeros(100, 1);
colorList = ["black", "cyan", "yellow", "magenta"];
discreteSlitWidth = floor(slitWidth / delta_x);
slitDistance = 20e-6;
discreteSlitDistance = ceil(slitDistance / delta_x);
% if even symmetric fft, otherwise not
discretisationFrequency = discreteSlitWidth + discreteSlitDistance;   

for i = 1:numberOfSlitElements
    if numberOfSlits(i) == 1
       slitPositions = ones(discreteSlitWidth, 1);
       intervalLength = length(slitPositions);
    else
    slitPositions = zeros((numberOfSlits(i) - 1) * discretisationFrequency, 1);
    intervalLength = length(slitPositions);

    for j = 1:(numberOfSlits(i) * discretisationFrequency)
        if mod(j - 1, discretisationFrequency) == 0
                if j < intervalLength && slitPositions(j) == 0
                    slitPositions(j:j+3) = 1;    
                end
        end
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
    spectralFunction = abs(fft(slitPositions));
    spectralFunction = fftshift(spectralFunction);
    spectralFunction = spectralFunction / max(spectralFunction);
    binVector = linspace(0, freqStep * N, length(slitPositions));
    binVector = binVector - (freqStep * N / 2);
    subplot(numberOfSlitElements, 1, i)
    plot(binVector, spectralFunction, linewidth=2, color=colorList(i))
%     xlim([-1, 1])
    sgt = sgtitle("Spectral Function");
    sgt.FontSize = 20;
    label = strcat('Slits: ', num2str(numberOfSlits(i)));
    legend(label)
end


