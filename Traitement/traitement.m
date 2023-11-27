function [trameReh] = traitement(trame)
% 1.Construction de la matrice de Hankel
    % Paramètres de la matrice de Hankel 
    N = length(trame);    %Longueur de la trame
    L = floor(N/2);             % Nombre de lignes 
    M = N - L + 1;              % Nombre de colonnes : L>M

    % matrice de Hankel
    Hy = hankel(trame(1:L), trame(L:N));
    [U, S, V] = svd(Hy);

% 2.Décomposition en valeurs singulières (SVD)
    seuil=0.8;
    % Calculer le pourcentage cumulatif des valeurs singulières
    cumulative_percentage = cumsum(diag(S)) / sum(diag(S));

    % Trouver le premier indice où le pourcentage cumulatif dépasse le seuil
    k = find(cumulative_percentage >= seuil, 1, 'first');
         
% 3.Estimation de la matrice de données du signal
    Uk = U(:, 1:k);
    Sk = S(1:k, 1:k);
    Vk = V(:, 1:k);
    HsLS = Uk * Sk * Vk';

% Moyennage des anti-diagonales pour reconstruire la matrice de Hankel
    % Tourner HsLS
    HsLSflip=flipud(HsLS);

    % Nombre de lignes et de colonnes dans la matrice HsLS
    [m, n] = size(HsLSflip);
    
    % Initialisation du vecteur pour stocker la moyenne des anti-diagonales
    averageDiagonals = zeros(1, m + n - 1);
    
    % Calcul de la moyenne des anti-diagonales
    for k = 1:(m + n - 1)
        diagonalElements = diag(HsLSflip, k - m);
        averageDiagonals(k) = mean(diagonalElements);
    end

% Obtenir la trame rehaussée.
    trameReh=averageDiagonals;
end

