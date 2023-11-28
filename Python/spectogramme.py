import matplotlib.pyplot as plt
import scipy.io


def afficher_spectrogramme(signal):
    
    # Vérifier si le signal est unidimensionnel
    if signal.ndim != 1:
        raise ValueError("Le signal doit être unidimensionnel.")

    # Calculer et afficher le spectrogramme
    plt.figure()
    plt.specgram(signal, NFFT=256, Fs=2000, noverlap=128)
    plt.title("Spectrogramme du signal")
    plt.xlabel("Temps")
    plt.ylabel("Fréquence")
    plt.colorbar(label='Intensité (dB)')
    plt.show()


data = scipy.io.loadmat('fcno03fz.mat')
signal = data['fcno03fz'].flatten()
afficher_spectrogramme(signal)