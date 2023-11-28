import numpy as np
import scipy.io
import matplotlib.pyplot as plt

def bruiter_signal(signal_parole, rsb_dB):
    bruit = np.random.randn(*signal_parole.shape)
    puissance_signal = np.mean(signal_parole ** 2)
    puissance_bruit = puissance_signal / (10 ** (rsb_dB / 10))
    bruit_ajuste = np.sqrt(puissance_bruit) * bruit
    return signal_parole + bruit_ajuste

def afficher_spectre_puissance(signal):
    fft_signal = np.fft.fft(signal)
    spectre_puissance = np.abs(fft_signal) ** 2
    frequences = np.fft.fftfreq(len(signal), d=0.5)  # Ajustez selon la fréquence d'échantillonnage
    plt.plot(frequences, spectre_puissance)
    plt.title('Spectre de Puissance')
    plt.xlabel('Fréquence (Hz)')
    plt.ylabel('Puissance')
    plt.show()

# Charger le fichier .mat
data = scipy.io.loadmat('fcno03fz.mat')
signal = data['fcno03fz']

# Demander à l'utilisateur de saisir le RSB
rsb_dB = float(input("Entrez le RSB en dB : "))

# Bruiter le signal avec le RSB spécifié
signal_bruite = bruiter_signal(signal, rsb_dB)

# Afficher le spectre de puissance du signal bruité
afficher_spectre_puissance(signal_bruite)





"""import numpy as np
import matplotlib.pyplot as plt

def afficher_spectre_puissance(signal):
    
    # Calculer la FFT
    fft_signal = np.fft.fft(signal)
    
    # Calculer le spectre de puissance
    spectre_puissance = np.abs(fft_signal) ** 2

    # Fréquences pour l'axe horizontal
    N = len(signal)
    frequences = np.fft.fftfreq(N, d=1.0)  # Remplacer 1.0 par votre intervalle de temps entre les échantillons si différent

    # Afficher le spectre de puissance
    plt.plot(frequences, spectre_puissance)
    plt.title('Spectre de Puissance du Signal')
    plt.xlabel('Fréquence (Hz)')
    plt.ylabel('Puissance')
    plt.show()


  data = scipy.io.loadmat('fcno03fz.mat')
  signal = data['fcno03fz']
  afficher_spectre_puissance(signal)
"""