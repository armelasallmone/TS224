%% Mony Alexandra && Sallmone Armela 
%% Groupe 5

clear 
close all;
clc

%% Partie 2,5

% Hypothèse : Signal et bruit sont décorrélés 

% Récupération des données bruitées
data =load('fcno03fz.mat');
signalBruit = data.fcno03fz;

% 1.Construction de la matrice de Hankel

    % Paramètres de la matrice de Hankel 
    N = length(signalBruit);    %Longueur du signal
    L = floor(N/2);             % Nombre de lignes 
    M = N - L + 1;              % Nombre de colonnes : L>M

    % matrice de Hankel
    H_y = hankel(signalBruit(1:L), signalBruit(L:N));

% 2.Décomposition en valeurs singulières (SVD)
[U, S, V] = svd(H_y);

% Sélection des K valeurs singulières dominantes
K = 10; 
UK = U(:, 1:K);   % valeurs propres
SK = S(1:K, 1:K); % valeurs singulières 
VK = V(:, 1:K);   % vecteurs propres

% 3.Estimation de la matrice de données du signal (H_s)
H_s_LS = UK * SK * VK';

% Moyennage des anti-diagonales pour reconstruire la matrice de Hankel
H_s_reconstructed = zeros(size(H_s_LS));
for i = 1:L
    for j = 1:M
        diagIdx = i + j - 1;
        H_s_reconstructed(i, j) = mean(diag(H_s_LS, j - i));
    end
end

% Extraction de la trame rehaussée
signal_reconstructed = [H_s_reconstructed(:, 1); H_s_reconstructed(end, 2:end)'];


% Affichage du signal reconstitué
plot(signal_reconstructed);
title('Signal Reconstitué');
xlabel('Échantillon');
ylabel('Amplitude');

