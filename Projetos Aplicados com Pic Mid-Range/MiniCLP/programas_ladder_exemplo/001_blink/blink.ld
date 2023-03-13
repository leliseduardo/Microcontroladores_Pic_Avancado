LDmicro0.1
MICRO=Microchip PIC16F877 40-PDIP
CYCLE=10000
CRYSTAL=16000000
BAUD=2400
COMPILED=C:\You Tube - Meu Canal\ZZZ_Séries_Patrocinadas\Projetos Aplicados com PIC Mid-Range\PIC_MidRange_017__Mini_CLP__p3\PIC_mid_WR_files_017\programas_ladder_exemplo\001_blink\blink.hex

IO LIST
    Yout1 at 35
END

PROGRAM
RUNG
    CONTACTS Rblk 0
    TON Ton 555000
    TOF Tnew 555000
    COIL Rblk 1 0 0
END
RUNG
    CONTACTS Rblk 0
    COIL Yout1 0 0 0
END
