// Inclusão de arquivos
#include "MCU_H.h"
#include "DELAY_H.h"

void delay_ms(unsigned int delayms){
    
    unsigned int i;
    unsigned long j;
    
    for(i = 0; i < delayms; i++)
        for(j = 0; j < _MCU_FREQ/65200; j++);
            
}
