
clear; close all; clc;

%% Préliminaire 1: bruiter un signal de parole selon un rapport SNR donné

N = 1000; % nombre d'échantillons
average = 0;
sigma_squared = 1;
Fs = 8000;
f = linspace(-Fs/2, Fs/2, N);

Nfft = 128;
L = 10; % Largeur de la fenêtre pour Daniell
taille_segment = 256; % Taille du segment pour Bartlett

% Génération du bruit blanc 
white_noise = sqrt(sigma_squared) * randn(N,1);

% Densité spectrale de puissance 
dsp = sigma_squared * ones(size(f));

% Spectre de puissance d'une réalisation 
    
    tf_white_noise = fftshift(fft(white_noise));
    spectre_puissance = abs(tf_white_noise).^2;

% Périodogrammes 
dsp_daniell = my_daniell(white_noise, L);
dsp_bartlett = my_Bartlett(white_noise, taille_segment);
dsp_welch = my_welch(white_noise, Nfft);

% Fréquences associées aux DSP
f_welch = linspace(-Fs/2, Fs/2, length(dsp_welch));
f_daniell = linspace(-Fs/2, Fs/2, length(dsp_daniell));
f_bartlett = linspace(-Fs/2, Fs/2, length(dsp_bartlett));

%% Affichage 
% Affichage périodogramme & DSP
figure;
subplot(3, 1, 1);
plot(f_welch, dsp_welch);
hold on;
plot(f, dsp, 'r--', 'LineWidth', 1); 
title('Périodogramme de Welch');
xlabel('Fréquence (Hz)');
ylabel('DSP');
legend('Périodogramme', 'DSP');
hold off;

subplot(3, 1, 2);
plot(f_daniell, dsp_daniell);
hold on;
plot(f, dsp, 'r--', 'LineWidth', 1); 
title('Périodogramme de Daniell');
xlabel('Fréquence (Hz)');
ylabel('DSP');
legend('Périodogramme', 'DSP');
grid on;

subplot(3, 1, 3);
plot(f_bartlett, dsp_bartlett);
hold on;
plot(f, dsp, 'r--', 'LineWidth', 1);
title('Périodogramme de Bartlett');
xlabel('Fréquence (Hz)');
ylabel('DSP');
legend('Périodogramme', 'DSP');
grid on;

