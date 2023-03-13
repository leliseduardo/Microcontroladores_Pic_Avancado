/* ============================================================================

   Projetos Aplicados com PIC Mid-Range

   Mini CLP com IHM (Projeto 6)

   Desenvolvimento de Mini Controlador Lógico Programável com Interface HM
   
   Software da interface HM

   O sistema contará com Botões e LCD 20x4


   Compilador: MikroC Pro For PIC v.4.15.0.0

   MCU: PIC16F628A   Clock: Interno 4MHz   CM: 1µs

   Autor: Eng. Wagner Rambo

   Data: Julho de 2018

   www.wrkits.com.br

============================================================================ */

// ============================================================================
// --- Conexões do Módulo LCD ---
sbit LCD_RS at RA7_bit;
sbit LCD_EN at RA6_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

// --- Direcionamento dos pinos do LCD ---
sbit LCD_RS_Direction at TRISA7_bit;
sbit LCD_EN_Direction at TRISA6_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;
//end LCD conexões


// ============================================================================
// --- Mapeamento de Hardware ---
#define    bt_up      RA0_bit                  //botão up
#define    bt_down    RA1_bit                  //botão down
#define    bt_ent     RA2_bit                  //botão enter
#define    rst_ctr    RA4_bit                  //controle de reset


// ============================================================================
// --- Mapeamento de Hardware ---
#define    bt_up_f    flagsA.B0                //flag de status do botão up
#define    bt_down_f  flagsA.B1                //flag de status do botão down
#define    bt_ent_f   flagsA.B2                //flag de status do botão enter
#define    lcd_clr    flagsA.B3                //flag para limpa única do LCD


// ============================================================================
// --- Protótipo das Funções ---
void   principal();                            //função de processamento principal
void   read_bts();                             //função para leitura dos botões
void   menu_1();                               //função para chamar menu_1
void   menu_2();                               //função para chamar menu_2
void   menu_3();                               //função para chamar menu_3
void   menu_4();                               //função para chamar menu_4
void   lcd_msg(char opt);                      //função de seleção de mensagens
void   boot_sys();                             //função para boot do systema
void   one_clear_LCD();                        //limpa o LCD uma única vez


// ============================================================================
// --- Variáveis Globais ---
int       menu_num = 0x00;                      //armazena número do menu atual

char      flagsA   = 0x00,                      //registrador de flags auxiliares
          control  = 0x00;                      //variável para controle dos parâmetros ajustados


char      pos[4][3] = {0};                      //vetor multi dimensional (matriz 4 linhas x 3 colunas)
                                                //armazena o status atual de cada I/O digital
                                                //e entradas analógicas


// ============================================================================
// --- Função Principal ---
void main() 
{
   CMCON    = 0x07;                            //desabilita comparadores internos
   TRISA    = 0x2F;                            //configura RA7,RA6,RA4 como saída
   TRISB    = 0x0B;                            //configura RB7,RB6,RB5,RB4,RB3 como saída
   PORTA    = 0x2F;                            //inicializa PORTA (saídas em LOW)
   PORTB    = 0x0B;                            //inicializa PORTB
   
   Lcd_Init();                                 //inicializa LCD
   Lcd_Cmd(_LCD_CURSOR_OFF);                   //desliga cursor
   Lcd_Cmd(_LCD_CLEAR);                        //limpa display
   
   boot_sys();                                 //faz boot do sistema

   Lcd_Cmd(_LCD_CLEAR);                        //limpa display

   
   
   while(1)                                    //Loop Infinito
   {
   
      read_bts();                              //lê botões

      principal();                             //processamento principal
          



   } //end while


} //end main


// ============================================================================
// --- Funções (desenvolvimento) ---


// ============================================================================
// --- Função de Processamento Principal ---
void principal()
{
   switch(menu_num)                            //verifica menu_num
   {
      case 0: menu_1(); break;                 //caso 0, mostra menu_1
      case 1: menu_2(); break;                 //caso 1, mostra menu_2
      case 2: menu_3(); break;                 //caso 2, mostra menu_3
      case 3: menu_4(); break;                 //caso 3, mostra menu_4
   
   
   } //end menu_num

} //end principal


