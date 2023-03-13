#define bot1 RB1_bit
#define bot2 RB2_bit
#define bot3 RB3_bit
#define bot4 RB4_bit

unsigned short duty1, duty2;

void main() {

     CMCON = 0x07; // Desativa os comparadores internos
     TRISB = 0xFF; // Configura todo o porta como entrada digital
     TRISC = 0x00; // Configura todo portc como saída digital
     PORTB = 0xFF; // Inicia todo porta em HIGH
     PORTC = 0x00; // Inicia todo portc em LOW
     
     PWM1_Init(5000); // Inicia o pwm na porta RC2/CCP1
     PWM2_Init(5000); // Inicia o pwm na porta RC1/CCP2
     
     PWM1_Start(); // Ativa os PWMs
     PWM2_Start();
     
     duty1 = 127; // Faz as variáveis equivalerem a 50% de duty cicle
     duty2 = 127;
     
     PWM1_Set_Duty(duty1); // Configura os dutys dos pwms em 127, ou seja, 50%
     PWM2_Set_Duty(duty2);
     
     
     while(1){
     
              if(!bot1){
                       delay_ms(40);
                       duty1++;
                       PWM1_Set_Duty(duty1);
              }
              if(!bot2){
                       delay_ms(40);
                       duty1--;
                       PWM1_Set_Duty(duty1);
              }
              if(!bot3){
                       delay_ms(40);
                       duty2++;
                       PWM2_Set_Duty(duty2);
              }
              if(!bot4){
                       delay_ms(40);
                       duty2--;
                       PWM2_Set_Duty(duty2);
              }
     }
}