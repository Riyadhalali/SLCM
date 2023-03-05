
_Gpio_Init:

;Solar_Loads_Controller_SLCM_V1.c,132 :: 		void Gpio_Init()
;Solar_Loads_Controller_SLCM_V1.c,134 :: 		DDRB=0xFF; // set as output for 7 segment
	LDI        R27, 255
	OUT        DDRB+0, R27
;Solar_Loads_Controller_SLCM_V1.c,135 :: 		DDRC.B4=1; // display 1
	IN         R27, DDRC+0
	SBR        R27, 16
	OUT        DDRC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,136 :: 		DDRC.B5=1; // display 2
	IN         R27, DDRC+0
	SBR        R27, 32
	OUT        DDRC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,137 :: 		DDRC.B6=1; // display 3
	IN         R27, DDRC+0
	SBR        R27, 64
	OUT        DDRC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,138 :: 		DDRA.B5=0; // increment as input
	IN         R27, DDRA+0
	CBR        R27, 32
	OUT        DDRA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,139 :: 		DDRA.B6=0; // decrement as input
	IN         R27, DDRA+0
	CBR        R27, 64
	OUT        DDRA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,140 :: 		DDRD.B3=0;  // set as input
	IN         R27, DDRD+0
	CBR        R27, 8
	OUT        DDRD+0, R27
;Solar_Loads_Controller_SLCM_V1.c,141 :: 		DDRD.B2=0; // ac available as input
	IN         R27, DDRD+0
	CBR        R27, 4
	OUT        DDRD+0, R27
;Solar_Loads_Controller_SLCM_V1.c,142 :: 		DDRA.B3=1; // relay as output
	IN         R27, DDRA+0
	SBR        R27, 8
	OUT        DDRA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,143 :: 		DDRC.B3=1; // grid indicator led
	IN         R27, DDRC+0
	SBR        R27, 8
	OUT        DDRC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,144 :: 		}      //------------------------------------------------------------------------------
L_end_Gpio_Init:
	RET
; end of _Gpio_Init

_Config:

;Solar_Loads_Controller_SLCM_V1.c,145 :: 		void Config()
;Solar_Loads_Controller_SLCM_V1.c,147 :: 		GPIO_Init();
	CALL       _Gpio_Init+0
;Solar_Loads_Controller_SLCM_V1.c,148 :: 		}
L_end_Config:
	RET
; end of _Config

_Write_Time:

;Solar_Loads_Controller_SLCM_V1.c,152 :: 		void Write_Time(unsigned int seconds,unsigned int minutes,unsigned int hours)
;Solar_Loads_Controller_SLCM_V1.c,154 :: 		write_Ds1307(0x00,seconds);           //seconds
	PUSH       R2
	PUSH       R3
	MOVW       R16, R2
	PUSH       R7
	PUSH       R6
	PUSH       R5
	PUSH       R4
	MOV        R3, R16
	CLR        R2
	CALL       _write_Ds1307+0
	POP        R4
	POP        R5
;Solar_Loads_Controller_SLCM_V1.c,155 :: 		write_Ds1307(0x01,minutes);          // minutes
	MOVW       R16, R4
	MOV        R3, R16
	LDI        R27, 1
	MOV        R2, R27
	CALL       _write_Ds1307+0
	POP        R6
	POP        R7
;Solar_Loads_Controller_SLCM_V1.c,156 :: 		write_Ds1307(0x02,hours); // using the 24 hour system
	MOVW       R16, R6
	MOV        R3, R16
	LDI        R27, 2
	MOV        R2, R27
	CALL       _write_Ds1307+0
;Solar_Loads_Controller_SLCM_V1.c,157 :: 		}
L_end_Write_Time:
	POP        R3
	POP        R2
	RET
; end of _Write_Time

_Write_Date:

;Solar_Loads_Controller_SLCM_V1.c,160 :: 		void Write_Date(unsigned int day, unsigned int month,unsigned int year)
;Solar_Loads_Controller_SLCM_V1.c,162 :: 		write_Ds1307(0x04,day);          //01-31
	PUSH       R2
	PUSH       R3
	MOVW       R16, R2
	PUSH       R7
	PUSH       R6
	PUSH       R5
	PUSH       R4
	MOV        R3, R16
	LDI        R27, 4
	MOV        R2, R27
	CALL       _write_Ds1307+0
	POP        R4
	POP        R5
;Solar_Loads_Controller_SLCM_V1.c,163 :: 		Write_Ds1307(0x05,month);       //01-12
	MOVW       R16, R4
	MOV        R3, R16
	LDI        R27, 5
	MOV        R2, R27
	CALL       _write_Ds1307+0
	POP        R6
	POP        R7
;Solar_Loads_Controller_SLCM_V1.c,164 :: 		Write_Ds1307(0x06,year);       // 00-99
	MOVW       R16, R6
	MOV        R3, R16
	LDI        R27, 6
	MOV        R2, R27
	CALL       _write_Ds1307+0
;Solar_Loads_Controller_SLCM_V1.c,165 :: 		}
L_end_Write_Date:
	POP        R3
	POP        R2
	RET
; end of _Write_Date

_EEPROM_Load:

;Solar_Loads_Controller_SLCM_V1.c,167 :: 		void EEPROM_Load()
;Solar_Loads_Controller_SLCM_V1.c,170 :: 		hours_lcd_1=EEPROM_Read(0x00);
	PUSH       R2
	PUSH       R3
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_1+0, R16
;Solar_Loads_Controller_SLCM_V1.c,171 :: 		minutes_lcd_1=EEPROM_Read(0x01);
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_1+0, R16
;Solar_Loads_Controller_SLCM_V1.c,172 :: 		hours_lcd_2=EEPROM_Read(0x02);
	LDI        R27, 2
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_2+0, R16
;Solar_Loads_Controller_SLCM_V1.c,173 :: 		minutes_lcd_2=EEPROM_Read(0x03);
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_2+0, R16
;Solar_Loads_Controller_SLCM_V1.c,174 :: 		RunOnBatteryVoltageWithoutTimer_Flag=EEPROM_Read(0x14);
	LDI        R27, 20
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _RunOnBatteryVoltageWithoutTimer_Flag+0, R16
;Solar_Loads_Controller_SLCM_V1.c,176 :: 		ByPassState=0;   // enable is zero  // delete function to be programmed for rom spac
	LDI        R27, 0
	STS        _ByPassState+0, R27
;Solar_Loads_Controller_SLCM_V1.c,177 :: 		Timer_Enable=1;      // delete function to be programmed for rom space
	LDI        R27, 1
	STS        _Timer_Enable+0, R27
;Solar_Loads_Controller_SLCM_V1.c,179 :: 		}
L_end_EEPROM_Load:
	POP        R3
	POP        R2
	RET
; end of _EEPROM_Load

_StoreBytesIntoEEprom:

;Solar_Loads_Controller_SLCM_V1.c,182 :: 		void StoreBytesIntoEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
;Solar_Loads_Controller_SLCM_V1.c,185 :: 		for (j=0;j<SizeinBytes;j++)
; j start address is: 19 (R19)
	LDI        R19, 0
	LDI        R20, 0
; j end address is: 19 (R19)
L_StoreBytesIntoEEprom0:
; j start address is: 19 (R19)
	CP         R19, R6
	CPC        R20, R7
	BRLO       L__StoreBytesIntoEEprom560
	JMP        L_StoreBytesIntoEEprom1
L__StoreBytesIntoEEprom560:
;Solar_Loads_Controller_SLCM_V1.c,187 :: 		EEprom_Write(address+j,*(ptr+j));
	MOV        R30, R19
	MOV        R31, R20
	ADD        R30, R4
	ADC        R31, R5
	LD         R18, Z
	MOV        R16, R19
	MOV        R17, R20
	ADD        R16, R2
	ADC        R17, R3
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	MOV        R4, R18
	MOVW       R2, R16
	CALL       _EEPROM_Write+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
;Solar_Loads_Controller_SLCM_V1.c,188 :: 		Delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_StoreBytesIntoEEprom3:
	DEC        R16
	BRNE       L_StoreBytesIntoEEprom3
	DEC        R17
	BRNE       L_StoreBytesIntoEEprom3
	DEC        R18
	BRNE       L_StoreBytesIntoEEprom3
;Solar_Loads_Controller_SLCM_V1.c,185 :: 		for (j=0;j<SizeinBytes;j++)
	MOV        R16, R19
	MOV        R17, R20
	SUBI       R16, 255
	SBCI       R17, 255
	MOV        R19, R16
	MOV        R20, R17
;Solar_Loads_Controller_SLCM_V1.c,189 :: 		};
; j end address is: 19 (R19)
	JMP        L_StoreBytesIntoEEprom0
L_StoreBytesIntoEEprom1:
;Solar_Loads_Controller_SLCM_V1.c,190 :: 		}
L_end_StoreBytesIntoEEprom:
	RET
; end of _StoreBytesIntoEEprom

_ReadBytesFromEEprom:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;Solar_Loads_Controller_SLCM_V1.c,193 :: 		void ReadBytesFromEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
;Solar_Loads_Controller_SLCM_V1.c,196 :: 		for (j=0;j<SizeinBytes;j++)
; j start address is: 19 (R19)
	LDI        R19, 0
	LDI        R20, 0
; j end address is: 19 (R19)
L_ReadBytesFromEEprom5:
; j start address is: 19 (R19)
	CP         R19, R6
	CPC        R20, R7
	BRLO       L__ReadBytesFromEEprom562
	JMP        L_ReadBytesFromEEprom6
L__ReadBytesFromEEprom562:
;Solar_Loads_Controller_SLCM_V1.c,198 :: 		*(ptr+j)=EEPROM_Read(address+j);
	MOV        R16, R19
	MOV        R17, R20
	ADD        R16, R4
	ADC        R17, R5
	STD        Y+0, R16
	STD        Y+1, R17
	MOV        R16, R19
	MOV        R17, R20
	ADD        R16, R2
	ADC        R17, R3
	PUSH       R3
	PUSH       R2
	MOVW       R2, R16
	CALL       _EEPROM_Read+0
	POP        R2
	POP        R3
	LDD        R17, Y+0
	LDD        R18, Y+1
	MOV        R30, R17
	MOV        R31, R18
	ST         Z, R16
;Solar_Loads_Controller_SLCM_V1.c,199 :: 		Delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_ReadBytesFromEEprom8:
	DEC        R16
	BRNE       L_ReadBytesFromEEprom8
	DEC        R17
	BRNE       L_ReadBytesFromEEprom8
	DEC        R18
	BRNE       L_ReadBytesFromEEprom8
;Solar_Loads_Controller_SLCM_V1.c,196 :: 		for (j=0;j<SizeinBytes;j++)
	MOV        R16, R19
	MOV        R17, R20
	SUBI       R16, 255
	SBCI       R17, 255
	MOV        R19, R16
	MOV        R20, R17
;Solar_Loads_Controller_SLCM_V1.c,200 :: 		}
; j end address is: 19 (R19)
	JMP        L_ReadBytesFromEEprom5
L_ReadBytesFromEEprom6:
;Solar_Loads_Controller_SLCM_V1.c,201 :: 		}
L_end_ReadBytesFromEEprom:
	ADIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _ReadBytesFromEEprom

_Check_Timers:

;Solar_Loads_Controller_SLCM_V1.c,203 :: 		void Check_Timers()
;Solar_Loads_Controller_SLCM_V1.c,206 :: 		matched_timer_1_start=CheckTimeOccuredOn(seconds_lcd_1,minutes_lcd_1,hours_lcd_1);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDS        R4, _hours_lcd_1+0
	LDS        R3, _minutes_lcd_1+0
	LDS        R2, _seconds_lcd_1+0
	CALL       _CheckTimeOccuredOn+0
	STS        _matched_timer_1_start+0, R16
;Solar_Loads_Controller_SLCM_V1.c,207 :: 		matched_timer_1_stop=CheckTimeOccuredOff(seconds_lcd_2,minutes_lcd_2,hours_lcd_2);
	LDS        R4, _hours_lcd_2+0
	LDS        R3, _minutes_lcd_2+0
	LDS        R2, _seconds_lcd_2+0
	CALL       _CheckTimeOccuredOff+0
	STS        _matched_timer_1_stop+0, R16
;Solar_Loads_Controller_SLCM_V1.c,210 :: 		if (matched_timer_1_start==1)
	LDS        R16, _matched_timer_1_start+0
	CPI        R16, 1
	BREQ       L__Check_Timers564
	JMP        L_Check_Timers10
L__Check_Timers564:
;Solar_Loads_Controller_SLCM_V1.c,212 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,213 :: 		TurnOffLoadsByPass=0;
	LDI        R27, 0
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Loads_Controller_SLCM_V1.c,215 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && RunOnBatteryVoltageWithoutTimer_Flag==0)
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers437
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers565
	JMP        L__Check_Timers436
L__Check_Timers565:
	LDS        R20, _StartLoadsVoltage+0
	LDS        R21, _StartLoadsVoltage+1
	LDS        R22, _StartLoadsVoltage+2
	LDS        R23, _StartLoadsVoltage+3
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_gequ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__Check_Timers566
	LDI        R16, 1
L__Check_Timers566:
	TST        R16
	BRNE       L__Check_Timers567
	JMP        L__Check_Timers435
L__Check_Timers567:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers568
	JMP        L__Check_Timers434
L__Check_Timers568:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers569
	JMP        L__Check_Timers433
L__Check_Timers569:
L__Check_Timers432:
;Solar_Loads_Controller_SLCM_V1.c,217 :: 		Relay_L_Solar=1;
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,215 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && RunOnBatteryVoltageWithoutTimer_Flag==0)
L__Check_Timers437:
L__Check_Timers436:
L__Check_Timers435:
L__Check_Timers434:
L__Check_Timers433:
;Solar_Loads_Controller_SLCM_V1.c,221 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true && RunOnBatteryVoltageWithoutTimer_Flag==0 )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers441
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers570
	JMP        L__Check_Timers440
L__Check_Timers570:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers571
	JMP        L__Check_Timers439
L__Check_Timers571:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers572
	JMP        L__Check_Timers438
L__Check_Timers572:
L__Check_Timers431:
;Solar_Loads_Controller_SLCM_V1.c,223 :: 		Relay_L_Solar=1;
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,221 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true && RunOnBatteryVoltageWithoutTimer_Flag==0 )
L__Check_Timers441:
L__Check_Timers440:
L__Check_Timers439:
L__Check_Timers438:
;Solar_Loads_Controller_SLCM_V1.c,225 :: 		} // end if ac_available
L_Check_Timers10:
;Solar_Loads_Controller_SLCM_V1.c,228 :: 		if (matched_timer_1_stop==1)
	LDS        R16, _matched_timer_1_stop+0
	CPI        R16, 1
	BREQ       L__Check_Timers573
	JMP        L_Check_Timers17
L__Check_Timers573:
;Solar_Loads_Controller_SLCM_V1.c,230 :: 		Timer_isOn=0;        // to continue the timer after breakout the timer when grid is available
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,233 :: 		if (AC_Available==1 && Timer_Enable==1  &&  RunWithOutBattery==false  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers445
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers574
	JMP        L__Check_Timers444
L__Check_Timers574:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers575
	JMP        L__Check_Timers443
L__Check_Timers575:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers576
	JMP        L__Check_Timers442
L__Check_Timers576:
L__Check_Timers430:
;Solar_Loads_Controller_SLCM_V1.c,236 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,237 :: 		Relay_L_Solar=0; // relay off
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,233 :: 		if (AC_Available==1 && Timer_Enable==1  &&  RunWithOutBattery==false  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
L__Check_Timers445:
L__Check_Timers444:
L__Check_Timers443:
L__Check_Timers442:
;Solar_Loads_Controller_SLCM_V1.c,239 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers449
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers577
	JMP        L__Check_Timers448
L__Check_Timers577:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers578
	JMP        L__Check_Timers447
L__Check_Timers578:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers579
	JMP        L__Check_Timers446
L__Check_Timers579:
L__Check_Timers429:
;Solar_Loads_Controller_SLCM_V1.c,242 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,243 :: 		Relay_L_Solar=0; // relay off
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,239 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
L__Check_Timers449:
L__Check_Timers448:
L__Check_Timers447:
L__Check_Timers446:
;Solar_Loads_Controller_SLCM_V1.c,245 :: 		}
L_Check_Timers17:
;Solar_Loads_Controller_SLCM_V1.c,264 :: 		if(AC_Available==0 )
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L_Check_Timers24
;Solar_Loads_Controller_SLCM_V1.c,266 :: 		Delay_ms(300);       // for error to get one seconds approxmiallty
	LDI        R18, 13
	LDI        R17, 45
	LDI        R16, 216
L_Check_Timers25:
	DEC        R16
	BRNE       L_Check_Timers25
	DEC        R17
	BRNE       L_Check_Timers25
	DEC        R18
	BRNE       L_Check_Timers25
	NOP
	NOP
;Solar_Loads_Controller_SLCM_V1.c,267 :: 		SecondsRealTime++;
	LDS        R16, _SecondsRealTime+0
	LDS        R17, _SecondsRealTime+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _SecondsRealTime+0, R18
	STS        _SecondsRealTime+1, R19
;Solar_Loads_Controller_SLCM_V1.c,268 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R18, R16
	CPC        R19, R17
	BRSH       L__Check_Timers580
	JMP        L__Check_Timers451
L__Check_Timers580:
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L__Check_Timers450
L__Check_Timers428:
;Solar_Loads_Controller_SLCM_V1.c,270 :: 		Relay_L_Solar=1;
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,268 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
L__Check_Timers451:
L__Check_Timers450:
;Solar_Loads_Controller_SLCM_V1.c,272 :: 		} // end function of voltage protector
L_Check_Timers24:
;Solar_Loads_Controller_SLCM_V1.c,278 :: 		if (AC_Available==1 && Timer_isOn==1 && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0)
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers457
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers581
	JMP        L__Check_Timers456
L__Check_Timers581:
	LDS        R20, _StartLoadsVoltage+0
	LDS        R21, _StartLoadsVoltage+1
	LDS        R22, _StartLoadsVoltage+2
	LDS        R23, _StartLoadsVoltage+3
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_gequ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__Check_Timers582
	LDI        R16, 1
L__Check_Timers582:
	TST        R16
	BRNE       L__Check_Timers583
	JMP        L__Check_Timers455
L__Check_Timers583:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers584
	JMP        L__Check_Timers454
L__Check_Timers584:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers585
	JMP        L__Check_Timers453
L__Check_Timers585:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers586
	JMP        L__Check_Timers452
L__Check_Timers586:
L__Check_Timers427:
;Solar_Loads_Controller_SLCM_V1.c,281 :: 		SecondsRealTimePv_ReConnect_T1++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T1+0, R16
	STS        _SecondsRealTimePv_ReConnect_T1+1, R17
;Solar_Loads_Controller_SLCM_V1.c,282 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_Check_Timers33:
	DEC        R16
	BRNE       L_Check_Timers33
	DEC        R17
	BRNE       L_Check_Timers33
	DEC        R18
	BRNE       L_Check_Timers33
	NOP
;Solar_Loads_Controller_SLCM_V1.c,283 :: 		if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1)     Relay_L_Solar=1;
	LDS        R18, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T1+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers587
	JMP        L_Check_Timers35
