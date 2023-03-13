/*  
 *      Esta biblioteca serve para o display 20x4 e 16x2, e será usada para 16x2.
 * 
 *      Neste código basicamente são feitas configurações de pinos para comunicar com o display e, na função lcd_command,
 *   são passados códigos para o display que são códigos próprios do display e realizam comando específicos como posiciona-
 *   mento de escrita, limpeza, habilitação de cursor, entre outros.
 * 
 *      Caso eu necessite desta biblioteca para algum projeto prático ou profissional, vale a pena dar uma estudada mais a 
 *  fundo e reescrever cada função, além de estudar o datasheet do display LCD.
 * 
 */

// This is a guard condition so that contents of this file are not included
// more than once.  
#ifndef LelisPicLibs
    #define	LelisPicLibs

    #include <xc.h> // include processor files - each processor file is guarded.  
    // ========================================================================================//
    //Definição de configurações
    // ========================================================================================//

    //Cristal Oscilador - Frequencia
    #ifndef XTAL_FREQ
        #define _XTAL_FREQ 8000000
    #endif
    //Pinos para Display LCD
    #ifndef DISPLAYLCD_PORTS
        #define RS LATB2  
        #define EN LATB3  
        #define D4 LATB4
        #define D5 LATB5
        #define D6 LATB6
        #define D7 LATB7
        #define RSTRIS TRISB2  
        #define ENTRIS TRISB3  
        #define D4TRIS TRISB4 
        #define D5TRIS TRISB5  
        #define D6TRIS TRISB6  
        #define D7TRIS TRISB7 
    #endif


    // ========================================================================================//
    //Prototipos de funções
    // ========================================================================================//

    #ifdef	__ADC_Inicializa
        extern void ADC_Inicializa(unsigned short canal);
    #endif 

    #ifdef	__leitura_ADC
        extern unsigned int leitura_ADC(unsigned short canal)
    #endif   

    #ifdef	__DELAY_MS
        extern void delay_ms(unsigned int tempo)
    #endif    

    #ifdef __DISPLAYLCD
            extern void LCD_Init();                   /*Initialize LCD*/
            extern void LCD_Command(unsigned char );  /*Send command to LCD*/
            extern void LCD_Char(unsigned char x);    /*Send data to LCD*/
            extern void LCD_String(const char *);     /*Display data string on LCD*/
            extern void LCD_String_xy(char, char , const char *);
            extern void LCD_Char_xy(char row,char pos,unsigned char dat);
            extern void LCD_Clear();                  /*Clear LCD Screen*/
    #endif         

#endif	/* BobsienPICLIBS */
    
   
//========================================================================================================================//
//Leitura de entrada analogica
//========================================================================================================================//
            
void ADC_Inicializa(unsigned short canal)
{
    //ADCON1/2 - PG 261-262 
    ADCON1bits.VCFG0=0;                  //Configura referência de tensão positiva
    ADCON1bits.VCFG1=0;                  //Configura referência de tensão negativa
    ADCON1bits.PCFG=(0b1111-(canal+1));    //Configura quais canais devem ser habilitados
    ADCON2bits.ADFM=1;                   //Configura justiicação do resultado (MSB a esquerda)
    ADCON2bits.ACQT=0b111;               //Configura velocidade de aquisição (maior, menor precisão)
    ADCON2bits.ADCS=0b000;               //Configura clock de entrada do ADC
}

unsigned int leitura_ADC(unsigned short canal)
{
    ADCON0bits.CHS = canal;            //Informa qual canal deverá ser aquisitado
    ADCON0bits.ADON = 1;                 //Ativa conversão AD
    ADCON0bits.GODONE = 1;               //Sinaliza inicialização da conversão AD
    while(ADCON0bits.GODONE);            //Verifica se a conversão AD foi concluida
    return (ADRES);                      //Retorna o valor discretizador
}

//========================================================================================================================//
//Função delay de 1ms
//========================================================================================================================//

void delay_ms(unsigned int tempo){
    //Variáveis locais
    unsigned int i;
    unsigned long j;
 
    for(i=0;i<tempo;i++){                         //loop para amarrar em X ms - onde X e passado através de "val"
        for(j=0;j<_XTAL_FREQ/65200 ;j++);      //Loop de processamento vazio - consome 1ms em media   
    }        
}


//========================================================================================================================//
//Display LCD 16x2
//========================================================================================================================//

