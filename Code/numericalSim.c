#include <stdio.h>

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
    int startingArr = 0b11;
    int arr = startingArr;
    
    
    for(int n = 1; n <= 35; n++){
        int counter = 1;
        
        
        printf("--------\n n= %d\n", n);
        printf(BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY( arr ));
//        printf("\n");
        
        do{
            counter++;
            // XOR of last two places and reinserting in the beginning
            int swapXor = ( ( (arr & 0b10) >> 1 ) ^ ( arr & 0b1 ) ) << n;
            arr = ( arr >> 1 ) | swapXor;
            
//            printf(BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY( arr ));
//            printf("\n");
            
        } while (arr != startingArr);
        
        printf("\nIt took %d cycles\n", counter);
        sprintf(savingString, "%s\n%d\t%d", savingString, n, counter);
        
        startingArr = (startingArr<<1)+1;
        arr = startingArr;
    }
    
    // Saves computed data to file
    fptr = fopen("output.txt", "w");
    fprintf(fptr, savingString);
    fclose(fptr);
    
    return 0;
}


