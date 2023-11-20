function recSignal = decomposition(signal,Lt)
    %Décomposition en Trame
    Ls=length(signal);
    nbT =floor(2*Ls/Lt - 2);
    ham=hamming(Lt);
    Trames=zeros(nbT,Lt);

    tmpS=1;
    for i=1:nbT-1
        Trames(i,:)=signal(tmpS:tmpS+Lt-1);
        Trames(i,:)=Trames(i,:).*ham';
        tmpS=tmpS+Lt/2;
    end

    %Reconstruction du signal
    recSignal=zeros(1,Ls);
    
    for t=1:nbT-1
        for x=1:Lt/2
            xk1=Trames(t,Lt/2+x);
            xk2=Trames(t+1,x);
            w1=ham(Lt/2+x);
            w2=ham(x);
            recSignal(t*Lt/2+x)=(xk1+xk2)/(w1+w2);
        end
    end

end

