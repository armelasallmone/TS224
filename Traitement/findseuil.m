function [seuil] = findseuil(trame)
% 1.Construction de la matrice de Hankel
    % Paramètres de la matrice de Hankel 
    N = length(trame);    %Longueur de la trame
    L = floor(N/2);             % Nombre de lignes 

    % matrice de Hankel
    Hy = hankel(trame(1:L), trame(L:N));
    [~, S, ~] = svd(Hy);

% 2.Décomposition en valeurs singulières (SVD)
    seuil=max(diag(S));

end
