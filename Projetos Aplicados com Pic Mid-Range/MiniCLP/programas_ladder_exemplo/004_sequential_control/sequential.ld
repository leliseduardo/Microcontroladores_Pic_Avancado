LDmicro0.1
MICRO=Microchip PIC16F877 40-PDIP
CYCLE=10000
CRYSTAL=16000000
BAUD=2400
COMPILED=C:\You Tube - Meu Canal\ZZZ_Séries_Patrocinadas\Projetos Aplicados com PIC Mid-Range\PIC_MidRange_017__Mini_CLP__p3\PIC_mid_WR_files_017\programas_ladder_exemplo\004_sequential_control\sequential.hex

IO LIST
    Xin1 at 38
    Yout1 at 35
    Yout2 at 34
    Yout3 at 33
END

PROGRAM
RUNG
    CONTACTS Rtmr 0
    TON Ton 250000
    TOF Toff 250000
    COIL Rtmr 1 0 0
END
RUNG
    CONTACTS Xin1 1
    CONTACTS Rtmr 0
    CTC Coption 3
END
RUNG
    EQU Coption 0
    COIL Yout1 0 0 0
END
RUNG
    PARALLEL
        EQU Coption 1
        EQU Coption 3
    END
    COIL Yout2 0 0 0
END
RUNG
    EQU Coption 2
    COIL Yout3 0 0 0
END
