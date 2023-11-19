function dsp_daniell = my_daniell(signal,L)
    % L: la largeur de la fenêtre 
    N = length(signal);
    spectre_puissance = abs(fftshift(fft(signal))).^2 / N;
    dsp_daniell = filter((1/L)*ones(1,L), 1, spectre_puissance);
end