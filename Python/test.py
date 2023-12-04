import matplotlib.pyplot as plt
import numpy as np
from scipy.io import loadmat
import tkinter as tk
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
from scipy import signal


#### INITIALISATION DES VARIABLES
    ### Charger le fichier MATLAB
signal_parole = loadmat('fcno03fz.mat')
data = signal_parole['fcno03fz'].squeeze()

# Calculer la moyenne et l'écart-type du signal de parole
mean = np.mean(data)
std = np.std(data)

rsb = 5  # Rapport signal à bruit


   

    ### Perriodogramme
N = 1000
Fs = 8000
f = np.linspace(-Fs/2, Fs/2, N)

def my_daniell(signal):
    L=10 #la largeur de la fenêtre
    N = len(signal)
    spectre_puissance = abs(np.fft.fftshift(np.fft.fft(signal)))**2 / N
    dsp_daniell = np.convolve(spectre_puissance, np.ones(L)/L, mode='same')
    return dsp_daniell



    ### Clean les fenêtres 
canvas = None

def clear_canvas():
    global canvas
    if canvas:
        canvas.get_tk_widget().destroy()
        canvas = None


#### FONCTIONS D'AFFICHAGE

def charger():
    # Clear previous plot if it exists
    clear_canvas()
    
    plt.clf()
    plt.plot(data)
    plt.title("Signal de parole original")
    plt.xlabel("Échantillons")
    plt.ylabel("Amplitude")

    # Create a new canvas widget and pack it
    global canvas
    canvas = FigureCanvasTkAgg(plt.gcf(), master=fenetre)
    canvas.draw()
    canvas.get_tk_widget().pack()

def bruiter():
    # Générer un bruit additif avec un RSB donné
    bruit = np.random.normal(mean, std / rsb, len(data))

    # Bruiter le signal de parole
    signal_bruite = data + bruit

    # Clear previous plot if it exists
    clear_canvas()

    plt.clf()
    plt.plot(signal_bruite)
    plt.title(f"Signal de parole bruité (RSB = {rsb} dB)")
    plt.xlabel("Échantillons")
    plt.ylabel("Amplitude")

    # Create a new canvas widget and pack it
    global canvas
    canvas = FigureCanvasTkAgg(plt.gcf(), master=fenetre)
    canvas.draw()
    canvas.get_tk_widget().pack()


def dsp():
    ###  Spectre de puissance
    bruit = np.random.normal(mean, std / rsb, len(data))

    # Calcul du spectre en fréquence X(f)
    tf_white_noise = np.fft.fftshift(np.fft.fft(bruit))

    # Spectre de puissance |X(f)|^2
    spectre_puissance = np.abs(tf_white_noise)**2

    # Clear previous plot if it exists
    clear_canvas()

    plt.clf()
    plt.plot(spectre_puissance)
    plt.title("Spectre de puissance du bruit")
    plt.xlabel("Fréquence (Hz)")
    plt.ylabel("Puissance (dB)")

    # Create a new canvas widget and pack it
    global canvas
    canvas = FigureCanvasTkAgg(plt.gcf(), master=fenetre)
    canvas.draw()
    canvas.get_tk_widget().pack()


def periodogramme():
    bruit = np.random.normal(mean, std / rsb, len(data))
    
    # Calcul de DSP avec my_daniell
    dsp_daniell = my_daniell(bruit)

    # Fréquences associées aux DSP
    f_daniell = np.linspace(-Fs/2, Fs/2, len(dsp_daniell))

    # Clear previous plot if it exists
    clear_canvas()

    plt.clf()
    plt.plot(dsp_daniell)
    plt.title('Périodogramme de Daniell')
    plt.xlabel('Fréquence (Hz)')
    plt.ylabel('DSP')


    # Create a new canvas widget and pack it
    global canvas
    canvas = FigureCanvasTkAgg(plt.gcf(), master=fenetre)
    canvas.draw()
    canvas.get_tk_widget().pack()

def spectrogramme():
    # Clear previous plot if it exists
    clear_canvas()

    plt.clf()
    plt.specgram(data, NFFT=256, Fs=2000, noverlap=128)
    plt.title("Spectrogramme du signal")
    plt.xlabel("Temps")
    plt.ylabel("Fréquence")
    plt.colorbar(label='Intensité (dB)')


    # Create a new canvas widget and pack it
    global canvas
    canvas = FigureCanvasTkAgg(plt.gcf(), master=fenetre)
    canvas.draw()
    canvas.get_tk_widget().pack()



#### AFFICHAGE DE LA FENÊTRE
fenetre = tk.Tk()
fenetre.title("Ma fenêtre")
fenetre_width = 800
fenetre_height = 500
screen_width = fenetre.winfo_screenwidth()
screen_height = fenetre.winfo_screenheight()
x_offset = (screen_width - fenetre_width) // 2
y_offset = (screen_height - fenetre_height) // 2
fenetre.geometry(f"{fenetre_width}x{fenetre_height}+{x_offset}+{y_offset}")

###  Charger le signal
boutoncharger = tk.Button(fenetre, text="Charger le signal", command=charger)
boutoncharger.pack()

###  Bruiter le signal
boutonbruiter = tk.Button(fenetre, text="Bruiter le signal", command=bruiter)
boutonbruiter.pack()

###  Recharcher le signal initial
boutonrecharger = tk.Button(fenetre, text="Recharcher le signal initial", command=charger)
boutonrecharger.pack()


###  Spectre de puissance
boutonbruiter = tk.Button(fenetre, text="Spectre de puissance",command=dsp)
boutonbruiter.pack()


###  Periodogramme
boutonperiodogramme = tk.Button(fenetre, text="Periodogramme",command=periodogramme)
boutonperiodogramme.pack()


###  Spectrogramme
boutonspectrogramme = tk.Button(fenetre, text="Spectrogramme",command=spectrogramme)
boutonspectrogramme.pack()

### RSB
label_rsb = tk.Label(fenetre, text="RSB :")
label_rsb.pack()

def on_enter_pressed(event):
    global rsb
    rsb_value = entry_rsb.get()
    
    try:
        rsb_value = int(rsb_value)
        if 5 <= rsb_value <= 20:
            rsb = rsb_value
            print(f"RSB saisi : {rsb_value}")
        else:
            print("Erreur : la valeur doit être entre 5 et 20.")
    except ValueError:
        print("Erreur : la valeur doit être un nombre entier.")

entry_rsb = tk.Entry(fenetre)
entry_rsb.pack()
entry_rsb.bind("<Return>", on_enter_pressed)


fenetre.mainloop()




