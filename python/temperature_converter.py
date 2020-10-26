# -*- coding: utf-8 -*-

## Function: Tutorail of Tkinter, Fahrenheit convet to Celsius
## Knowledge point:
##    1. grid manager
##    2. Iteractive using command
##  code refer to https://realpython.com/python-gui-tkinter/#building-a-text-editor-example-app

import tkinter as tk

def fahrenheit_to_celsius():
  """Convert the value for Fahrenheit to Celsius and insert the result to
  into lbl_result.
  """
  fahrenheit  = ent_temperature.get()
  if not fahrenheit : 
    return
  celsius = (5/9) * (float(fahrenheit)  - 32)
  lbl_result["text"] = f"{round(celsius,2)} \N{DEGREE CELSIUS}"

# set-up the window
window = tk.Tk()
window.title("Temperature Converter")
window.resizable(width=False,height=False)

# Create the Fahrenheit entry frame with an Entry
# widget and label in it.
frm_entry = tk.Frame(master=window)
ent_temperature = tk.Entry(master=frm_entry,width=10)
lbl_temp = tk.Label(master=frm_entry,text="\N{DEGREE FAHRENHEIT}") 

# Layout the temperature Entry and Label in frm_entry
# using the .grid() geometry manager
ent_temperature.grid(row=0,column=0,sticky="e")
lbl_temp.grid(row=0,column=1,sticky="w")

# Create the conversion Button and result display Label
btn_convert = tk.Button(
  master=window,
  text="\N{RIGHTWARDS BLACK ARROW}",
  command=fahrenheit_to_celsius
)
lbl_result = tk.Label(master=window,text=u"\N{DEGREE CELSIUS}")

# set-up the layout using the .grid() geometry nanager
frm_entry.grid(row=0,column=0,padx=10)
btn_convert.grid(row=0,column=1,padx=10)
lbl_result.grid(row=0,column=2,padx=10)

# Run the application
window.mainloop()