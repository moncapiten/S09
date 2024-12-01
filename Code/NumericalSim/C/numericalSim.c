#include <stdio.h>
#include <time.h>

#define BYTE_TO_BINARY_PATTERN "%c%c%c%c%c%c%c%c"
#define BYTE_TO_BINARY(byte)  \
  ((byte) & 0x80 ? '1' : '0'), \
  ((byte) & 0x40 ? '1' : '0'), \
  ((byte) & 0x20 ? '1' : '0'), \
  ((byte) & 0x10 ? '1' : '0'), \
  ((byte) & 0x08 ? '1' : '0'), \
  ((byte) & 0x04 ? '1' : '0'), \
  ((byte) & 0x02 ? '1' : '0'), \
  ((byte) & 0x01 ? '1' : '0') 

FILE *fptr;
char savingString[256];

int main()
{
    sprintf(savingString, "");
    unsigned long long int startingArr = 0b11;
    unsigned long long int arr = startingArr;
    
    clock_t totbegin = clock();
    for(unsigned long long int n = 1; n <= 32; n++){
        unsigned long long int counter = 1;
        
        
//        printf("--------\n n= %llu\n", n);
//        printf(BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY( arr ));
//        printf("\n");
        do{
            
            counter++;
            // XOR of last two places and reinserting in the beginning
            unsigned long long int swapXor = ( ( (arr & 0b10) >> 1 ) ^ ( arr & 0b1 ) ) << n;
            arr = ( arr >> 1 ) | swapXor;
            
//            printf(BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY( arr ));
//            printf("\n");
            
        } while ( (arr ^ startingArr) != 0);
        
        printf("\nIt took %llu cycles\n", counter);
        sprintf(savingString, "%s\n%llu\t%llu", savingString, n, counter);
        
        startingArr = (startingArr<<1)+1;
        arr = startingArr;

/*      // Saves computed data to file
        fptr = fopen("test2.txt", "a");
        fprintf(fptr, savingString);
        fclose(fptr);
        sprintf(savingString, "");*/
    }
    clock_t totend = clock();
    double time_spent = (double)(totend - totbegin) / CLOCKS_PER_SEC;
    sprintf(savingString, "%s\nTotal time spent: %f s", savingString, time_spent);
    // Saves computed data to file
    fptr = fopen("test2.txt", "a");
    fprintf(fptr, savingString);
    fclose(fptr);
    sprintf(savingString, "");

    
    
    
    return 0;
}


