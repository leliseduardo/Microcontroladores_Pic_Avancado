// Lcd pinout settings
sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D7 at RB7_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D4 at RB4_bit;

// Pin direction
sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D7_Direction at TRISB7_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB4_bit;

unsigned pulse; // Declara a variavel pulse, que é int (16 bits), para atribuir o valor do contador do timer1, isto é, o numero
                // de pulsos externos
char txt[7];

void main() {

     CMCON = 0x07; // Desabilita os comparadores internos
     T1CON = 0x03; // Ou 0b00000011, que configura o prescaler como 1:1, habilita o timer1 e habilita a contagem do timer1
                   // por clock externo. Isto é, o contador do timer1 incrementa quando há uma borda de subida externa
                   
     TMR1L = 0x00;
     TMR1H = 0x00;
     
     TRISB = 0x03; // Ou 0b00000011, que configura apenas RB0 e RB1 como entradas digitais
     TRISC = 0xEF; // Ou 0b11101111, que configura apenas RC4 como saída digital
     
     PORTB = 0x00; // Inicia todo o portb em low;
     PORTC = 0xEF; // Inicia apenas RC4 em low
     
     /* 
        A variável pulse, que é do tipo int, tem 16 bits, isto é, 0b 00000000 00000000, e será atribuída ao contador do timer1, 
        isto é, 0b 00000000(TMR1H) 00000000(TMR1L).
        
        No funcionamento interno do pic, para contar os 16bits = 2^(16) = 65536, o registrador TMR1H (mais significativo), incrementa
        sempre que TMR1L (menos significativo) estoura, assim, para contar até 65536, o TMR1H tem que incrementar 256 vezes. Logo depois,
        este registrador estoura e volta para zero. Porém, cada registrador é de 8 bits, e não apenas 1 de 16. Logo, para fazer com que
        uma variável de 16 bits (pulse) = 0b 00000000 00000000 seja atribuida aos registradores corretamente, deve-se atribui-la ao
        registrador TMR1H (mais significativo) deslocado de 8 bits para a esquerda, somado com o registrador TMR1L (menos significativo).
        Fazendo tal operação, a variável pulse resulta: pulse = 0b TMR1H + TMR1L.
        
        Valer ressaltar que, deslocar o TMR1H 8 bits à esquerda, é o mesmo de multiplica-lo por 256.
     
     */
     
     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     
     while(1){
     
       lcd_out(1,1,"Pulse: ");
     
       pulse = (TMR1H << 8) + TMR1L; // Desloca o TMR1H 8 bits para esquerda e soma TMR1L, logo, pulse = 0b TMR1H TMR1L
       
       IntToStr(pulse, txt);
       
       lcd_out(2,1,txt);
       
       if(pulse > 20)
         RC4_bit = 0x01;
     }

}