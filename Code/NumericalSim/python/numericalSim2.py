import numpy as np
import matplotlib.pyplot as plt


def fancyprint(arr, counter):
    class bcolors:
        HEADER = '\033[95m'
        OKBLUE = '\033[94m'
        OKCYAN = '\033[96m'
        OKGREEN = '\033[92m'
        WARNING = '\033[93m'
        FAIL = '\033[91m'
        ENDC = '\033[0m'
        BOLD = '\033[1m'
        UNDERLINE = '\033[4m'

    startString = f"[{bcolors.OKGREEN}{arr[0]}{bcolors.ENDC}, "
    middleString = "".join([f"{a}, " for a in arr[1:-2]])
    endString = f"{bcolors.OKCYAN}{arr[-2]}{bcolors.ENDC}, {bcolors.OKCYAN}{arr[-1]}{bcolors.ENDC}]"
    print(startString + middleString + endString + "      " + str(counter))


# number of bits we will work with
cycles = []



for n in range(1, 17 ):

    print(f"n = {n}")
    # creating starting conditions
    arr = [ 1 for i in range(n+1) ]
    sequence = []
    counter = 0

    print(str(arr) + "      " + str(counter))


    while True:
        swap = arr[-1] ^ arr[-2]
        for i in range(len(arr)-1, 0, -1):
            arr[i] = arr[i - 1]
#            print(i)
        arr[0] = swap
        sequence.append(swap)

        counter += 1
        fancyprint(arr, counter)

        if sum(arr) == n+1:
            break
    cycles.append(counter+1)

    f = open("sequences.txt", "a")
    swapSequence = ""
    for i in sequence:
        swapSequence += str(i)
    
    sequence = swapSequence

    f.write(str(n) + "\t" + sequence + "\n")
    f.close()

print(cycles)


