function [Px] =Bartlett_test(x, nsubsequences)
    
    % Taille du segment 
    L = floor(length(x)/nsubsequences);
    Px = 0;
    n1 = 1;

    for i=1:nsubsequences
        Px = Px + periodogram(n1:n1+L-1)/nsubsequences;
        n1 =n1+1;
    
    end
end