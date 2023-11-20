%% Sallmone Armela & Mony Alexandra
%% Groupe 5
clear;
close all;
clc;

%% Corrélogramme
% Paramètres
moyenne = 0;
variance = 1;
N = 1000; % Taille de l'échantillon

% Générer le bruit blanc
bruit_blanc = moyenne + sqrt(variance) * randn(1, N);

% Calcul du corrélogramme
correlogramme = xcorr(bruit_blanc, 'biased');

% Tracé du corrélogramme
figure;
subplot(3,1,1);
stem(correlogramme);
title('Corrélogramme du bruit blanc');
xlabel('Lags');
ylabel('Corrélation');

% Calcul du spectre de puissance
[pxx, f] = periodogram(bruit_blanc, [], [], 1);

% Tracé du spectre de puissance
subplot(3,1,2);
plot(f, 10*log10(pxx));
title('Spectre de puissance du bruit blanc');
xlabel('Fréquence (Hz)');
ylabel('Puissance (dB)');

% Densité spectrale de puissance théorique
psd_theorique = variance * ones(size(f));
subplot(3,1,3);
plot(f, 10*log10(psd_theorique));
title('Densité spectrale de puissance théorique du bruit blanc');
xlabel('Fréquence (Hz)');
ylabel('Puissance (dB)');
