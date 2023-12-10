function dsp_bartlett = my_Bartlett(signal, M)
    
    N = length(signal); % Signal de taille N
    K = floor(N / M);   % K segemnts de taille M
    dsp_bartlett = zeros(M, 1);

    for k = 1:K
        debut = (k-1) * M + 1;
        fin = debut + M - 1;
        segment = signal(debut:fin);
        dsp_bartlett = dsp_bartlett + abs(fftshift(fft(segment))).^2 / M;
    end
    
    dsp_bartlett = dsp_bartlett / K;
end

