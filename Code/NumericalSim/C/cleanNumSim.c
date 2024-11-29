#include <stdio.h>
#include <time.h>

FILE *fptr;
char savingString[256];


void saveSmth(char *str){
    fptr = fopen("test2.txt", "a");
    fprintf(fptr, str);
    fclose(fptr);
    sprintf(savingString, "");
    return;
}


unsigned long long int periodCalculation(int n, unsigned long long int startinNumber)
{
    unsigned long long int counter = 0;
    unsigned long long int arr = startinNumber;
    do {
        counter++;
        unsigned long long int bit0 = arr & 1;            // Extract the least significant bit
        unsigned long long int bit1 = (arr & 2) >> 1;     // Extract the second least significant bit
        unsigned long long int swapXor = (bit0 ^ bit1) << n; // Compute the XOR and shift
        arr = (arr >> 1) | swapXor;                       // Update arr
    } while (arr != startinNumber);
    
    return counter;
}




int main()
{

    sprintf(savingString, "");
    unsigned long long int startingArr = 0b11;
    
    clock_t totbegin = clock();

    for(int n = 1; n <= 63; n++){

        unsigned long long int counter = periodCalculation(n, startingArr);

        sprintf(savingString, "%s\n%d\t%llu", savingString, n, counter);
        
        startingArr = (startingArr<<1) | 1;

        saveSmth(savingString);
        sprintf(savingString, "");

    }


    clock_t totend = clock();
    double time_spent = (double)(totend - totbegin) / CLOCKS_PER_SEC;
    sprintf(savingString, "%s\nTotal time spent: %f s", savingString, time_spent);
    // Saves computed data to file
    
    
    
    saveSmth(savingString);

    
    
    
    return 0;
}

