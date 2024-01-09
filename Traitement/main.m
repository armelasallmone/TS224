%% Sallmone Armela && Mony Alexandra | Groupe 5
clear; close all; clc;

%% Méthode de traitement d une trame d'un signal de parole bruité par un bruit blanc gaussien :

%% Initialisation des paramètres
% Charger le signal de parole 
signal_parole=load('fcno03fz.mat');

Fe = 8000; % Fréquence du signal
Te=1/Fe;

T=30e-3; % Durée d'une Trame
Lt=T/Te; % Longueur d'une Trame 
Ls=length(signal_parole.fcno03fz); %Longueur du signal
nbT =floor(2*Ls/Lt - 2); % Nombre de Trame

% Les signaux de parole sont généralement supposés quasi stationnaires sur des durées de l'ordre de 20 à 40 millisecondes.

%% Traitement 

% Bruiter le signal
RSB=10;

[signal_bruite,sigmaB] = bruiter_signal(signal_parole.fcno03fz, RSB);


TramesOriginal=decomposition(signal_parole.fcno03fz,Lt,nbT);
TramesBruite=decomposition(signal_bruite,Lt,nbT);

% Détermination du seuil : 

seuil=0;

for i=1:75
    tmp1=findseuil(TramesBruite(i,:));    
    if (tmp1>seuil)
        seuil=tmp1;
    end
end
 
% Trames rehaussées:
TramesRehausse=zeros(nbT,Lt);

for t=1:nbT
    TramesRehausse(t,:)=traitement(TramesBruite(t,:),seuil);
end

% Reconstruction :
signalRehausse=reconstruction(TramesRehausse,Ls,Lt,nbT);


% Calculer le RSB sur les signaux rehaussés
puissanceSignalParole = sum(signal_parole.fcno03fz.^2) / Ls;

% Calcul de la puissance du bruit (différence entre signal bruité et signal non bruité)
bruit = signal_parole.fcno03fz - signalRehausse';
puissanceBruit = sum(bruit.^2) / Ls;

% Calcul du RSB en décibels (dB)
RSB_dB = 10 * log10(puissanceSignalParole / puissanceBruit);



%% Affichage

% Affichage des 10 premières trames
figure;


    plot((1:Lt)*Te, TramesBruite(1, :), 'r', 'LineWidth', 1.5);
    hold on;
    plot((1:Lt)*Te, TramesOriginal(1, :), 'b', 'LineWidth', 1.5);
    hold on;
    plot((1:Lt)*Te, TramesRehausse(1, :), 'g', 'LineWidth', 1.5);
    title(['Trame ', num2str(1)]);
    xlabel('Temps (s)');
    ylabel('Amplitude');
    legend('Parole bruitée', 'Parole originale', 'Parole rehaussée');
    grid on;


% Affichage de la représentation temporelle du signal rehaussé dans sa totalité


figure;
subplot(4, 1, 1);
plot((1:Ls)*Te, signal_bruite, 'r', 'LineWidth', 1.5);
hold on;
plot((1:Ls)*Te, signal_parole.fcno03fz, 'b', 'LineWidth', 1.5);
hold on;
plot((1:Ls)*Te, signalRehausse, 'g', 'LineWidth', 1.5);
title('Signal de parole rehaussé');
xlabel('Temps (s)');
ylabel('Amplitude');
legend('Parole bruitée', 'Parole originale', 'Parole rehaussée');
grid on;

% Affichage du spectrogramme du signal rehaussé dans sa totalité
subplot(4, 1, 2);
spectrogram(signalRehausse, 256, 250, 256, Fe, 'yaxis');
title('Spectrogramme du signal de parole rehaussé');

subplot(4, 1, 3);
spectrogram(signal_bruite, 256, 250, 256, Fe, 'yaxis');
title('Spectrogramme du signal de parole bruite');

subplot(4, 1, 4);
spectrogram(signal_parole.fcno03fz, 256, 250, 256, Fe, 'yaxis');
title('Spectrogramme du signal de parole original');




