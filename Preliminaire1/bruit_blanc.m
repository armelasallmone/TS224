clear; close all; clc;
%% Sallmone Armela && Mony Alexandra | Groupe 5

%% Préliminaire 1: bruiter un signal de parole selon un rapport SNR donné

N = 1000; % nombre d'échantillons 
average = 0;
sigma_squared = 1;

Fs = 8000; % Fréquence d'échantillonnage 
f = linspace(-Fs/2, Fs/2, N);

dirac = zeros(1,N);
dirac(1) = 1;

% Génération du bruit blanc 
white_noise = average + sqrt(sigma_squared) * randn(N,1);

% Fonction d'autocorrélation théorique d'un bbg
autocorrelation_theorique = sigma_squared * dirac;

% Fonction d'autocorrélation estimée
    
    % biaisé 
    [autocorrelation_biaise,lags_b] = xcorr(white_noise, 'biased');

    % non biaisé 
    [autocorrelation_nonBiaise, lags_ub] = xcorr(white_noise, 'unbiased');

% Spectre de puissance d'une réalisation

    %Calcul du spectre en fréquence X(f)
    tf_white_noise = fftshift(fft(white_noise));

    % Spectre de puissance |X(f)|^2
    spectre_puissance = abs(tf_white_noise).^2/N;

% Densité spectrale de puissance: indépendant de la réalisation
    
    % théorique
    dsp_theorique = sigma_squared * ones(1,N);

% Corrélogramme d'un bruit blanc gaussien 
dsp_correlogram = my_correlogram(white_noise); % Assurez-vous que my_correlogram est défini ailleurs dans votre code

%% Affichage 

figure;
plot(white_noise);
title("Bruit blanc gaussien: μ = 0 et V = σ²");
xlabel('Échantillons');
ylabel('Amplitude');

figure; 
plot(autocorrelation_theorique);
xlim([-N N]);
title('Fonction d''autocorrélation théorique');
xlabel('Décalage \tau'); 
ylabel('Autocorrélation');

figure; 
plot(lags_b,autocorrelation_biaise);
title('Fonction d''autocorrélation estimée: biaisée');
xlabel('Décalage \tau'); 
ylabel('Autocorrélation'); 

figure; 
plot(lags_ub, autocorrelation_nonBiaise);
title('Fonction d''autocorrélation estimée: non biaisée');
xlabel('Décalage \tau');
ylabel('Autocorrélation');

figure;
plot(f, spectre_puissance);
xlim([-Fs/2 Fs/2]);
title('Spectre de puissance d''un bruit blanc gaussien');
xlabel('Fréquence (Hz)');
ylabel('Puissance');

figure; 
plot(f, dsp_theorique);
xlim([-Fs/2 Fs/2]);
title('Densité spectrale de puissance d''un bruit blanc gaussien');
xlabel('Fréquence (Hz)');
ylabel('DSP');

figure;
lags = 0:N-1;
plot(lags, dsp_correlogram);
title('Corrélogramme d''un bruit blanc gaussien');
xlabel('Décalage Temporel');
ylabel('Auto-corrélation');
