import matplotlib.pyplot as plt
import numpy as np
import scipy.io

def afficher_periodogramme(signal, fs=1.0):
    """
    Affiche le périodogramme d'un signal.

    Args:
    signal (array-like): Le signal à analyser.
    fs (float): La fréquence d'échantillonnage du signal.
    """
    # Calcul de la densité spectrale de puissance
    freqs, psd = plt.psd(signal, NFFT=256, Fs=fs, noverlap=128)

    # Affichage du périodogramme
    plt.figure()
    plt.plot(freqs, psd)
    plt.title("Périodogramme du signal")
    plt.xlabel("Fréquence")
    plt.ylabel("Densité spectrale de puissance")
    plt.show()

# Exemple d'utilisation
data = scipy.io.loadmat('fcno03fz.mat')
signal = data['fcno03fz'].flatten()
afficher_periodogramme(signal, fs=1.0) 
