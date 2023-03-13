
_main:

;HelloWorld3.c,27 :: 		void main() {
;HelloWorld3.c,29 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;HelloWorld3.c,30 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
	MOVLW       254
	MOVWF       TRISB+0 
;HelloWorld3.c,31 :: 		PORTB = 0xFE; // Inicia todos as entradas digitais em High
	MOVLW       254
	MOVWF       PORTB+0 
;HelloWorld3.c,32 :: 		LATB0_bit = 0x00; // Inicia LATB0 em Low
	BCF         LATB0_bit+0, 0 
;HelloWorld3.c,35 :: 		while(1){
L_main0:
;HelloWorld3.c,37 :: 		pisca_Led();
	CALL        _pisca_Led+0, 0
;HelloWorld3.c,39 :: 		var1 = 5555;
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,40 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,41 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,42 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,43 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,44 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,45 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,46 :: 		var8 = 555251;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
;HelloWorld3.c,49 :: 		var1 = 5555;
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,50 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,51 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,52 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,53 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,54 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,55 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,56 :: 		var8 = 555251; var1 = 5555;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,57 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,58 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,59 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,60 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,61 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,62 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,63 :: 		var8 = 555251; var1 = 5555;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,64 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,65 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,66 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,67 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,68 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,69 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,70 :: 		var8 = 555251; var1 = 5555;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,71 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,72 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,73 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,74 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,75 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,76 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,77 :: 		var8 = 555251; var1 = 5555;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,78 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,79 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,80 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,81 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,82 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,83 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,84 :: 		var8 = 555251; var1 = 5555;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,85 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,86 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,87 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,88 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,89 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,90 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,91 :: 		var8 = 555251; var1 = 5555;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,92 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,93 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,94 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,95 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,96 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,97 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,98 :: 		var8 = 555251; var1 = 5555;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,99 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,100 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,101 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,102 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,103 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,104 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,105 :: 		var8 = 555251; var1 = 5555;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,106 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,107 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,108 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,109 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,110 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,111 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,112 :: 		var8 = 555251; var1 = 5555;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,113 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,114 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,115 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,116 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,117 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,118 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,119 :: 		var8 = 555251; var1 = 5555;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,120 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,121 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,122 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,123 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,124 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,125 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,126 :: 		var8 = 555251; var1 = 5555;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,127 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,128 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,129 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,130 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,131 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,132 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,133 :: 		var8 = 555251; var1 = 5555;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,134 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,135 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,136 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,137 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,138 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,139 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,140 :: 		var8 = 555251; var1 = 5555;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,141 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,142 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,143 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,144 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,145 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,146 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,147 :: 		var8 = 555251; var1 = 5555;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,148 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,149 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,150 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,151 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,152 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,153 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,154 :: 		var8 = 555251; var1 = 5555;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,155 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,156 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,157 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,158 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,159 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,160 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,161 :: 		var8 = 555251; var1 = 5555;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,162 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,163 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,164 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,165 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,166 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,167 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,168 :: 		var8 = 555251; var1 = 5555;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,169 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,170 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,171 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,172 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,173 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,174 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,175 :: 		var8 = 555251; var1 = 5555;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
	MOVLW       179
	MOVWF       _var1+0 
	MOVLW       21
	MOVWF       _var1+1 
	MOVLW       0
	MOVWF       _var1+2 
	MOVWF       _var1+3 
;HelloWorld3.c,176 :: 		var2 = 888888;
	MOVLW       56
	MOVWF       _var2+0 
	MOVLW       144
	MOVWF       _var2+1 
	MOVLW       13
	MOVWF       _var2+2 
	MOVLW       0
	MOVWF       _var2+3 
;HelloWorld3.c,177 :: 		var3 = 4444;
	MOVLW       92
	MOVWF       _var3+0 
	MOVLW       17
	MOVWF       _var3+1 
	MOVLW       0
	MOVWF       _var3+2 
	MOVWF       _var3+3 
;HelloWorld3.c,178 :: 		var4 = 7777;
	MOVLW       97
	MOVWF       _var4+0 
	MOVLW       30
	MOVWF       _var4+1 
	MOVLW       0
	MOVWF       _var4+2 
	MOVWF       _var4+3 
;HelloWorld3.c,179 :: 		var5 = 777777;
	MOVLW       49
	MOVWF       _var5+0 
	MOVLW       222
	MOVWF       _var5+1 
	MOVLW       11
	MOVWF       _var5+2 
	MOVLW       0
	MOVWF       _var5+3 
;HelloWorld3.c,180 :: 		var6 = 8888;
	MOVLW       184
	MOVWF       _var6+0 
	MOVLW       34
	MOVWF       _var6+1 
	MOVLW       0
	MOVWF       _var6+2 
	MOVWF       _var6+3 
;HelloWorld3.c,181 :: 		var7 = 666666;
	MOVLW       42
	MOVWF       _var7+0 
	MOVLW       44
	MOVWF       _var7+1 
	MOVLW       10
	MOVWF       _var7+2 
	MOVLW       0
	MOVWF       _var7+3 
;HelloWorld3.c,182 :: 		var8 = 555251;
	MOVLW       243
	MOVWF       _var8+0 
	MOVLW       120
	MOVWF       _var8+1 
	MOVLW       8
	MOVWF       _var8+2 
	MOVLW       0
	MOVWF       _var8+3 
;HelloWorld3.c,184 :: 		} // end loop infinito
	GOTO        L_main0
;HelloWorld3.c,186 :: 		} // end void main
	GOTO        $+0
; end of _main

_pisca_Led:

;HelloWorld3.c,188 :: 		void pisca_Led(){
;HelloWorld3.c,190 :: 		LATB0_bit = 0x01;
	BSF         LATB0_bit+0, 0 
;HelloWorld3.c,191 :: 		delay_ms(200);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_pisca_Led2:
	DECFSZ      R13, 1, 1
	BRA         L_pisca_Led2
	DECFSZ      R12, 1, 1
	BRA         L_pisca_Led2
	DECFSZ      R11, 1, 1
	BRA         L_pisca_Led2
;HelloWorld3.c,192 :: 		LATB0_bit = 0x00;
	BCF         LATB0_bit+0, 0 
;HelloWorld3.c,193 :: 		delay_ms(200);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_pisca_Led3:
	DECFSZ      R13, 1, 1
	BRA         L_pisca_Led3
	DECFSZ      R12, 1, 1
	BRA         L_pisca_Led3
	DECFSZ      R11, 1, 1
	BRA         L_pisca_Led3
;HelloWorld3.c,195 :: 		} // end void pisca_Led
	RETURN      0
; end of _pisca_Led
