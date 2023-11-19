clear; close all; clc;
%% Sallmone Armela && Mony Alexandra | Groupe 5

%% Préliminaire 1: bruiter un signal de parole selon un rapport SNR donné

N = 1000; % nombre d'échantiollons
average = 0;
sigma_squared = 1;
variance = sigma_squared;
Fs = 1000;
f = linspace(-Fs/2, Fs/2, N);

Nfft = 128;
L = 10; %Largeur de la fenêtre pour Daniell
taille_segment = 256; %taille du segment pour bartlett


% Génération du bruit blanc 
white_noise = sqrt(sigma_squared) * randn(N,1);


% Pérodogrammes 
dsp_welch = my_welch(white_noise, Nfft);
dsp_daniell = my_daniell(white_noise, L);
dsp_bartlett = my_Bartlett(white_noise, taille_segment);



%% Affichage 

figure;
subplot(3, 1, 1);
plot((dsp_welch));
title('Périodogramme de Welch');

subplot(3, 1, 2);
plot((dsp_daniell));
title('Périodogramme de Daniell');

subplot(3, 1, 3);
plot(dsp_bartlett);
title('Périodogramme de Bartlett');
