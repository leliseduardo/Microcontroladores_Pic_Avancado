#define digUnidade PORTB.F7
#define digDezena PORTA.F2
#define digCentena PORTA.F3
#define mais PORTA.F1
#define menos PORTA.F0

int display(int num);
void contagem();

int unid, dez, cent, cont = 0;

void main() {

      CMCON = 0X07; // Desabilita os comparadores internos
      TRISA = 0X03; // Seleciona an0 e an1 como entradas digitais
      TRISB = 0X00; // Seleciona todo o portb como saida digital
      digDezena = 0x00; // Desliga o display das dezena
      digCentena = 0x00; // Desliga o display das centenas
      
      while(1){
      
        // Aqui todos os diplays são ligados numa frequencia f = 1/0,015s = 66,67 hz, sempre atualizando seu valor
      
        contagem(); // Função que verifica se os botôes foram clicados
        
        // Atualizando display das centenas
        cent = (cont/100) - ((cont%100)/100); //Filtra, de cont, o numero centesimal. Ex: Se cont = 154, cent = 1
        PORTB = display(cent); // Usa a função display para retornar o numero hexadecimal que aciona o portb igual a cent
        digCentena = 1;  // Liga o display que representa a centena, fazendo com que os leds desse diplay acendam
        delay_ms(5); // Espera 5ms, que representa a alta frequencia que os displays ficarão ligados
        digCentena = 0; // Desliga o display das centenas

        // Atualizando o display das dezenas
        dez = (cont%100); // Exclui o numero centesimal de cont. Ex: Se cont = 154, dez = 54
        dez = (dez/10) - ((dez%10)/10); // Filtra, de dez, o numero decimal. Ex: Se dez = 54, dez = 5
        PORTB = display(dez); // Usa a função display para retornar o numero hexadecimal que aciona o portb igual a dez
        digDezena = 1; // Liga o display que representa os numero decimais
        delay_ms(5); // Espera 5ms, o tempo referente a frequencia que os displays ficarão ligados
        digDezena = 0; // Desliga o display das dezenas
        
        // Atualizando o display das unidades
        unid = cont%10; // Filtra, de cont, a unidade do numero. Ex: Se cont = 154, unid = 4
        PORTB = display(unid); // Usa a função display para retornar o numero hexadecimal que aciona o portb igual a unid
        digUnidade = 1; // Liga o display das unidades
        delay_ms(5); // Espera 5ms, tempo referente à frequência que os displays ficarão ligados
        digUnidade = 0; // Desliga o display da unidades
      }
}

int display(int num){

    int vetorDisplay[] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0xF7F,0x67}; //Numeros de 0 a 9 no display, representados em hexa
    int aux;
    
    aux = vetorDisplay[num];
    
    return aux;
}

void contagem(){

     while(mais == 1){
       cont = cont + 10;
       delay_ms(180);
       if(cont > 300)
         cont = 300;
     }
     
     while(menos == 1){
       cont = cont - 10;
       delay_ms(180);
       if(cont < 1)
         cont = 0;
     }
}