L__Check_Timers587:
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
L_Check_Timers35:
;Solar_Loads_Controller_SLCM_V1.c,278 :: 		if (AC_Available==1 && Timer_isOn==1 && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0)
L__Check_Timers457:
L__Check_Timers456:
L__Check_Timers455:
L__Check_Timers454:
L__Check_Timers453:
L__Check_Timers452:
;Solar_Loads_Controller_SLCM_V1.c,286 :: 		if (AC_Available==1 && Timer_isOn==1  && RunWithOutBattery==true && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0 )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers462
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers588
	JMP        L__Check_Timers461
L__Check_Timers588:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers589
	JMP        L__Check_Timers460
L__Check_Timers589:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers590
	JMP        L__Check_Timers459
L__Check_Timers590:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers591
	JMP        L__Check_Timers458
L__Check_Timers591:
L__Check_Timers426:
;Solar_Loads_Controller_SLCM_V1.c,288 :: 		SecondsRealTimePv_ReConnect_T1++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T1+0, R16
	STS        _SecondsRealTimePv_ReConnect_T1+1, R17
;Solar_Loads_Controller_SLCM_V1.c,289 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_Check_Timers39:
	DEC        R16
	BRNE       L_Check_Timers39
	DEC        R17
	BRNE       L_Check_Timers39
	DEC        R18
	BRNE       L_Check_Timers39
	NOP
;Solar_Loads_Controller_SLCM_V1.c,291 :: 		if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1) Relay_L_Solar=1;
	LDS        R18, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T1+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers592
	JMP        L_Check_Timers41
L__Check_Timers592:
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
L_Check_Timers41:
;Solar_Loads_Controller_SLCM_V1.c,286 :: 		if (AC_Available==1 && Timer_isOn==1  && RunWithOutBattery==true && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0 )
L__Check_Timers462:
L__Check_Timers461:
L__Check_Timers460:
L__Check_Timers459:
L__Check_Timers458:
;Solar_Loads_Controller_SLCM_V1.c,295 :: 		if (AC_Available==1 && Timer_isOn==0 && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==1)
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers468
	LDS        R16, _Timer_isOn+0
	CPI        R16, 0
	BREQ       L__Check_Timers593
	JMP        L__Check_Timers467
L__Check_Timers593:
	LDS        R20, _StartLoadsVoltage+0
	LDS        R21, _StartLoadsVoltage+1
	LDS        R22, _StartLoadsVoltage+2
	LDS        R23, _StartLoadsVoltage+3
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_gequ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__Check_Timers594
	LDI        R16, 1
L__Check_Timers594:
	TST        R16
	BRNE       L__Check_Timers595
	JMP        L__Check_Timers466
L__Check_Timers595:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers596
	JMP        L__Check_Timers465
L__Check_Timers596:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers597
	JMP        L__Check_Timers464
L__Check_Timers597:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 1
	BREQ       L__Check_Timers598
	JMP        L__Check_Timers463
L__Check_Timers598:
L__Check_Timers425:
;Solar_Loads_Controller_SLCM_V1.c,297 :: 		SecondsRealTimePv_ReConnect_T1++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T1+0, R16
	STS        _SecondsRealTimePv_ReConnect_T1+1, R17
;Solar_Loads_Controller_SLCM_V1.c,298 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_Check_Timers45:
	DEC        R16
	BRNE       L_Check_Timers45
	DEC        R17
	BRNE       L_Check_Timers45
	DEC        R18
	BRNE       L_Check_Timers45
	NOP
;Solar_Loads_Controller_SLCM_V1.c,299 :: 		if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1)     Relay_L_Solar=1;
	LDS        R18, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T1+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers599
	JMP        L_Check_Timers47
L__Check_Timers599:
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
L_Check_Timers47:
;Solar_Loads_Controller_SLCM_V1.c,295 :: 		if (AC_Available==1 && Timer_isOn==0 && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==1)
L__Check_Timers468:
L__Check_Timers467:
L__Check_Timers466:
L__Check_Timers465:
L__Check_Timers464:
L__Check_Timers463:
;Solar_Loads_Controller_SLCM_V1.c,305 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1 && Timer_isOn==1 && RunWithOutBattery==false && RunOnBatteryVoltageWithoutTimer_Flag==0)
	LDS        R20, _Mini_Battery_Voltage+0
	LDS        R21, _Mini_Battery_Voltage+1
	LDS        R22, _Mini_Battery_Voltage+2
	LDS        R23, _Mini_Battery_Voltage+3
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_less+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__Check_Timers600
	LDI        R16, 1
L__Check_Timers600:
	TST        R16
	BRNE       L__Check_Timers601
	JMP        L__Check_Timers473
L__Check_Timers601:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers472
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers602
	JMP        L__Check_Timers471
L__Check_Timers602:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers603
	JMP        L__Check_Timers470
L__Check_Timers603:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers604
	JMP        L__Check_Timers469
L__Check_Timers604:
L__Check_Timers424:
;Solar_Loads_Controller_SLCM_V1.c,307 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,308 :: 		Start_Timer_0_A();         // give some time for battery voltage
	CALL       _Start_Timer_0_A+0
;Solar_Loads_Controller_SLCM_V1.c,305 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1 && Timer_isOn==1 && RunWithOutBattery==false && RunOnBatteryVoltageWithoutTimer_Flag==0)
L__Check_Timers473:
L__Check_Timers472:
L__Check_Timers471:
L__Check_Timers470:
L__Check_Timers469:
;Solar_Loads_Controller_SLCM_V1.c,311 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1 && RunWithOutBattery==false && RunOnBatteryVoltageWithoutTimer_Flag==1)
	LDS        R20, _Mini_Battery_Voltage+0
	LDS        R21, _Mini_Battery_Voltage+1
	LDS        R22, _Mini_Battery_Voltage+2
	LDS        R23, _Mini_Battery_Voltage+3
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_less+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__Check_Timers605
	LDI        R16, 1
L__Check_Timers605:
	TST        R16
	BRNE       L__Check_Timers606
	JMP        L__Check_Timers477
L__Check_Timers606:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers476
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers607
	JMP        L__Check_Timers475
L__Check_Timers607:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 1
	BREQ       L__Check_Timers608
	JMP        L__Check_Timers474
L__Check_Timers608:
L__Check_Timers423:
;Solar_Loads_Controller_SLCM_V1.c,313 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,314 :: 		Start_Timer_0_A();         // give some time for battery voltage
	CALL       _Start_Timer_0_A+0
;Solar_Loads_Controller_SLCM_V1.c,311 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1 && RunWithOutBattery==false && RunOnBatteryVoltageWithoutTimer_Flag==1)
L__Check_Timers477:
L__Check_Timers476:
L__Check_Timers475:
L__Check_Timers474:
;Solar_Loads_Controller_SLCM_V1.c,317 :: 		}// end of check timers
L_end_Check_Timers:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _Check_Timers

_SetUpProgram:

;Solar_Loads_Controller_SLCM_V1.c,322 :: 		void SetUpProgram()
;Solar_Loads_Controller_SLCM_V1.c,324 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram54:
	DEC        R16
	BRNE       L_SetUpProgram54
	DEC        R17
	BRNE       L_SetUpProgram54
	DEC        R18
	BRNE       L_SetUpProgram54
	NOP
;Solar_Loads_Controller_SLCM_V1.c,329 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram56:
	DEC        R16
	BRNE       L_SetUpProgram56
	DEC        R17
	BRNE       L_SetUpProgram56
	DEC        R18
	BRNE       L_SetUpProgram56
	NOP
;Solar_Loads_Controller_SLCM_V1.c,333 :: 		while (Set==0)
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetUpProgram59
;Solar_Loads_Controller_SLCM_V1.c,337 :: 		SetTimerOn_1();
	CALL       _SetTimerOn_1+0
;Solar_Loads_Controller_SLCM_V1.c,338 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram60:
	DEC        R16
	BRNE       L_SetUpProgram60
	DEC        R17
	BRNE       L_SetUpProgram60
	DEC        R18
	BRNE       L_SetUpProgram60
	NOP
;Solar_Loads_Controller_SLCM_V1.c,339 :: 		SetTimerOff_1();
	CALL       _SetTimerOff_1+0
;Solar_Loads_Controller_SLCM_V1.c,340 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram62:
	DEC        R16
	BRNE       L_SetUpProgram62
	DEC        R17
	BRNE       L_SetUpProgram62
	DEC        R18
	BRNE       L_SetUpProgram62
	NOP
;Solar_Loads_Controller_SLCM_V1.c,341 :: 		SetLowBatteryVoltage();// program 3 to set low battery voltage
	CALL       _SetLowBatteryVoltage+0
;Solar_Loads_Controller_SLCM_V1.c,342 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram64:
	DEC        R16
	BRNE       L_SetUpProgram64
	DEC        R17
	BRNE       L_SetUpProgram64
	DEC        R18
	BRNE       L_SetUpProgram64
	NOP
;Solar_Loads_Controller_SLCM_V1.c,343 :: 		SetStartUpLoadsVoltage(); // program 4 to enable timer or disable
	CALL       _SetStartUpLoadsVoltage+0
;Solar_Loads_Controller_SLCM_V1.c,344 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram66:
	DEC        R16
	BRNE       L_SetUpProgram66
	DEC        R17
	BRNE       L_SetUpProgram66
	DEC        R18
	BRNE       L_SetUpProgram66
	NOP
;Solar_Loads_Controller_SLCM_V1.c,345 :: 		Startup_Timers();
	CALL       _Startup_Timers+0
;Solar_Loads_Controller_SLCM_V1.c,346 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram68:
	DEC        R16
	BRNE       L_SetUpProgram68
	DEC        R17
	BRNE       L_SetUpProgram68
	DEC        R18
	BRNE       L_SetUpProgram68
	NOP
;Solar_Loads_Controller_SLCM_V1.c,347 :: 		RunOnBatteryVoltageWithoutTimer();
	CALL       _RunOnBatteryVoltageWithoutTimer+0
;Solar_Loads_Controller_SLCM_V1.c,348 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram70:
	DEC        R16
	BRNE       L_SetUpProgram70
	DEC        R17
	BRNE       L_SetUpProgram70
	DEC        R18
	BRNE       L_SetUpProgram70
	NOP
;Solar_Loads_Controller_SLCM_V1.c,349 :: 		SetDS1307_Time();   // program 6
	CALL       _SetDS1307_Time+0
;Solar_Loads_Controller_SLCM_V1.c,350 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram72:
	DEC        R16
	BRNE       L_SetUpProgram72
	DEC        R17
	BRNE       L_SetUpProgram72
	DEC        R18
	BRNE       L_SetUpProgram72
	NOP
;Solar_Loads_Controller_SLCM_V1.c,353 :: 		} // end while
L_SetUpProgram59:
;Solar_Loads_Controller_SLCM_V1.c,354 :: 		}
L_end_SetUpProgram:
	RET
; end of _SetUpProgram

_SetTimerOn_1:

;Solar_Loads_Controller_SLCM_V1.c,356 :: 		void SetTimerOn_1()
;Solar_Loads_Controller_SLCM_V1.c,358 :: 		Delay_ms(500);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOn_174:
	DEC        R16
	BRNE       L_SetTimerOn_174
	DEC        R17
	BRNE       L_SetTimerOn_174
	DEC        R18
	BRNE       L_SetTimerOn_174
	NOP
;Solar_Loads_Controller_SLCM_V1.c,359 :: 		while(Set==0)
L_SetTimerOn_176:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetTimerOn_177
;Solar_Loads_Controller_SLCM_V1.c,361 :: 		Display_On_7Segment_Character(0x92,0x92,0xC7);
	LDI        R27, 199
	MOV        R4, R27
	LDI        R27, 146
	MOV        R3, R27
	LDI        R27, 146
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,362 :: 		}
	JMP        L_SetTimerOn_176
L_SetTimerOn_177:
;Solar_Loads_Controller_SLCM_V1.c,363 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOn_178:
	DEC        R16
	BRNE       L_SetTimerOn_178
	DEC        R17
	BRNE       L_SetTimerOn_178
	DEC        R18
	BRNE       L_SetTimerOn_178
	NOP
;Solar_Loads_Controller_SLCM_V1.c,364 :: 		while (Set==0)
L_SetTimerOn_180:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetTimerOn_181
;Solar_Loads_Controller_SLCM_V1.c,366 :: 		Display_On_7Segment(hours_lcd_1);
	LDS        R2, _hours_lcd_1+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,368 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_182:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetTimerOn_1481
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetTimerOn_1480
	JMP        L_SetTimerOn_183
L__SetTimerOn_1481:
L__SetTimerOn_1480:
;Solar_Loads_Controller_SLCM_V1.c,370 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetTimerOn_186
;Solar_Loads_Controller_SLCM_V1.c,372 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_187:
	DEC        R16
	BRNE       L_SetTimerOn_187
	DEC        R17
	BRNE       L_SetTimerOn_187
	DEC        R18
	BRNE       L_SetTimerOn_187
;Solar_Loads_Controller_SLCM_V1.c,373 :: 		hours_lcd_1++;
	LDS        R16, _hours_lcd_1+0
	SUBI       R16, 255
	STS        _hours_lcd_1+0, R16
;Solar_Loads_Controller_SLCM_V1.c,374 :: 		}
L_SetTimerOn_186:
;Solar_Loads_Controller_SLCM_V1.c,375 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetTimerOn_189
;Solar_Loads_Controller_SLCM_V1.c,377 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_190:
	DEC        R16
	BRNE       L_SetTimerOn_190
	DEC        R17
	BRNE       L_SetTimerOn_190
	DEC        R18
	BRNE       L_SetTimerOn_190
;Solar_Loads_Controller_SLCM_V1.c,378 :: 		hours_lcd_1--;
	LDS        R16, _hours_lcd_1+0
	SUBI       R16, 1
	STS        _hours_lcd_1+0, R16
;Solar_Loads_Controller_SLCM_V1.c,379 :: 		}
L_SetTimerOn_189:
;Solar_Loads_Controller_SLCM_V1.c,381 :: 		if  (hours_lcd_1>23) hours_lcd_1=0;
	LDS        R17, _hours_lcd_1+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOn_1611
	JMP        L_SetTimerOn_192
L__SetTimerOn_1611:
	LDI        R27, 0
	STS        _hours_lcd_1+0, R27
L_SetTimerOn_192:
;Solar_Loads_Controller_SLCM_V1.c,382 :: 		if  (hours_lcd_1<0) hours_lcd_1=0;
	LDS        R16, _hours_lcd_1+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_1612
	JMP        L_SetTimerOn_193
L__SetTimerOn_1612:
	LDI        R27, 0
	STS        _hours_lcd_1+0, R27
L_SetTimerOn_193:
;Solar_Loads_Controller_SLCM_V1.c,383 :: 		Timer_isOn=0; //
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,384 :: 		SecondsRealTimePv_ReConnect_T1=0;    //
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,385 :: 		} // end while increment
	JMP        L_SetTimerOn_182
L_SetTimerOn_183:
;Solar_Loads_Controller_SLCM_V1.c,386 :: 		} // end first while
	JMP        L_SetTimerOn_180
L_SetTimerOn_181:
;Solar_Loads_Controller_SLCM_V1.c,389 :: 		EEPROM_Write(0x00,hours_lcd_1); // save hours 1 timer tp eeprom
	LDS        R4, _hours_lcd_1+0
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,390 :: 		Delay_ms(500);     //read time for state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOn_194:
	DEC        R16
	BRNE       L_SetTimerOn_194
	DEC        R17
	BRNE       L_SetTimerOn_194
	DEC        R18
	BRNE       L_SetTimerOn_194
	NOP
;Solar_Loads_Controller_SLCM_V1.c,391 :: 		while (Set==0)
L_SetTimerOn_196:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetTimerOn_197
;Solar_Loads_Controller_SLCM_V1.c,393 :: 		Display_On_7Segment(minutes_lcd_1);
	LDS        R2, _minutes_lcd_1+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,395 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_198:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetTimerOn_1483
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetTimerOn_1482
	JMP        L_SetTimerOn_199
L__SetTimerOn_1483:
L__SetTimerOn_1482:
;Solar_Loads_Controller_SLCM_V1.c,397 :: 		if (Increment==1  )
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetTimerOn_1102
;Solar_Loads_Controller_SLCM_V1.c,399 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_1103:
	DEC        R16
	BRNE       L_SetTimerOn_1103
	DEC        R17
	BRNE       L_SetTimerOn_1103
	DEC        R18
	BRNE       L_SetTimerOn_1103
;Solar_Loads_Controller_SLCM_V1.c,400 :: 		minutes_lcd_1++;
	LDS        R16, _minutes_lcd_1+0
	SUBI       R16, 255
	STS        _minutes_lcd_1+0, R16
;Solar_Loads_Controller_SLCM_V1.c,401 :: 		}
L_SetTimerOn_1102:
;Solar_Loads_Controller_SLCM_V1.c,402 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetTimerOn_1105
;Solar_Loads_Controller_SLCM_V1.c,404 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_1106:
	DEC        R16
	BRNE       L_SetTimerOn_1106
	DEC        R17
	BRNE       L_SetTimerOn_1106
	DEC        R18
	BRNE       L_SetTimerOn_1106
;Solar_Loads_Controller_SLCM_V1.c,405 :: 		minutes_lcd_1--;
	LDS        R16, _minutes_lcd_1+0
	SUBI       R16, 1
	STS        _minutes_lcd_1+0, R16
;Solar_Loads_Controller_SLCM_V1.c,406 :: 		}
L_SetTimerOn_1105:
;Solar_Loads_Controller_SLCM_V1.c,408 :: 		if (minutes_lcd_1>59)    minutes_lcd_1=0;
	LDS        R17, _minutes_lcd_1+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOn_1613
	JMP        L_SetTimerOn_1108
L__SetTimerOn_1613:
	LDI        R27, 0
	STS        _minutes_lcd_1+0, R27
L_SetTimerOn_1108:
;Solar_Loads_Controller_SLCM_V1.c,409 :: 		if (minutes_lcd_1<0) minutes_lcd_1=0;
	LDS        R16, _minutes_lcd_1+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_1614
	JMP        L_SetTimerOn_1109
L__SetTimerOn_1614:
	LDI        R27, 0
	STS        _minutes_lcd_1+0, R27
L_SetTimerOn_1109:
;Solar_Loads_Controller_SLCM_V1.c,410 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,411 :: 		Timer_isOn=0;
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,412 :: 		} // end while increment and decrement
	JMP        L_SetTimerOn_198
L_SetTimerOn_199:
;Solar_Loads_Controller_SLCM_V1.c,413 :: 		} // end first while
	JMP        L_SetTimerOn_196
L_SetTimerOn_197:
;Solar_Loads_Controller_SLCM_V1.c,415 :: 		EEPROM_Write(0x01,minutes_lcd_1); // save minutes 1 timer tp eeprom
	LDS        R4, _minutes_lcd_1+0
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,416 :: 		}
L_end_SetTimerOn_1:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOn_1

_SetTimerOff_1:

