function Trames = decomposition(signal,Lt,nbT)
    %Décomposition en Trame
    
    ham=hamming(Lt);
    Trames=zeros(nbT,Lt);

    tmpS=1;
    for i=1:nbT-1
        Trames(i,:)=signal(tmpS:tmpS+Lt-1);
        Trames(i,:)=Trames(i,:).*ham';
        tmpS=tmpS+Lt/2;
    end

end