// ============================================================================
// --- Função do Menu 1 ---
void menu_1()
{

   one_clear_LCD();                         //limpa display
   lcd_msg(1);                              //chama mensagens e mostra os
                                            //parâmetros do menu_1

} //end menu_1


// ============================================================================
// --- Função do Menu 2 ---
void menu_2()
{

   one_clear_LCD();                         //limpa display
   lcd_msg(2);                              //chama mensagens e mostra os
                                            //parâmetros do menu_2
   
} //end menu_2


// ============================================================================
// --- Função do Menu 3 ---
void menu_3()
{

   one_clear_LCD();                         //limpa display
   lcd_msg(3);                              //chama mensagens e mostra os
                                            //parâmetros do menu_3
   
} //end menu_3


// ============================================================================
// --- Função do Menu 4 ---
void menu_4()
{

   one_clear_LCD();                         //limpa display
   lcd_msg(4);                              //chama mensagens e mostra os
                                            //parâmetros do menu_4


} //end menu_4


// ============================================================================
// --- Função de leitura dos botões ---
void read_bts()
{
   if(!bt_up)   bt_up_f   = 0x01;              //se botão up pressionado, seta flag
   if(!bt_down) bt_down_f = 0x01;              //se botão down pressionado, seta flag
   if(!bt_ent)  bt_ent_f  = 0x01;              //se botão enter pressionado, seta flag
   
   
   if(bt_up && bt_up_f)                        //se botão up solto e flag setada
   {
      bt_up_f = 0x00;                          //limpa flag
      
      if(!control) menu_num += 1;              //incrementa menu_num, se control igual a 0

      else if(menu_num == 2)                   //se menu_num igual a 2...
      {                                        //incrementa posição atual da matriz, se ela for menor que 24
         if(pos[control][menu_num] < 24) pos[control][menu_num] ++;
      }
      
      else pos[control][menu_num] = 1;         //senão, força posição atual para 1
      

      
      if(menu_num > 3) menu_num = 0;           //se menu_num maior que 3, volta para 0
      
      lcd_clr = 1;                             //seta flag de limpeza do LCD
      
      
   } //end bt_up
   
   
   if(bt_down && bt_down_f)                    //se botão down solto e flag setada
   {
      bt_down_f = 0x00;                        //limpa flag
      
      if(!control) menu_num -= 1;              //decrementa menu_num, se control igual a 0
      
      else if(menu_num == 2)                   //se menu_num igual a 2...
      {                                        //decrementa posição atual da matriz, se ela for diferente de 0
        if(pos[control][menu_num]) pos[control][menu_num] --;
      }
      
      else pos[control][menu_num] = 0;         //senão, força posição atual para 0

      

      if(menu_num < 0) menu_num = 3;           //se menu_num menor que 0, volta para 3
      
      lcd_clr = 1;                             //seta flag de limpeza do LCD


   } //end bt_down
   
   
   if(bt_ent && bt_ent_f)                      //se botão enter solto e flag setada
   {
      bt_ent_f = 0x00;                         //limpa flag
      
      if(menu_num != 3) control += 1;          //incrementa control, se menu_num for diferente de 3
      
      if(control > 3) control = 0;             //se control maior que 3, volta para 0
      
      lcd_clr = 1;                             //seta flag de limpeza do LCD


   } //end bt_ent


} //end read_bts


