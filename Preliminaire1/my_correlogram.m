function dsp_correlogram = my_correlogram(signal)
    N = length(signal);
    autocorr_signal = xcorr(signal, 'biased'); % Calcul de l'autocorrélation
    dsp_correlogram = abs(fftshift(fft(autocorr_signal))); % DSP par transformée de Fourier
    dsp_correlogram = dsp_correlogram(1:N); % Prendre la moitié du spectre
end