;Solar_Loads_Controller_SLCM_V1.c,418 :: 		void SetTimerOff_1()
;Solar_Loads_Controller_SLCM_V1.c,420 :: 		Delay_ms(500);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_1110:
	DEC        R16
	BRNE       L_SetTimerOff_1110
	DEC        R17
	BRNE       L_SetTimerOff_1110
	DEC        R18
	BRNE       L_SetTimerOff_1110
	NOP
;Solar_Loads_Controller_SLCM_V1.c,421 :: 		while(Set==0)
L_SetTimerOff_1112:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetTimerOff_1113
;Solar_Loads_Controller_SLCM_V1.c,423 :: 		Display_On_7Segment_Character(0x92,0xC0,0xC7);
	LDI        R27, 199
	MOV        R4, R27
	LDI        R27, 192
	MOV        R3, R27
	LDI        R27, 146
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,424 :: 		}
	JMP        L_SetTimerOff_1112
L_SetTimerOff_1113:
;Solar_Loads_Controller_SLCM_V1.c,425 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_1114:
	DEC        R16
	BRNE       L_SetTimerOff_1114
	DEC        R17
	BRNE       L_SetTimerOff_1114
	DEC        R18
	BRNE       L_SetTimerOff_1114
	NOP
;Solar_Loads_Controller_SLCM_V1.c,427 :: 		while (Set==0)
L_SetTimerOff_1116:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetTimerOff_1117
;Solar_Loads_Controller_SLCM_V1.c,429 :: 		Display_On_7Segment(hours_lcd_2);
	LDS        R2, _hours_lcd_2+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,431 :: 		while(Increment== 1 || Decrement==1)
L_SetTimerOff_1118:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetTimerOff_1487
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetTimerOff_1486
	JMP        L_SetTimerOff_1119
L__SetTimerOff_1487:
L__SetTimerOff_1486:
;Solar_Loads_Controller_SLCM_V1.c,433 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetTimerOff_1122
;Solar_Loads_Controller_SLCM_V1.c,435 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOff_1123:
	DEC        R16
	BRNE       L_SetTimerOff_1123
	DEC        R17
	BRNE       L_SetTimerOff_1123
	DEC        R18
	BRNE       L_SetTimerOff_1123
;Solar_Loads_Controller_SLCM_V1.c,436 :: 		hours_lcd_2++;
	LDS        R16, _hours_lcd_2+0
	SUBI       R16, 255
	STS        _hours_lcd_2+0, R16
;Solar_Loads_Controller_SLCM_V1.c,437 :: 		}
L_SetTimerOff_1122:
;Solar_Loads_Controller_SLCM_V1.c,438 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetTimerOff_1125
;Solar_Loads_Controller_SLCM_V1.c,440 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOff_1126:
	DEC        R16
	BRNE       L_SetTimerOff_1126
	DEC        R17
	BRNE       L_SetTimerOff_1126
	DEC        R18
	BRNE       L_SetTimerOff_1126
;Solar_Loads_Controller_SLCM_V1.c,441 :: 		hours_lcd_2--;
	LDS        R16, _hours_lcd_2+0
	SUBI       R16, 1
	STS        _hours_lcd_2+0, R16
;Solar_Loads_Controller_SLCM_V1.c,442 :: 		}
L_SetTimerOff_1125:
;Solar_Loads_Controller_SLCM_V1.c,443 :: 		if(hours_lcd_2>23) hours_lcd_2=0;
	LDS        R17, _hours_lcd_2+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOff_1616
	JMP        L_SetTimerOff_1128
L__SetTimerOff_1616:
	LDI        R27, 0
	STS        _hours_lcd_2+0, R27
L_SetTimerOff_1128:
;Solar_Loads_Controller_SLCM_V1.c,444 :: 		if (hours_lcd_2<0 ) hours_lcd_2=0;
	LDS        R16, _hours_lcd_2+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_1617
	JMP        L_SetTimerOff_1129
L__SetTimerOff_1617:
	LDI        R27, 0
	STS        _hours_lcd_2+0, R27
L_SetTimerOff_1129:
;Solar_Loads_Controller_SLCM_V1.c,445 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,446 :: 		Timer_isOn=0;
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,447 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_1118
L_SetTimerOff_1119:
;Solar_Loads_Controller_SLCM_V1.c,448 :: 		} // end first while
	JMP        L_SetTimerOff_1116
L_SetTimerOff_1117:
;Solar_Loads_Controller_SLCM_V1.c,450 :: 		EEPROM_Write(0x02,hours_lcd_2); // save hours off  timer_1 to eeprom
	LDS        R4, _hours_lcd_2+0
	LDI        R27, 2
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,451 :: 		Delay_ms(500); // read button state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_1130:
	DEC        R16
	BRNE       L_SetTimerOff_1130
	DEC        R17
	BRNE       L_SetTimerOff_1130
	DEC        R18
	BRNE       L_SetTimerOff_1130
	NOP
;Solar_Loads_Controller_SLCM_V1.c,452 :: 		while (Set==0)
L_SetTimerOff_1132:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetTimerOff_1133
;Solar_Loads_Controller_SLCM_V1.c,454 :: 		Display_On_7Segment(minutes_lcd_2);
	LDS        R2, _minutes_lcd_2+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,456 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOff_1134:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetTimerOff_1489
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetTimerOff_1488
	JMP        L_SetTimerOff_1135
L__SetTimerOff_1489:
L__SetTimerOff_1488:
;Solar_Loads_Controller_SLCM_V1.c,458 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetTimerOff_1138
;Solar_Loads_Controller_SLCM_V1.c,460 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOff_1139:
	DEC        R16
	BRNE       L_SetTimerOff_1139
	DEC        R17
	BRNE       L_SetTimerOff_1139
	DEC        R18
	BRNE       L_SetTimerOff_1139
;Solar_Loads_Controller_SLCM_V1.c,461 :: 		minutes_lcd_2++;
	LDS        R16, _minutes_lcd_2+0
	SUBI       R16, 255
	STS        _minutes_lcd_2+0, R16
;Solar_Loads_Controller_SLCM_V1.c,462 :: 		}
L_SetTimerOff_1138:
;Solar_Loads_Controller_SLCM_V1.c,463 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetTimerOff_1141
;Solar_Loads_Controller_SLCM_V1.c,465 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOff_1142:
	DEC        R16
	BRNE       L_SetTimerOff_1142
	DEC        R17
	BRNE       L_SetTimerOff_1142
	DEC        R18
	BRNE       L_SetTimerOff_1142
;Solar_Loads_Controller_SLCM_V1.c,466 :: 		minutes_lcd_2--;
	LDS        R16, _minutes_lcd_2+0
	SUBI       R16, 1
	STS        _minutes_lcd_2+0, R16
;Solar_Loads_Controller_SLCM_V1.c,467 :: 		}
L_SetTimerOff_1141:
;Solar_Loads_Controller_SLCM_V1.c,469 :: 		if(minutes_lcd_2>59) minutes_lcd_2=0;
	LDS        R17, _minutes_lcd_2+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOff_1618
	JMP        L_SetTimerOff_1144
L__SetTimerOff_1618:
	LDI        R27, 0
	STS        _minutes_lcd_2+0, R27
L_SetTimerOff_1144:
;Solar_Loads_Controller_SLCM_V1.c,470 :: 		if (minutes_lcd_2<0) minutes_lcd_2=0;
	LDS        R16, _minutes_lcd_2+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_1619
	JMP        L_SetTimerOff_1145
L__SetTimerOff_1619:
	LDI        R27, 0
	STS        _minutes_lcd_2+0, R27
L_SetTimerOff_1145:
;Solar_Loads_Controller_SLCM_V1.c,471 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,472 :: 		Timer_isOn=0;
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,473 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_1134
L_SetTimerOff_1135:
;Solar_Loads_Controller_SLCM_V1.c,474 :: 		} // end first while
	JMP        L_SetTimerOff_1132
L_SetTimerOff_1133:
;Solar_Loads_Controller_SLCM_V1.c,477 :: 		EEPROM_Write(0x03,minutes_lcd_2); // save minutes off timer_1 to eeprom
	LDS        R4, _minutes_lcd_2+0
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,478 :: 		}
L_end_SetTimerOff_1:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOff_1

_SetLowBatteryVoltage:

;Solar_Loads_Controller_SLCM_V1.c,480 :: 		void SetLowBatteryVoltage()
;Solar_Loads_Controller_SLCM_V1.c,482 :: 		while(Set==0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
L_SetLowBatteryVoltage146:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetLowBatteryVoltage147
;Solar_Loads_Controller_SLCM_V1.c,484 :: 		Display_On_7Segment_Character(0xC6,0xE3,0xC1);
	LDI        R27, 193
	MOV        R4, R27
	LDI        R27, 227
	MOV        R3, R27
	LDI        R27, 198
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,485 :: 		}
	JMP        L_SetLowBatteryVoltage146
L_SetLowBatteryVoltage147:
;Solar_Loads_Controller_SLCM_V1.c,486 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetLowBatteryVoltage148:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage148
	DEC        R17
	BRNE       L_SetLowBatteryVoltage148
	DEC        R18
	BRNE       L_SetLowBatteryVoltage148
	NOP
;Solar_Loads_Controller_SLCM_V1.c,487 :: 		while(Set==0)
L_SetLowBatteryVoltage150:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetLowBatteryVoltage151
;Solar_Loads_Controller_SLCM_V1.c,489 :: 		Display_On_7Segment_Float(Mini_Battery_Voltage);  // to indicate program 2
	LDS        R2, _Mini_Battery_Voltage+0
	LDS        R3, _Mini_Battery_Voltage+1
	LDS        R4, _Mini_Battery_Voltage+2
	LDS        R5, _Mini_Battery_Voltage+3
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,490 :: 		while (Increment==1 || Decrement==1)
L_SetLowBatteryVoltage152:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetLowBatteryVoltage492
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetLowBatteryVoltage491
	JMP        L_SetLowBatteryVoltage153
L__SetLowBatteryVoltage492:
L__SetLowBatteryVoltage491:
;Solar_Loads_Controller_SLCM_V1.c,492 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetLowBatteryVoltage156
;Solar_Loads_Controller_SLCM_V1.c,494 :: 		Display_On_7Segment_Float(Mini_Battery_Voltage);  // to indicate program 2
	LDS        R2, _Mini_Battery_Voltage+0
	LDS        R3, _Mini_Battery_Voltage+1
	LDS        R4, _Mini_Battery_Voltage+2
	LDS        R5, _Mini_Battery_Voltage+3
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,495 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetLowBatteryVoltage157:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage157
	DEC        R17
	BRNE       L_SetLowBatteryVoltage157
	DEC        R18
	BRNE       L_SetLowBatteryVoltage157
;Solar_Loads_Controller_SLCM_V1.c,496 :: 		Mini_Battery_Voltage+=0.1;
	LDS        R16, _Mini_Battery_Voltage+0
	LDS        R17, _Mini_Battery_Voltage+1
	LDS        R18, _Mini_Battery_Voltage+2
	LDS        R19, _Mini_Battery_Voltage+3
	LDI        R20, 205
	LDI        R21, 204
	LDI        R22, 204
	LDI        R23, 61
	CALL       _float_fpadd1+0
	STS        _Mini_Battery_Voltage+0, R16
	STS        _Mini_Battery_Voltage+1, R17
	STS        _Mini_Battery_Voltage+2, R18
	STS        _Mini_Battery_Voltage+3, R19
;Solar_Loads_Controller_SLCM_V1.c,498 :: 		}
L_SetLowBatteryVoltage156:
;Solar_Loads_Controller_SLCM_V1.c,499 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetLowBatteryVoltage159
;Solar_Loads_Controller_SLCM_V1.c,501 :: 		Display_On_7Segment_Float(Mini_Battery_Voltage);  // to indicate program 2
	LDS        R2, _Mini_Battery_Voltage+0
	LDS        R3, _Mini_Battery_Voltage+1
	LDS        R4, _Mini_Battery_Voltage+2
	LDS        R5, _Mini_Battery_Voltage+3
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,502 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetLowBatteryVoltage160:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage160
	DEC        R17
	BRNE       L_SetLowBatteryVoltage160
	DEC        R18
	BRNE       L_SetLowBatteryVoltage160
;Solar_Loads_Controller_SLCM_V1.c,503 :: 		Mini_Battery_Voltage-=0.1;
	LDI        R20, 205
	LDI        R21, 204
	LDI        R22, 204
	LDI        R23, 61
	LDS        R16, _Mini_Battery_Voltage+0
	LDS        R17, _Mini_Battery_Voltage+1
	LDS        R18, _Mini_Battery_Voltage+2
	LDS        R19, _Mini_Battery_Voltage+3
	CALL       _float_fpsub1+0
	STS        _Mini_Battery_Voltage+0, R16
	STS        _Mini_Battery_Voltage+1, R17
	STS        _Mini_Battery_Voltage+2, R18
	STS        _Mini_Battery_Voltage+3, R19
;Solar_Loads_Controller_SLCM_V1.c,504 :: 		}
L_SetLowBatteryVoltage159:
;Solar_Loads_Controller_SLCM_V1.c,505 :: 		if (Mini_Battery_Voltage>65) Mini_Battery_Voltage=0;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 130
	LDI        R23, 66
	LDS        R16, _Mini_Battery_Voltage+0
	LDS        R17, _Mini_Battery_Voltage+1
	LDS        R18, _Mini_Battery_Voltage+2
	LDS        R19, _Mini_Battery_Voltage+3
	CALL       _float_op_big+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__SetLowBatteryVoltage621
	LDI        R16, 1
L__SetLowBatteryVoltage621:
	TST        R16
	BRNE       L__SetLowBatteryVoltage622
	JMP        L_SetLowBatteryVoltage162
L__SetLowBatteryVoltage622:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	STS        _Mini_Battery_Voltage+2, R27
	STS        _Mini_Battery_Voltage+3, R27
L_SetLowBatteryVoltage162:
;Solar_Loads_Controller_SLCM_V1.c,506 :: 		if (Mini_Battery_Voltage<0) Mini_Battery_Voltage=0;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 0
	LDI        R23, 0
	LDS        R16, _Mini_Battery_Voltage+0
	LDS        R17, _Mini_Battery_Voltage+1
	LDS        R18, _Mini_Battery_Voltage+2
	LDS        R19, _Mini_Battery_Voltage+3
	CALL       _float_op_less+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__SetLowBatteryVoltage623
	LDI        R16, 1
L__SetLowBatteryVoltage623:
	TST        R16
	BRNE       L__SetLowBatteryVoltage624
	JMP        L_SetLowBatteryVoltage163
L__SetLowBatteryVoltage624:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	STS        _Mini_Battery_Voltage+2, R27
	STS        _Mini_Battery_Voltage+3, R27
L_SetLowBatteryVoltage163:
;Solar_Loads_Controller_SLCM_V1.c,507 :: 		} //end wile increment and decrement
	JMP        L_SetLowBatteryVoltage152
L_SetLowBatteryVoltage153:
;Solar_Loads_Controller_SLCM_V1.c,508 :: 		}// end first while set
	JMP        L_SetLowBatteryVoltage150
L_SetLowBatteryVoltage151:
;Solar_Loads_Controller_SLCM_V1.c,509 :: 		StoreBytesIntoEEprom(0x04,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_Mini_Battery_Voltage+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_Mini_Battery_Voltage+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Loads_Controller_SLCM_V1.c,510 :: 		}
L_end_SetLowBatteryVoltage:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetLowBatteryVoltage

_SetStartUpLoadsVoltage:

;Solar_Loads_Controller_SLCM_V1.c,513 :: 		void SetStartUpLoadsVoltage()
;Solar_Loads_Controller_SLCM_V1.c,515 :: 		while(Set==0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
L_SetStartUpLoadsVoltage164:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetStartUpLoadsVoltage165
;Solar_Loads_Controller_SLCM_V1.c,517 :: 		Display_On_7Segment_Character(0x92,0x83,0x9D);
	LDI        R27, 157
	MOV        R4, R27
	LDI        R27, 131
	MOV        R3, R27
	LDI        R27, 146
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,518 :: 		}
	JMP        L_SetStartUpLoadsVoltage164
L_SetStartUpLoadsVoltage165:
;Solar_Loads_Controller_SLCM_V1.c,519 :: 		Delay_ms(500);;
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetStartUpLoadsVoltage166:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage166
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage166
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage166
	NOP
;Solar_Loads_Controller_SLCM_V1.c,520 :: 		while(Set==0)
L_SetStartUpLoadsVoltage168:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetStartUpLoadsVoltage169
;Solar_Loads_Controller_SLCM_V1.c,522 :: 		Display_On_7Segment_Float(StartLoadsVoltage);
	LDS        R2, _StartLoadsVoltage+0
	LDS        R3, _StartLoadsVoltage+1
	LDS        R4, _StartLoadsVoltage+2
	LDS        R5, _StartLoadsVoltage+3
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,523 :: 		while (Increment==1 || Decrement==1)
L_SetStartUpLoadsVoltage170:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetStartUpLoadsVoltage495
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetStartUpLoadsVoltage494
	JMP        L_SetStartUpLoadsVoltage171
L__SetStartUpLoadsVoltage495:
L__SetStartUpLoadsVoltage494:
;Solar_Loads_Controller_SLCM_V1.c,525 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetStartUpLoadsVoltage174
;Solar_Loads_Controller_SLCM_V1.c,527 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetStartUpLoadsVoltage175:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage175
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage175
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage175
;Solar_Loads_Controller_SLCM_V1.c,528 :: 		StartLoadsVoltage+=0.1;
	LDS        R16, _StartLoadsVoltage+0
	LDS        R17, _StartLoadsVoltage+1
	LDS        R18, _StartLoadsVoltage+2
	LDS        R19, _StartLoadsVoltage+3
	LDI        R20, 205
	LDI        R21, 204
	LDI        R22, 204
	LDI        R23, 61
	CALL       _float_fpadd1+0
	STS        _StartLoadsVoltage+0, R16
	STS        _StartLoadsVoltage+1, R17
	STS        _StartLoadsVoltage+2, R18
	STS        _StartLoadsVoltage+3, R19
;Solar_Loads_Controller_SLCM_V1.c,529 :: 		Display_On_7Segment_Float(StartLoadsVoltage);
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,530 :: 		}
L_SetStartUpLoadsVoltage174:
;Solar_Loads_Controller_SLCM_V1.c,531 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetStartUpLoadsVoltage177
;Solar_Loads_Controller_SLCM_V1.c,533 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetStartUpLoadsVoltage178:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage178
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage178
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage178
;Solar_Loads_Controller_SLCM_V1.c,534 :: 		StartLoadsVoltage-=0.1;
	LDI        R20, 205
	LDI        R21, 204
	LDI        R22, 204
	LDI        R23, 61
	LDS        R16, _StartLoadsVoltage+0
	LDS        R17, _StartLoadsVoltage+1
	LDS        R18, _StartLoadsVoltage+2
	LDS        R19, _StartLoadsVoltage+3
	CALL       _float_fpsub1+0
	STS        _StartLoadsVoltage+0, R16
	STS        _StartLoadsVoltage+1, R17
	STS        _StartLoadsVoltage+2, R18
	STS        _StartLoadsVoltage+3, R19
