clear; close all; clc;
%% Sallmone Armela && Mony Alexandra | Groupe 5

%% Préliminaire 1: bruiter un signal de parole selon un rapport SNR donné

N = 1000; % nombre d'échantiollons
average = 0;
sigma_squared = 1;
variance = sigma_squared;

% Génération du bruit blanc 
white_noise = sqrt(sigma_squared) * randn(N,1);

% Corrélogramme
dsp_correlogram = my_correlogram(white_noise);

%% Affichage 

figure;

plot((dsp_correlogram));
title('corrélogramme d''''un bruit blanc Gaussien');

