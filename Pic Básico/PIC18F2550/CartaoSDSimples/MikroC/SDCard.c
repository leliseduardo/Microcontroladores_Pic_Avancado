/*

        Arquivo criado com o objetivo de auxiliar o projeto "CartaoSDSimples", que está na mesma pasta. Este arquivo irá conter as funções utili-
    zadas no cartão SD.

*/

// Variáveis auxiliares
const TAMANHO = 24;                                       //tamanho da string
char nomearquivo[11] = "hello.txt";                //Nome do arquivo
char conteudoarquivo[TAMANHO] = "XX Hello World SD Card!";  //texto a ser escrito

//Cria um novo arquivo e escreve dados dentro dele
void novo_Arquivo(){

  Mmc_Fat_Assign(&nomearquivo, 0xA0);          //Cria arquivo para escrita
  Mmc_Fat_Rewrite();                        //Limpa arquivo para escrever novo dado

  Lcd_Out(2, 1, "Ok");                        //mensagem de status

  conteudoarquivo[0] = 42/10 + 48;            //escreve o número 4 na posição 0 da string
  conteudoarquivo[1] = 42%10 + 48;            //escreve o número 2 na posição 1 da string

  Mmc_Fat_Write(conteudoarquivo, TAMANHO-1); //escreve no cartão

} // end void novo_Arquivo

void start_SD(){

       //Inicializa SPI1
      SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

      //Cartão SD formatado para FAT 16
      if (Mmc_Fat_Init() == 0)
      {
        //reinicia SPI
        SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
        //mensagem de status (cartão SD encontrado)
        Lcd_Out(1, 1, "SD Start!");
        //chama função para criação e escrita
        novo_Arquivo();

      }
      else
      {
        //imprime erro no LCD caso o cartão não seja encontrado ou exista algum outro problema.
        Lcd_Out(1, 1, "SD Error!");
      }

      delay_ms(1000);   //aguarda...

} // end void start_SD