;Solar_Loads_Controller_SLCM_V1.c,535 :: 		Display_On_7Segment_Float(StartLoadsVoltage);
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,536 :: 		}
L_SetStartUpLoadsVoltage177:
;Solar_Loads_Controller_SLCM_V1.c,537 :: 		if (StartLoadsVoltage>65) StartLoadsVoltage=0;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 130
	LDI        R23, 66
	LDS        R16, _StartLoadsVoltage+0
	LDS        R17, _StartLoadsVoltage+1
	LDS        R18, _StartLoadsVoltage+2
	LDS        R19, _StartLoadsVoltage+3
	CALL       _float_op_big+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__SetStartUpLoadsVoltage626
	LDI        R16, 1
L__SetStartUpLoadsVoltage626:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage627
	JMP        L_SetStartUpLoadsVoltage180
L__SetStartUpLoadsVoltage627:
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	STS        _StartLoadsVoltage+2, R27
	STS        _StartLoadsVoltage+3, R27
L_SetStartUpLoadsVoltage180:
;Solar_Loads_Controller_SLCM_V1.c,538 :: 		if (StartLoadsVoltage<0) StartLoadsVoltage=0;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 0
	LDI        R23, 0
	LDS        R16, _StartLoadsVoltage+0
	LDS        R17, _StartLoadsVoltage+1
	LDS        R18, _StartLoadsVoltage+2
	LDS        R19, _StartLoadsVoltage+3
	CALL       _float_op_less+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__SetStartUpLoadsVoltage628
	LDI        R16, 1
L__SetStartUpLoadsVoltage628:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage629
	JMP        L_SetStartUpLoadsVoltage181
L__SetStartUpLoadsVoltage629:
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	STS        _StartLoadsVoltage+2, R27
	STS        _StartLoadsVoltage+3, R27
L_SetStartUpLoadsVoltage181:
;Solar_Loads_Controller_SLCM_V1.c,539 :: 		} //end wile increment and decrement
	JMP        L_SetStartUpLoadsVoltage170
L_SetStartUpLoadsVoltage171:
;Solar_Loads_Controller_SLCM_V1.c,540 :: 		}// end first while
	JMP        L_SetStartUpLoadsVoltage168
L_SetStartUpLoadsVoltage169:
;Solar_Loads_Controller_SLCM_V1.c,541 :: 		StoreBytesIntoEEprom(0x08,(unsigned short *)&StartLoadsVoltage,4);   // save float number to eeprom
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_StartLoadsVoltage+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_StartLoadsVoltage+0)
	MOV        R5, R27
	LDI        R27, 8
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Loads_Controller_SLCM_V1.c,542 :: 		}
L_end_SetStartUpLoadsVoltage:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetStartUpLoadsVoltage

_Startup_Timers:

;Solar_Loads_Controller_SLCM_V1.c,546 :: 		void Startup_Timers()
;Solar_Loads_Controller_SLCM_V1.c,548 :: 		while(Set==0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
L_Startup_Timers182:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_Startup_Timers183
;Solar_Loads_Controller_SLCM_V1.c,550 :: 		Display_On_7Segment_Character(0x92,0xC7,0x92);
	LDI        R27, 146
	MOV        R4, R27
	LDI        R27, 199
	MOV        R3, R27
	LDI        R27, 146
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,551 :: 		}
	JMP        L_Startup_Timers182
L_Startup_Timers183:
;Solar_Loads_Controller_SLCM_V1.c,552 :: 		Delay_ms(500);;
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Startup_Timers184:
	DEC        R16
	BRNE       L_Startup_Timers184
	DEC        R17
	BRNE       L_Startup_Timers184
	DEC        R18
	BRNE       L_Startup_Timers184
	NOP
;Solar_Loads_Controller_SLCM_V1.c,553 :: 		while(Set==0)
L_Startup_Timers186:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_Startup_Timers187
;Solar_Loads_Controller_SLCM_V1.c,555 :: 		Display_On_7Segment(startupTIme_1);
	LDS        R2, _startupTIme_1+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,556 :: 		while(Increment==1 || Decrement==1)
L_Startup_Timers188:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__Startup_Timers498
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__Startup_Timers497
	JMP        L_Startup_Timers189
L__Startup_Timers498:
L__Startup_Timers497:
;Solar_Loads_Controller_SLCM_V1.c,558 :: 		if(Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_Startup_Timers192
;Solar_Loads_Controller_SLCM_V1.c,561 :: 		Display_On_7Segment(startupTIme_1);
	LDS        R2, _startupTIme_1+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,562 :: 		Delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_Startup_Timers193:
	DEC        R16
	BRNE       L_Startup_Timers193
	DEC        R17
	BRNE       L_Startup_Timers193
	DEC        R18
	BRNE       L_Startup_Timers193
;Solar_Loads_Controller_SLCM_V1.c,563 :: 		startupTIme_1++;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _startupTIme_1+0, R16
	STS        _startupTIme_1+1, R17
;Solar_Loads_Controller_SLCM_V1.c,564 :: 		}
L_Startup_Timers192:
;Solar_Loads_Controller_SLCM_V1.c,565 :: 		if(Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_Startup_Timers195
;Solar_Loads_Controller_SLCM_V1.c,568 :: 		Display_On_7Segment(startupTIme_1);
	LDS        R2, _startupTIme_1+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,569 :: 		Delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_Startup_Timers196:
	DEC        R16
	BRNE       L_Startup_Timers196
	DEC        R17
	BRNE       L_Startup_Timers196
	DEC        R18
	BRNE       L_Startup_Timers196
;Solar_Loads_Controller_SLCM_V1.c,570 :: 		startupTIme_1--;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _startupTIme_1+0, R16
	STS        _startupTIme_1+1, R17
;Solar_Loads_Controller_SLCM_V1.c,571 :: 		}
L_Startup_Timers195:
;Solar_Loads_Controller_SLCM_V1.c,572 :: 		if(startupTIme_1 > 600  ) startupTIme_1=0;
	LDS        R18, _startupTIme_1+0
	LDS        R19, _startupTIme_1+1
	LDI        R16, 88
	LDI        R17, 2
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Startup_Timers631
	JMP        L_Startup_Timers198
L__Startup_Timers631:
	LDI        R27, 0
	STS        _startupTIme_1+0, R27
	STS        _startupTIme_1+1, R27
L_Startup_Timers198:
;Solar_Loads_Controller_SLCM_V1.c,573 :: 		if (startupTIme_1<0) startupTIme_1=0;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CPI        R17, 0
	BRNE       L__Startup_Timers632
	CPI        R16, 0
L__Startup_Timers632:
	BRLO       L__Startup_Timers633
	JMP        L_Startup_Timers199
L__Startup_Timers633:
	LDI        R27, 0
	STS        _startupTIme_1+0, R27
	STS        _startupTIme_1+1, R27
L_Startup_Timers199:
;Solar_Loads_Controller_SLCM_V1.c,574 :: 		} // end  while increment decrement
	JMP        L_Startup_Timers188
L_Startup_Timers189:
;Solar_Loads_Controller_SLCM_V1.c,575 :: 		} // end while main while set
	JMP        L_Startup_Timers186
L_Startup_Timers187:
;Solar_Loads_Controller_SLCM_V1.c,576 :: 		StoreBytesIntoEEprom(0x12,(unsigned short *)&startupTIme_1,2);   // save float number to eeprom
	LDI        R27, 2
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_startupTIme_1+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_startupTIme_1+0)
	MOV        R5, R27
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Loads_Controller_SLCM_V1.c,577 :: 		} // end  function
L_end_Startup_Timers:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _Startup_Timers

_SetDS1307_Time:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;Solar_Loads_Controller_SLCM_V1.c,580 :: 		void SetDS1307_Time()
;Solar_Loads_Controller_SLCM_V1.c,582 :: 		while(Set==0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
L_SetDS1307_Time200:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time201
;Solar_Loads_Controller_SLCM_V1.c,584 :: 		Display_On_7Segment(6);  // to indicate program 3
	LDI        R27, 6
	MOV        R2, R27
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,585 :: 		}
	JMP        L_SetDS1307_Time200
L_SetDS1307_Time201:
;Solar_Loads_Controller_SLCM_V1.c,586 :: 		set_ds1307_minutes=ReadMinutes();      // to read time now
	CALL       _ReadMinutes+0
	STS        _set_ds1307_minutes+0, R16
;Solar_Loads_Controller_SLCM_V1.c,587 :: 		set_ds1307_hours=ReadHours();          // to read time now
	CALL       _ReadHours+0
	STS        _set_ds1307_hours+0, R16
;Solar_Loads_Controller_SLCM_V1.c,588 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time202:
	DEC        R16
	BRNE       L_SetDS1307_Time202
	DEC        R17
	BRNE       L_SetDS1307_Time202
	DEC        R18
	BRNE       L_SetDS1307_Time202
	NOP
;Solar_Loads_Controller_SLCM_V1.c,589 :: 		while(Set==0)
L_SetDS1307_Time204:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time205
;Solar_Loads_Controller_SLCM_V1.c,591 :: 		Display_On_7Segment_Character(0x89,0xC0,0xC1);
	LDI        R27, 193
	MOV        R4, R27
	LDI        R27, 192
	MOV        R3, R27
	LDI        R27, 137
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,592 :: 		}
	JMP        L_SetDS1307_Time204
L_SetDS1307_Time205:
;Solar_Loads_Controller_SLCM_V1.c,593 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time206:
	DEC        R16
	BRNE       L_SetDS1307_Time206
	DEC        R17
	BRNE       L_SetDS1307_Time206
	DEC        R18
	BRNE       L_SetDS1307_Time206
	NOP
;Solar_Loads_Controller_SLCM_V1.c,594 :: 		while (Set==0)
L_SetDS1307_Time208:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time209
;Solar_Loads_Controller_SLCM_V1.c,596 :: 		Display_On_7Segment(set_ds1307_hours);
	LDS        R2, _set_ds1307_hours+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,597 :: 		while (Increment==1 || Decrement==1 )
L_SetDS1307_Time210:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetDS1307_Time509
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetDS1307_Time508
	JMP        L_SetDS1307_Time211
L__SetDS1307_Time509:
L__SetDS1307_Time508:
;Solar_Loads_Controller_SLCM_V1.c,599 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetDS1307_Time214
;Solar_Loads_Controller_SLCM_V1.c,601 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time215:
	DEC        R16
	BRNE       L_SetDS1307_Time215
	DEC        R17
	BRNE       L_SetDS1307_Time215
	DEC        R18
	BRNE       L_SetDS1307_Time215
;Solar_Loads_Controller_SLCM_V1.c,602 :: 		set_ds1307_hours++;
	LDS        R16, _set_ds1307_hours+0
	SUBI       R16, 255
	STS        _set_ds1307_hours+0, R16
;Solar_Loads_Controller_SLCM_V1.c,603 :: 		}
L_SetDS1307_Time214:
;Solar_Loads_Controller_SLCM_V1.c,604 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetDS1307_Time217
;Solar_Loads_Controller_SLCM_V1.c,606 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time218:
	DEC        R16
	BRNE       L_SetDS1307_Time218
	DEC        R17
	BRNE       L_SetDS1307_Time218
	DEC        R18
	BRNE       L_SetDS1307_Time218
;Solar_Loads_Controller_SLCM_V1.c,607 :: 		set_ds1307_hours--;
	LDS        R16, _set_ds1307_hours+0
	SUBI       R16, 1
	STS        _set_ds1307_hours+0, R16
;Solar_Loads_Controller_SLCM_V1.c,608 :: 		}
L_SetDS1307_Time217:
;Solar_Loads_Controller_SLCM_V1.c,609 :: 		if(set_ds1307_hours>23) set_ds1307_hours=0;
	LDS        R17, _set_ds1307_hours+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetDS1307_Time635
	JMP        L_SetDS1307_Time220
L__SetDS1307_Time635:
	LDI        R27, 0
	STS        _set_ds1307_hours+0, R27
L_SetDS1307_Time220:
;Solar_Loads_Controller_SLCM_V1.c,610 :: 		if (set_ds1307_hours<0) set_ds1307_hours=0;
	LDS        R16, _set_ds1307_hours+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time636
	JMP        L_SetDS1307_Time221
L__SetDS1307_Time636:
	LDI        R27, 0
	STS        _set_ds1307_hours+0, R27
L_SetDS1307_Time221:
;Solar_Loads_Controller_SLCM_V1.c,611 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time210
L_SetDS1307_Time211:
;Solar_Loads_Controller_SLCM_V1.c,612 :: 		} // end first while
	JMP        L_SetDS1307_Time208
L_SetDS1307_Time209:
;Solar_Loads_Controller_SLCM_V1.c,614 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time222:
	DEC        R16
	BRNE       L_SetDS1307_Time222
	DEC        R17
	BRNE       L_SetDS1307_Time222
	DEC        R18
	BRNE       L_SetDS1307_Time222
	NOP
;Solar_Loads_Controller_SLCM_V1.c,615 :: 		while(Set==0)
L_SetDS1307_Time224:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time225
;Solar_Loads_Controller_SLCM_V1.c,617 :: 		Display_On_7Segment_Character(0xC8,0xC8,0xCF);
	LDI        R27, 207
	MOV        R4, R27
	LDI        R27, 200
	MOV        R3, R27
	LDI        R27, 200
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,618 :: 		}
	JMP        L_SetDS1307_Time224
L_SetDS1307_Time225:
;Solar_Loads_Controller_SLCM_V1.c,619 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time226:
	DEC        R16
	BRNE       L_SetDS1307_Time226
	DEC        R17
	BRNE       L_SetDS1307_Time226
	DEC        R18
	BRNE       L_SetDS1307_Time226
	NOP
;Solar_Loads_Controller_SLCM_V1.c,620 :: 		while (Set==0)
L_SetDS1307_Time228:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time229
;Solar_Loads_Controller_SLCM_V1.c,622 :: 		Display_On_7Segment(set_ds1307_minutes);
	LDS        R2, _set_ds1307_minutes+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,623 :: 		while (Increment==1 || Decrement==1)
L_SetDS1307_Time230:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetDS1307_Time511
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetDS1307_Time510
	JMP        L_SetDS1307_Time231
L__SetDS1307_Time511:
L__SetDS1307_Time510:
;Solar_Loads_Controller_SLCM_V1.c,625 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetDS1307_Time234
;Solar_Loads_Controller_SLCM_V1.c,627 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time235:
	DEC        R16
	BRNE       L_SetDS1307_Time235
	DEC        R17
	BRNE       L_SetDS1307_Time235
	DEC        R18
	BRNE       L_SetDS1307_Time235
;Solar_Loads_Controller_SLCM_V1.c,628 :: 		set_ds1307_minutes++;
	LDS        R16, _set_ds1307_minutes+0
	SUBI       R16, 255
	STS        _set_ds1307_minutes+0, R16
;Solar_Loads_Controller_SLCM_V1.c,629 :: 		}
L_SetDS1307_Time234:
;Solar_Loads_Controller_SLCM_V1.c,630 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetDS1307_Time237
;Solar_Loads_Controller_SLCM_V1.c,632 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time238:
	DEC        R16
	BRNE       L_SetDS1307_Time238
	DEC        R17
	BRNE       L_SetDS1307_Time238
	DEC        R18
	BRNE       L_SetDS1307_Time238
;Solar_Loads_Controller_SLCM_V1.c,633 :: 		set_ds1307_minutes--;
	LDS        R16, _set_ds1307_minutes+0
	SUBI       R16, 1
	STS        _set_ds1307_minutes+0, R16
;Solar_Loads_Controller_SLCM_V1.c,634 :: 		}
L_SetDS1307_Time237:
;Solar_Loads_Controller_SLCM_V1.c,635 :: 		if(set_ds1307_minutes>59) set_ds1307_minutes=0;
	LDS        R17, _set_ds1307_minutes+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetDS1307_Time637
	JMP        L_SetDS1307_Time240
L__SetDS1307_Time637:
	LDI        R27, 0
	STS        _set_ds1307_minutes+0, R27
L_SetDS1307_Time240:
;Solar_Loads_Controller_SLCM_V1.c,636 :: 		if(set_ds1307_minutes<0) set_ds1307_minutes=0;
	LDS        R16, _set_ds1307_minutes+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time638
	JMP        L_SetDS1307_Time241
L__SetDS1307_Time638:
	LDI        R27, 0
	STS        _set_ds1307_minutes+0, R27
L_SetDS1307_Time241:
;Solar_Loads_Controller_SLCM_V1.c,637 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time230
L_SetDS1307_Time231:
;Solar_Loads_Controller_SLCM_V1.c,638 :: 		} // end first while
	JMP        L_SetDS1307_Time228
L_SetDS1307_Time229:
;Solar_Loads_Controller_SLCM_V1.c,640 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time242:
	DEC        R16
	BRNE       L_SetDS1307_Time242
	DEC        R17
	BRNE       L_SetDS1307_Time242
	DEC        R18
	BRNE       L_SetDS1307_Time242
	NOP
;Solar_Loads_Controller_SLCM_V1.c,641 :: 		while(Set==0)
L_SetDS1307_Time244:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time245
;Solar_Loads_Controller_SLCM_V1.c,643 :: 		Display_On_7Segment_Character(0x92,0x86,0xC6);
	LDI        R27, 198
	MOV        R4, R27
	LDI        R27, 134
	MOV        R3, R27
	LDI        R27, 146
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,644 :: 		}
	JMP        L_SetDS1307_Time244
L_SetDS1307_Time245:
;Solar_Loads_Controller_SLCM_V1.c,645 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time246:
	DEC        R16
	BRNE       L_SetDS1307_Time246
	DEC        R17
	BRNE       L_SetDS1307_Time246
	DEC        R18
	BRNE       L_SetDS1307_Time246
	NOP
;Solar_Loads_Controller_SLCM_V1.c,646 :: 		while (Set==0)
L_SetDS1307_Time248:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time249
;Solar_Loads_Controller_SLCM_V1.c,648 :: 		Display_On_7Segment(set_ds1307_seconds);
	LDS        R2, _set_ds1307_seconds+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,649 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time250:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetDS1307_Time513
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetDS1307_Time512
	JMP        L_SetDS1307_Time251
L__SetDS1307_Time513:
L__SetDS1307_Time512:
;Solar_Loads_Controller_SLCM_V1.c,651 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetDS1307_Time254
;Solar_Loads_Controller_SLCM_V1.c,653 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time255:
	DEC        R16
	BRNE       L_SetDS1307_Time255
	DEC        R17
	BRNE       L_SetDS1307_Time255
	DEC        R18
	BRNE       L_SetDS1307_Time255
;Solar_Loads_Controller_SLCM_V1.c,654 :: 		set_ds1307_seconds++;
	LDS        R16, _set_ds1307_seconds+0
	SUBI       R16, 255
	STS        _set_ds1307_seconds+0, R16
;Solar_Loads_Controller_SLCM_V1.c,655 :: 		}
L_SetDS1307_Time254:
;Solar_Loads_Controller_SLCM_V1.c,656 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetDS1307_Time257
;Solar_Loads_Controller_SLCM_V1.c,658 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time258:
	DEC        R16
	BRNE       L_SetDS1307_Time258
	DEC        R17
	BRNE       L_SetDS1307_Time258
	DEC        R18
	BRNE       L_SetDS1307_Time258
