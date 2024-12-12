#include <stdio.h>
#include <stdint.h>
#include <time.h>

FILE *fptr;
char savingString[256];


void saveSmth(char *str){
    fptr = fopen("test+=48.txt", "a");
    fprintf(fptr, str);
    fclose(fptr);
    sprintf(savingString, "");
    return;
}


uint_fast64_t periodCalculation(int n, uint_fast64_t startinNumber)
{
    uint_fast64_t counter = 0;
    uint_fast64_t arr = startinNumber;
    do {
        counter++;
        uint_fast64_t bit0 = arr & 1;            // Extract the least significant bit
        uint_fast64_t bit1 = (arr & 2) >> 1;     // Extract the second least significant bit
        uint_fast64_t swapXor = (bit0 ^ bit1) << n; // Compute the XOR and shift
        arr = (arr >> 1) | swapXor;                       // Update arr
    } while (arr != startinNumber);
    
    return counter;
}




int main()
{

    sprintf(savingString, "");
    uint_fast64_t startingArr = 0b11;
    
    clock_t totbegin = clock();

    for(int n = 48; n <= 63; n++){

        clock_t nbegin = clock();

        uint_fast64_t counter = periodCalculation(n, startingArr);
        
        clock_t nend = clock();

        double ntime_spent = (double)(nend - nbegin) / CLOCKS_PER_SEC;

        sprintf(savingString, "%s\n%f s\n%d\t%llu", savingString, ntime_spent, n, counter);

        startingArr = (startingArr<<1) | 1;

        saveSmth(savingString);
        sprintf(savingString, "");

    }


    clock_t totend = clock();
    double time_spent = (double)(totend - totbegin) / CLOCKS_PER_SEC;
    sprintf(savingString, "%s\n\nTotal time spent: %f s", savingString, time_spent);
    // Saves computed data to file
    
    
    
    saveSmth(savingString);

    
    
    
    return 0;
}

