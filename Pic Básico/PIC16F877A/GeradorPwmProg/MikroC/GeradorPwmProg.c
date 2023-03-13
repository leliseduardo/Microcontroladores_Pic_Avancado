
// Configuração do LCD

// Lcd pinout settings
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;

// Pin direction
sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;



// Configuração do hardware

#define col1 RB1_bit
#define col2 RB2_bit
#define col3 RB3_bit
#define lina RB4_bit
#define linb RB5_bit
#define linc RB6_bit
#define lind RB7_bit

// Macro para LCD
#define escreve    Lcd_Out(2, 1, "Duty Cicle: "); \
                   lcd_chr_cp(dezena+48); \
                   lcd_chr_cp(unidade+48);

// Funções auxiliares

void guardaNum(unsigned num);
char concatenaNum(unsigned dez, unsigned uni);
void dutyHalf(unsigned duty);

// Variáveis globais

char control = 0x01;
char dezena = 0;
char unidade = 0;
char guardaNume = 0;
char aux = 0;
char numero = 0;


// Função de interrupção

void interrupt(){


     if(TMR0IF_bit){

       TMR0IF_bit = 0x00;
       TMR0 = 0x00;

       if(col1 && control == 0x01){
             col1 = 0x00;
             col2 = 0x01;
             col3 = 0x01;
             control = 0x02;

             if(!lina)
                      guardaNum(1);
             else if(!linb)
                      guardaNum(4);
             else if(!linc)
                      guardaNum(7);
             else if(!lind)
                      aux = 1;

       }
        else if(col2 && control == 0x02){
             col1 = 0x01;
             col2 = 0x00;
             col3 = 0x01;
             control = 0x03;

             if(!lina)
                      guardaNum(2);
             else if(!linb)
                      guardaNum(5);
             else if(!linc)
                      guardaNum(8);
             else if(!lind)
                      guardaNum(0);

       }
       else if(col3 && control == 0x03){
             col1 = 0x01;
             col2 = 0x01;
             col3 = 0x00;
             control = 0x01;

             if(!lina)
                      guardaNum(3);
             else if(!linb)
                      guardaNum(6);
             else if(!linc)
                      guardaNum(9);
             else if(!lind)
                      dutyHalf(50);

       }
     }
}

void main() {

     CMCON = 0x07; // Desativa os comparadores internos
     OPTION_REG = 0x87; // Desativa os pull-ups internos e configura o prescaler para 1:128
     GIE_bit = 0x01; // Ativa a interrupção global
     PEIE_bit = 0x01; // Ativa a interrupção por periféricos
     TMR0IE_bit = 0x01; // Ativa a interrupção do timer0 por estouro
     TMR0 = 0x00;

     TRISB = 0xF0; // Faz o primeiro nibble do portb ser entrada
     TRISC = 0xFB; // Apenas ccp1 como saída
     TRISD = 0x03; // Apenas RD0 e RD1 como entrada
     PORTB = 0x0F; // Inicia o primeiro nibble do portb em High

     // Inicializações

     // PWM

     PWM1_Init(2000);

     // Lcd

     Lcd_Init();
     Lcd_Cmd(_LCD_CURSOR_OFF);
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Out(1, 4, "Ajuste de PWM");

     // PWM

     PWM1_Start();

     while(1){

              escreve;

              if(aux == 1){
                     numero = concatenaNum(dezena, unidade);

                     guardaNume = 0;
              }

              PWM1_Set_Duty((numero*255)/100);
              delay_ms(100);
     }
}

void guardaNum(unsigned num){

     if(guardaNume == 0){
             dezena = num;
             delay_ms(300);
             guardaNume = 1;
     }
     else{
             unidade = num;
             delay_ms(300);
     }
}

char concatenaNum(unsigned dez, unsigned uni){

     unsigned char num;

     num = (dez*10) + uni;

     aux = 0;

     return num;
}

void dutyHalf(unsigned duty){
     numero = duty;
     delay_ms(100);
     dezena = 5;
     unidade = 0;
}