;Solar_Loads_Controller_SLCM_V1.c,659 :: 		set_ds1307_seconds--;
	LDS        R16, _set_ds1307_seconds+0
	SUBI       R16, 1
	STS        _set_ds1307_seconds+0, R16
;Solar_Loads_Controller_SLCM_V1.c,660 :: 		}
L_SetDS1307_Time257:
;Solar_Loads_Controller_SLCM_V1.c,661 :: 		if (set_ds1307_seconds>59) set_ds1307_seconds=0;
	LDS        R17, _set_ds1307_seconds+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetDS1307_Time639
	JMP        L_SetDS1307_Time260
L__SetDS1307_Time639:
	LDI        R27, 0
	STS        _set_ds1307_seconds+0, R27
L_SetDS1307_Time260:
;Solar_Loads_Controller_SLCM_V1.c,662 :: 		if (set_ds1307_seconds<0) set_ds1307_seconds=0;
	LDS        R16, _set_ds1307_seconds+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time640
	JMP        L_SetDS1307_Time261
L__SetDS1307_Time640:
	LDI        R27, 0
	STS        _set_ds1307_seconds+0, R27
L_SetDS1307_Time261:
;Solar_Loads_Controller_SLCM_V1.c,665 :: 		Write_Time(Dec2Bcd(set_ds1307_seconds),Dec2Bcd(set_ds1307_minutes),Dec2Bcd(set_ds1307_hours)); // write time to DS1307
	LDS        R2, _set_ds1307_hours+0
	CALL       _Dec2Bcd+0
	STD        Y+1, R16
	LDS        R2, _set_ds1307_minutes+0
	CALL       _Dec2Bcd+0
	STD        Y+0, R16
	LDS        R2, _set_ds1307_seconds+0
	CALL       _Dec2Bcd+0
	LDD        R18, Y+1
	LDD        R17, Y+0
	MOV        R6, R18
	LDI        R27, 0
	MOV        R7, R27
	MOV        R4, R17
	LDI        R27, 0
	MOV        R5, R27
	MOV        R2, R16
	LDI        R27, 0
	MOV        R3, R27
	CALL       _Write_Time+0
;Solar_Loads_Controller_SLCM_V1.c,666 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time250
L_SetDS1307_Time251:
;Solar_Loads_Controller_SLCM_V1.c,667 :: 		} // end first while
	JMP        L_SetDS1307_Time248
L_SetDS1307_Time249:
;Solar_Loads_Controller_SLCM_V1.c,669 :: 		set_ds1307_day=ReadDate(0x04);  // read day
	LDI        R27, 4
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_day+0, R16
;Solar_Loads_Controller_SLCM_V1.c,670 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time262:
	DEC        R16
	BRNE       L_SetDS1307_Time262
	DEC        R17
	BRNE       L_SetDS1307_Time262
	DEC        R18
	BRNE       L_SetDS1307_Time262
	NOP
;Solar_Loads_Controller_SLCM_V1.c,671 :: 		while(Set==0)
L_SetDS1307_Time264:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time265
;Solar_Loads_Controller_SLCM_V1.c,673 :: 		Display_On_7Segment_Character(0xC0,0x88,0x91);
	LDI        R27, 145
	MOV        R4, R27
	LDI        R27, 136
	MOV        R3, R27
	LDI        R27, 192
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,674 :: 		}
	JMP        L_SetDS1307_Time264
L_SetDS1307_Time265:
;Solar_Loads_Controller_SLCM_V1.c,675 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time266:
	DEC        R16
	BRNE       L_SetDS1307_Time266
	DEC        R17
	BRNE       L_SetDS1307_Time266
	DEC        R18
	BRNE       L_SetDS1307_Time266
	NOP
;Solar_Loads_Controller_SLCM_V1.c,676 :: 		while (Set==0)
L_SetDS1307_Time268:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time269
;Solar_Loads_Controller_SLCM_V1.c,678 :: 		Display_On_7Segment(set_ds1307_day);
	LDS        R2, _set_ds1307_day+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,679 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time270:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetDS1307_Time515
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetDS1307_Time514
	JMP        L_SetDS1307_Time271
L__SetDS1307_Time515:
L__SetDS1307_Time514:
;Solar_Loads_Controller_SLCM_V1.c,682 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetDS1307_Time274
;Solar_Loads_Controller_SLCM_V1.c,684 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time275:
	DEC        R16
	BRNE       L_SetDS1307_Time275
	DEC        R17
	BRNE       L_SetDS1307_Time275
	DEC        R18
	BRNE       L_SetDS1307_Time275
;Solar_Loads_Controller_SLCM_V1.c,685 :: 		set_ds1307_day++;
	LDS        R16, _set_ds1307_day+0
	SUBI       R16, 255
	STS        _set_ds1307_day+0, R16
;Solar_Loads_Controller_SLCM_V1.c,686 :: 		}
L_SetDS1307_Time274:
;Solar_Loads_Controller_SLCM_V1.c,687 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetDS1307_Time277
;Solar_Loads_Controller_SLCM_V1.c,689 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time278:
	DEC        R16
	BRNE       L_SetDS1307_Time278
	DEC        R17
	BRNE       L_SetDS1307_Time278
	DEC        R18
	BRNE       L_SetDS1307_Time278
;Solar_Loads_Controller_SLCM_V1.c,690 :: 		set_ds1307_day--;
	LDS        R16, _set_ds1307_day+0
	SUBI       R16, 1
	STS        _set_ds1307_day+0, R16
;Solar_Loads_Controller_SLCM_V1.c,691 :: 		}
L_SetDS1307_Time277:
;Solar_Loads_Controller_SLCM_V1.c,692 :: 		if (set_ds1307_day>31) set_ds1307_day=0;
	LDS        R17, _set_ds1307_day+0
	LDI        R16, 31
	CP         R16, R17
	BRLO       L__SetDS1307_Time641
	JMP        L_SetDS1307_Time280
L__SetDS1307_Time641:
	LDI        R27, 0
	STS        _set_ds1307_day+0, R27
L_SetDS1307_Time280:
;Solar_Loads_Controller_SLCM_V1.c,693 :: 		if (set_ds1307_day<0) set_ds1307_day=0;
	LDS        R16, _set_ds1307_day+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time642
	JMP        L_SetDS1307_Time281
L__SetDS1307_Time642:
	LDI        R27, 0
	STS        _set_ds1307_day+0, R27
L_SetDS1307_Time281:
;Solar_Loads_Controller_SLCM_V1.c,694 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time270
L_SetDS1307_Time271:
;Solar_Loads_Controller_SLCM_V1.c,695 :: 		} //  end while set
	JMP        L_SetDS1307_Time268
L_SetDS1307_Time269:
;Solar_Loads_Controller_SLCM_V1.c,698 :: 		set_ds1307_month=ReadDate(0x05);     // month
	LDI        R27, 5
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_month+0, R16
;Solar_Loads_Controller_SLCM_V1.c,699 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time282:
	DEC        R16
	BRNE       L_SetDS1307_Time282
	DEC        R17
	BRNE       L_SetDS1307_Time282
	DEC        R18
	BRNE       L_SetDS1307_Time282
	NOP
;Solar_Loads_Controller_SLCM_V1.c,700 :: 		while(Set==0)
L_SetDS1307_Time284:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time285
;Solar_Loads_Controller_SLCM_V1.c,702 :: 		Display_On_7Segment_Character(0xC8,0xC0,0xC8);
	LDI        R27, 200
	MOV        R4, R27
	LDI        R27, 192
	MOV        R3, R27
	LDI        R27, 200
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,703 :: 		}
	JMP        L_SetDS1307_Time284
L_SetDS1307_Time285:
;Solar_Loads_Controller_SLCM_V1.c,704 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time286:
	DEC        R16
	BRNE       L_SetDS1307_Time286
	DEC        R17
	BRNE       L_SetDS1307_Time286
	DEC        R18
	BRNE       L_SetDS1307_Time286
	NOP
;Solar_Loads_Controller_SLCM_V1.c,705 :: 		while (Set==0)
L_SetDS1307_Time288:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time289
;Solar_Loads_Controller_SLCM_V1.c,707 :: 		Display_On_7Segment( set_ds1307_month);
	LDS        R2, _set_ds1307_month+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,708 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time290:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetDS1307_Time517
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetDS1307_Time516
	JMP        L_SetDS1307_Time291
L__SetDS1307_Time517:
L__SetDS1307_Time516:
;Solar_Loads_Controller_SLCM_V1.c,710 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetDS1307_Time294
;Solar_Loads_Controller_SLCM_V1.c,712 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time295:
	DEC        R16
	BRNE       L_SetDS1307_Time295
	DEC        R17
	BRNE       L_SetDS1307_Time295
	DEC        R18
	BRNE       L_SetDS1307_Time295
;Solar_Loads_Controller_SLCM_V1.c,713 :: 		set_ds1307_month++;
	LDS        R16, _set_ds1307_month+0
	SUBI       R16, 255
	STS        _set_ds1307_month+0, R16
;Solar_Loads_Controller_SLCM_V1.c,715 :: 		}
L_SetDS1307_Time294:
;Solar_Loads_Controller_SLCM_V1.c,716 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetDS1307_Time297
;Solar_Loads_Controller_SLCM_V1.c,718 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time298:
	DEC        R16
	BRNE       L_SetDS1307_Time298
	DEC        R17
	BRNE       L_SetDS1307_Time298
	DEC        R18
	BRNE       L_SetDS1307_Time298
;Solar_Loads_Controller_SLCM_V1.c,719 :: 		set_ds1307_month--;
	LDS        R16, _set_ds1307_month+0
	SUBI       R16, 1
	STS        _set_ds1307_month+0, R16
;Solar_Loads_Controller_SLCM_V1.c,720 :: 		}
L_SetDS1307_Time297:
;Solar_Loads_Controller_SLCM_V1.c,721 :: 		if (set_ds1307_month>12) set_ds1307_month=0;
	LDS        R17, _set_ds1307_month+0
	LDI        R16, 12
	CP         R16, R17
	BRLO       L__SetDS1307_Time643
	JMP        L_SetDS1307_Time300
L__SetDS1307_Time643:
	LDI        R27, 0
	STS        _set_ds1307_month+0, R27
L_SetDS1307_Time300:
;Solar_Loads_Controller_SLCM_V1.c,722 :: 		if (set_ds1307_month<0) set_ds1307_month=0;
	LDS        R16, _set_ds1307_month+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time644
	JMP        L_SetDS1307_Time301
L__SetDS1307_Time644:
	LDI        R27, 0
	STS        _set_ds1307_month+0, R27
L_SetDS1307_Time301:
;Solar_Loads_Controller_SLCM_V1.c,723 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time290
L_SetDS1307_Time291:
;Solar_Loads_Controller_SLCM_V1.c,724 :: 		} //  end while set
	JMP        L_SetDS1307_Time288
L_SetDS1307_Time289:
;Solar_Loads_Controller_SLCM_V1.c,727 :: 		set_ds1307_year=ReadDate(0x06);
	LDI        R27, 6
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_year+0, R16
;Solar_Loads_Controller_SLCM_V1.c,728 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time302:
	DEC        R16
	BRNE       L_SetDS1307_Time302
	DEC        R17
	BRNE       L_SetDS1307_Time302
	DEC        R18
	BRNE       L_SetDS1307_Time302
	NOP
;Solar_Loads_Controller_SLCM_V1.c,729 :: 		while(Set==0)
L_SetDS1307_Time304:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time305
;Solar_Loads_Controller_SLCM_V1.c,731 :: 		Display_On_7Segment_Character(0x91,0x86,0x88);
	LDI        R27, 136
	MOV        R4, R27
	LDI        R27, 134
	MOV        R3, R27
	LDI        R27, 145
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,732 :: 		}
	JMP        L_SetDS1307_Time304
L_SetDS1307_Time305:
;Solar_Loads_Controller_SLCM_V1.c,733 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time306:
	DEC        R16
	BRNE       L_SetDS1307_Time306
	DEC        R17
	BRNE       L_SetDS1307_Time306
	DEC        R18
	BRNE       L_SetDS1307_Time306
	NOP
;Solar_Loads_Controller_SLCM_V1.c,734 :: 		while (Set==0)
L_SetDS1307_Time308:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time309
;Solar_Loads_Controller_SLCM_V1.c,736 :: 		Display_On_7Segment( set_ds1307_year);
	LDS        R2, _set_ds1307_year+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,737 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time310:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetDS1307_Time519
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetDS1307_Time518
	JMP        L_SetDS1307_Time311
L__SetDS1307_Time519:
L__SetDS1307_Time518:
;Solar_Loads_Controller_SLCM_V1.c,739 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetDS1307_Time314
;Solar_Loads_Controller_SLCM_V1.c,741 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time315:
	DEC        R16
	BRNE       L_SetDS1307_Time315
	DEC        R17
	BRNE       L_SetDS1307_Time315
	DEC        R18
	BRNE       L_SetDS1307_Time315
;Solar_Loads_Controller_SLCM_V1.c,742 :: 		set_ds1307_year++;
	LDS        R16, _set_ds1307_year+0
	SUBI       R16, 255
	STS        _set_ds1307_year+0, R16
;Solar_Loads_Controller_SLCM_V1.c,744 :: 		}
L_SetDS1307_Time314:
;Solar_Loads_Controller_SLCM_V1.c,745 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetDS1307_Time317
;Solar_Loads_Controller_SLCM_V1.c,747 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time318:
	DEC        R16
	BRNE       L_SetDS1307_Time318
	DEC        R17
	BRNE       L_SetDS1307_Time318
	DEC        R18
	BRNE       L_SetDS1307_Time318
;Solar_Loads_Controller_SLCM_V1.c,748 :: 		set_ds1307_year--;
	LDS        R16, _set_ds1307_year+0
	SUBI       R16, 1
	STS        _set_ds1307_year+0, R16
;Solar_Loads_Controller_SLCM_V1.c,749 :: 		}
L_SetDS1307_Time317:
;Solar_Loads_Controller_SLCM_V1.c,750 :: 		if (set_ds1307_year>99) set_ds1307_year=0;
	LDS        R17, _set_ds1307_year+0
	LDI        R16, 99
	CP         R16, R17
	BRLO       L__SetDS1307_Time645
	JMP        L_SetDS1307_Time320
L__SetDS1307_Time645:
	LDI        R27, 0
	STS        _set_ds1307_year+0, R27
L_SetDS1307_Time320:
;Solar_Loads_Controller_SLCM_V1.c,751 :: 		if (set_ds1307_year<0) set_ds1307_year=0;
	LDS        R16, _set_ds1307_year+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time646
	JMP        L_SetDS1307_Time321
L__SetDS1307_Time646:
	LDI        R27, 0
	STS        _set_ds1307_year+0, R27
L_SetDS1307_Time321:
;Solar_Loads_Controller_SLCM_V1.c,753 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time310
L_SetDS1307_Time311:
;Solar_Loads_Controller_SLCM_V1.c,754 :: 		Write_Date(Dec2Bcd(set_ds1307_day),Dec2Bcd(set_ds1307_month),Dec2Bcd(set_ds1307_year)); // write Date to DS1307
	LDS        R2, _set_ds1307_year+0
	CALL       _Dec2Bcd+0
	STD        Y+1, R16
	LDS        R2, _set_ds1307_month+0
	CALL       _Dec2Bcd+0
	STD        Y+0, R16
	LDS        R2, _set_ds1307_day+0
	CALL       _Dec2Bcd+0
	LDD        R18, Y+1
	LDD        R17, Y+0
	MOV        R6, R18
	LDI        R27, 0
	MOV        R7, R27
	MOV        R4, R17
	LDI        R27, 0
	MOV        R5, R27
	MOV        R2, R16
	LDI        R27, 0
	MOV        R3, R27
	CALL       _Write_Date+0
;Solar_Loads_Controller_SLCM_V1.c,755 :: 		} //  end while set
	JMP        L_SetDS1307_Time308
L_SetDS1307_Time309:
;Solar_Loads_Controller_SLCM_V1.c,756 :: 		}  // end setTimeAndData
L_end_SetDS1307_Time:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _SetDS1307_Time

_RunOnBatteryVoltageWithoutTimer:

;Solar_Loads_Controller_SLCM_V1.c,759 :: 		void RunOnBatteryVoltageWithoutTimer()
;Solar_Loads_Controller_SLCM_V1.c,761 :: 		Delay_ms(500);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_RunOnBatteryVoltageWithoutTimer322:
	DEC        R16
	BRNE       L_RunOnBatteryVoltageWithoutTimer322
	DEC        R17
	BRNE       L_RunOnBatteryVoltageWithoutTimer322
	DEC        R18
	BRNE       L_RunOnBatteryVoltageWithoutTimer322
	NOP
;Solar_Loads_Controller_SLCM_V1.c,762 :: 		while(Set==0)
L_RunOnBatteryVoltageWithoutTimer324:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_RunOnBatteryVoltageWithoutTimer325
;Solar_Loads_Controller_SLCM_V1.c,764 :: 		Display_On_7Segment_Character(0xC1,0xC0,0x80);   //VOB= voltage on battery
	LDI        R27, 128
	MOV        R4, R27
	LDI        R27, 192
	MOV        R3, R27
	LDI        R27, 193
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,765 :: 		}
	JMP        L_RunOnBatteryVoltageWithoutTimer324
L_RunOnBatteryVoltageWithoutTimer325:
;Solar_Loads_Controller_SLCM_V1.c,766 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_RunOnBatteryVoltageWithoutTimer326:
	DEC        R16
	BRNE       L_RunOnBatteryVoltageWithoutTimer326
	DEC        R17
	BRNE       L_RunOnBatteryVoltageWithoutTimer326
	DEC        R18
	BRNE       L_RunOnBatteryVoltageWithoutTimer326
	NOP
;Solar_Loads_Controller_SLCM_V1.c,767 :: 		while (Set==0)
L_RunOnBatteryVoltageWithoutTimer328:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_RunOnBatteryVoltageWithoutTimer329
;Solar_Loads_Controller_SLCM_V1.c,769 :: 		if(RunOnBatteryVoltageWithoutTimer_Flag==0)          Display_On_7Segment_Character(0xC0,0x8E,0x8E);        // mode is off so timer is on
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__RunOnBatteryVoltageWithoutTimer648
	JMP        L_RunOnBatteryVoltageWithoutTimer330
L__RunOnBatteryVoltageWithoutTimer648:
	LDI        R27, 142
	MOV        R4, R27
	LDI        R27, 142
	MOV        R3, R27
	LDI        R27, 192
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
L_RunOnBatteryVoltageWithoutTimer330:
;Solar_Loads_Controller_SLCM_V1.c,770 :: 		if(RunOnBatteryVoltageWithoutTimer_Flag==1)          Display_On_7Segment_Character(0xC0,0xC8,0xC8);       // mode is on so timer is off
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 1
	BREQ       L__RunOnBatteryVoltageWithoutTimer649
	JMP        L_RunOnBatteryVoltageWithoutTimer331
L__RunOnBatteryVoltageWithoutTimer649:
	LDI        R27, 200
	MOV        R4, R27
	LDI        R27, 200
	MOV        R3, R27
	LDI        R27, 192
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
L_RunOnBatteryVoltageWithoutTimer331:
;Solar_Loads_Controller_SLCM_V1.c,772 :: 		while (Increment == 1 || Decrement==1)
L_RunOnBatteryVoltageWithoutTimer332:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__RunOnBatteryVoltageWithoutTimer501
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__RunOnBatteryVoltageWithoutTimer500
	JMP        L_RunOnBatteryVoltageWithoutTimer333