// ============================================================================
// --- Função de Seleção de Mensagens ---
void lcd_msg(char opt)
{
   char dez1, uni1, dez2, uni2, dez3, uni3;    //variáveis locais para cálculo de
                                               //parâmetros a exibir
                                               
   switch(opt)                                 //verifica opt
   {
      case 1:                                  //caso 1, mensagens do menu_1
         Lcd_Chr(1,3,'A');                     //
         Lcd_Chr_Cp ('c');                     //
         Lcd_Chr_Cp ('i');                     //
         Lcd_Chr_Cp ('o');                     //
         Lcd_Chr_Cp ('n');                     //
         Lcd_Chr_Cp ('a');                     //
         Lcd_Chr_Cp ('r');                     //
         Lcd_Chr_Cp (' ');                     //
         Lcd_Chr_Cp ('s');                     //
         Lcd_Chr_Cp ('a');                     //
         Lcd_Chr_Cp ('i');                     //
         Lcd_Chr_Cp ('d');                     //
         Lcd_Chr_Cp ('a');                     //
         Lcd_Chr_Cp ('s');                     //

         Lcd_Chr(2,4,'O');                     //
         Lcd_Chr_Cp ('U');                     //
         Lcd_Chr_Cp ('T');                     //
         Lcd_Chr_Cp ('1');                     //
         
         Lcd_Chr(3,4,'O');                     //
         Lcd_Chr_Cp ('U');                     //
         Lcd_Chr_Cp ('T');                     //
         Lcd_Chr_Cp ('2');                     //
         
         Lcd_Chr(4,4,'O');                     //
         Lcd_Chr_Cp ('U');                     //
         Lcd_Chr_Cp ('T');                     //
         Lcd_Chr_Cp ('3');                     //
         break;                                //
      
      case 2:                                  //caso 2, mensagens do menu_2
         Lcd_Chr(1,3,'T');                     //
         Lcd_Chr_Cp ('e');                     //
         Lcd_Chr_Cp ('s');                     //
         Lcd_Chr_Cp ('t');                     //
         Lcd_Chr_Cp ('a');                     //
         Lcd_Chr_Cp ('r');                     //
         Lcd_Chr_Cp (' ');                     //
         Lcd_Chr_Cp ('D');                     //
         Lcd_Chr_Cp ('i');                     //
         Lcd_Chr_Cp ('g');                     //
         Lcd_Chr_Cp ('i');                     //
         Lcd_Chr_Cp ('t');                     //
         Lcd_Chr_Cp ('a');                     //
         Lcd_Chr_Cp ('l');                     //
         
         Lcd_Chr(2,4,'I');                     //
         Lcd_Chr_Cp ('N');                     //
         Lcd_Chr_Cp ('1');                     //

         Lcd_Chr(3,4,'I');                     //
         Lcd_Chr_Cp ('N');                     //
         Lcd_Chr_Cp ('2');                     //

         Lcd_Chr(4,4,'I');                     //
         Lcd_Chr_Cp ('N');                     //
         Lcd_Chr_Cp ('3');                     //
         break;                                //
         
      case 3:                                  //caso 3, mensagens do menu_3
         Lcd_Chr(1,3,'T');                     //
         Lcd_Chr_Cp ('e');                     //
         Lcd_Chr_Cp ('s');                     //
         Lcd_Chr_Cp ('t');                     //
         Lcd_Chr_Cp ('a');                     //
         Lcd_Chr_Cp ('r');                     //
         Lcd_Chr_Cp (' ');                     //
         Lcd_Chr_Cp ('A');                     //
         Lcd_Chr_Cp ('n');                     //
         Lcd_Chr_Cp ('a');                     //
         Lcd_Chr_Cp ('l');                     //
         Lcd_Chr_Cp ('o');                     //
         Lcd_Chr_Cp ('g');                     //
         Lcd_Chr_Cp ('s');                     //
         
         Lcd_Chr(2,4,'A');                     //
         Lcd_Chr_Cp ('N');                     //
         Lcd_Chr_Cp ('1');                     //

         Lcd_Chr(3,4,'A');                     //
         Lcd_Chr_Cp ('N');                     //
         Lcd_Chr_Cp ('2');                     //

         Lcd_Chr(4,4,'A');                     //
         Lcd_Chr_Cp ('N');                     //
         Lcd_Chr_Cp ('3');                     //
         break;                                //
         
         case 4:                               //caso 4, mensagens do menu_4
         Lcd_Chr(1,3,'R');                     //
         Lcd_Chr_Cp ('e');                     //
         Lcd_Chr_Cp ('s');                     //
         Lcd_Chr_Cp ('u');                     //
         Lcd_Chr_Cp ('m');                     //
         Lcd_Chr_Cp ('o');                     //
         Lcd_Chr_Cp (' ');                     //
         Lcd_Chr_Cp ('C');                     //
         Lcd_Chr_Cp ('o');                     //
         Lcd_Chr_Cp ('n');                     //
         Lcd_Chr_Cp ('f');                     //
         Lcd_Chr_Cp ('i');                     //
         Lcd_Chr_Cp ('g');                     //
         Lcd_Chr_Cp ('s');                     //
         break;                                //
         
   
   } //end opt
   

   if(menu_num != 3)                           //se menu_num diferente de 3
   {

     if(menu_num == 2)                         //se menu_num igual a 2..
     {
       dez1 = pos[1][menu_num]/10;             //calcula dezena1 da posição atual
       uni1 = pos[1][menu_num]%10;             //calcula unidade1 da posição atual
       
       dez2 = pos[2][menu_num]/10;             //calcula dezena2 da posição atual
       uni2 = pos[2][menu_num]%10;             //calcula unidade2 da posição atual
       
       dez3 = pos[3][menu_num]/10;             //calcula dezena3 da posição atual
       uni3 = pos[3][menu_num]%10;             //calcula unidade3 da posição atual
       
       Lcd_Chr(2,12,dez1+48);                  //imprime parâmetro 1 de
       Lcd_Chr_Cp  (uni1+48);                  //tensão de teste
       Lcd_Chr_Cp  ('V');                      //unidade em Volts
       Lcd_Chr(3,12,dez2+48);                  //imprime parâmetro 2 de
       Lcd_Chr_Cp  (uni2+48);                  //tensão de teste
       Lcd_Chr_Cp  ('V');                      //unidade em Volts
       Lcd_Chr(4,12,dez3+48);                  //imprime parâmetro 3 de
       Lcd_Chr_Cp  (uni3+48);                  //tensão de teste
       Lcd_Chr_Cp  ('V');                      //unidade em Volts


     } //end if menu_num aninhado
     
     else                                      //senão
     {
       Lcd_Chr(2,12,pos[1][menu_num]+48);      //imprime status da entrada/saída 1
       Lcd_Chr(3,12,pos[2][menu_num]+48);      //imprime status da entrada/saída 2
       Lcd_Chr(4,12,pos[3][menu_num]+48);      //imprime status da entrada/saída 3


     } //end else menu_num aninhado
     
     
     switch(control)                           //verifica control
     {
        case 0: Lcd_Chr(1,1, '>');             //caso 0, imprime >   no início da linha 1
                Lcd_Chr(1,20,'<'); break;      //        imprime <   no final da linha 1
        case 1: Lcd_Chr(2,1, '*'); break;      //caso 2, posiciona * na linha 2, coluna 1
        case 2: Lcd_Chr(3,1, '*'); break;      //caso 3, posiciona * na linha 3, coluna 1
        case 3: Lcd_Chr(4,1, '*'); break;      //caso 4, posiciona * na linha 4, coluna 1

     } //end switch control
     
   
   } //end if menu_num
   
   
   else                                        //senão (menu_num igual a 3)
   {
   
     Lcd_Chr(2,1,'O');                         //imprime saídas digitais
     Lcd_Chr_Cp ('U');                         //
     Lcd_Chr_Cp ('T');                         //
     Lcd_Chr_Cp ('1');                         //

     Lcd_Chr(3,1,'O');                         //
     Lcd_Chr_Cp ('U');                         //
     Lcd_Chr_Cp ('T');                         //
     Lcd_Chr_Cp ('2');                         //

     Lcd_Chr(4,1,'O');                         //
     Lcd_Chr_Cp ('U');                         //
     Lcd_Chr_Cp ('T');                         //
     Lcd_Chr_Cp ('3');                         //
     
     Lcd_Chr(2,6,pos[1][0]+48);                //imprime status da saída 1
     Lcd_Chr(3,6,pos[2][0]+48);                //imprime status da saída 2
     Lcd_Chr(4,6,pos[3][0]+48);                //imprime status da saída 3
     
     
     Lcd_Chr(2,8,'I');                         //imprime entradas digitais
     Lcd_Chr_Cp ('N');                         //
     Lcd_Chr_Cp ('1');                         //

     Lcd_Chr(3,8,'I');                         //
     Lcd_Chr_Cp ('N');                         //
     Lcd_Chr_Cp ('2');                         //

     Lcd_Chr(4,8,'I');                         //
     Lcd_Chr_Cp ('N');                         //
     Lcd_Chr_Cp ('3');                         //

     Lcd_Chr(2,12,pos[1][1]+48);               //imprime status da entrada 1
     Lcd_Chr(3,12,pos[2][1]+48);               //imprime status da entrada 2
     Lcd_Chr(4,12,pos[3][1]+48);               //imprime status da entrada 3
     
     
     Lcd_Chr(2,14,'A');                        //imprime entradas analógicas
     Lcd_Chr_Cp  ('N');                        //
     Lcd_Chr_Cp  ('1');                        //

     Lcd_Chr(3,14,'A');                        //
     Lcd_Chr_Cp  ('N');                        //
     Lcd_Chr_Cp  ('2');                        //
     
     Lcd_Chr(4,14,'A');                        //
     Lcd_Chr_Cp  ('N');                        //
     Lcd_Chr_Cp  ('3');                        //
     
     Lcd_Chr(2,18,dez1+48);                    //imprime tensão
     Lcd_Chr_Cp  (uni1+48);                    //ajustada para entrada 1
     Lcd_Chr_Cp  ('V');                        //
     Lcd_Chr(3,18,dez2+48);                    //imprime tensão
     Lcd_Chr_Cp  (uni2+48);                    //ajustada para entrada 2
     Lcd_Chr_Cp  ('V');                        //
     Lcd_Chr(4,18,dez3+48);                    //imprime tensão
     Lcd_Chr_Cp  (uni3+48);                    //ajustada para entrada 3
     Lcd_Chr_Cp  ('V');                        //
   
   
   } //end else
   

} //end lcd_msg


