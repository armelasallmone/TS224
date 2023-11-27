function recSignal = reconstruction(Trames,Ls,Lt,nbT)
    %Reconstruction du signal
    recSignal=zeros(1,Ls);

    ham=hamming(Lt);
    
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

