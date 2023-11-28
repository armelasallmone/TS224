import numpy as np
import matplotlib.pyplot as plt
import scipy.io

def correlogram(signal):
    N = len(signal) # Taille du signal
    autocorr_signal = np.correlate(signal, signal, 'full')  # Autocorrélation
    dsp_correlogram = np.abs(np.fft.fftshift(np.fft.fft(autocorr_signal)))  # DSP par FFT
    dsp_correlogram = dsp_correlogram[N-1:]  # Prendre la moitié du spectre

    return dsp_correlogram


data = scipy.io.loadmat('fcno03fz.mat') 
signal = data['fcno03fz'].flatten()  # Convertir en vecteur 1D si nécessaire

# Calcul et affichage du correlogramme
dsp_correlogram = correlogram(signal)
plt.plot(dsp_correlogram)
plt.title("Corrélogramme")
plt.xlabel("Fréquence")
plt.ylabel("Amplitude")
plt.show()