L__RunOnBatteryVoltageWithoutTimer501:
L__RunOnBatteryVoltageWithoutTimer500:
;Solar_Loads_Controller_SLCM_V1.c,774 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_RunOnBatteryVoltageWithoutTimer336
;Solar_Loads_Controller_SLCM_V1.c,776 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_RunOnBatteryVoltageWithoutTimer337:
	DEC        R16
	BRNE       L_RunOnBatteryVoltageWithoutTimer337
	DEC        R17
	BRNE       L_RunOnBatteryVoltageWithoutTimer337
	DEC        R18
	BRNE       L_RunOnBatteryVoltageWithoutTimer337
;Solar_Loads_Controller_SLCM_V1.c,777 :: 		RunOnBatteryVoltageWithoutTimer_Flag=0;
	LDI        R27, 0
	STS        _RunOnBatteryVoltageWithoutTimer_Flag+0, R27
;Solar_Loads_Controller_SLCM_V1.c,778 :: 		}
L_RunOnBatteryVoltageWithoutTimer336:
;Solar_Loads_Controller_SLCM_V1.c,779 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_RunOnBatteryVoltageWithoutTimer339
;Solar_Loads_Controller_SLCM_V1.c,781 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_RunOnBatteryVoltageWithoutTimer340:
	DEC        R16
	BRNE       L_RunOnBatteryVoltageWithoutTimer340
	DEC        R17
	BRNE       L_RunOnBatteryVoltageWithoutTimer340
	DEC        R18
	BRNE       L_RunOnBatteryVoltageWithoutTimer340
;Solar_Loads_Controller_SLCM_V1.c,782 :: 		RunOnBatteryVoltageWithoutTimer_Flag=1;
	LDI        R27, 1
	STS        _RunOnBatteryVoltageWithoutTimer_Flag+0, R27
;Solar_Loads_Controller_SLCM_V1.c,783 :: 		}
L_RunOnBatteryVoltageWithoutTimer339:
;Solar_Loads_Controller_SLCM_V1.c,784 :: 		} // end while increment
	JMP        L_RunOnBatteryVoltageWithoutTimer332
L_RunOnBatteryVoltageWithoutTimer333:
;Solar_Loads_Controller_SLCM_V1.c,785 :: 		EEPROM_Write(0x14,RunOnBatteryVoltageWithoutTimer_Flag); // if zero timer is on and if 1 tiemr is off
	LDS        R4, _RunOnBatteryVoltageWithoutTimer_Flag+0
	LDI        R27, 20
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,786 :: 		} // end first while
	JMP        L_RunOnBatteryVoltageWithoutTimer328
L_RunOnBatteryVoltageWithoutTimer329:
;Solar_Loads_Controller_SLCM_V1.c,787 :: 		}
L_end_RunOnBatteryVoltageWithoutTimer:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _RunOnBatteryVoltageWithoutTimer

_Screen_1:

;Solar_Loads_Controller_SLCM_V1.c,789 :: 		void Screen_1()
;Solar_Loads_Controller_SLCM_V1.c,791 :: 		Read_Time();
	CALL       _Read_time+0
;Solar_Loads_Controller_SLCM_V1.c,793 :: 		}
L_end_Screen_1:
	RET
; end of _Screen_1

_ADCBattery:

;Solar_Loads_Controller_SLCM_V1.c,795 :: 		void ADCBattery()
;Solar_Loads_Controller_SLCM_V1.c,797 :: 		ADC_Init();
	PUSH       R2
	CALL       _ADC_Init+0
;Solar_Loads_Controller_SLCM_V1.c,798 :: 		ADC_Init_Advanced(_ADC_EXTERNAL_REF);
	CLR        R2
	CALL       _ADC_Init_Advanced+0
;Solar_Loads_Controller_SLCM_V1.c,799 :: 		ADPS2_Bit=1;
	IN         R27, ADPS2_bit+0
	SBR        R27, BitMask(ADPS2_bit+0)
	OUT        ADPS2_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,800 :: 		ADPS1_Bit=1;
	IN         R27, ADPS1_bit+0
	SBR        R27, BitMask(ADPS1_bit+0)
	OUT        ADPS1_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,801 :: 		ADPS0_Bit=0;
	IN         R27, ADPS0_bit+0
	CBR        R27, BitMask(ADPS0_bit+0)
	OUT        ADPS0_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,802 :: 		}
L_end_ADCBattery:
	POP        R2
	RET
; end of _ADCBattery

_Read_Battery:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 49
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;Solar_Loads_Controller_SLCM_V1.c,804 :: 		void Read_Battery()
;Solar_Loads_Controller_SLCM_V1.c,806 :: 		float sum=0 , Battery[10];
	PUSH       R2
	LDI        R27, 0
	STD        Y+40, R27
	STD        Y+41, R27
	STD        Y+42, R27
	STD        Y+43, R27
;Solar_Loads_Controller_SLCM_V1.c,807 :: 		char i=0;
;Solar_Loads_Controller_SLCM_V1.c,808 :: 		ADC_Value=ADC_Read(1);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _ADC_Read+0
	STS        _ADC_Value+0, R16
	STS        _ADC_Value+1, R17
;Solar_Loads_Controller_SLCM_V1.c,809 :: 		Battery_Voltage=(ADC_Value *5.0)/1024.0;
	LDI        R18, 0
	MOV        R19, R18
	CALL       _float_ulong2fp+0
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 160
	LDI        R23, 64
	CALL       _float_fpmul1+0
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 128
	LDI        R23, 68
	CALL       _float_fpdiv1+0
	STS        _Battery_Voltage+0, R16
	STS        _Battery_Voltage+1, R17
	STS        _Battery_Voltage+2, R18
	STS        _Battery_Voltage+3, R19
;Solar_Loads_Controller_SLCM_V1.c,813 :: 		for ( i=0; i<10 ; i++)
	LDI        R27, 0
	STD        Y+44, R27
L_Read_Battery342:
	LDD        R16, Y+44
	CPI        R16, 10
	BRLO       L__Read_Battery653
	JMP        L_Read_Battery343
L__Read_Battery653:
;Solar_Loads_Controller_SLCM_V1.c,815 :: 		Battery[i]=((10.5/0.5)*Battery_Voltage);
	MOVW       R18, R28
	LDD        R16, Y+44
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	ADD        R16, R18
	ADC        R17, R19
	STD        Y+47, R16
	STD        Y+48, R17
	LDI        R16, 0
	LDI        R17, 0
	LDI        R18, 168
	LDI        R19, 65
	LDS        R20, _Battery_Voltage+0
	LDS        R21, _Battery_Voltage+1
	LDS        R22, _Battery_Voltage+2
	LDS        R23, _Battery_Voltage+3
	CALL       _float_fpmul1+0
	LDD        R20, Y+47
	LDD        R21, Y+48
	MOVW       R30, R20
	ST         Z+, R16
	ST         Z+, R17
	ST         Z+, R18
	ST         Z+, R19
;Solar_Loads_Controller_SLCM_V1.c,817 :: 		sum+=Battery[i];
	MOVW       R18, R28
	LDD        R16, Y+44
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LSL        R16
	ROL        R17
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z+
	LD         R17, Z+
	LD         R18, Z+
	LD         R19, Z+
	LDD        R20, Y+40
	LDD        R21, Y+41
	LDD        R22, Y+42
	LDD        R23, Y+43
	CALL       _float_fpadd1+0
	STD        Y+40, R16
	STD        Y+41, R17
	STD        Y+42, R18
	STD        Y+43, R19
;Solar_Loads_Controller_SLCM_V1.c,813 :: 		for ( i=0; i<10 ; i++)
	LDD        R16, Y+44
	SUBI       R16, 255
	STD        Y+44, R16
;Solar_Loads_Controller_SLCM_V1.c,818 :: 		}
	JMP        L_Read_Battery342
L_Read_Battery343:
;Solar_Loads_Controller_SLCM_V1.c,819 :: 		Vin_Battery= sum/10.0 ;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 32
	LDI        R23, 65
	LDD        R16, Y+40
	LDD        R17, Y+41
	LDD        R18, Y+42
	LDD        R19, Y+43
	CALL       _float_fpdiv1+0
	STS        _Vin_Battery+0, R16
	STS        _Vin_Battery+1, R17
	STS        _Vin_Battery+2, R18
	STS        _Vin_Battery+3, R19
;Solar_Loads_Controller_SLCM_V1.c,821 :: 		}
L_end_Read_Battery:
	POP        R2
	ADIW       R28, 48
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _Read_Battery

_Start_Timer_0_A:

;Solar_Loads_Controller_SLCM_V1.c,824 :: 		void Start_Timer_0_A()
;Solar_Loads_Controller_SLCM_V1.c,826 :: 		WGM00_bit=0;
	IN         R27, WGM00_bit+0
	CBR        R27, BitMask(WGM00_bit+0)
	OUT        WGM00_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,827 :: 		WGM01_bit=0;
	IN         R27, WGM01_bit+0
	CBR        R27, BitMask(WGM01_bit+0)
	OUT        WGM01_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,828 :: 		CS00_bit=1; // prescalar 1024
	IN         R27, CS00_bit+0
	SBR        R27, BitMask(CS00_bit+0)
	OUT        CS00_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,829 :: 		CS02_bit=1; //prescalar 1024
	IN         R27, CS02_bit+0
	SBR        R27, BitMask(CS02_bit+0)
	OUT        CS02_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,830 :: 		SREG_I_Bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,831 :: 		OCR0=0xFF;
	LDI        R27, 255
	OUT        OCR0+0, R27
;Solar_Loads_Controller_SLCM_V1.c,832 :: 		OCIE0_Bit=1;
	IN         R27, OCIE0_bit+0
	SBR        R27, BitMask(OCIE0_bit+0)
	OUT        OCIE0_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,833 :: 		}
L_end_Start_Timer_0_A:
	RET
; end of _Start_Timer_0_A

_Interupt_Timer_0_OFFTime:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Loads_Controller_SLCM_V1.c,836 :: 		void Interupt_Timer_0_OFFTime() iv IVT_ADDR_TIMER0_COMP
;Solar_Loads_Controller_SLCM_V1.c,838 :: 		SREG_I_Bit=0; // disable interrupts
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,839 :: 		Timer_Counter_3++;                // timer for battery voltage
	LDS        R16, _Timer_Counter_3+0
	LDS        R17, _Timer_Counter_3+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _Timer_Counter_3+0, R18
	STS        _Timer_Counter_3+1, R19
;Solar_Loads_Controller_SLCM_V1.c,840 :: 		Timer_Counter_4++;
	LDS        R16, _Timer_Counter_4+0
	LDS        R17, _Timer_Counter_4+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Timer_Counter_4+0, R16
	STS        _Timer_Counter_4+1, R17
;Solar_Loads_Controller_SLCM_V1.c,841 :: 		Timer_Counter_For_Grid_Turn_Off++;
	LDS        R16, _Timer_Counter_For_Grid_Turn_Off+0
	LDS        R17, _Timer_Counter_For_Grid_Turn_Off+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Timer_Counter_For_Grid_Turn_Off+0, R16
	STS        _Timer_Counter_For_Grid_Turn_Off+1, R17
;Solar_Loads_Controller_SLCM_V1.c,844 :: 		if (Timer_Counter_3==500)              // more than 10 seconds
	CPI        R19, 1
	BRNE       L__Interupt_Timer_0_OFFTime656
	CPI        R18, 244
L__Interupt_Timer_0_OFFTime656:
	BREQ       L__Interupt_Timer_0_OFFTime657
	JMP        L_Interupt_Timer_0_OFFTime345
L__Interupt_Timer_0_OFFTime657:
;Solar_Loads_Controller_SLCM_V1.c,846 :: 		if(Vin_Battery<Mini_Battery_Voltage && AC_Available==1)
	LDS        R20, _Mini_Battery_Voltage+0
	LDS        R21, _Mini_Battery_Voltage+1
	LDS        R22, _Mini_Battery_Voltage+2
	LDS        R23, _Mini_Battery_Voltage+3
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_less+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__Interupt_Timer_0_OFFTime658
	LDI        R16, 1
L__Interupt_Timer_0_OFFTime658:
	TST        R16
	BRNE       L__Interupt_Timer_0_OFFTime659
	JMP        L__Interupt_Timer_0_OFFTime522
L__Interupt_Timer_0_OFFTime659:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Interupt_Timer_0_OFFTime521
L__Interupt_Timer_0_OFFTime520:
;Solar_Loads_Controller_SLCM_V1.c,848 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,849 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Interupt_Timer_0_OFFTime349:
	DEC        R16
	BRNE       L_Interupt_Timer_0_OFFTime349
	DEC        R17
	BRNE       L_Interupt_Timer_0_OFFTime349
	DEC        R18
	BRNE       L_Interupt_Timer_0_OFFTime349
	NOP
;Solar_Loads_Controller_SLCM_V1.c,850 :: 		Relay_L_Solar=0;
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,846 :: 		if(Vin_Battery<Mini_Battery_Voltage && AC_Available==1)
L__Interupt_Timer_0_OFFTime522:
L__Interupt_Timer_0_OFFTime521:
;Solar_Loads_Controller_SLCM_V1.c,853 :: 		Timer_Counter_3=0;
	LDI        R27, 0
	STS        _Timer_Counter_3+0, R27
	STS        _Timer_Counter_3+1, R27
;Solar_Loads_Controller_SLCM_V1.c,854 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Loads_Controller_SLCM_V1.c,855 :: 		}
L_Interupt_Timer_0_OFFTime345:
;Solar_Loads_Controller_SLCM_V1.c,859 :: 		if (Timer_Counter_For_Grid_Turn_Off==1000)
	LDS        R16, _Timer_Counter_For_Grid_Turn_Off+0
	LDS        R17, _Timer_Counter_For_Grid_Turn_Off+1
	CPI        R17, 3
	BRNE       L__Interupt_Timer_0_OFFTime660
	CPI        R16, 232
L__Interupt_Timer_0_OFFTime660:
	BREQ       L__Interupt_Timer_0_OFFTime661
	JMP        L_Interupt_Timer_0_OFFTime351
L__Interupt_Timer_0_OFFTime661:
;Solar_Loads_Controller_SLCM_V1.c,861 :: 		if(AC_Available==0)
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L_Interupt_Timer_0_OFFTime352
;Solar_Loads_Controller_SLCM_V1.c,863 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,864 :: 		Relay_L_Solar=0;
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,865 :: 		}
L_Interupt_Timer_0_OFFTime352:
;Solar_Loads_Controller_SLCM_V1.c,866 :: 		Timer_Counter_For_Grid_Turn_Off=0;
	LDI        R27, 0
	STS        _Timer_Counter_For_Grid_Turn_Off+0, R27
	STS        _Timer_Counter_For_Grid_Turn_Off+1, R27
;Solar_Loads_Controller_SLCM_V1.c,867 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Loads_Controller_SLCM_V1.c,868 :: 		}
L_Interupt_Timer_0_OFFTime351:
;Solar_Loads_Controller_SLCM_V1.c,870 :: 		SREG_I_Bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,871 :: 		OCF0_Bit=1; // clear
	IN         R27, OCF0_bit+0
	SBR        R27, BitMask(OCF0_bit+0)
	OUT        OCF0_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,872 :: 		}
L_end_Interupt_Timer_0_OFFTime:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Interupt_Timer_0_OFFTime

_Stop_Timer_0:

;Solar_Loads_Controller_SLCM_V1.c,874 :: 		void Stop_Timer_0()
;Solar_Loads_Controller_SLCM_V1.c,876 :: 		CS00_bit=0;
	IN         R27, CS00_bit+0
	CBR        R27, BitMask(CS00_bit+0)
	OUT        CS00_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,877 :: 		CS01_bit=0;
	IN         R27, CS01_bit+0
	CBR        R27, BitMask(CS01_bit+0)
	OUT        CS01_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,878 :: 		CS02_bit=0;
	IN         R27, CS02_bit+0
	CBR        R27, BitMask(CS02_bit+0)
	OUT        CS02_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,879 :: 		}
L_end_Stop_Timer_0:
	RET
; end of _Stop_Timer_0

_EEPROM_FactorySettings:

;Solar_Loads_Controller_SLCM_V1.c,882 :: 		void EEPROM_FactorySettings(char period)
;Solar_Loads_Controller_SLCM_V1.c,884 :: 		if(period==1) // summer  timer
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, 1
	CP         R2, R27
	BREQ       L__EEPROM_FactorySettings664
	JMP        L_EEPROM_FactorySettings353
L__EEPROM_FactorySettings664:
;Solar_Loads_Controller_SLCM_V1.c,886 :: 		Mini_Battery_Voltage=24.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	LDI        R27, 196
	STS        _Mini_Battery_Voltage+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage+3, R27
;Solar_Loads_Controller_SLCM_V1.c,887 :: 		StartLoadsVoltage=26.5,
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	LDI        R27, 212
	STS        _StartLoadsVoltage+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage+3, R27
;Solar_Loads_Controller_SLCM_V1.c,888 :: 		startupTIme_1 =180,
	LDI        R27, 180
	STS        _startupTIme_1+0, R27
	LDI        R27, 0
	STS        _startupTIme_1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,890 :: 		EEPROM_Write(0x00,8);  // writing start hours
	LDI        R27, 8
	MOV        R4, R27
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,891 :: 		EEPROM_Write(0x01,0);    // writing  start minutes
	CLR        R4
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,892 :: 		EEPROM_Write(0x02,17);    // writing off hours
	LDI        R27, 17
	MOV        R4, R27
	LDI        R27, 2
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,893 :: 		EEPROM_Write(0x03,0);    // writing off minutes
	CLR        R4
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,895 :: 		EEPROM_write(0x14,0);    // timer is on and RunOnBatteryVolatgeWithoutTimer is off
	CLR        R4
	LDI        R27, 20
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,897 :: 		StoreBytesIntoEEprom(0x04,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_Mini_Battery_Voltage+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_Mini_Battery_Voltage+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Loads_Controller_SLCM_V1.c,898 :: 		StoreBytesIntoEEprom(0x08,(unsigned short *)&StartLoadsVoltage,4);
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_StartLoadsVoltage+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_StartLoadsVoltage+0)
	MOV        R5, R27
	LDI        R27, 8
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Loads_Controller_SLCM_V1.c,899 :: 		StoreBytesIntoEEprom(0x12,(unsigned short *)&startupTIme_1,2);
	LDI        R27, 2
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_startupTIme_1+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_startupTIme_1+0)
	MOV        R5, R27
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Loads_Controller_SLCM_V1.c,900 :: 		}
L_EEPROM_FactorySettings353:
;Solar_Loads_Controller_SLCM_V1.c,901 :: 		}
L_end_EEPROM_FactorySettings:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _EEPROM_FactorySettings

_RunTimersNowCheck:

