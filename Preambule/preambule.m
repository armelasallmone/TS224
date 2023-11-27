%% Sallmone Armela && Mony Alexandra | Groupe 5
clear; close all; clc;

%% Préambule à la méthode de traitement d un signal de parole bruité par un bruit blanc gaussien : procédure dite d’addition-recouvrement

%% Initialisation des paramètres
% Charger le signal de parole 
signal_parole=load('fcno03fz.mat');

Fe = 8000; % Fréquence du signal
Te=1/Fe;

T=20e-3; % Durée d'une Trame
Lt=T/Te; % Longueur d'une Trame 
Ls=length(signal_parole.fcno03fz); %Longueur du signal
nbT =floor(2*Ls/Lt - 2); % Nombre de Trame

% Les signaux de parole sont généralement supposés quasi stationnaires sur des durées de l'ordre de 20 à 40 millisecondes.

%% Traitement 

% Bruiter le signal
RSB=20;
signal_bruite = bruiter_signal(signal_parole.fcno03fz, RSB);

Trames=decomposition(signal_bruite,Lt,nbT);
recSignal=reconstruction(Trames,Ls,Lt,nbT);

%% Affichage
subplot(2,1,1);
plot(signal_parole.fcno03fz, 'r');
title('Signal de parole original');
xlabel('Temps');
ylabel('Amplitude');

subplot(2,1,2);
plot(signal_bruite, 'r+');
hold on;
plot(recSignal, 'kx');
title('Signal de parole bruité et signal reconstitué');
xlabel('Temps');
ylabel('Amplitude');
legend('Signal bruité', 'Signal reconstitué');