/* 

   Clock = 4MHz, Ciclo de máquina = 1us
   
   Overflow = Ciclo de maquina x prescaler x TMR0
   Overflow = 1us x 4 x 256
   Overflow = 1024us ~= 1ms
   
*/

// Configuração de hardware

#define led1 RA0_bit
#define led2 RA1_bit
#define speaker RA2_bit

// Variáveis globais
unsigned short duty = 5;
char cont = 0x00;

void interrupt(){

     if(T0IF_bit){
     
       T0IF_bit = 0x00;
       speaker = ~speaker; // Se Overflow = 1ms, então speaker irá alternar a cada 1us, tendo um periodo T de 2ms e f = 1/T = 500Hz
       cont++;
       
       if(cont == 0x32){ // Se cont = 0x32(hexadecimal) = 50(decimal)
       
         cont = 0x00;
         duty++;
         led1 = ~led1;
         led2 = ~led2;
       }
     }
}

void main() {

     // Configuração de registradores
     
     CMCON = 0x07; // Desabilita os comparadores internos
     OPTION_REG = 0x81; // Desabilita os pull-ups internos e configura o prescaler para 1:4, associado ao timer0
     INTCON = 0xA0; // Habilita a interrupção global e habilita a interrupção pelo timer0
     
     TRISA = 0xF8; // Configura apenas RA0, RA1 e RA2 como saídas digitais
     TRISB = 0xF7; // Configura apenas RB3 como saída digital
     led1 = 0x00;
     led2 = 0x01;
     
     // Configurando e inicializando pwm
     
     PWM1_Init(1500);
     PWM1_Set_Duty(duty);
     PWM1_Start();
     
     while(1){
     
       PWM1_Set_Duty(duty);
     }
}