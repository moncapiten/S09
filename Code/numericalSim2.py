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

    '''
    string = f"["
    for i in range(len(arr)):
        if i == 0:
            string.join( {bcolors.OKGREEN}, str(arr[i]), {bcolors.ENDC } )
        elif i == len(arr)-1 or i == len(arr)-2:
            string.join( {bcolors.OKCYAN + str(arr[i]) + bcolors.ENDC} )
        else:
            string += str(arr[i])
        if i != len(arr)-1:
            string += ", "
    string += "]" + "      " + str(counter)
    print(string)
    '''

    startString = f"[{bcolors.OKGREEN}{arr[0]}{bcolors.ENDC}, "
    middleString = "".join([f"{a}, " for a in arr[1:-2]])
    endString = f"{bcolors.OKCYAN}{arr[-2]}{bcolors.ENDC}, {bcolors.OKCYAN}{arr[-1]}{bcolors.ENDC}]"
    print(startString + middleString + endString + "      " + str(counter))


# number of bits we will work with
cycles = []

n =4



for n in range(1, 15):

    print(n)
    # creating starting conditions
    arr = [ 1 for i in range(n+1) ]
    counter = 0

    #print(str(arr) + "      " + str(counter))


    while True:
        swap = arr[-1] ^ arr[-2]
        for i in range(len(arr)-1, 0, -1):
            arr[i] = arr[i - 1]
        arr[0] = swap

        counter += 1
    #    fancyprint(arr, counter)

#        if arr == [ 1 for i in range(len(arr)) ]:
#            break
        if sum(arr) == n+1:
            break
    cycles.append(counter+1)


print(cycles)















'''
    for i in range(n - 1):
        arr[i] = arr[i] ^ arr[i + 1]
    print(arr)
'''