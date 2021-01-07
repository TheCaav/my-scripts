import sys
import subprocess 
import os
import time


TIMEOUT = 2 * 60 * 60 # 2 hour timeout
devices = {
    "10.10.10.1" : "WGRouter",
    "lappy2" : "MyLaptop" # hostname only works if the ip is in /etc/hosts and correct
}
lastSeens = {}
for device in devices:
    lastSeens[device] = 0

while True:
    for device in devices:
        try:
            output = subprocess.check_output("ping -c 1 -W 1".split() + [device], text=True)
        except:
            output = "Doesnt matter its just not up"
        if "1 received" in output: # if device received package it is connected
            if lastSeens[device] + TIMEOUT < time.time():
                subprocess.run(["notify-send", "{} is connected".format(devices[device])])
        lastSeens[device] = time.time()
    time.sleep(5)
