function dsp_welch = my_welch(x,Nfft)
   
    L=floor(length(x)/Nfft);
    dsp_welch=zeros(L,Nfft);

    %Calcul des DSP des segments
    for i=0:L-1
        dsp_welch(i+1,:)=abs(fft(x(Nfft*i+1:Nfft*(i+1)))).^2;
    end
    %Calcul de la DSP du signal 
    dsp_welch=fftshift(mean(dsp_welch)/(Nfft));

end