// ============================================================================
// --- Função de Boot do Sistema ---
void boot_sys()
{
   char boot_cnt = 0;                          //variável local para temporização

   Lcd_Chr(1,5, 'C');                          //escreve mensagem
   Lcd_Chr_Cp  ('L');                          //
   Lcd_Chr_Cp  ('P');                          //
   Lcd_Chr_Cp  (' ');                          //
   Lcd_Chr_Cp  ('W');                          //
   Lcd_Chr_Cp  ('R');                          //
   Lcd_Chr_Cp  (' ');                          //
   Lcd_Chr_Cp  ('K');                          //
   Lcd_Chr_Cp  ('i');                          //
   Lcd_Chr_Cp  ('t');                          //
   Lcd_Chr_Cp  ('s');                          //
   
   Lcd_Chr(2,8, 'v');                          //
   Lcd_Chr_Cp  ('1');                          //
   Lcd_Chr_Cp  ('.');                          //
   Lcd_Chr_Cp  ('0');                          //
   
   Lcd_Chr(3,5, 'I');                          //
   Lcd_Chr_Cp  ('n');                          //
   Lcd_Chr_Cp  ('i');                          //
   Lcd_Chr_Cp  ('c');                          //
   Lcd_Chr_Cp  ('i');                          //
   Lcd_Chr_Cp  ('a');                          //
   Lcd_Chr_Cp  ('n');                          //
   Lcd_Chr_Cp  ('d');                          //
   Lcd_Chr_Cp  ('o');                          //
   Lcd_Chr_Cp  ('.');                          //
   Lcd_Chr_Cp  ('.');                          //
   Lcd_Chr_Cp  ('.');                          //
   
   Lcd_Chr(4,1,'#');                           //imprime caractere de status "carregando"

   while(boot_cnt < 20)                        //processa enquanto boot_cnt menor que 20
   {
   
      Lcd_Chr_Cp('#');                         //imprime caractere de status "carregando"
      delay_ms(100);                           //aguarda 100ms
      boot_cnt += 1;                           //incrementa boot_cnt
   
   } //end while
   
   rst_ctr = 0x01;                             //libera PIC16F877A
   
   
} //end boot_sys


// ============================================================================
// --- Função para limpar o LCD uma única vez ---
void one_clear_LCD()                           //Limpa o LCD uma única vez
{
   if(lcd_clr)                                 //lcd_clr setada?
   {                                           //sim...
      Lcd_Cmd(_LCD_CLEAR);                     //limpa display
      lcd_clr = 0x00;                          //limpa flag para invalidar o laço

   } //end if lcd_clr


} //end one_clear_LCD

