void LCD_Command(unsigned char cmd )
{
    
    short OUTS[8], i;
    
    for (i=0; i < 8; i++ ) { 
  
        // storing remainder in binary array 
        OUTS[i] = cmd % 2; 
        cmd = cmd / 2; 
      //  i++; 
    } 
    
	//dsipdata = (dsipdata & 0x0f) |(0xF0 & cmd);  /*Send higher nibble of command first to PORT*/ 
    D4 = OUTS[4];
    D5 = OUTS[5];
    D6 = OUTS[6];
    D7 = OUTS[7];
	RS = 0;  /*Command Register is selected i.e.RS=0*/ 
	EN = 1;  /*High-to-low pulse on Enable pin to latch data*/ 
	NOP();
	EN = 0;
	delay_ms(1);
    //dsipdata = (dsipdata & 0x0f) | (cmd<<4);  /*Send lower nibble of command to PORT */
    D4 = OUTS[0];
    D5 = OUTS[1];
    D6 = OUTS[2];
    D7 = OUTS[3];    
	EN = 1;
	NOP();
	EN = 0;
	delay_ms(3);
}

void LCD_Init()
{
    RSTRIS = 0;       /*PORT as Output Port*/
    ENTRIS = 0;       /*PORT as Output Port*/
    D4TRIS = 0;       /*PORT as Output Port*/
    D5TRIS = 0;       /*PORT as Output Port*/
    D6TRIS = 0;       /*PORT as Output Port*/
    D7TRIS = 0;       /*PORT as Output Port*/
    
    delay_ms(40);        /*15ms,16x2 LCD Power on delay*/
    LCD_Command(0x02);  /*send for initialization of LCD 
                          for nibble (4-bit) mode */
    LCD_Command(0x28);  /*use 2 line and 
                          initialize 5*8 matrix in (4-bit mode)*/
	LCD_Command(0x01);  /*clear display screen*/
    LCD_Command(0x0c);  /*display on cursor off*/
	LCD_Command(0x06);  /*increment cursor (shift cursor to right)*/	   
}

void LCD_Char(unsigned char dat)
{
    short OUTS[8], i;
    
    for (i=0; i < 8; i++ ) { 
  
        // storing remainder in binary array 
        OUTS[i] = dat % 2; 
        dat = dat / 2; 
    }  
       
	//dsipdata = (dsipdata & 0x0f) | (0xF0 & dat);  /*Send higher nibble of data first to PORT*/
    D4 = OUTS[4];
    D5 = OUTS[5];
    D6 = OUTS[6];
    D7 = OUTS[7];
	RS = 1;  /*Data Register is selected*/
	EN = 1;  /*High-to-low pulse on Enable pin to latch data*/
	NOP();
	EN = 0;
	delay_ms(1);
    //dsipdata = (dsipdata & 0x0f) | (dat<<4);  /*Send lower nibble of data to PORT*/
    D4 = OUTS[0];
    D5 = OUTS[1];
    D6 = OUTS[2];
    D7 = OUTS[3];
	EN = 1;  /*High-to-low pulse on Enable pin to latch data*/
	NOP();
	EN = 0;
	delay_ms(3);
}


void LCD_Char_xy(char row,char pos,unsigned char dat)
{
    char location=0;
    switch (row){
        case 1:
           location=(0x80) | ((pos) & 0x0f);  /*Print message on 1st row and desired location*/
           LCD_Command(location);   
           break;
        case 2:
           location=(0xC0) | ((pos) & 0x0f);  /*Print message on 1st row and desired location*/
           LCD_Command(location);   
           break;
           
           
      //  Só se usa para o display 20x4    
      //  case 3:
      //    location=(0x94) | ((pos) & 0x0f);  //Print message on 1st row and desired location
      //     LCD_Command(location);   
      //    break;
      // case 4:
      //     location=(0xD4) | ((pos) & 0x0f);  //Print message on 1st row and desired location
      //     LCD_Command(location);   
      //    break;
      
           
    }

    

    LCD_Char(dat);
}

void LCD_String(const char *msg)
{
	while((*msg)!=0)
	{		
	  LCD_Char(*msg);
	  msg++;	
    }
}

void LCD_String_xy(char row,char pos,const char *msg)
{
    char location=0;
    switch (row){
        case 1:
           location=(0x80) | ((pos) & 0x0f);  
           LCD_Command(location);   
           break;
        case 2:
           location=(0xC0) | ((pos) & 0x0f);  
           LCD_Command(location);   
           break;
           
     //    Só se usa para o display 20x4
     //   case 3:
     //      location=(0x94) | ((pos) & 0x0f); 
     //      LCD_Command(location);   
     //      break;
     //   case 4:
     //      location=(0xD4) | ((pos) & 0x0f);  
     //      LCD_Command(location);   
     //      break;
           
    }
      
      

    LCD_String(msg);

}

void LCD_Clear()
{
   	LCD_Command(0x01);  /*clear display screen*/
    delay_ms(3);
}
