function wavefunction = Wavefunction(distanceList, wavelength)
% wavelength = lambda
% distanceList = d_j(x)

wavefunction = sum(exp(2i * pi * distanceList / wavelength));

end