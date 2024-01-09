function [signal_bruite,sigmaB] = bruiter_signal(signal_parole, rsb_dB)
    % Générer un bruit blanc avec une variance appropriée en fonction du RSB
    bruit = randn(size(signal_parole));

    puissance_signal = mean(signal_parole.^2);
    puissance_bruit = puissance_signal / (10^(rsb_dB/10));
    bruit_ajuste = sqrt(puissance_bruit) * bruit;
    
    sigmaB=sqrt(puissance_bruit);

    % Bruiter le signal de parole
    signal_bruite = signal_parole + bruit_ajuste;
end

