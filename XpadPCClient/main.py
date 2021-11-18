# Press ⌃R to execute it or replace it with your code.
# Press Double ⇧ to search everywhere for classes, files, tool windows, actions, and settings.


# Press the green button in the gutter to run the script.
import socket
import time
import subprocess
import sys
import re

sys.path.insert(0, './lib/vgamepad')
import vgamepad as vg

Commands = [
    "Up",
    "Down",
    "Left",
    "Right",
    "A",
    "B",
    "X",
    "Y",
    "Back",
    "Start",
    "LB",
    "RB",
    "LT",
    "RT",
    "Str"
]

def parseCommand(input):
    input = input.decode()
    if len(input) == 0:
        return{"Command":None, "Value":None}
    if '><' in input:
        return {"Command":None, "Value":None}

    cmd = re.search('<(.*?)>', input).group(1)
    value = re.search('<{cmd}>(.*?)</{cmd}>'.format(cmd=cmd), input).group(1)
    return {"Command":cmd, "Value":value}


def sendCommandtoController(cmdDict, controller):
    if not cmdDict:
        return
    else:
        cmd = cmdDict["Command"]
        value = cmdDict["Value"]

        if cmd == "Up":
            if value == "Press":
                controller.press_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_DPAD_UP)
            if value == "Release":
                controller.release_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_DPAD_UP)
        if cmd == "Down":
            if value == "Press":
                controller.press_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_DPAD_DOWN)
            if value == "Release":
                controller.release_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_DPAD_DOWN)
        if cmd == "Left":
            if value == "Press":
                controller.press_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_DPAD_LEFT)
            if value == "Release":
                controller.release_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_DPAD_LEFT)
        if cmd == "Right":
            if value == "Press":
                controller.press_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_DPAD_RIGHT)
            if value == "Release":
                controller.release_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_DPAD_RIGHT)
        if cmd == "A":
            if value == "Press":
                controller.press_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_A)
            if value == "Release":
                controller.release_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_A)
        if cmd == "B":
            if value == "Press":
                controller.press_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_B)
            if value == "Release":
                controller.release_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_B)
        if cmd == "X":
            if value == "Press":
                controller.press_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_X)
            if value == "Release":
                controller.release_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_X)
        if cmd == "Y":
            if value == "Press":
                controller.press_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_Y)
            if value == "Release":
                controller.release_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_Y)
        if cmd == "Back":
            if value == "Press":
                controller.press_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_BACK)
            if value == "Release":
                controller.release_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_BACK)
        if cmd == "Start":
            if value == "Press":
                controller.press_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_START)
            if value == "Release":
                controller.release_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_START)
        if cmd == "LB":
            if value == "Press":
                controller.press_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_LEFT_THUMB)
            if value == "Release":
                controller.release_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_LEFT_THUMB)
        if cmd == "RB":
            if value == "Press":
                controller.press_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_RIGHT_THUMB)
            if value == "Release":
                controller.release_button(button=vg.XUSB_BUTTON.XUSB_GAMEPAD_RIGHT_THUMB)
        if cmd == "LT":
            value = float(value)
            controller.left_trigger_float(value_float=value)
        if cmd == "RT":
            value = float(value)
            controller.right_trigger_float(value_float=value)
        if cmd == "Str":
            value = float(value)
            controller.left_joystick_float(x_value_float=value, y_value_float=0.0)

        controller.update()


if __name__ == '__main__':
    gamepad = vg.VX360Gamepad()
    gamepad.register_callback()
    localPort = 23399
    remotePort = 5050

    cmd = "python tcprelay.py {rp}:{lp}".format(rp=remotePort, lp=localPort)
    #cmd = "tidevice relay -x {lp} {rp}".format(rp=remotePort, lp=localPort)
    p = subprocess.Popen(cmd, shell=True)

    s = socket.socket()
    host = socket.gethostname()

    s.connect((host, localPort))

    l = []
    while True:
        dat = ""
        dat = s.recv(1024)
        if dat:
            cmdDict = parseCommand(dat)
            print(cmdDict)
            sendCommandtoController(cmdDict=cmdDict, controller=gamepad)
            if dat.decode() == "<SIG>Close Connection</SIG>":
                s.close()
                exit(1)

















#
