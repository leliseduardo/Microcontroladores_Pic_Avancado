/* ============================================================================

     Controle de Portão Codificado com módulos TXRX 433MHz
     
     Software do Receptor


     MCU: PIC16F628A    Clock: Interno 4MHz


     Autor: Eng. Wagner Rambo    Data: Maio de 2018



============================================================================ */


// ============================================================================
// --- Protótipo das Funções ---
void rx_func(char *cmd, char *val, char *ok);  //Recebimento de dados seriais


// ============================================================================
// --- Variáveis Globais ---
char start, cnt;                               //start e contador auxiliar
char comand, value, check;                     //bytes a serem recebidos
char m_control = 1;                            //controle do motor

bit flag_c;

// ============================================================================
// --- Interrupção ---
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
// --- Função Principal ---
void main()
{
    CMCON = 0x07;                              //Desabilita comparadores
    TRISB = 0xCE;                              //Configura RB0, RB4 e RB5 como saída
    PORTB = 0xCE;                              //Inicializa PORTB
  
    flag_c = 0x00;
    
    RCIE_bit = 0x01;                           //habilita interrupção da recepção serial
    GIE_bit  = 0x01;                           //habilita interrupção global
    PEIE_Bit = 0x01;                           //habilita interrupção dos periféricos
  
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
// --- Desenvolvimento das Funções ---


// ============================================================================
// --- Função para Recebimento de Dados Seriais ---
void rx_func(char *cmd, char *val, char *ok)
{
   char buffer;                                //variável local para buffer de dados
   char checksum;                              //variável de checksum
   *ok = 0;                                    //bit de verificação

   if(RCIF_bit)                                //houve interrupção na recepção serial?
   {                                           //sim
      RCIF_bit = 0x00;                         //limpa flag
      
      buffer = Uart1_Read();                   //lê serial e armazena em buffer
      
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
      
      else                                     //senão
      {
         if(buffer == 0xFF)                    //buffer completo?
         {                                     //sim
            start = 0x01;                      //seta start
            cnt   = 0x00;                      //reinicia contador
            
         } //end if buffer
      
      } //end else
      
   } //end if RCIF

} //end rx_func