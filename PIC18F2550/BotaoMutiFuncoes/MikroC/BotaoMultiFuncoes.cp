#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/BotaoMutiFuncoes/MikroC/BotaoMultiFuncoes.c"
#line 32 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/BotaoMutiFuncoes/MikroC/BotaoMultiFuncoes.c"
void leitura_Botao();


bit flagBotao;
bit ativaAjuste;
unsigned short duty = 128;
unsigned short cont = 0x00;
unsigned short i;

void main() {

 ADCON1 = 0x0F;
 TRISB = 0xFE;
 PORTB = 0xFE;
 LATB = 0xFE;

 INTCON2.B7 = 0x00;

 T0CON = 0x84;
 TMR0L = 0xEE;
 TMR0H = 0x85;

 flagBotao = 0;
 ativaAjuste = 0;

 PWM1_Init(1500);
 PWM1_Start();


 while(1){

 if(TMR0IF_bit){

 TMR0IF_bit = 0x00;
 TMR0L = 0xEE;
 TMR0H = 0x85;

 if(! RB7_bit  && flagBotao) cont++;
 else cont = 0x00;

 if(cont == 0x08){

 cont = 0x00;
 ativaAjuste = ~ativaAjuste;

 for(i = 0x00; i < 0x0A; i++){

  LATB0_bit  = ~ LATB0_bit ;
 delay_ms(50);

 }

  LATB0_bit  = 0x00;

 }

 }

 leitura_Botao();
 PWM1_Set_Duty(duty);



 }

}


void leitura_Botao(){

 if(! RB7_bit ) flagBotao = 0x01;

 if( RB7_bit  && flagBotao){

 flagBotao = 0x00;

 if(ativaAjuste) duty += 0x0A;
 else  LATB0_bit  = ~ LATB0_bit ;

 }

}
