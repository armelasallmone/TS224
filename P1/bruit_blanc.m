clear; close all; clc;
%% Sallmone Armela && Mony Alexandra | Groupe 5

%% Préliminaire 1: bruiter un signal de parole selon un rapport SNR donné

N = 1000; % nombre d'échantiollons 
average = 0;
sigma_squared = 1;
variance = sigma_squared;
Fs = 8000;
f = linspace(-Fs/2, Fs/2, N);


% Génération du bruit blanc 
white_noise = sqrt(sigma_squared) * randn(N,1);

% Fonction d'autocorrélation théorique d'un bbg
autocorrelation_theorique = zeros(1,N);
center = ceil(N/2);
autocorrelation_theorique(center) = 1;

% Fonction d'autocorrélation estimée
autocorrelation_biaise = xcorr(white_noise, 'biased');
autocorrelation_nonBiaise = xcorr(white_noise, 'unbiased');


% Spectre de puissance d'une réalisation : carcatèrise le processus en moyenne

    %Calcul du spectre en fréquence X(f)
    tf_white_noise = fftshift(fft(white_noise));

    % Spectre de puissance |X(f)|^2
    spectre_puissance = abs(tf_white_noise).^2;
   

% Densité spectrale de puissance: indépendant de la réalisation
    
    % théorique
    dsp_theorique = sigma_squared * ones(1,N);

    % estimée
    dsp_estime = fftshift(fft(autocorrelation_theorique));


% Corrélogramme d'un bruit blanc gaussien 

dsp_correlogram = my_correlogram(white_noise);



%% Affichage 

figure;
plot(white_noise);
title("Bruit blanc gaussien: μ = 0 et V = σ²");

figure; 
subplot(1,3,1);
plot(autocorrelation_theorique);
title('Fonction d autocorrélation théorique');

subplot(1,3,2);
plot(autocorrelation_biaise);
title('Fonction d autocorrélation estimée: biaisée');


subplot(1,3,3);
plot(autocorrelation_nonBiaise);
title('Fonction d autocorrélation estimée: non biaisée');

figure;
subplot(2,2,1);
plot(f,spectre_puissance);
title('Spectre de puissance');

subplot(2,2,2);
plot(f,dsp_theorique);
title('Densité spectrale de puissance théorique');

subplot(2,2,3);
plot(dsp_estime);
title('Densité spectrale de puissance estimée');

figure;
plot((dsp_correlogram));
title('Corrélogramme d''''un bruit blanc Gaussien');


