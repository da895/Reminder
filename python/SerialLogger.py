## Serial Port Logger Application

# We can't do any thing without Serial
try:
    import serial
except (ImportError):
    msg = """ERROR: pyserial library not found
    Install pyserial library
    pip install pyserial"""
    print(msg)
    exit(1)
  
import os
from datetime import datetime
import math
import re
import binascii
import pyvisa as visa
import sys
from ctypes import *

# Other Imports
import logging, time
from signal import signal, SIGINT
from sys import exit
from queue import Queue,Empty

# Port Configuration
PORT = "COM6"
BAUD = 115200
logFileName='serial.log'
q = Queue(2)

def QueryTemp_Espec(addr ='TCPIP0::xx.x.xx.xx::57732::SOCKET') :
	#Temp_Value=like '-40.0','25.0','85.0',OnOff='POWER,ON' or 'POWER,OFF'
	rm = visa.ResourceManager()
	espec_su662_addr = addr
	SU662 = rm.open_resource(espec_su662_addr)
	SU662.write_termination = '\r\n'
	SU662.read_termination = '\r\n'
	try:
		fb0 = SU662.query('TEMP?')
	except:
		fb0 = "Unconnected!"
	time.sleep(1)
	SU662.close()
	return fb0

def setupLogger(filename):    
    logger = logging.getLogger('Serial Logger')
    logger.setLevel(logging.DEBUG)
    # create file handler which logs even debug messages
    fh = logging.FileHandler(filename)
    fh.setLevel(logging.DEBUG)
    # create console handler with a higher log level
    ch = logging.StreamHandler()
    ch.setLevel(logging.DEBUG)
    # create formatter and add it to the handlers
    formatter = logging.Formatter('%(asctime)s ~ %(name)s ~ %(levelname)s ~ %(message)s')
    fh.setFormatter(formatter)
    ch.setFormatter(formatter)
    # add the handlers to the logger
    logger.addHandler(fh)
    logger.addHandler(ch)
    # Return the Created logger
    return logger

def main(qSignal):
    ## Logger Configuration
    global logFileName
    log = setupLogger(logFileName)
    ## Begin
    log.info("Program Started")
    ser = None
    # try:
    #     ser = serial.Serial(PORT, BAUD, timeout=1)
    # except Exception as e:
    #     log.error("Got Fatal error - {}".format(e))
    #     exit(4)
    # Loop for Reception
    while 1:
        ## Ctrl+C signal
        try:
            squit = qSignal.get(block=False, timeout=0.1)
        except Empty as e:
            squit = False            
        if squit == True:
            log.info("Exiting")
            ser.close()
            exit(0)
        # Get Data
        try:
            #data = ser.readline().decode('utf-8')
            data = QueryTemp_Espec()
            if len(data) > 0:
                #log.info(QueryTemp_Espec())
                log.info(data)
        except KeyboardInterrupt as e:
            q.put(True)
            log.info("Ctrl + C pressed")
        time.sleep(20)
    
    
def handler(signal_received, frame):
    # Handle any cleanup here
    print('SIGINT or CTRL-C detected. Exiting gracefully')
    q.put(True)
    

if __name__ == "__main__":
    signal(SIGINT, handler)
    print('Running. Press CTRL-C to exit.')
    main(q)    
