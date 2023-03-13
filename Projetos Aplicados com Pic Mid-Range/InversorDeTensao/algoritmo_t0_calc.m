%
%  Algoritmo para obten��o de bases de tempo precisas 
%  com interrup��o do Timer0 do PIC12F675
%
%  Ferramenta: Octave 3.8
%
%  Autor: Eng. Wagner Rambo
%
%  www.wrkits.com.br 
%
%  Data: Abril de 2018
%

Freq      = 16E6;                  % Frequ�ncia principal
CM        = 4/16E6;                % Ciclo de M�quina
PS        = 256;                   % Prescaler Timer0
Tovf      = 8.333E-3;              % Base de tempo desejada
CC_ISR    = 26;                    % Ciclos Constantes na Interrup��o

TMR0      = 256-(Tovf/(PS*CM))    % C�lculo do TMR0

TMR0_i    = ceil(TMR0)            % Calcula o TMR0 inteiro mais pr�ximo


Tovf_r    = (256-TMR0_i)*PS*CM    % Reaplica na equa��o


Tovf_err  = Tovf - Tovf_r         % Calcula o erro

cic_C     = (Tovf_err/CM)-CC_ISR  % Calcula os ciclos de compensa��o


