
void unidades(char contUnidades);
void dezenas(char contDezenas);

char contUnidades = 0, contDezenas = 0;

void main() {

     CMCON = 0x07; // Desabilita os comparadores analogicos internos
     TRISB = 0X00; // Ou 0b00000000 Seleciona todo o portb como saída digital
     PORTB = 0X00; // Inicia todo o portb com nivel logico baixo
     
     
     while(1){
     
       contUnidades++;
       
       unidades(contUnidades);
       dezenas(contDezenas);
       
       if(contUnidades == 10){
         contDezenas++;
         contUnidades = 0;
         
         if(contDezenas == 10)
           contDezenas = 0;

         unidades(contUnidades);
         dezenas(contDezenas);
         
       }
       
       delay_ms(300);
     
     }

}

void unidades(char contUnidades){

     switch(contDezenas){
       case 0:
       RB0_bit = 0x00;
       RB1_bit = 0x00;
       RB2_bit = 0x00;
       RB3_bit = 0x00;
       break;
       case 1:
       RB0_bit = 0x01;
       RB1_bit = 0x00;
       RB2_bit = 0x00;
       RB3_bit = 0x00;
       break;
       case 2:
       RB0_bit = 0x00;
       RB1_bit = 0x01;
       RB2_bit = 0x00;
       RB3_bit = 0x00;
       break;
       case 3:
       RB0_bit = 0x01;
       RB1_bit = 0x01;
       RB2_bit = 0x00;
       RB3_bit = 0x00;
       break;
       case 4:
       RB0_bit = 0x00;
       RB1_bit = 0x00;
       RB2_bit = 0x01;
       RB3_bit = 0x00;
       break;
       case 5:
       RB0_bit = 0x01;
       RB1_bit = 0x00;
       RB2_bit = 0x01;
       RB3_bit = 0x00;
       break;
       case 6:
       RB0_bit = 0x00;
       RB1_bit = 0x01;
       RB2_bit = 0x01;
       RB3_bit = 0x00;
       break;
       case 7:
       RB0_bit = 0x01;
       RB1_bit = 0x01;
       RB2_bit = 0x01;
       RB3_bit = 0x00;
       break;
       case 8:
       RB0_bit = 0x00;
       RB1_bit = 0x00;
       RB2_bit = 0x00;
       RB3_bit = 0x01;
       break;
       case 9:
       RB0_bit = 0x01;
       RB1_bit = 0x00;
       RB2_bit = 0x00;
       RB3_bit = 0x01;
       break;
     }

}

void dezenas(char contDezenas){

     switch(contUnidades){
       case 0:
       RB4_bit = 0x00;
       RB5_bit = 0x00;
       RB6_bit = 0x00;
       RB7_bit = 0x00;
       break;
       case 1:
       RB4_bit = 0x01;
       RB5_bit = 0x00;
       RB6_bit = 0x00;
       RB7_bit = 0x00;
       break;
       case 2:
       RB4_bit = 0x00;
       RB5_bit = 0x01;
       RB6_bit = 0x00;
       RB7_bit = 0x00;
       break;
       case 3:
       RB4_bit = 0x01;
       RB5_bit = 0x01;
       RB6_bit = 0x00;
       RB7_bit = 0x00;
       break;
       case 4:
       RB4_bit = 0x00;
       RB5_bit = 0x00;
       RB6_bit = 0x01;
       RB7_bit = 0x00;
       break;
       case 5:
       RB4_bit = 0x01;
       RB5_bit = 0x00;
       RB6_bit = 0x01;
       RB7_bit = 0x00;
       break;
       case 6:
       RB4_bit = 0x00;
       RB5_bit = 0x01;
       RB6_bit = 0x01;
       RB7_bit = 0x00;
       break;
       case 7:
       RB4_bit = 0x01;
       RB5_bit = 0x01;
       RB6_bit = 0x01;
       RB7_bit = 0x00;
       break;
       case 8:
       RB4_bit = 0x00;
       RB5_bit = 0x00;
       RB6_bit = 0x00;
       RB7_bit = 0x01;
       break;
       case 9:
       RB4_bit = 0x01;
       RB5_bit = 0x00;
       RB6_bit = 0x00;
       RB7_bit = 0x01;
       break;
     }

}

