import tkinter as tk

RSB =""


def on_button_click(event):
    print("Le bouton a été cliqué!")


def on_enter_pressed(event):
    global RSB
    rsb_value = entry_rsb.get()
    
    try:
        rsb_value = int(rsb_value)
        if 5 <= rsb_value <= 20:
            RSB = rsb_value
            print(f"RSB saisi : {rsb_value}")
        else:
            print("Erreur : la valeur doit être entre 5 et 20.")
    except ValueError:
        print("Erreur : la valeur doit être un nombre entier.")
    


fenetre = tk.Tk()
fenetre.title("Ma fenêtre")
fenetre_width = 500
fenetre_height = 300
screen_width = fenetre.winfo_screenwidth()
screen_height = fenetre.winfo_screenheight()
x_offset = (screen_width - fenetre_width) // 2
y_offset = (screen_height - fenetre_height) // 2
fenetre.geometry(f"{fenetre_width}x{fenetre_height}+{x_offset}+{y_offset}")

###  Charger le signal
boutoncharger = tk.Button(fenetre, text="Charger le signal")
boutoncharger.pack()
boutoncharger.bind("<Button-1>", on_button_click)

###  Bruiter le signal
boutonbruiter = tk.Button(fenetre, text="Bruiter le signal")
boutonbruiter.pack()
boutonbruiter.bind("<Button-1>", on_button_click)

###  Recharcher le signal initial
boutonrecharger = tk.Button(fenetre, text="Recharcher le signal initial")
boutonrecharger.pack()
boutonrecharger.bind("<Button-1>", on_button_click)

###  Spectre de puissance
boutonbruiter = tk.Button(fenetre, text="Spectre de puissance")
boutonbruiter.pack()
boutonbruiter.bind("<Button-1>", on_button_click)

###  Periodogramme
boutonperiodogramme = tk.Button(fenetre, text="Periodogramme")
boutonperiodogramme.pack()
boutonperiodogramme.bind("<Button-1>", on_button_click)

###  Spectrogramme
boutonspectrogramme = tk.Button(fenetre, text="Spectrogramme")
boutonspectrogramme.pack()
boutonspectrogramme.bind("<Button-1>", on_button_click)

label_rsb = tk.Label(fenetre, text="RSB :")
label_rsb.pack()

entry_rsb = tk.Entry(fenetre)
entry_rsb.pack()
entry_rsb.bind("<Return>", on_enter_pressed)


fenetre.mainloop()




