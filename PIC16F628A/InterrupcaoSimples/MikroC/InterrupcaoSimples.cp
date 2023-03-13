#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/InterrupcaoSimples/MikroC/InterrupcaoSimples.c"
int cont = 0x00;

void interrupt(){
 if(T0IF_bit){
 cont++;
 TMR0 = 0x06;

 T0IF_bit = 0x00;
 }
}

void main() {

 OPTION_REG = 0x81;
 GIE_bit = 0x01;
 PEIE_bit = 0x01;
 T0IE_bit = 0x01;

 TMR0 = 0x06;

 TRISB.RB4 = 0x00;
 RB4_bit = 0x00;

 while(1){
 if(cont == 500){
 RB4_bit = ~RB4_bit;
 cont = 0x00;
 }
 }

}
