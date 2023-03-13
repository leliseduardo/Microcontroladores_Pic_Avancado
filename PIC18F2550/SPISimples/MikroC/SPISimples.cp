#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/SPISimples/MikroC/SPISimples.c"
#line 12 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/SPISimples/MikroC/SPISimples.c"
sbit Chip_Select at RC0_bit;
sbit Chip_Select_Direction at TRISC0_bit;







void leitura_Botoes();


unsigned char flagBotoes = 0x00;

unsigned short valor = 0x00,
 dado = 0x01;

void main() {

 ADCON1 = 0x0F;

 Chip_Select = 1;
 Chip_Select_Direction = 0;
 SPI1_Init();



 while(1){

 leitura_Botoes();

 Chip_Select = 0;

 SPI1_Write(valor);

 Chip_Select = 1;
 delay_ms(1);

 }

}



void leitura_Botoes(){

 if(! RB7_bit ) flagBotoes.B0 = 0x01;
 if(! RB6_bit ) flagBotoes.B1 = 0x01;

 if( RB7_bit  && flagBotoes.B0){

 flagBotoes.B0 = 0x00;
 dado++;

 if(dado > 0x05) dado = 0x01;

 }

 if( RB6_bit  && flagBotoes.B1){

 flagBotoes.B1 = 0x00;
 dado--;

 if(dado < 1) dado = 0x05;

 }

 switch(dado){

 case 0x01: valor = 0x01;
 break;
 case 0x02: valor = 0x02;
 break;
 case 0x03: valor = 0x72;
 break;
 case 0x04: valor = 0xBD;
 break;
 case 0x05: valor = 0xAA;
 break;

 }

}
