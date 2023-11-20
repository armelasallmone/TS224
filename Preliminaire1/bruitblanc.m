%% Sallmone Armela & Mony Alexandra
%% Groupe 5
clear;
close all;
clc;

%% Générer un bruit blanc de moyenne nulle et de variance σ²

% Paramètres
moyenne = 0;
variance = 1;
N = 1000; % Nombre d'échantillons

% Générer le bruit blanc
bruit_blanc = moyenne + sqrt(variance) * randn(1, N);

% Estimation de l'autocorrélation
lags = -N+1:N-1;
autocorrelation_estimee = xcorr(bruit_blanc, 'unbiased');

% Tracé de l'autocorrélation théorique et estimée
figure;
subplot(2,1,1);
stem(lags, autocorrelation_estimee);
title('Autocorrélation estimée du bruit blanc');
xlabel('Lags');
ylabel('Autocorrélation');

% Autocorrélation théorique
autocorrelation_theorique = variance * exp(-abs(lags) / N);
subplot(2,1,2);
stem(lags, autocorrelation_theorique);
title('Autocorrélation théorique du bruit blanc');
xlabel('Lags');
ylabel('Autocorrélation');

% Calcul du spectre de puissance
fft_result = fft(bruit_blanc);
power_spectrum = abs(fft_result).^2 / N;
frequencies = (0:N-1) / N;

% Tracé du spectre de puissance
figure;
subplot(2,1,1);
plot(frequencies, power_spectrum);
title('Spectre de puissance de la réalisation du bruit blanc');
xlabel('Fréquence normalisée');
ylabel('Puissance (dB)');

% Densité spectrale de puissance théorique
psd_theorique = variance * ones(size(frequencies));
subplot(2,1,2);
plot(frequencies, psd_theorique);
title('Densité spectrale de puissance théorique du bruit blanc');
xlabel('Fréquence normalisée');
ylabel('Puissance (dB)');
