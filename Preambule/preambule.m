clear; close all; clc;
%% Sallmone Armela && Mony Alexandra | Groupe 5

%% Préambule à la méthode de traitement d un signal de parole bruité par un bruit blanc gaussien : procédure dite d’addition-recouvrement

Fe = 8000;
Te=1/Fe;
T=20e-3;
Lt=T/Te;
% Les signaux de parole sont généralement supposés quasi stationnaires sur des durées de l'ordre de 20 à 40 millisecondes.

% Charger le signal de parole (remplacez le chemin par le vôtre)
signal_parole=load('fcno03fz.mat');

% Bruiter le signal
signal_bruite = bruiter_signal(signal_parole.fcno03fz, 20);

recSignal=decomposition(signal_bruite,Lt);

figure;
subplot(2,2,1);
plot(signal_parole.fcno03fz,'r');


hold on;
subplot(2,2,2);
plot(signal_bruite,"r+");

hold on;
plot(recSignal,'kx');

hold on;
subplot(2,2,4);
s=signal_bruite-recSignal';
plot(s(240:1000),'b');




