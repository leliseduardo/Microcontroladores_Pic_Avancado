#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/ShiftLeftLeds/MikroC/ShiftLeftLeds.c"

int control = 0b11111111;

void main() {

 TRISB = 0;
 PORTB = 0b11111111;

 while(1){

 PORTB = control;

 control = control << 1;
 delay_ms(200);

 if(control == 0)
 control = 0b11111111;

 }

}