;Solar_Loads_Controller_SLCM_V1.c,903 :: 		RunTimersNowCheck()
;Solar_Loads_Controller_SLCM_V1.c,906 :: 		if (Button(&PINA,5,1000,1 ) && Button(&PINA,6,1000,0 )) // if increment pressed for 1 second
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	LDI        R27, 1
	MOV        R6, R27
	LDI        R27, 232
	MOV        R5, R27
	LDI        R27, 5
	MOV        R4, R27
	LDI        R27, #lo_addr(PINA+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PINA+0)
	MOV        R3, R27
	CALL       _Button+0
	TST        R16
	BRNE       L__RunTimersNowCheck666
	JMP        L__RunTimersNowCheck528
L__RunTimersNowCheck666:
	CLR        R6
	LDI        R27, 232
	MOV        R5, R27
	LDI        R27, 6
	MOV        R4, R27
	LDI        R27, #lo_addr(PINA+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PINA+0)
	MOV        R3, R27
	CALL       _Button+0
	TST        R16
	BRNE       L__RunTimersNowCheck667
	JMP        L__RunTimersNowCheck527
L__RunTimersNowCheck667:
L__RunTimersNowCheck526:
;Solar_Loads_Controller_SLCM_V1.c,908 :: 		RunLoadsByBass=1;
	LDI        R27, 1
	STS        _RunLoadsByBass+0, R27
;Solar_Loads_Controller_SLCM_V1.c,909 :: 		if (  RunLoadsByBass==1 ) Relay_L_Solar=1;
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,906 :: 		if (Button(&PINA,5,1000,1 ) && Button(&PINA,6,1000,0 )) // if increment pressed for 1 second
L__RunTimersNowCheck528:
L__RunTimersNowCheck527:
;Solar_Loads_Controller_SLCM_V1.c,912 :: 		if (Button(&PINA,6,1000,1)  && Button(&PINA,5,1000,1))     // up & Down for 1 seconds reset mode
	LDI        R27, 1
	MOV        R6, R27
	LDI        R27, 232
	MOV        R5, R27
	LDI        R27, 6
	MOV        R4, R27
	LDI        R27, #lo_addr(PINA+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PINA+0)
	MOV        R3, R27
	CALL       _Button+0
	TST        R16
	BRNE       L__RunTimersNowCheck668
	JMP        L__RunTimersNowCheck530
L__RunTimersNowCheck668:
	LDI        R27, 1
	MOV        R6, R27
	LDI        R27, 232
	MOV        R5, R27
	LDI        R27, 5
	MOV        R4, R27
	LDI        R27, #lo_addr(PINA+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PINA+0)
	MOV        R3, R27
	CALL       _Button+0
	TST        R16
	BRNE       L__RunTimersNowCheck669
	JMP        L__RunTimersNowCheck529
L__RunTimersNowCheck669:
L__RunTimersNowCheck525:
;Solar_Loads_Controller_SLCM_V1.c,914 :: 		EEPROM_FactorySettings(1);        // summer time in this version i deleted winter time
	LDI        R27, 1
	MOV        R2, R27
	CALL       _EEPROM_FactorySettings+0
;Solar_Loads_Controller_SLCM_V1.c,915 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_RunTimersNowCheck361:
	DEC        R16
	BRNE       L_RunTimersNowCheck361
	DEC        R17
	BRNE       L_RunTimersNowCheck361
	DEC        R18
	BRNE       L_RunTimersNowCheck361
;Solar_Loads_Controller_SLCM_V1.c,916 :: 		EEPROM_Load();    // read the new values from epprom
	CALL       _EEPROM_Load+0
;Solar_Loads_Controller_SLCM_V1.c,917 :: 		Delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_RunTimersNowCheck363:
	DEC        R16
	BRNE       L_RunTimersNowCheck363
	DEC        R17
	BRNE       L_RunTimersNowCheck363
	DEC        R18
	BRNE       L_RunTimersNowCheck363
	NOP
	NOP
	NOP
	NOP
;Solar_Loads_Controller_SLCM_V1.c,918 :: 		while(1)
L_RunTimersNowCheck365:
;Solar_Loads_Controller_SLCM_V1.c,920 :: 		Display_On_7Segment_Character(0x88,0x92,0xB8);     //RST
	LDI        R27, 184
	MOV        R4, R27
	LDI        R27, 146
	MOV        R3, R27
	LDI        R27, 136
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,921 :: 		}
	JMP        L_RunTimersNowCheck365
;Solar_Loads_Controller_SLCM_V1.c,912 :: 		if (Button(&PINA,6,1000,1)  && Button(&PINA,5,1000,1))     // up & Down for 1 seconds reset mode
L__RunTimersNowCheck530:
L__RunTimersNowCheck529:
;Solar_Loads_Controller_SLCM_V1.c,926 :: 		if(Decrement==1 && Increment==0)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L__RunTimersNowCheck534
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__RunTimersNowCheck533
L__RunTimersNowCheck524:
;Solar_Loads_Controller_SLCM_V1.c,928 :: 		Delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_RunTimersNowCheck372:
	DEC        R16
	BRNE       L_RunTimersNowCheck372
	DEC        R17
	BRNE       L_RunTimersNowCheck372
	DEC        R18
	BRNE       L_RunTimersNowCheck372
	NOP
	NOP
	NOP
	NOP
;Solar_Loads_Controller_SLCM_V1.c,929 :: 		if (Decrement==1 && Increment==0 )
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L__RunTimersNowCheck532
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__RunTimersNowCheck531
L__RunTimersNowCheck523:
;Solar_Loads_Controller_SLCM_V1.c,931 :: 		TurnOffLoadsByPass=1;
	LDI        R27, 1
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Loads_Controller_SLCM_V1.c,932 :: 		RunLoadsByBass=0;
	LDI        R27, 0
	STS        _RunLoadsByBass+0, R27
;Solar_Loads_Controller_SLCM_V1.c,933 :: 		Relay_L_Solar=0;
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,929 :: 		if (Decrement==1 && Increment==0 )
L__RunTimersNowCheck532:
L__RunTimersNowCheck531:
;Solar_Loads_Controller_SLCM_V1.c,926 :: 		if(Decrement==1 && Increment==0)
L__RunTimersNowCheck534:
L__RunTimersNowCheck533:
;Solar_Loads_Controller_SLCM_V1.c,936 :: 		}
L_end_RunTimersNowCheck:
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _RunTimersNowCheck

_AutoRunWithOutBatteryProtection:

;Solar_Loads_Controller_SLCM_V1.c,939 :: 		void AutoRunWithOutBatteryProtection()
;Solar_Loads_Controller_SLCM_V1.c,941 :: 		if (Vin_Battery==0)
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 0
	LDI        R23, 0
	CALL       _float_op_equ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__AutoRunWithOutBatteryProtection671
	LDI        R16, 1
L__AutoRunWithOutBatteryProtection671:
	TST        R16
	BRNE       L__AutoRunWithOutBatteryProtection672
	JMP        L_AutoRunWithOutBatteryProtection377
L__AutoRunWithOutBatteryProtection672:
;Solar_Loads_Controller_SLCM_V1.c,943 :: 		RunWithOutBattery=true;
	LDI        R27, 1
	STS        _RunWithOutBattery+0, R27
;Solar_Loads_Controller_SLCM_V1.c,944 :: 		}
	JMP        L_AutoRunWithOutBatteryProtection378
L_AutoRunWithOutBatteryProtection377:
;Solar_Loads_Controller_SLCM_V1.c,947 :: 		RunWithOutBattery=false;
	LDI        R27, 0
	STS        _RunWithOutBattery+0, R27
;Solar_Loads_Controller_SLCM_V1.c,948 :: 		}
L_AutoRunWithOutBatteryProtection378:
;Solar_Loads_Controller_SLCM_V1.c,949 :: 		}
L_end_AutoRunWithOutBatteryProtection:
	RET
; end of _AutoRunWithOutBatteryProtection

_CheckForTimerActivationInRange:

;Solar_Loads_Controller_SLCM_V1.c,951 :: 		void CheckForTimerActivationInRange()
;Solar_Loads_Controller_SLCM_V1.c,955 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2 && RunOnBatteryVoltageWithoutTimer_Flag==0  )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange674
	JMP        L__CheckForTimerActivationInRange540
L__CheckForTimerActivationInRange674:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange675
	JMP        L__CheckForTimerActivationInRange539
L__CheckForTimerActivationInRange675:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_2+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange676
	JMP        L__CheckForTimerActivationInRange538
L__CheckForTimerActivationInRange676:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__CheckForTimerActivationInRange677
	JMP        L__CheckForTimerActivationInRange537
L__CheckForTimerActivationInRange677:
L__CheckForTimerActivationInRange536:
;Solar_Loads_Controller_SLCM_V1.c,957 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,955 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2 && RunOnBatteryVoltageWithoutTimer_Flag==0  )
L__CheckForTimerActivationInRange540:
L__CheckForTimerActivationInRange539:
L__CheckForTimerActivationInRange538:
L__CheckForTimerActivationInRange537:
;Solar_Loads_Controller_SLCM_V1.c,962 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2  && RunOnBatteryVoltageWithoutTimer_Flag==0)
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange678
	JMP        L__CheckForTimerActivationInRange544
L__CheckForTimerActivationInRange678:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange679
	JMP        L__CheckForTimerActivationInRange543
L__CheckForTimerActivationInRange679:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_2+0
	CP         R16, R17
	BREQ       L__CheckForTimerActivationInRange680
	JMP        L__CheckForTimerActivationInRange542
L__CheckForTimerActivationInRange680:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__CheckForTimerActivationInRange681
	JMP        L__CheckForTimerActivationInRange541
L__CheckForTimerActivationInRange681:
L__CheckForTimerActivationInRange535:
;Solar_Loads_Controller_SLCM_V1.c,965 :: 		if(ReadMinutes() < minutes_lcd_2)        // starts the load
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_2+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange682
	JMP        L_CheckForTimerActivationInRange385
L__CheckForTimerActivationInRange682:
;Solar_Loads_Controller_SLCM_V1.c,967 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,968 :: 		}
L_CheckForTimerActivationInRange385:
;Solar_Loads_Controller_SLCM_V1.c,962 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2  && RunOnBatteryVoltageWithoutTimer_Flag==0)
L__CheckForTimerActivationInRange544:
L__CheckForTimerActivationInRange543:
L__CheckForTimerActivationInRange542:
L__CheckForTimerActivationInRange541:
;Solar_Loads_Controller_SLCM_V1.c,970 :: 		}  // end function
L_end_CheckForTimerActivationInRange:
	RET
; end of _CheckForTimerActivationInRange

_TurnLoadsOffWhenGridOff:

;Solar_Loads_Controller_SLCM_V1.c,973 :: 		void TurnLoadsOffWhenGridOff()
;Solar_Loads_Controller_SLCM_V1.c,976 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0)
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__TurnLoadsOffWhenGridOff549
	LDS        R16, _Timer_isOn+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff684
	JMP        L__TurnLoadsOffWhenGridOff548
L__TurnLoadsOffWhenGridOff684:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff685
	JMP        L__TurnLoadsOffWhenGridOff547
L__TurnLoadsOffWhenGridOff685:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff686
	JMP        L__TurnLoadsOffWhenGridOff546
L__TurnLoadsOffWhenGridOff686:
L__TurnLoadsOffWhenGridOff545:
;Solar_Loads_Controller_SLCM_V1.c,978 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,979 :: 		Relay_L_Solar=0;
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,976 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0)
L__TurnLoadsOffWhenGridOff549:
L__TurnLoadsOffWhenGridOff548:
L__TurnLoadsOffWhenGridOff547:
L__TurnLoadsOffWhenGridOff546:
;Solar_Loads_Controller_SLCM_V1.c,981 :: 		}
L_end_TurnLoadsOffWhenGridOff:
	RET
; end of _TurnLoadsOffWhenGridOff

_Display_On_7Segment_Battery:

;Solar_Loads_Controller_SLCM_V1.c,985 :: 		void Display_On_7Segment_Battery(float num)
;Solar_Loads_Controller_SLCM_V1.c,988 :: 		num = num*10;      //(Becuase there is just three digits that i want to Display
	MOVW       R16, R2
	MOVW       R18, R4
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 32
	LDI        R23, 65
	CALL       _float_fpmul1+0
	MOVW       R2, R16
	MOVW       R4, R18
;Solar_Loads_Controller_SLCM_V1.c,989 :: 		voltage_int=(int)num;      // Convert the Value to Int and Display just three Digits
	CALL       _float_fpint+0
	STS        _voltage_int+0, R16
	STS        _voltage_int+1, R17
;Solar_Loads_Controller_SLCM_V1.c,990 :: 		a=voltage_int%10;    //3th digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _a+0, R16
	STS        _a+1, R17
;Solar_Loads_Controller_SLCM_V1.c,991 :: 		b=voltage_int/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _voltage_int+0
	LDS        R17, _voltage_int+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _b+0, R16
	STS        _b+1, R17
;Solar_Loads_Controller_SLCM_V1.c,992 :: 		c=b%10;       //2rd digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _c+0, R16
	STS        _c+1, R17
;Solar_Loads_Controller_SLCM_V1.c,993 :: 		d=b/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _b+0
	LDS        R17, _b+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _d+0, R16
	STS        _d+1, R17
;Solar_Loads_Controller_SLCM_V1.c,994 :: 		e=d%10;      //1nd digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _e+0, R16
	STS        _e+1, R17
;Solar_Loads_Controller_SLCM_V1.c,995 :: 		f=d/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _d+0
	LDS        R17, _d+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _f+0, R16
	STS        _f+1, R17
;Solar_Loads_Controller_SLCM_V1.c,996 :: 		Display_3=1;    // 3 th digit
	IN         R27, PORTC+0
	SBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,997 :: 		PORTB=array[a];
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _a+0
	LDS        R17, _a+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,998 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Battery389:
	DEC        R16
	BRNE       L_Display_On_7Segment_Battery389
	DEC        R17
	BRNE       L_Display_On_7Segment_Battery389
;Solar_Loads_Controller_SLCM_V1.c,999 :: 		Display_3=0;
	IN         R27, PORTC+0
	CBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1000 :: 		Display_2=1;
	IN         R27, PORTC+0
	SBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1001 :: 		PORTB=array[c] & 0x7F;   // second    7F for turning on dp
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _c+0
	LDS        R17, _c+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	ANDI       R16, 127
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1002 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Battery391:
	DEC        R16
	BRNE       L_Display_On_7Segment_Battery391
	DEC        R17
	BRNE       L_Display_On_7Segment_Battery391
;Solar_Loads_Controller_SLCM_V1.c,1003 :: 		Display_2=0;
	IN         R27, PORTC+0
	CBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1004 :: 		if ( e!=0)  // if num=8.1 it will show 08.1 on 7 segment
	LDS        R16, _e+0
	LDS        R17, _e+1
	CPI        R17, 0
	BRNE       L__Display_On_7Segment_Battery688
	CPI        R16, 0
L__Display_On_7Segment_Battery688:
	BRNE       L__Display_On_7Segment_Battery689
	JMP        L_Display_On_7Segment_Battery393
L__Display_On_7Segment_Battery689:
;Solar_Loads_Controller_SLCM_V1.c,1006 :: 		Display_1=1;
	IN         R27, PORTC+0
	SBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1007 :: 		PORTB=array[e];
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _e+0
	LDS        R17, _e+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1008 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Battery394:
	DEC        R16
	BRNE       L_Display_On_7Segment_Battery394
	DEC        R17
	BRNE       L_Display_On_7Segment_Battery394
;Solar_Loads_Controller_SLCM_V1.c,1009 :: 		Display_1=0;
	IN         R27, PORTC+0
	CBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1010 :: 		}
	JMP        L_Display_On_7Segment_Battery396
L_Display_On_7Segment_Battery393:
;Solar_Loads_Controller_SLCM_V1.c,1013 :: 		Display_1=0;
	IN         R27, PORTC+0
	CBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1014 :: 		}
L_Display_On_7Segment_Battery396:
;Solar_Loads_Controller_SLCM_V1.c,1015 :: 		}
L_end_Display_On_7Segment_Battery:
	RET
; end of _Display_On_7Segment_Battery

_Display_On_7Segment:

;Solar_Loads_Controller_SLCM_V1.c,1017 :: 		void Display_On_7Segment(unsigned short number)
;Solar_Loads_Controller_SLCM_V1.c,1019 :: 		number=number;
;Solar_Loads_Controller_SLCM_V1.c,1020 :: 		a=number%10;    //3th digit is saved here
	LDI        R20, 10
	MOV        R16, R2
	CALL       _Div_8x8_U+0
	MOV        R16, R25
	STS        _a+0, R16
	LDI        R27, 0
	STS        _a+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1021 :: 		b=number/10;
	LDI        R20, 10
	MOV        R16, R2
	CALL       _Div_8x8_U+0
	STS        _b+0, R16
	LDI        R27, 0
	STS        _b+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1022 :: 		c=b%10;       //2rd digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _b+0
	LDS        R17, _b+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _c+0, R16
	STS        _c+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1023 :: 		d=b/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _b+0
	LDS        R17, _b+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _d+0, R16
	STS        _d+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1024 :: 		e=d%10;      //1nd digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _e+0, R16
	STS        _e+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1025 :: 		f=d/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _d+0
	LDS        R17, _d+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _f+0, R16
	STS        _f+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1026 :: 		Display_3=1;    // 3 th digit
	IN         R27, PORTC+0
	SBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1027 :: 		PORTB=array[a];
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _a+0
	LDS        R17, _a+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1028 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment397:
	DEC        R16
	BRNE       L_Display_On_7Segment397
	DEC        R17
	BRNE       L_Display_On_7Segment397
;Solar_Loads_Controller_SLCM_V1.c,1029 :: 		Display_3=0;
	IN         R27, PORTC+0
	CBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1030 :: 		Display_2=1;
	IN         R27, PORTC+0
	SBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1031 :: 		PORTB=array[c] ;   // second    7F for turning on dp
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _c+0
	LDS        R17, _c+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1032 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment399:
	DEC        R16
	BRNE       L_Display_On_7Segment399
	DEC        R17
	BRNE       L_Display_On_7Segment399
;Solar_Loads_Controller_SLCM_V1.c,1033 :: 		Display_2=0;
	IN         R27, PORTC+0
	CBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1034 :: 		Display_1=1;
	IN         R27, PORTC+0
	SBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1035 :: 		PORTB=array[e];
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _e+0
	LDS        R17, _e+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1036 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment401:
	DEC        R16
	BRNE       L_Display_On_7Segment401
	DEC        R17
	BRNE       L_Display_On_7Segment401
;Solar_Loads_Controller_SLCM_V1.c,1037 :: 		Display_1=0;
	IN         R27, PORTC+0
	CBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1038 :: 		}
L_end_Display_On_7Segment:
	RET
; end of _Display_On_7Segment

_Display_On_7Segment_Float:

;Solar_Loads_Controller_SLCM_V1.c,1040 :: 		void Display_On_7Segment_Float(float number)
;Solar_Loads_Controller_SLCM_V1.c,1043 :: 		number=number*10;
	MOVW       R16, R2
	MOVW       R18, R4
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 32
	LDI        R23, 65
	CALL       _float_fpmul1+0
	MOVW       R2, R16
	MOVW       R4, R18
;Solar_Loads_Controller_SLCM_V1.c,1044 :: 		convertedNum=(int)Number;
	CALL       _float_fpint+0
