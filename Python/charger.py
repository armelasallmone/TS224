import scipy.io
import numpy as np
import matplotlib.pyplot as plt

def afficher_signal():
    # Charger le fichier .mat
    data = scipy.io.loadmat('fcno03fz.mat')
    
    # Extraire le signal à partir du fichier .mat
    signal = data['fcno03fz']
    
    # Créer un tableau de temps en fonction du nombre d'échantillons
    temps = np.arange(signal.shape[0])
    
    # Afficher le signal original
    plt.figure(figsize=(10, 6))
    plt.plot(temps, signal)
    plt.title("Signal original")
    plt.xlabel("Temps")
    plt.ylabel("Amplitude")
    
    plt.show()

# Utilisation de la fonction
afficher_signal()
