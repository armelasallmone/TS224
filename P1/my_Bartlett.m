function dsp_bartlett = my_Bartlett(signal, taille_segment)
    N = length(signal);
    nb_segments = floor(N / taille_segment);
    dsp_bartlett = zeros(taille_segment, 1);

    for k = 1:nb_segments
        debut = (k-1) * taille_segment + 1;
        fin = debut + taille_segment - 1;
        segment = signal(debut:fin);
        dsp_bartlett = dsp_bartlett + abs(fftshift(fft(segment))).^2 / taille_segment;
    end
    
    dsp_bartlett = dsp_bartlett / nb_segments;
end

