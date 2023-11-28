import numpy as np
import scipy.io
import matplotlib.pyplot as plt

def bruiter_signal(signal_parole, rsb_dB):
    bruit = np.random.randn(*signal_parole.shape)
    puissance_signal = np.mean(signal_parole ** 2)
    puissance_bruit = puissance_signal / (10 ** (rsb_dB / 10))
    bruit_ajuste = np.sqrt(puissance_bruit) * bruit
    signal_bruite = signal_parole + bruit_ajuste
    return signal_bruite

# Charger le fichier .mat
data = scipy.io.loadmat('fcno03fz.mat')

# Extraire le signal à partir du fichier .mat
signal = data['fcno03fz']

# Demander à l'utilisateur de saisir le RSB
rsb_dB = float(input("Entrez le RSB en dB : "))

# Bruiter le signal avec le RSB spécifié
signal_bruite = bruiter_signal(signal, rsb_dB)

# Afficher le signal bruité
plt.plot(signal_bruite)
plt.title('Signal Bruité avec RSB de ' + str(rsb_dB) + ' dB')
plt.show()
