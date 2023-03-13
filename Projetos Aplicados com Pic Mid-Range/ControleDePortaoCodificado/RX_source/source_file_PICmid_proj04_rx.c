/* ============================================================================

     Controle de Port�o Codificado com m�dulos TXRX 433MHz
     
     Software do Receptor


     MCU: PIC16F628A    Clock: Interno 4MHz


     Autor: Eng. Wagner Rambo    Data: Maio de 2018



============================================================================ */


// ============================================================================
// --- Prot�tipo das Fun��es ---
void rx_func(char *cmd, char *val, char *ok);  //Recebimento de dados seriais


// ============================================================================
// --- Vari�veis Globais ---
char start, cnt;                               //start e contador auxiliar
char comand, value, check;                     //bytes a serem recebidos
char m_control = 1;                            //controle do motor

bit flag_c;

// ============================================================================
// --- Interrup��o ---
void interrupt()
{
   rx_func(&comand, &value, &check);           //verifica comando e valor recebido

   if(check)                                   //check verdadeiro?
   {                                           //Sim...

      if(comand == 'A')                        //se comando recebido igual a 'A' (41h na ASCII)
      {
         RB0_bit = value;                      //RB0 recebe value
         flag_c = 1;                           //seta flag_c

      } //end if



   } //end if ok

} //end interrupt


// ============================================================================
// --- Fun��o Principal ---
void main()
{
    CMCON = 0x07;                              //Desabilita comparadores
    TRISB = 0xCE;                              //Configura RB0, RB4 e RB5 como sa�da
    PORTB = 0xCE;                              //Inicializa PORTB
  
    flag_c = 0x00;
    
    RCIE_bit = 0x01;                           //habilita interrup��o da recep��o serial
    GIE_bit  = 0x01;                           //habilita interrup��o global
    PEIE_Bit = 0x01;                           //habilita interrup��o dos perif�ricos
  
    UART1_Init(1200);                          //Inicializa UART1 com 1200 baud rate
    delay_ms(100);                             //aguarda 100ms



    while(1)                                  //Loop Infinito
    {
    
       if(RB0_bit && flag_c)                  //RB0 em high e flag_c setada?
       {                                      //sim...
          flag_c = 0;                         //limpa flag_c
          m_control += 1;                     //incrementa m_control
          delay_ms(200);                      //aguarda 200ms
             
          if(m_control > 4) m_control = 1;    //se m_control maior que 4, volta para 1
         
       } //end if RB0_bit flag_c


       switch(m_control)                      //verifica m_control
       {
          case 1:                             //caso 1
            RB4_bit = 0x00;                   //motor parado
            RB5_bit = 0x00;                   //bits desligados
            break;                            //interrompe case
          case 2:                             //caso 2
            RB4_bit = 0x01;                   //motor gira em um sentido
            RB5_bit = 0x00;                   //liga bit em RB4
            break;                            //interrompe case
          case 3:                             //caso 3
            RB4_bit = 0x00;                   //motor parado
            RB5_bit = 0x00;                   //bits desligados
            break;                            //interrompe case
          case 4:                             //caso 4
            RB4_bit = 0x00;                   //motor gira em outro sentido
            RB5_bit = 0x01;                   //liga bit em RB5
            break;                            //interrompe case


       } //end switch
       
    } //end while
    
} //end main


// ============================================================================
// --- Desenvolvimento das Fun��es ---


// ============================================================================
// --- Fun��o para Recebimento de Dados Seriais ---
void rx_func(char *cmd, char *val, char *ok)
{
   char buffer;                                //vari�vel local para buffer de dados
   char checksum;                              //vari�vel de checksum
   *ok = 0;                                    //bit de verifica��o

   if(RCIF_bit)                                //houve interrup��o na recep��o serial?
   {                                           //sim
      RCIF_bit = 0x00;                         //limpa flag
      
      buffer = Uart1_Read();                   //l� serial e armazena em buffer
      
      if(start)                                //se start verdadeiro
      {
         cnt++;                                //incrementa contador
         
         if(cnt == 1) *cmd = buffer;           //atualiza cmd, se contador igual a 1

         if(cnt == 2) *val = buffer;           //atualiza val, se contador igual a 2

         if(cnt == 3)                          //contador igual a 3?
         {                                     //sim
            checksum = buffer;                 //checksum recebe o valor do buffer
            start    = 0x00;                   //limpa start
            
            if(checksum == ~(char)(*cmd + *val)) *ok = 1; //seta ok, se checksum estiver correto

         } //end if cnt 3
         
      } //end if start
      
      else                                     //sen�o
      {
         if(buffer == 0xFF)                    //buffer completo?
         {                                     //sim
            start = 0x01;                      //seta start
            cnt   = 0x00;                      //reinicia contador
            
         } //end if buffer
      
      } //end else
      
   } //end if RCIF

} //end rx_func