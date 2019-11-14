#! /usr/bin/python

import socket
import random
import time

UDP_IP = "127.0.0.1"
UDP_PORT = 57222

sock = socket.socket(socket.AF_INET, # Internet
                     socket.SOCK_DGRAM) # UDP
#sock.bind((UDP_IP, UDP_PORT)) #Receiver

messages=["elevator_1", "elevator_2", "stair_1", "stair_2", "stair_3", "stair_4", "stair_5", "stair_6"]

def elev_1():
    sock.sendto(messages[0], (UDP_IP, UDP_PORT))

def elev_2():
    sock.sendto(messages[1], (UDP_IP, UDP_PORT))

def stair_1():
    sock.sendto(messages[2], (UDP_IP, UDP_PORT))

def stair_2():
    sock.sendto(messages[3], (UDP_IP, UDP_PORT))

def stair_3():
    sock.sendto(messages[4], (UDP_IP, UDP_PORT))

def stair_4():
    sock.sendto(messages[5], (UDP_IP, UDP_PORT))


def stair_5():
    sock.sendto(messages[6], (UDP_IP, UDP_PORT))

def stair_6():
    sock.sendto(messages[7], (UDP_IP, UDP_PORT))

def mic():
    r = random.randint(0, 4095)
    sock.sendto(str(r), (UDP_IP, UDP_PORT))

if __name__ == "__main__":
    while True:
        r = random.randint(0, 9)
        if r == 0:
            elev_1()
        elif r == 1:
            elev_2()
        elif r == 3:
            stair_1()
        elif r == 4:
            stair_2()
        elif r == 5:
            stair_3()
        elif r == 6:
            stair_4()
        elif r == 7:
            stair_5()
        elif r == 8:
            stair_6()
        else:
            mic()
        time.sleep(random.random())