; convertedNum start address is: 18 (R18)
	MOVW       R18, R16
;Solar_Loads_Controller_SLCM_V1.c,1045 :: 		a=convertedNum%10;    //3th digit is saved here
	PUSH       R19
	PUSH       R18
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	POP        R18
	POP        R19
	STS        _a+0, R16
	STS        _a+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1046 :: 		b=convertedNum/10;
	MOVW       R16, R18
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
; convertedNum end address is: 18 (R18)
	STS        _b+0, R16
	STS        _b+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1047 :: 		c=b%10;       //2rd digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _c+0, R16
	STS        _c+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1048 :: 		d=b/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _b+0
	LDS        R17, _b+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _d+0, R16
	STS        _d+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1049 :: 		e=d%10;      //1nd digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _e+0, R16
	STS        _e+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1050 :: 		f=d/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _d+0
	LDS        R17, _d+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _f+0, R16
	STS        _f+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1051 :: 		Display_3=1;    // 3 th digit
	IN         R27, PORTC+0
	SBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1052 :: 		PORTB=array[a];
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _a+0
	LDS        R17, _a+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1053 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Float403:
	DEC        R16
	BRNE       L_Display_On_7Segment_Float403
	DEC        R17
	BRNE       L_Display_On_7Segment_Float403
;Solar_Loads_Controller_SLCM_V1.c,1054 :: 		Display_3=0;
	IN         R27, PORTC+0
	CBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1055 :: 		Display_2=1;
	IN         R27, PORTC+0
	SBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1056 :: 		PORTB=array[c] &0x7F ;   // second    7F for turning on dp
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _c+0
	LDS        R17, _c+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	ANDI       R16, 127
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1057 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Float405:
	DEC        R16
	BRNE       L_Display_On_7Segment_Float405
	DEC        R17
	BRNE       L_Display_On_7Segment_Float405
;Solar_Loads_Controller_SLCM_V1.c,1058 :: 		Display_2=0;
	IN         R27, PORTC+0
	CBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1059 :: 		Display_1=1;
	IN         R27, PORTC+0
	SBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1060 :: 		PORTB=array[e];
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _e+0
	LDS        R17, _e+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1061 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Float407:
	DEC        R16
	BRNE       L_Display_On_7Segment_Float407
	DEC        R17
	BRNE       L_Display_On_7Segment_Float407
;Solar_Loads_Controller_SLCM_V1.c,1062 :: 		Display_1=0;
	IN         R27, PORTC+0
	CBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1063 :: 		}
L_end_Display_On_7Segment_Float:
	RET
; end of _Display_On_7Segment_Float

_Display_On_7Segment_Character:

;Solar_Loads_Controller_SLCM_V1.c,1066 :: 		void Display_On_7Segment_Character(char chr1,char chr2,char chr3)
;Solar_Loads_Controller_SLCM_V1.c,1068 :: 		Display_3=1;    // 3 th digit
	IN         R27, PORTC+0
	SBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1069 :: 		PORTB=chr3;
	OUT        PORTB+0, R4
;Solar_Loads_Controller_SLCM_V1.c,1070 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Character409:
	DEC        R16
	BRNE       L_Display_On_7Segment_Character409
	DEC        R17
	BRNE       L_Display_On_7Segment_Character409
;Solar_Loads_Controller_SLCM_V1.c,1071 :: 		Display_3=0;
	IN         R27, PORTC+0
	CBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1072 :: 		Display_2=1;
	IN         R27, PORTC+0
	SBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1073 :: 		PORTB=chr2 ;   // second    7F for turning on dp
	OUT        PORTB+0, R3
;Solar_Loads_Controller_SLCM_V1.c,1074 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Character411:
	DEC        R16
	BRNE       L_Display_On_7Segment_Character411
	DEC        R17
	BRNE       L_Display_On_7Segment_Character411
;Solar_Loads_Controller_SLCM_V1.c,1075 :: 		Display_2=0;
	IN         R27, PORTC+0
	CBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1076 :: 		Display_1=1;
	IN         R27, PORTC+0
	SBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1077 :: 		PORTB=chr1;
	OUT        PORTB+0, R2
;Solar_Loads_Controller_SLCM_V1.c,1078 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Character413:
	DEC        R16
	BRNE       L_Display_On_7Segment_Character413
	DEC        R17
	BRNE       L_Display_On_7Segment_Character413
;Solar_Loads_Controller_SLCM_V1.c,1079 :: 		Display_1=0;
	IN         R27, PORTC+0
	CBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1080 :: 		}
L_end_Display_On_7Segment_Character:
	RET
; end of _Display_On_7Segment_Character

_Timer_2_Init_Screen:

;Solar_Loads_Controller_SLCM_V1.c,1082 :: 		void Timer_2_Init_Screen()
;Solar_Loads_Controller_SLCM_V1.c,1090 :: 		SREG_I_bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1091 :: 		TCCR2|= (1<<WGM21);   //choosing compare output mode for timer 2
	IN         R27, TCCR2+0
	SBR        R27, 8
	OUT        TCCR2+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1092 :: 		TCCR2|=(1<<CS22) | (1 <<CS21 ) | ( 1<< CS20) ;    //choosing 1024 prescalar so we can get 1 ms delay for updating Dipslay
	IN         R16, TCCR2+0
	ORI        R16, 7
	OUT        TCCR2+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1093 :: 		OCR2=80;
	LDI        R27, 80
	OUT        OCR2+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1094 :: 		TIMSK |= (1<<OCIE2);     //enabling interrupt
	IN         R16, TIMSK+0
	ORI        R16, 128
	OUT        TIMSK+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1095 :: 		TIMSK |=(1<<OCF2);
	ORI        R16, 128
	OUT        TIMSK+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1096 :: 		}
L_end_Timer_2_Init_Screen:
	RET
; end of _Timer_2_Init_Screen

_Timer_Interrupt_UpdateScreen:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Loads_Controller_SLCM_V1.c,1098 :: 		void Timer_Interrupt_UpdateScreen() iv IVT_ADDR_TIMER2_COMP
;Solar_Loads_Controller_SLCM_V1.c,1100 :: 		Display_On_7Segment_Battery(Vin_Battery); // update display
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDS        R2, _Vin_Battery+0
	LDS        R3, _Vin_Battery+1
	LDS        R4, _Vin_Battery+2
	LDS        R5, _Vin_Battery+3
	CALL       _Display_On_7Segment_Battery+0
;Solar_Loads_Controller_SLCM_V1.c,1102 :: 		OCF1A_bit=1;               //clear flag
	IN         R27, OCF1A_bit+0
	SBR        R27, BitMask(OCF1A_bit+0)
	OUT        OCF1A_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1104 :: 		}
L_end_Timer_Interrupt_UpdateScreen:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Timer_Interrupt_UpdateScreen

_CheckForSet:

;Solar_Loads_Controller_SLCM_V1.c,1106 :: 		void CheckForSet()
;Solar_Loads_Controller_SLCM_V1.c,1108 :: 		SREG_I_Bit=0; // disable interrupts
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1109 :: 		if (Button(&PIND,3,1000,1 ))
	LDI        R27, 1
	MOV        R6, R27
	LDI        R27, 232
	MOV        R5, R27
	LDI        R27, 3
	MOV        R4, R27
	LDI        R27, #lo_addr(PIND+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PIND+0)
	MOV        R3, R27
	CALL       _Button+0
	TST        R16
	BRNE       L__CheckForSet696
	JMP        L_CheckForSet415
L__CheckForSet696:
;Solar_Loads_Controller_SLCM_V1.c,1111 :: 		SetUpProgram();
	CALL       _SetUpProgram+0
;Solar_Loads_Controller_SLCM_V1.c,1112 :: 		}
L_CheckForSet415:
;Solar_Loads_Controller_SLCM_V1.c,1113 :: 		SREG_I_Bit=1; // disable interrupts
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1114 :: 		}
L_end_CheckForSet:
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _CheckForSet

_Config_Interrupts:

;Solar_Loads_Controller_SLCM_V1.c,1117 :: 		void Config_Interrupts()
;Solar_Loads_Controller_SLCM_V1.c,1119 :: 		ISC10_bit=1;   // Config interrupts for setup program
	IN         R27, ISC10_bit+0
	SBR        R27, BitMask(ISC10_bit+0)
	OUT        ISC10_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1120 :: 		ISC11_bit=1;   // Config interrupts for setup program
	IN         R27, ISC11_bit+0
	SBR        R27, BitMask(ISC11_bit+0)
	OUT        ISC11_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1121 :: 		ISC00_bit=1;   //config interrupts for shutting loads off when grid is off
	IN         R27, ISC00_bit+0
	SBR        R27, BitMask(ISC00_bit+0)
	OUT        ISC00_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1122 :: 		ISC01_bit=1;   //config interrupts for shutting loads off when grid is off
	IN         R27, ISC01_bit+0
	SBR        R27, BitMask(ISC01_bit+0)
	OUT        ISC01_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1123 :: 		INT1_bit=1;
	IN         R27, INT1_bit+0
	SBR        R27, BitMask(INT1_bit+0)
	OUT        INT1_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1124 :: 		INT0_bit=1;
	IN         R27, INT0_bit+0
	SBR        R27, BitMask(INT0_bit+0)
	OUT        INT0_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1125 :: 		SREG_I_bit=1; // enable the global interrupt vector
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1126 :: 		}
L_end_Config_Interrupts:
	RET
; end of _Config_Interrupts

_Interrupt_INT1:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Loads_Controller_SLCM_V1.c,1129 :: 		void Interrupt_INT1 () iv IVT_ADDR_INT1
;Solar_Loads_Controller_SLCM_V1.c,1131 :: 		SREG_I_Bit=0; // disable interrupts
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1132 :: 		SetUpProgram();
	CALL       _SetUpProgram+0
;Solar_Loads_Controller_SLCM_V1.c,1133 :: 		SREG_I_Bit=1; // disable interrupts
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1134 :: 		INTF1_bit=1;     //clear  flag
	IN         R27, INTF1_bit+0
	SBR        R27, BitMask(INTF1_bit+0)
	OUT        INTF1_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1135 :: 		}
L_end_Interrupt_INT1:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Interrupt_INT1

_Interrupt_INT0_GridOFF:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Loads_Controller_SLCM_V1.c,1137 :: 		void Interrupt_INT0_GridOFF() iv IVT_ADDR_INT0
;Solar_Loads_Controller_SLCM_V1.c,1142 :: 		SREG_I_Bit=0; // disable interrupts
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1143 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Interrupt_INT0_GridOFF553
	LDS        R16, _Timer_isOn+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT0_GridOFF700
	JMP        L__Interrupt_INT0_GridOFF552
L__Interrupt_INT0_GridOFF700:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT0_GridOFF701
	JMP        L__Interrupt_INT0_GridOFF551
L__Interrupt_INT0_GridOFF701:
L__Interrupt_INT0_GridOFF550:
;Solar_Loads_Controller_SLCM_V1.c,1145 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1146 :: 		Relay_L_Solar=0;
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1143 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 )
L__Interrupt_INT0_GridOFF553:
L__Interrupt_INT0_GridOFF552:
L__Interrupt_INT0_GridOFF551:
;Solar_Loads_Controller_SLCM_V1.c,1148 :: 		SREG_I_Bit=1; // enable interrupts
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1149 :: 		INTF0_bit=1; // clear flag
	IN         R27, INTF0_bit+0
	SBR        R27, BitMask(INTF0_bit+0)
	OUT        INTF0_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1150 :: 		}
L_end_Interrupt_INT0_GridOFF:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Interrupt_INT0_GridOFF

_Timer_1_A_ReadBattery_Init:

;Solar_Loads_Controller_SLCM_V1.c,1153 :: 		void Timer_1_A_ReadBattery_Init()
;Solar_Loads_Controller_SLCM_V1.c,1155 :: 		SREG_I_bit=1 ;   // i already enabled interrupts in vl53l0x but just for make sure
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1156 :: 		WGM10_bit=0;
	IN         R27, WGM10_bit+0
	CBR        R27, BitMask(WGM10_bit+0)
	OUT        WGM10_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1157 :: 		WGM11_bit=0;
	IN         R27, WGM11_bit+0
	CBR        R27, BitMask(WGM11_bit+0)
	OUT        WGM11_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1158 :: 		WGM12_bit=1;
	IN         R27, WGM12_bit+0
	SBR        R27, BitMask(WGM12_bit+0)
	OUT        WGM12_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1159 :: 		WGM13_bit=0;    //mode 4 ctc mode OCR1A top
	IN         R27, WGM13_bit+0
	CBR        R27, BitMask(WGM13_bit+0)
	OUT        WGM13_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1160 :: 		CS12_bit=1;    //prescalr 1024
	IN         R27, CS12_bit+0
	SBR        R27, BitMask(CS12_bit+0)
	OUT        CS12_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1161 :: 		CS10_Bit=1;    //prescalr 1024
	IN         R27, CS10_bit+0
	SBR        R27, BitMask(CS10_bit+0)
	OUT        CS10_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1162 :: 		OCR1AH=0x1E;     //writing high bit first
	LDI        R27, 30
	OUT        OCR1AH+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1163 :: 		OCR1AL=0x84;     //writing high bit first
	LDI        R27, 132
	OUT        OCR1AL+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1164 :: 		OCIE1A_bit=1;    //Enable Interrupts CTC Mode
	IN         R27, OCIE1A_bit+0
	SBR        R27, BitMask(OCIE1A_bit+0)
	OUT        OCIE1A_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1165 :: 		OCF1A_Bit=1;    // clear interrupt flag
	IN         R27, OCF1A_bit+0
	SBR        R27, BitMask(OCF1A_bit+0)
	OUT        OCF1A_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1166 :: 		}
L_end_Timer_1_A_ReadBattery_Init:
	RET
; end of _Timer_1_A_ReadBattery_Init

_Timer_Interrupt_ReadBattery:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Loads_Controller_SLCM_V1.c,1167 :: 		void Timer_Interrupt_ReadBattery() iv IVT_ADDR_TIMER1_COMPA
;Solar_Loads_Controller_SLCM_V1.c,1169 :: 		Read_Battery();
	CALL       _Read_Battery+0
;Solar_Loads_Controller_SLCM_V1.c,1170 :: 		OCF1A_bit=1;               //clear flag
	IN         R27, OCF1A_bit+0
	SBR        R27, BitMask(OCF1A_bit+0)
	OUT        OCF1A_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1171 :: 		}
L_end_Timer_Interrupt_ReadBattery:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Timer_Interrupt_ReadBattery

_Stop_Timer_ReadBattery:

;Solar_Loads_Controller_SLCM_V1.c,1172 :: 		void Stop_Timer_ReadBattery()
;Solar_Loads_Controller_SLCM_V1.c,1174 :: 		CS10_Bit=0;
	IN         R27, CS10_bit+0
	CBR        R27, BitMask(CS10_bit+0)
	OUT        CS10_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1175 :: 		CS11_Bit=0;
	IN         R27, CS11_bit+0
	CBR        R27, BitMask(CS11_bit+0)
	OUT        CS11_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1176 :: 		CS12_Bit=0;
	IN         R27, CS12_bit+0
	CBR        R27, BitMask(CS12_bit+0)
	OUT        CS12_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1177 :: 		}
L_end_Stop_Timer_ReadBattery:
	RET
; end of _Stop_Timer_ReadBattery

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;Solar_Loads_Controller_SLCM_V1.c,1179 :: 		void main() {
;Solar_Loads_Controller_SLCM_V1.c,1180 :: 		Config();
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	CALL       _Config+0
;Solar_Loads_Controller_SLCM_V1.c,1181 :: 		EEPROM_Load(); // load params programs
	CALL       _EEPROM_Load+0
;Solar_Loads_Controller_SLCM_V1.c,1182 :: 		ADCBattery(); // adc configuartion for adc
	CALL       _ADCBattery+0
;Solar_Loads_Controller_SLCM_V1.c,1183 :: 		TWI_Config();
	CALL       _TWI_Config+0
;Solar_Loads_Controller_SLCM_V1.c,1184 :: 		Config_Interrupts();
	CALL       _Config_Interrupts+0
;Solar_Loads_Controller_SLCM_V1.c,1185 :: 		ReadBytesFromEEprom(0x04,(unsigned short *)&Mini_Battery_Voltage,4);       // Loads will cut of this voltgage
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_Mini_Battery_Voltage+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_Mini_Battery_Voltage+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _ReadBytesFromEEprom+0
;Solar_Loads_Controller_SLCM_V1.c,1186 :: 		ReadBytesFromEEprom(0x08,(unsigned short *)&StartLoadsVoltage,4);         //Loads will start based on this voltage
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_StartLoadsVoltage+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_StartLoadsVoltage+0)
	MOV        R5, R27
	LDI        R27, 8
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _ReadBytesFromEEprom+0
;Solar_Loads_Controller_SLCM_V1.c,1187 :: 		ReadBytesFromEEprom(0x12,(unsigned short *)&startupTIme_1,2);
	LDI        R27, 2
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_startupTIme_1+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_startupTIme_1+0)
	MOV        R5, R27
	LDI        R27, 18
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _ReadBytesFromEEprom+0
;Solar_Loads_Controller_SLCM_V1.c,1188 :: 		Timer_2_Init_Screen();  // this timer is for update screen
	CALL       _Timer_2_Init_Screen+0
;Solar_Loads_Controller_SLCM_V1.c,1189 :: 		Timer_1_A_ReadBattery_Init(); // timer for seconds
	CALL       _Timer_1_A_ReadBattery_Init+0
;Solar_Loads_Controller_SLCM_V1.c,1190 :: 		while(1)
L_main419:
;Solar_Loads_Controller_SLCM_V1.c,1192 :: 		CheckForSet();        // done in interrupt
	CALL       _CheckForSet+0
;Solar_Loads_Controller_SLCM_V1.c,1193 :: 		CheckForTimerActivationInRange();
	CALL       _CheckForTimerActivationInRange+0
;Solar_Loads_Controller_SLCM_V1.c,1194 :: 		AutoRunWithOutBatteryProtection(); // to auto select run with battery protection or not
	CALL       _AutoRunWithOutBatteryProtection+0
;Solar_Loads_Controller_SLCM_V1.c,1195 :: 		RunTimersNowCheck();
	CALL       _RunTimersNowCheck+0
;Solar_Loads_Controller_SLCM_V1.c,1196 :: 		Screen_1();       // for reading time
	CALL       _Screen_1+0
;Solar_Loads_Controller_SLCM_V1.c,1197 :: 		Check_Timers();
	CALL       _Check_Timers+0
;Solar_Loads_Controller_SLCM_V1.c,1198 :: 		TurnLoadsOffWhenGridOff();       // sometine when grid comes fast and cut it will not make interrupt so this second check for loads off
	CALL       _TurnLoadsOffWhenGridOff+0
;Solar_Loads_Controller_SLCM_V1.c,1199 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_main421:
	DEC        R16
	BRNE       L_main421
	DEC        R17
	BRNE       L_main421
	DEC        R18
	BRNE       L_main421
	NOP
;Solar_Loads_Controller_SLCM_V1.c,1205 :: 		}
	JMP        L_main419
;Solar_Loads_Controller_SLCM_V1.c,1206 :: 		}
L_end_main:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
