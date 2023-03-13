#define trig RB0_bit

// Lcd pinout settings
sbit LCD_RS at RB1_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

// Pin direction
sbit LCD_RS_Direction at TRISB1_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;

// Função auxiliar

void trigger(); // Função que envia um pulso ao trigger so sensor

//Variáveis globais

unsigned tempoH; // Recebe o pulso em nível alto so sensor
char tmrH, tmrL; // Armazena a contagem do modo de captura (CCP1H::CCP1L)
char txt[7];     // Armazena a string com o valor do pulso
char distancia; // Armazena a distancia já convertida

void interrupt(){

    if(CCP1IF_bit && CCP1CON.B0){

      CCP1IF_bit = 0x00; // Zera a flag de interrupção
      TMR1H = 0x00; // Inicia TMR1 em 0
      TMR1L = 0x00;
      CCP1IE_bit = 0x00; // Desliga a interrupção do modulo ccp
      CCP1CON = 0x04; // Configura a captura em borda de descida
      CCP1IE_bit = 0x01; // Liga a interrupão do modulo ccp
      TMR1ON_bit = 0x01; // Liga a contagem do timer1
    }
    else if(CCP1IF){
       CCP1IF_bit = 0x00; // Zera a flag de interrupção
       TMR1ON_bit = 0x00; // Desliga a contagem do timer1
       CCP1IE_bit = 0x00; // Desliga a interrupção do modulo ccp
       CCP1CON = 0x05; // Configura a captura em borda de subida
       CCP1IE_bit = 0x01; // Liga a interrupção do modulo ccp
       tmrH = CCPR1H; // Iguala o neeble mais significativo do timer 1 a tempoH
       tmrL = CCPR1L; // Iguala o neeble menos significativo do timer 1 a tempoL
    }
}

void main() {

     CMCON = 0x07; // Desativa os comparadores internos
     INTCON = 0xC0; // Hablita a interrupção global e por periféricos
     TMR1IE_bit = 0x00; // Desabilita a interrupção do timer 1
     CCP1IE_bit = 0x01; // Habilita a interrupção pelo modulo cpp
     CCP1CON = 0x05; // Configura o modo de captura por borda de subida

     //Registrado T1CON
     T1CKPS1_bit = 0x00; // Configura o prescaler como 1:1
     T1CKPS0_bit = 0x00; // Configura o prescaler como 1:1
     TMR1CS_bit = 0x00; // Configura clock interno, e não clock externo a partir do pino RB6
     TMR1ON_bit = 0x00; // Para a contagem do timer 1

     TRISA = 0xFF; // Configura todo porta como entrada digital
     TRISB = 0x09; // Ou 0b00001001, que configura apenas RB0 e RB3 como entradas digitais
     PORTA = 0xFF; // Inicia todo o porta em High
     PORTB = 0x00; // Inicia todo o portb em Low

     lcd_init(); // Inicia lcd
     lcd_cmd(_LCD_CURSOR_OFF); // Desliga cursor
     lcd_cmd(_LCD_CLEAR); // Apaga caracteres display
     lcd_out(1,1,"Distancia"); // Escreve na primeira linha
     lcd_out(2,14,"cm"); // Coloca a unidade do valos lido, no final da segunda linha
     delay_ms(100); // Atraso de inicialização do display

     while(1){

       trigger();

       delay_ms(100);

       tempoH = (tmrH << 8) + tmrL; // Faz tempoH = 0b tmrH tmrL, sendo tmrH o mais sig, e o tmrL o menos sig.

       distancia = tempoH / 58;

       IntToStr(distancia, txt);

       lcd_out(2,8,txt);
     }
}

void trigger(){

     trig = 0x01;
     delay_ms(10);
     trig = 0x00;
}