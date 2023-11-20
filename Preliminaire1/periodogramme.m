%% Sallmone Armela & Mony Alexandra
%% Groupe 5
clear;
close all;
clc;

%% Periodogramme
% Paramètres
moyenne = 0;
variance = 1;
N = 1000; % Taille de l'échantillon

% Générer le bruit blanc
bruit_blanc = moyenne + sqrt(variance) * randn(1, N);

% Périodogramme
[Pxx, F] = periodogram(bruit_blanc, [], [], 1);

% Périodogramme de Daniell
order_daniell = 4; % Ordre de la moyenne de Daniell
[Pxx_daniell, F_daniell] = pburg(bruit_blanc, order_daniell);

% Périodogramme de Bartlett
window_bartlett = bartlett(N);
[Pxx_bartlett, F_bartlett] = periodogram(bruit_blanc, window_bartlett, [], 1);

% Périodogramme de Welch
segment_length = 64; % Longueur du segment
overlap = 50; % Chevauchement en pourcentage
[Pxx_welch, F_welch] = pwelch(bruit_blanc, segment_length, overlap, [], 1);

% Comparaison avec le spectre de puissance
[pxx, f] = periodogram(bruit_blanc, [], [], 1);

% Tracé des résultats
figure;

subplot(2,2,1);
plot(F, 10*log10(Pxx));
title('Périodogramme');
xlabel('Fréquence (Hz)');
ylabel('Puissance (dB)');

subplot(2,2,2);
plot(F_daniell, 10*log10(Pxx_daniell));
title('Périodogramme de Daniell');
xlabel('Fréquence (Hz)');
ylabel('Puissance (dB)');

subplot(2,2,3);
plot(F_bartlett, 10*log10(Pxx_bartlett));
title('Périodogramme de Bartlett');
xlabel('Fréquence (Hz)');
ylabel('Puissance (dB)');

subplot(2,2,4);
plot(F_welch, 10*log10(Pxx_welch));
title('Périodogramme de Welch');
xlabel('Fréquence (Hz)');
ylabel('Puissance (dB)');
