
unsigned int varreduraMemoria();
void salvaMemoria(unsigned char dado);
void apagaMemoria();
unsigned int ultimoGravado();

unsigned int ultimoDado;

void main() {

     ultimoDado = ultimoGravado();

     while(1){

         salvaMemoria(8);
         
         delay_ms(100);

     }

}

unsigned int varreduraMemoria(){

     unsigned char end;
     unsigned int i, aux;
     unsigned int cont = 0;
     
     for(i=0; i <= 128; i++){
     
       if(i < 128){
         end = EEPROM_Read(i);

         if(end == 0xFF){
           if(i == 0){
             aux = i;
             i = 128;
           }
           else if(i == 127){
             aux = i;
             i = 128;
           }
           else if(EEPROM_Read(i+1) == 0xFF){
             aux = i;
             i = 128;
           }
         }
        }
        else
          cont = 128;
     }

     if(cont == 128)
       aux = cont;

     return aux;
}

void salvaMemoria(unsigned char dado){

     unsigned int end;
     
     end = varreduraMemoria();    // Recebe o ultimo endereço gravado
     
     if(end == 128){
       apagaMemoria();
       end = 0;
     }

     EEPROM_Write(end, dado); // grava o dado no endereço
     
     delay_ms(25);  // Tempo de gravação
}

void apagaMemoria(){

     unsigned int i;
     
     for(i=0; i < 128; i++){
       EEPROM_Write(i, 0xFF);
       delay_ms(25);
     }
}

unsigned int ultimoGravado(){

     int end;
     unsigned int aux;
     
     end = varreduraMemoria();
     
     if(end == 128)
       aux = 127;
     else
       aux = end - 1;
       
     return aux;
}


