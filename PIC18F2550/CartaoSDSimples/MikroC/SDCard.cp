#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/CartaoSDSimples/MikroC/SDCard.c"
#line 9 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/CartaoSDSimples/MikroC/SDCard.c"
const TAMANHO = 24;
char nomearquivo[11] = "hello.txt";
char conteudoarquivo[TAMANHO] = "XX Hello World SD Card!";


void novo_Arquivo(){

 Mmc_Fat_Assign(&nomearquivo, 0xA0);
 Mmc_Fat_Rewrite();

 Lcd_Out(2, 1, "Ok");

 conteudoarquivo[0] = 42/10 + 48;
 conteudoarquivo[1] = 42%10 + 48;

 Mmc_Fat_Write(conteudoarquivo, TAMANHO-1);

}

void start_SD(){


 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);


 if (Mmc_Fat_Init() == 0)
 {

 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

 Lcd_Out(1, 1, "SD Start!");

 novo_Arquivo();

 }
 else
 {

 Lcd_Out(1, 1, "SD Error!");
 }

 delay_ms(1000);

}
