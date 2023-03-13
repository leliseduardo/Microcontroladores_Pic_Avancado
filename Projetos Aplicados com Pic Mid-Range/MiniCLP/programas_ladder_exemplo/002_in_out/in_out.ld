LDmicro0.1
MICRO=Microchip PIC16F877 40-PDIP
CYCLE=10000
CRYSTAL=16000000
BAUD=2400
COMPILED=C:\You Tube - Meu Canal\ZZZ_Séries_Patrocinadas\Projetos Aplicados com PIC Mid-Range\PIC_MidRange_017__Mini_CLP__p3\PIC_mid_WR_files_017\programas_ladder_exemplo\002_in_out\in_out.hex

IO LIST
    Xin1 at 38
    Yout1 at 35
END

PROGRAM
RUNG
    CONTACTS Xin1 0
    COIL Yout1 0 0 0
END
