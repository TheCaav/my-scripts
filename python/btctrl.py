#!/usr/bin/env python3

import os
import subprocess

devices = {
        "BH001": "00:86:10:16:04:8E",
    "Au": "F4:4E:FD:59:4F:0A",
    "UE Boom": "C0:28:8D:37:04:49"
}

def buildKeyListForEcho(dic: dict):
    string = ""
    for key in dic:
        string += key + "\n"
    string = string[:-1]
    return string

if __name__=="__main__":
    deviceList = buildKeyListForEcho(devices)
    subprocess.run("bluetoothctl power on".split())
    process = subprocess.Popen("echo -e".split() + [deviceList], stdout=subprocess.PIPE)
    chosen = subprocess.check_output("dmenu -i".split(), stdin=process.stdout, text=True)
    process.wait()
    deviceMAC = devices[chosen[:-1]]
    subprocess.run("bluetoothctl connect ".split() + [deviceMAC])
