%% Sallmone Armela & Mony Alexandra
clear;
close all;
clc;

%% Bruiter un signal de parole selon un rapport signal à bruit donné
% Charger le signal de parole (remplacez le chemin par le vôtre)
signal_parole=load('fcno03fz.mat');

% Cas à tester : 5 dB, 10 dB et 15 dB
rsb_values = [5, 10, 15];

% Affichage temporel et spectrogramme pour chaque cas
for i = 1:length(rsb_values)
    rsb_dB = rsb_values(i);
    
    % Bruiter le signal
    signal_bruite = bruiter_signal(signal_parole.fcno03fz, rsb_dB);
    
    % Figure pour le signal de parole original
    figure;
    subplot(2,1,1);
    plot(signal_parole.fcno03fz);
    title(['Signal de parole original (RSB = ' num2str(rsb_dB) ' dB)']);
    xlabel('Échantillons');
    ylabel('Amplitude');
    
    subplot(2,1,2);
    spectrogram(signal_parole.fcno03fz, hann(256), 128, 256, 1e3, 'yaxis');
    title('Spectrogramme');
    
    % Figure pour le signal de parole bruité
    figure;
    subplot(2,1,1);
    plot(signal_bruite);
    title(['Signal de parole bruité (RSB = ' num2str(rsb_dB) ' dB)']);
    xlabel('Échantillons');
    ylabel('Amplitude');
    
    subplot(2,1,2);
    spectrogram(signal_bruite, hann(256), 128, 256, 1e3, 'yaxis');
    title('Spectrogramme');
end