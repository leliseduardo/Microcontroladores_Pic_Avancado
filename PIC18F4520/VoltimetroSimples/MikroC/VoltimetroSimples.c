/* 

   O objetivo deste programa � piscar um led o numero de vezes que corresponde a tens�o que o conversor AD recebe. O conversor AD estar�
   lendo um sinal anal�gico e, quando o botao for pressionado, o led picar� o numero de vezes que representa a tens�o lida.
   O c�digo ser� feito para ler uma tensao de 12V e, atrav�s de um divisor de tens�o no circuito, esse 12 volts ser�o representados de
   0V a 5V no pic mas, no codigo, esse intervalo ser� entendido como de 0V a 12V.
   
   ***** Equa��o do divisor de tens�o para o pino AD ler de 0V a 5V *****
   
   (VCC)O---------R1----------O(VAD)----------R2-------O(GND)
                         (Tens�o pino AD)
                       
                       
   R2 = 15 KOhm
   R1 = ?
   VAD = 5V
   VCC = 12V

   I2 = VAD/R2
   I1 = (VCC-VAD)/R1
   I2 = I1
   
   VAD/R2 = (VCC-VAD)/R1
   R1 = (R2(VCC-VAD))/VAD
   R1 =(15KOhmx(12V-5V))/5V
   R1 = (15KOhmx7V)/5V
   R1 = 21KOhm
   
   Valor comercial: R1 = 22KOhm
   
   V = R x I
   12V = (22KOhm + 15KOhm) x I
   I = 12V / 37KOhm
   I = 324uA
   
   VR1 = R1 x I
   VR1 = 22KOhm x 324uA
   VR1 = 7,13V
   
   VR2 = R2 x I
   VR2 = 15KOhm x 324uA
   VR2 = 4,86V
   VAD = VR2
   
   Logo, em VAD, tens�o que vai para o pino AD, a tens�o m�xima ser� 4,87V. Tens�o de seguran�a. Para n�o correr o risco da tens�o passar de
   5V, que pode danificar o pic.
   
   Como VAD s� vai at� 4,86V, deve-se adicionar 1 itera��o no for, para que o MCU entenda que 4,86V representa 5V, que representa 12V e,
   assim, pisque as 12 vezes o led.
   
    ***** Equa��o para conversor AD *****
    
    12V ---------- 1024
    1V  ---------- n
        n = 1024 / 12
        n = 85,33 ~= 85
        
    1V     ---------- 85
    Tensao ---------- AD
           Tensao = AD / 85
    
    Ex: Tensao = 724 / 85
        Tensao = 8,51V
    Assim, o led piscar� 8 vezes.
    
    Obs: Como o conversor AD est� ativado, deve-se alterar o Fuse PORTB A/D Enable para configurado para pinos digitais. Caso isso n�o seja
    feito, os pull-ups internos do portb n�o ir�o funcionar.
    
    Importante: O c�lculo que fiz para "ler" 12V no Pic, isto �, interpretar 12V, chama-se Normaliza��o e seus passos est�o descritos
    no projeto "VoltTensaoNegativa" da aula 81 do curso.

*/

// Configura��es de hardware

#define led LATB0_bit
#define bot RB1_bit

// Vari�veis globais

int adc;
unsigned tensao;
unsigned aux;
char flag = 0x00;

// Fun��es auxiliares

void volts(unsigned volt);

void main() {

     INTCON2 = 0x7F; // Ou 0b0111 1111, que habilita os pull-ups internos do portb
     ADCON0 = 0x01; // Configura AN0 como canal anal�gico e habilita o conversor AD
     ADCON1 = 0x0E; // Configura o intervalo de leitura no pino AD, entre as tens�es da fonte (VSS � VDD). Ainda, configura apenas AN0 como
                    // porta anal�gica. O resto dos pinos que poderiam ser portas anal�gicas s�o configuradas como digitais
     TRISA = 0xFF; // Configura todo porta como entrada
     TRISB = 0xFE; // Configura apenas RB0 como sa�da digital
     LATB = 0x00; // Inicia RB0 em Low
     
     while(1){
     
       volts(12);
     }
}

void volts(unsigned volt){

     unsigned i;

     if(!bot) flag.B0 = 0x01;
     
     if(bot && flag.B0){
     
       flag.B0 = 0x00;
       
       aux = 1024/volt;

       adc = ADC_Read(0);
       
       tensao = adc / aux;
       
       for(i = 0x00; i <= tensao; i++){
       
         led = 0x01;
         delay_ms(300);
         led = 0x00;
         delay_ms(300);
       }
     }
}