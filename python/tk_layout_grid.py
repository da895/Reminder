# -*- coding: utf-8 -*-

## Function: Tutorail of Tkinter, Layout based on grid
## Knowledge point:
##    1. grid manager
##  code refer to https://realpython.com/python-gui-tkinter/#building-a-text-editor-example-app

import tkinter as tk

window = tk.Tk()

for i in range(3):
  window.columnconfigure(i,weight=1,minsize=75)
  window.rowconfigure(i,weight=1,minsize=50)

  for j in range(0,3):
    frame = tk.Frame(
      master=window,
      relief=tk.RAISED,
      borderwidth=1
    )
    frame.grid(row=i,column=j,padx=5,pady=5)

    btn = tk.Button(master=frame,text=f"Row {i}\nColumn {j}")
    btn.pack()



for i in range(3,6):
  #window.columnconfigure(i,weight=1,minsize=75)
  window.rowconfigure(i,weight=1,minsize=50)

  for j in range(0,3):
    frm_lbl = tk.Frame(
      master=window,
      relief=tk.RAISED,
      borderwidth=1
    )
    frm_lbl.grid(row=i,column=j,padx=5,pady=5)

    lbl = tk.Label(master=frm_lbl,text=f"Row {i}\nColumn {j}")
    lbl.pack()
    #btn.pack(padx=5,pady=5)


window.mainloop()