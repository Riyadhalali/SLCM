
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
	BRLO       L__StoreBytesIntoEEprom547
	JMP        L_StoreBytesIntoEEprom1
L__StoreBytesIntoEEprom547:
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
	BRLO       L__ReadBytesFromEEprom549
	JMP        L_ReadBytesFromEEprom6
L__ReadBytesFromEEprom549:
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
	BREQ       L__Check_Timers551
	JMP        L_Check_Timers10
L__Check_Timers551:
;Solar_Loads_Controller_SLCM_V1.c,212 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,213 :: 		TurnOffLoadsByPass=0;
	LDI        R27, 0
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Loads_Controller_SLCM_V1.c,215 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && RunOnBatteryVoltageWithoutTimer_Flag==0)
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers433
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers552
	JMP        L__Check_Timers432
L__Check_Timers552:
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
	BREQ       L__Check_Timers553
	LDI        R16, 1
L__Check_Timers553:
	TST        R16
	BRNE       L__Check_Timers554
	JMP        L__Check_Timers431
L__Check_Timers554:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers555
	JMP        L__Check_Timers430
L__Check_Timers555:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers556
	JMP        L__Check_Timers429
L__Check_Timers556:
L__Check_Timers428:
;Solar_Loads_Controller_SLCM_V1.c,217 :: 		Relay_L_Solar=1;
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,215 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && RunOnBatteryVoltageWithoutTimer_Flag==0)
L__Check_Timers433:
L__Check_Timers432:
L__Check_Timers431:
L__Check_Timers430:
L__Check_Timers429:
;Solar_Loads_Controller_SLCM_V1.c,221 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true && RunOnBatteryVoltageWithoutTimer_Flag==0 )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers437
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers557
	JMP        L__Check_Timers436
L__Check_Timers557:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers558
	JMP        L__Check_Timers435
L__Check_Timers558:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers559
	JMP        L__Check_Timers434
L__Check_Timers559:
L__Check_Timers427:
;Solar_Loads_Controller_SLCM_V1.c,223 :: 		Relay_L_Solar=1;
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,221 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true && RunOnBatteryVoltageWithoutTimer_Flag==0 )
L__Check_Timers437:
L__Check_Timers436:
L__Check_Timers435:
L__Check_Timers434:
;Solar_Loads_Controller_SLCM_V1.c,225 :: 		} // end if ac_available
L_Check_Timers10:
;Solar_Loads_Controller_SLCM_V1.c,228 :: 		if (matched_timer_1_stop==1)
	LDS        R16, _matched_timer_1_stop+0
	CPI        R16, 1
	BREQ       L__Check_Timers560
	JMP        L_Check_Timers17
L__Check_Timers560:
;Solar_Loads_Controller_SLCM_V1.c,230 :: 		Timer_isOn=0;        // to continue the timer after breakout the timer when grid is available
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,233 :: 		if (AC_Available==1 && Timer_Enable==1  &&  RunWithOutBattery==false  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers441
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers561
	JMP        L__Check_Timers440
L__Check_Timers561:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers562
	JMP        L__Check_Timers439
L__Check_Timers562:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers563
	JMP        L__Check_Timers438
L__Check_Timers563:
L__Check_Timers426:
;Solar_Loads_Controller_SLCM_V1.c,236 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,237 :: 		Relay_L_Solar=0; // relay off
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,233 :: 		if (AC_Available==1 && Timer_Enable==1  &&  RunWithOutBattery==false  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
L__Check_Timers441:
L__Check_Timers440:
L__Check_Timers439:
L__Check_Timers438:
;Solar_Loads_Controller_SLCM_V1.c,239 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers445
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers564
	JMP        L__Check_Timers444
L__Check_Timers564:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers565
	JMP        L__Check_Timers443
L__Check_Timers565:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers566
	JMP        L__Check_Timers442
L__Check_Timers566:
L__Check_Timers425:
;Solar_Loads_Controller_SLCM_V1.c,242 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,243 :: 		Relay_L_Solar=0; // relay off
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,239 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
L__Check_Timers445:
L__Check_Timers444:
L__Check_Timers443:
L__Check_Timers442:
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
	BRSH       L__Check_Timers567
	JMP        L__Check_Timers447
L__Check_Timers567:
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L__Check_Timers446
L__Check_Timers424:
;Solar_Loads_Controller_SLCM_V1.c,270 :: 		Relay_L_Solar=1;
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,268 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
L__Check_Timers447:
L__Check_Timers446:
;Solar_Loads_Controller_SLCM_V1.c,272 :: 		} // end function of voltage protector
L_Check_Timers24:
;Solar_Loads_Controller_SLCM_V1.c,278 :: 		if (AC_Available==1 && Timer_isOn==1 && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0)
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers453
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers568
	JMP        L__Check_Timers452
L__Check_Timers568:
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
	BREQ       L__Check_Timers569
	LDI        R16, 1
L__Check_Timers569:
	TST        R16
	BRNE       L__Check_Timers570
	JMP        L__Check_Timers451
L__Check_Timers570:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers571
	JMP        L__Check_Timers450
L__Check_Timers571:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers572
	JMP        L__Check_Timers449
L__Check_Timers572:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers573
	JMP        L__Check_Timers448
L__Check_Timers573:
L__Check_Timers423:
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
	BRLO       L__Check_Timers574
	JMP        L_Check_Timers35
L__Check_Timers574:
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
L_Check_Timers35:
;Solar_Loads_Controller_SLCM_V1.c,278 :: 		if (AC_Available==1 && Timer_isOn==1 && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0)
L__Check_Timers453:
L__Check_Timers452:
L__Check_Timers451:
L__Check_Timers450:
L__Check_Timers449:
L__Check_Timers448:
;Solar_Loads_Controller_SLCM_V1.c,286 :: 		if (AC_Available==1 && Timer_isOn==1  && RunWithOutBattery==true && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0 )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers458
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers575
	JMP        L__Check_Timers457
L__Check_Timers575:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers576
	JMP        L__Check_Timers456
L__Check_Timers576:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers577
	JMP        L__Check_Timers455
L__Check_Timers577:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers578
	JMP        L__Check_Timers454
L__Check_Timers578:
L__Check_Timers422:
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
	BRLO       L__Check_Timers579
	JMP        L_Check_Timers41
L__Check_Timers579:
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
L_Check_Timers41:
;Solar_Loads_Controller_SLCM_V1.c,286 :: 		if (AC_Available==1 && Timer_isOn==1  && RunWithOutBattery==true && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0 )
L__Check_Timers458:
L__Check_Timers457:
L__Check_Timers456:
L__Check_Timers455:
L__Check_Timers454:
;Solar_Loads_Controller_SLCM_V1.c,295 :: 		if (AC_Available==1  && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==1)
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers463
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
	BREQ       L__Check_Timers580
	LDI        R16, 1
L__Check_Timers580:
	TST        R16
	BRNE       L__Check_Timers581
	JMP        L__Check_Timers462
L__Check_Timers581:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers582
	JMP        L__Check_Timers461
L__Check_Timers582:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers583
	JMP        L__Check_Timers460
L__Check_Timers583:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 1
	BREQ       L__Check_Timers584
	JMP        L__Check_Timers459
L__Check_Timers584:
L__Check_Timers421:
;Solar_Loads_Controller_SLCM_V1.c,298 :: 		SecondsRealTimePv_ReConnect_T1++;
	LDS        R16, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T1+0, R16
	STS        _SecondsRealTimePv_ReConnect_T1+1, R17
;Solar_Loads_Controller_SLCM_V1.c,299 :: 		Delay_ms(200);
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
;Solar_Loads_Controller_SLCM_V1.c,300 :: 		if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1)     Relay_L_Solar=1;
	LDS        R18, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T1+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers585
	JMP        L_Check_Timers47
L__Check_Timers585:
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
L_Check_Timers47:
;Solar_Loads_Controller_SLCM_V1.c,295 :: 		if (AC_Available==1  && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==1)
L__Check_Timers463:
L__Check_Timers462:
L__Check_Timers461:
L__Check_Timers460:
L__Check_Timers459:
;Solar_Loads_Controller_SLCM_V1.c,305 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1 && Timer_isOn==1 && RunWithOutBattery==false)
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
	BREQ       L__Check_Timers586
	LDI        R16, 1
L__Check_Timers586:
	TST        R16
	BRNE       L__Check_Timers587
	JMP        L__Check_Timers467
L__Check_Timers587:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers466
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers588
	JMP        L__Check_Timers465
L__Check_Timers588:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers589
	JMP        L__Check_Timers464
L__Check_Timers589:
L__Check_Timers420:
;Solar_Loads_Controller_SLCM_V1.c,307 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,308 :: 		Start_Timer_0_A();         // give some time for battery voltage
	CALL       _Start_Timer_0_A+0
;Solar_Loads_Controller_SLCM_V1.c,305 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1 && Timer_isOn==1 && RunWithOutBattery==false)
L__Check_Timers467:
L__Check_Timers466:
L__Check_Timers465:
L__Check_Timers464:
;Solar_Loads_Controller_SLCM_V1.c,310 :: 		}// end of check timers
L_end_Check_Timers:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _Check_Timers

_SetUpProgram:

;Solar_Loads_Controller_SLCM_V1.c,315 :: 		void SetUpProgram()
;Solar_Loads_Controller_SLCM_V1.c,317 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram51:
	DEC        R16
	BRNE       L_SetUpProgram51
	DEC        R17
	BRNE       L_SetUpProgram51
	DEC        R18
	BRNE       L_SetUpProgram51
	NOP
;Solar_Loads_Controller_SLCM_V1.c,322 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram53:
	DEC        R16
	BRNE       L_SetUpProgram53
	DEC        R17
	BRNE       L_SetUpProgram53
	DEC        R18
	BRNE       L_SetUpProgram53
	NOP
;Solar_Loads_Controller_SLCM_V1.c,326 :: 		while (Set==0)
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetUpProgram56
;Solar_Loads_Controller_SLCM_V1.c,330 :: 		SetTimerOn_1();
	CALL       _SetTimerOn_1+0
;Solar_Loads_Controller_SLCM_V1.c,331 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram57:
	DEC        R16
	BRNE       L_SetUpProgram57
	DEC        R17
	BRNE       L_SetUpProgram57
	DEC        R18
	BRNE       L_SetUpProgram57
	NOP
;Solar_Loads_Controller_SLCM_V1.c,332 :: 		SetTimerOff_1();
	CALL       _SetTimerOff_1+0
;Solar_Loads_Controller_SLCM_V1.c,333 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram59:
	DEC        R16
	BRNE       L_SetUpProgram59
	DEC        R17
	BRNE       L_SetUpProgram59
	DEC        R18
	BRNE       L_SetUpProgram59
	NOP
;Solar_Loads_Controller_SLCM_V1.c,334 :: 		SetLowBatteryVoltage();// program 3 to set low battery voltage
	CALL       _SetLowBatteryVoltage+0
;Solar_Loads_Controller_SLCM_V1.c,335 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram61:
	DEC        R16
	BRNE       L_SetUpProgram61
	DEC        R17
	BRNE       L_SetUpProgram61
	DEC        R18
	BRNE       L_SetUpProgram61
	NOP
;Solar_Loads_Controller_SLCM_V1.c,336 :: 		SetStartUpLoadsVoltage(); // program 4 to enable timer or disable
	CALL       _SetStartUpLoadsVoltage+0
;Solar_Loads_Controller_SLCM_V1.c,337 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram63:
	DEC        R16
	BRNE       L_SetUpProgram63
	DEC        R17
	BRNE       L_SetUpProgram63
	DEC        R18
	BRNE       L_SetUpProgram63
	NOP
;Solar_Loads_Controller_SLCM_V1.c,338 :: 		Startup_Timers();
	CALL       _Startup_Timers+0
;Solar_Loads_Controller_SLCM_V1.c,339 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram65:
	DEC        R16
	BRNE       L_SetUpProgram65
	DEC        R17
	BRNE       L_SetUpProgram65
	DEC        R18
	BRNE       L_SetUpProgram65
	NOP
;Solar_Loads_Controller_SLCM_V1.c,340 :: 		RunOnBatteryVoltageWithoutTimer();
	CALL       _RunOnBatteryVoltageWithoutTimer+0
;Solar_Loads_Controller_SLCM_V1.c,341 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram67:
	DEC        R16
	BRNE       L_SetUpProgram67
	DEC        R17
	BRNE       L_SetUpProgram67
	DEC        R18
	BRNE       L_SetUpProgram67
	NOP
;Solar_Loads_Controller_SLCM_V1.c,342 :: 		SetDS1307_Time();   // program 6
	CALL       _SetDS1307_Time+0
;Solar_Loads_Controller_SLCM_V1.c,343 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram69:
	DEC        R16
	BRNE       L_SetUpProgram69
	DEC        R17
	BRNE       L_SetUpProgram69
	DEC        R18
	BRNE       L_SetUpProgram69
	NOP
;Solar_Loads_Controller_SLCM_V1.c,346 :: 		} // end while
L_SetUpProgram56:
;Solar_Loads_Controller_SLCM_V1.c,347 :: 		}
L_end_SetUpProgram:
	RET
; end of _SetUpProgram

_SetTimerOn_1:

;Solar_Loads_Controller_SLCM_V1.c,349 :: 		void SetTimerOn_1()
;Solar_Loads_Controller_SLCM_V1.c,351 :: 		Delay_ms(500);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOn_171:
	DEC        R16
	BRNE       L_SetTimerOn_171
	DEC        R17
	BRNE       L_SetTimerOn_171
	DEC        R18
	BRNE       L_SetTimerOn_171
	NOP
;Solar_Loads_Controller_SLCM_V1.c,352 :: 		while(Set==0)
L_SetTimerOn_173:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetTimerOn_174
;Solar_Loads_Controller_SLCM_V1.c,354 :: 		Display_On_7Segment_Character(0x92,0x92,0xC7);
	LDI        R27, 199
	MOV        R4, R27
	LDI        R27, 146
	MOV        R3, R27
	LDI        R27, 146
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,355 :: 		}
	JMP        L_SetTimerOn_173
L_SetTimerOn_174:
;Solar_Loads_Controller_SLCM_V1.c,356 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOn_175:
	DEC        R16
	BRNE       L_SetTimerOn_175
	DEC        R17
	BRNE       L_SetTimerOn_175
	DEC        R18
	BRNE       L_SetTimerOn_175
	NOP
;Solar_Loads_Controller_SLCM_V1.c,357 :: 		while (Set==0)
L_SetTimerOn_177:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetTimerOn_178
;Solar_Loads_Controller_SLCM_V1.c,359 :: 		Display_On_7Segment(hours_lcd_1);
	LDS        R2, _hours_lcd_1+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,361 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_179:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetTimerOn_1471
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetTimerOn_1470
	JMP        L_SetTimerOn_180
L__SetTimerOn_1471:
L__SetTimerOn_1470:
;Solar_Loads_Controller_SLCM_V1.c,363 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetTimerOn_183
;Solar_Loads_Controller_SLCM_V1.c,365 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_184:
	DEC        R16
	BRNE       L_SetTimerOn_184
	DEC        R17
	BRNE       L_SetTimerOn_184
	DEC        R18
	BRNE       L_SetTimerOn_184
;Solar_Loads_Controller_SLCM_V1.c,366 :: 		hours_lcd_1++;
	LDS        R16, _hours_lcd_1+0
	SUBI       R16, 255
	STS        _hours_lcd_1+0, R16
;Solar_Loads_Controller_SLCM_V1.c,367 :: 		}
L_SetTimerOn_183:
;Solar_Loads_Controller_SLCM_V1.c,368 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetTimerOn_186
;Solar_Loads_Controller_SLCM_V1.c,370 :: 		delay_ms(ButtonDelay);
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
;Solar_Loads_Controller_SLCM_V1.c,371 :: 		hours_lcd_1--;
	LDS        R16, _hours_lcd_1+0
	SUBI       R16, 1
	STS        _hours_lcd_1+0, R16
;Solar_Loads_Controller_SLCM_V1.c,372 :: 		}
L_SetTimerOn_186:
;Solar_Loads_Controller_SLCM_V1.c,374 :: 		if  (hours_lcd_1>23) hours_lcd_1=0;
	LDS        R17, _hours_lcd_1+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOn_1592
	JMP        L_SetTimerOn_189
L__SetTimerOn_1592:
	LDI        R27, 0
	STS        _hours_lcd_1+0, R27
L_SetTimerOn_189:
;Solar_Loads_Controller_SLCM_V1.c,375 :: 		if  (hours_lcd_1<0) hours_lcd_1=0;
	LDS        R16, _hours_lcd_1+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_1593
	JMP        L_SetTimerOn_190
L__SetTimerOn_1593:
	LDI        R27, 0
	STS        _hours_lcd_1+0, R27
L_SetTimerOn_190:
;Solar_Loads_Controller_SLCM_V1.c,376 :: 		Timer_isOn=0; //
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,377 :: 		SecondsRealTimePv_ReConnect_T1=0;    //
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,378 :: 		} // end while increment
	JMP        L_SetTimerOn_179
L_SetTimerOn_180:
;Solar_Loads_Controller_SLCM_V1.c,379 :: 		} // end first while
	JMP        L_SetTimerOn_177
L_SetTimerOn_178:
;Solar_Loads_Controller_SLCM_V1.c,382 :: 		EEPROM_Write(0x00,hours_lcd_1); // save hours 1 timer tp eeprom
	LDS        R4, _hours_lcd_1+0
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,383 :: 		Delay_ms(500);     //read time for state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOn_191:
	DEC        R16
	BRNE       L_SetTimerOn_191
	DEC        R17
	BRNE       L_SetTimerOn_191
	DEC        R18
	BRNE       L_SetTimerOn_191
	NOP
;Solar_Loads_Controller_SLCM_V1.c,384 :: 		while (Set==0)
L_SetTimerOn_193:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetTimerOn_194
;Solar_Loads_Controller_SLCM_V1.c,386 :: 		Display_On_7Segment(minutes_lcd_1);
	LDS        R2, _minutes_lcd_1+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,388 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_195:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetTimerOn_1473
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetTimerOn_1472
	JMP        L_SetTimerOn_196
L__SetTimerOn_1473:
L__SetTimerOn_1472:
;Solar_Loads_Controller_SLCM_V1.c,390 :: 		if (Increment==1  )
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetTimerOn_199
;Solar_Loads_Controller_SLCM_V1.c,392 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOn_1100:
	DEC        R16
	BRNE       L_SetTimerOn_1100
	DEC        R17
	BRNE       L_SetTimerOn_1100
	DEC        R18
	BRNE       L_SetTimerOn_1100
;Solar_Loads_Controller_SLCM_V1.c,393 :: 		minutes_lcd_1++;
	LDS        R16, _minutes_lcd_1+0
	SUBI       R16, 255
	STS        _minutes_lcd_1+0, R16
;Solar_Loads_Controller_SLCM_V1.c,394 :: 		}
L_SetTimerOn_199:
;Solar_Loads_Controller_SLCM_V1.c,395 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetTimerOn_1102
;Solar_Loads_Controller_SLCM_V1.c,397 :: 		delay_ms(ButtonDelay);
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
;Solar_Loads_Controller_SLCM_V1.c,398 :: 		minutes_lcd_1--;
	LDS        R16, _minutes_lcd_1+0
	SUBI       R16, 1
	STS        _minutes_lcd_1+0, R16
;Solar_Loads_Controller_SLCM_V1.c,399 :: 		}
L_SetTimerOn_1102:
;Solar_Loads_Controller_SLCM_V1.c,401 :: 		if (minutes_lcd_1>59)    minutes_lcd_1=0;
	LDS        R17, _minutes_lcd_1+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOn_1594
	JMP        L_SetTimerOn_1105
L__SetTimerOn_1594:
	LDI        R27, 0
	STS        _minutes_lcd_1+0, R27
L_SetTimerOn_1105:
;Solar_Loads_Controller_SLCM_V1.c,402 :: 		if (minutes_lcd_1<0) minutes_lcd_1=0;
	LDS        R16, _minutes_lcd_1+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_1595
	JMP        L_SetTimerOn_1106
L__SetTimerOn_1595:
	LDI        R27, 0
	STS        _minutes_lcd_1+0, R27
L_SetTimerOn_1106:
;Solar_Loads_Controller_SLCM_V1.c,403 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,404 :: 		Timer_isOn=0;
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,405 :: 		} // end while increment and decrement
	JMP        L_SetTimerOn_195
L_SetTimerOn_196:
;Solar_Loads_Controller_SLCM_V1.c,406 :: 		} // end first while
	JMP        L_SetTimerOn_193
L_SetTimerOn_194:
;Solar_Loads_Controller_SLCM_V1.c,408 :: 		EEPROM_Write(0x01,minutes_lcd_1); // save minutes 1 timer tp eeprom
	LDS        R4, _minutes_lcd_1+0
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,409 :: 		}
L_end_SetTimerOn_1:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOn_1

_SetTimerOff_1:

;Solar_Loads_Controller_SLCM_V1.c,411 :: 		void SetTimerOff_1()
;Solar_Loads_Controller_SLCM_V1.c,413 :: 		Delay_ms(500);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_1107:
	DEC        R16
	BRNE       L_SetTimerOff_1107
	DEC        R17
	BRNE       L_SetTimerOff_1107
	DEC        R18
	BRNE       L_SetTimerOff_1107
	NOP
;Solar_Loads_Controller_SLCM_V1.c,414 :: 		while(Set==0)
L_SetTimerOff_1109:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetTimerOff_1110
;Solar_Loads_Controller_SLCM_V1.c,416 :: 		Display_On_7Segment_Character(0x92,0xC0,0xC7);
	LDI        R27, 199
	MOV        R4, R27
	LDI        R27, 192
	MOV        R3, R27
	LDI        R27, 146
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,417 :: 		}
	JMP        L_SetTimerOff_1109
L_SetTimerOff_1110:
;Solar_Loads_Controller_SLCM_V1.c,418 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_1111:
	DEC        R16
	BRNE       L_SetTimerOff_1111
	DEC        R17
	BRNE       L_SetTimerOff_1111
	DEC        R18
	BRNE       L_SetTimerOff_1111
	NOP
;Solar_Loads_Controller_SLCM_V1.c,420 :: 		while (Set==0)
L_SetTimerOff_1113:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetTimerOff_1114
;Solar_Loads_Controller_SLCM_V1.c,422 :: 		Display_On_7Segment(hours_lcd_2);
	LDS        R2, _hours_lcd_2+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,424 :: 		while(Increment== 1 || Decrement==1)
L_SetTimerOff_1115:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetTimerOff_1477
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetTimerOff_1476
	JMP        L_SetTimerOff_1116
L__SetTimerOff_1477:
L__SetTimerOff_1476:
;Solar_Loads_Controller_SLCM_V1.c,426 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetTimerOff_1119
;Solar_Loads_Controller_SLCM_V1.c,428 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOff_1120:
	DEC        R16
	BRNE       L_SetTimerOff_1120
	DEC        R17
	BRNE       L_SetTimerOff_1120
	DEC        R18
	BRNE       L_SetTimerOff_1120
;Solar_Loads_Controller_SLCM_V1.c,429 :: 		hours_lcd_2++;
	LDS        R16, _hours_lcd_2+0
	SUBI       R16, 255
	STS        _hours_lcd_2+0, R16
;Solar_Loads_Controller_SLCM_V1.c,430 :: 		}
L_SetTimerOff_1119:
;Solar_Loads_Controller_SLCM_V1.c,431 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetTimerOff_1122
;Solar_Loads_Controller_SLCM_V1.c,433 :: 		delay_ms(ButtonDelay);
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
;Solar_Loads_Controller_SLCM_V1.c,434 :: 		hours_lcd_2--;
	LDS        R16, _hours_lcd_2+0
	SUBI       R16, 1
	STS        _hours_lcd_2+0, R16
;Solar_Loads_Controller_SLCM_V1.c,435 :: 		}
L_SetTimerOff_1122:
;Solar_Loads_Controller_SLCM_V1.c,436 :: 		if(hours_lcd_2>23) hours_lcd_2=0;
	LDS        R17, _hours_lcd_2+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOff_1597
	JMP        L_SetTimerOff_1125
L__SetTimerOff_1597:
	LDI        R27, 0
	STS        _hours_lcd_2+0, R27
L_SetTimerOff_1125:
;Solar_Loads_Controller_SLCM_V1.c,437 :: 		if (hours_lcd_2<0 ) hours_lcd_2=0;
	LDS        R16, _hours_lcd_2+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_1598
	JMP        L_SetTimerOff_1126
L__SetTimerOff_1598:
	LDI        R27, 0
	STS        _hours_lcd_2+0, R27
L_SetTimerOff_1126:
;Solar_Loads_Controller_SLCM_V1.c,438 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,439 :: 		Timer_isOn=0;
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,440 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_1115
L_SetTimerOff_1116:
;Solar_Loads_Controller_SLCM_V1.c,441 :: 		} // end first while
	JMP        L_SetTimerOff_1113
L_SetTimerOff_1114:
;Solar_Loads_Controller_SLCM_V1.c,443 :: 		EEPROM_Write(0x02,hours_lcd_2); // save hours off  timer_1 to eeprom
	LDS        R4, _hours_lcd_2+0
	LDI        R27, 2
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,444 :: 		Delay_ms(500); // read button state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_1127:
	DEC        R16
	BRNE       L_SetTimerOff_1127
	DEC        R17
	BRNE       L_SetTimerOff_1127
	DEC        R18
	BRNE       L_SetTimerOff_1127
	NOP
;Solar_Loads_Controller_SLCM_V1.c,445 :: 		while (Set==0)
L_SetTimerOff_1129:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetTimerOff_1130
;Solar_Loads_Controller_SLCM_V1.c,447 :: 		Display_On_7Segment(minutes_lcd_2);
	LDS        R2, _minutes_lcd_2+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,449 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOff_1131:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetTimerOff_1479
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetTimerOff_1478
	JMP        L_SetTimerOff_1132
L__SetTimerOff_1479:
L__SetTimerOff_1478:
;Solar_Loads_Controller_SLCM_V1.c,451 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetTimerOff_1135
;Solar_Loads_Controller_SLCM_V1.c,453 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetTimerOff_1136:
	DEC        R16
	BRNE       L_SetTimerOff_1136
	DEC        R17
	BRNE       L_SetTimerOff_1136
	DEC        R18
	BRNE       L_SetTimerOff_1136
;Solar_Loads_Controller_SLCM_V1.c,454 :: 		minutes_lcd_2++;
	LDS        R16, _minutes_lcd_2+0
	SUBI       R16, 255
	STS        _minutes_lcd_2+0, R16
;Solar_Loads_Controller_SLCM_V1.c,455 :: 		}
L_SetTimerOff_1135:
;Solar_Loads_Controller_SLCM_V1.c,456 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetTimerOff_1138
;Solar_Loads_Controller_SLCM_V1.c,458 :: 		delay_ms(ButtonDelay);
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
;Solar_Loads_Controller_SLCM_V1.c,459 :: 		minutes_lcd_2--;
	LDS        R16, _minutes_lcd_2+0
	SUBI       R16, 1
	STS        _minutes_lcd_2+0, R16
;Solar_Loads_Controller_SLCM_V1.c,460 :: 		}
L_SetTimerOff_1138:
;Solar_Loads_Controller_SLCM_V1.c,462 :: 		if(minutes_lcd_2>59) minutes_lcd_2=0;
	LDS        R17, _minutes_lcd_2+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOff_1599
	JMP        L_SetTimerOff_1141
L__SetTimerOff_1599:
	LDI        R27, 0
	STS        _minutes_lcd_2+0, R27
L_SetTimerOff_1141:
;Solar_Loads_Controller_SLCM_V1.c,463 :: 		if (minutes_lcd_2<0) minutes_lcd_2=0;
	LDS        R16, _minutes_lcd_2+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_1600
	JMP        L_SetTimerOff_1142
L__SetTimerOff_1600:
	LDI        R27, 0
	STS        _minutes_lcd_2+0, R27
L_SetTimerOff_1142:
;Solar_Loads_Controller_SLCM_V1.c,464 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,465 :: 		Timer_isOn=0;
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,466 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_1131
L_SetTimerOff_1132:
;Solar_Loads_Controller_SLCM_V1.c,467 :: 		} // end first while
	JMP        L_SetTimerOff_1129
L_SetTimerOff_1130:
;Solar_Loads_Controller_SLCM_V1.c,470 :: 		EEPROM_Write(0x03,minutes_lcd_2); // save minutes off timer_1 to eeprom
	LDS        R4, _minutes_lcd_2+0
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,471 :: 		}
L_end_SetTimerOff_1:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOff_1

_SetLowBatteryVoltage:

;Solar_Loads_Controller_SLCM_V1.c,473 :: 		void SetLowBatteryVoltage()
;Solar_Loads_Controller_SLCM_V1.c,475 :: 		while(Set==0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
L_SetLowBatteryVoltage143:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetLowBatteryVoltage144
;Solar_Loads_Controller_SLCM_V1.c,477 :: 		Display_On_7Segment_Character(0xC6,0xE3,0xC1);
	LDI        R27, 193
	MOV        R4, R27
	LDI        R27, 227
	MOV        R3, R27
	LDI        R27, 198
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,478 :: 		}
	JMP        L_SetLowBatteryVoltage143
L_SetLowBatteryVoltage144:
;Solar_Loads_Controller_SLCM_V1.c,479 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetLowBatteryVoltage145:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage145
	DEC        R17
	BRNE       L_SetLowBatteryVoltage145
	DEC        R18
	BRNE       L_SetLowBatteryVoltage145
	NOP
;Solar_Loads_Controller_SLCM_V1.c,480 :: 		while(Set==0)
L_SetLowBatteryVoltage147:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetLowBatteryVoltage148
;Solar_Loads_Controller_SLCM_V1.c,482 :: 		Display_On_7Segment_Float(Mini_Battery_Voltage);  // to indicate program 2
	LDS        R2, _Mini_Battery_Voltage+0
	LDS        R3, _Mini_Battery_Voltage+1
	LDS        R4, _Mini_Battery_Voltage+2
	LDS        R5, _Mini_Battery_Voltage+3
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,483 :: 		while (Increment==1 || Decrement==1)
L_SetLowBatteryVoltage149:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetLowBatteryVoltage482
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetLowBatteryVoltage481
	JMP        L_SetLowBatteryVoltage150
L__SetLowBatteryVoltage482:
L__SetLowBatteryVoltage481:
;Solar_Loads_Controller_SLCM_V1.c,485 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetLowBatteryVoltage153
;Solar_Loads_Controller_SLCM_V1.c,487 :: 		Display_On_7Segment_Float(Mini_Battery_Voltage);  // to indicate program 2
	LDS        R2, _Mini_Battery_Voltage+0
	LDS        R3, _Mini_Battery_Voltage+1
	LDS        R4, _Mini_Battery_Voltage+2
	LDS        R5, _Mini_Battery_Voltage+3
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,488 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetLowBatteryVoltage154:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage154
	DEC        R17
	BRNE       L_SetLowBatteryVoltage154
	DEC        R18
	BRNE       L_SetLowBatteryVoltage154
;Solar_Loads_Controller_SLCM_V1.c,489 :: 		Mini_Battery_Voltage+=0.1;
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
;Solar_Loads_Controller_SLCM_V1.c,491 :: 		}
L_SetLowBatteryVoltage153:
;Solar_Loads_Controller_SLCM_V1.c,492 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
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
;Solar_Loads_Controller_SLCM_V1.c,496 :: 		Mini_Battery_Voltage-=0.1;
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
;Solar_Loads_Controller_SLCM_V1.c,497 :: 		}
L_SetLowBatteryVoltage156:
;Solar_Loads_Controller_SLCM_V1.c,498 :: 		if (Mini_Battery_Voltage>65) Mini_Battery_Voltage=0;
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
	BREQ       L__SetLowBatteryVoltage602
	LDI        R16, 1
L__SetLowBatteryVoltage602:
	TST        R16
	BRNE       L__SetLowBatteryVoltage603
	JMP        L_SetLowBatteryVoltage159
L__SetLowBatteryVoltage603:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	STS        _Mini_Battery_Voltage+2, R27
	STS        _Mini_Battery_Voltage+3, R27
L_SetLowBatteryVoltage159:
;Solar_Loads_Controller_SLCM_V1.c,499 :: 		if (Mini_Battery_Voltage<0) Mini_Battery_Voltage=0;
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
	BREQ       L__SetLowBatteryVoltage604
	LDI        R16, 1
L__SetLowBatteryVoltage604:
	TST        R16
	BRNE       L__SetLowBatteryVoltage605
	JMP        L_SetLowBatteryVoltage160
L__SetLowBatteryVoltage605:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	STS        _Mini_Battery_Voltage+2, R27
	STS        _Mini_Battery_Voltage+3, R27
L_SetLowBatteryVoltage160:
;Solar_Loads_Controller_SLCM_V1.c,500 :: 		} //end wile increment and decrement
	JMP        L_SetLowBatteryVoltage149
L_SetLowBatteryVoltage150:
;Solar_Loads_Controller_SLCM_V1.c,501 :: 		}// end first while set
	JMP        L_SetLowBatteryVoltage147
L_SetLowBatteryVoltage148:
;Solar_Loads_Controller_SLCM_V1.c,502 :: 		StoreBytesIntoEEprom(0x04,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
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
;Solar_Loads_Controller_SLCM_V1.c,503 :: 		}
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

;Solar_Loads_Controller_SLCM_V1.c,506 :: 		void SetStartUpLoadsVoltage()
;Solar_Loads_Controller_SLCM_V1.c,508 :: 		while(Set==0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
L_SetStartUpLoadsVoltage161:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetStartUpLoadsVoltage162
;Solar_Loads_Controller_SLCM_V1.c,510 :: 		Display_On_7Segment_Character(0x92,0x83,0x9D);
	LDI        R27, 157
	MOV        R4, R27
	LDI        R27, 131
	MOV        R3, R27
	LDI        R27, 146
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,511 :: 		}
	JMP        L_SetStartUpLoadsVoltage161
L_SetStartUpLoadsVoltage162:
;Solar_Loads_Controller_SLCM_V1.c,512 :: 		Delay_ms(500);;
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetStartUpLoadsVoltage163:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage163
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage163
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage163
	NOP
;Solar_Loads_Controller_SLCM_V1.c,513 :: 		while(Set==0)
L_SetStartUpLoadsVoltage165:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetStartUpLoadsVoltage166
;Solar_Loads_Controller_SLCM_V1.c,515 :: 		Display_On_7Segment_Float(StartLoadsVoltage);
	LDS        R2, _StartLoadsVoltage+0
	LDS        R3, _StartLoadsVoltage+1
	LDS        R4, _StartLoadsVoltage+2
	LDS        R5, _StartLoadsVoltage+3
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,516 :: 		while (Increment==1 || Decrement==1)
L_SetStartUpLoadsVoltage167:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetStartUpLoadsVoltage485
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetStartUpLoadsVoltage484
	JMP        L_SetStartUpLoadsVoltage168
L__SetStartUpLoadsVoltage485:
L__SetStartUpLoadsVoltage484:
;Solar_Loads_Controller_SLCM_V1.c,518 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetStartUpLoadsVoltage171
;Solar_Loads_Controller_SLCM_V1.c,520 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetStartUpLoadsVoltage172:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage172
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage172
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage172
;Solar_Loads_Controller_SLCM_V1.c,521 :: 		StartLoadsVoltage+=0.1;
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
;Solar_Loads_Controller_SLCM_V1.c,522 :: 		Display_On_7Segment_Float(StartLoadsVoltage);
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,523 :: 		}
L_SetStartUpLoadsVoltage171:
;Solar_Loads_Controller_SLCM_V1.c,524 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetStartUpLoadsVoltage174
;Solar_Loads_Controller_SLCM_V1.c,526 :: 		Delay_ms(ButtonDelay);
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
;Solar_Loads_Controller_SLCM_V1.c,527 :: 		StartLoadsVoltage-=0.1;
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
;Solar_Loads_Controller_SLCM_V1.c,528 :: 		Display_On_7Segment_Float(StartLoadsVoltage);
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,529 :: 		}
L_SetStartUpLoadsVoltage174:
;Solar_Loads_Controller_SLCM_V1.c,530 :: 		if (StartLoadsVoltage>65) StartLoadsVoltage=0;
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
	BREQ       L__SetStartUpLoadsVoltage607
	LDI        R16, 1
L__SetStartUpLoadsVoltage607:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage608
	JMP        L_SetStartUpLoadsVoltage177
L__SetStartUpLoadsVoltage608:
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	STS        _StartLoadsVoltage+2, R27
	STS        _StartLoadsVoltage+3, R27
L_SetStartUpLoadsVoltage177:
;Solar_Loads_Controller_SLCM_V1.c,531 :: 		if (StartLoadsVoltage<0) StartLoadsVoltage=0;
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
	BREQ       L__SetStartUpLoadsVoltage609
	LDI        R16, 1
L__SetStartUpLoadsVoltage609:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage610
	JMP        L_SetStartUpLoadsVoltage178
L__SetStartUpLoadsVoltage610:
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	STS        _StartLoadsVoltage+2, R27
	STS        _StartLoadsVoltage+3, R27
L_SetStartUpLoadsVoltage178:
;Solar_Loads_Controller_SLCM_V1.c,532 :: 		} //end wile increment and decrement
	JMP        L_SetStartUpLoadsVoltage167
L_SetStartUpLoadsVoltage168:
;Solar_Loads_Controller_SLCM_V1.c,533 :: 		}// end first while
	JMP        L_SetStartUpLoadsVoltage165
L_SetStartUpLoadsVoltage166:
;Solar_Loads_Controller_SLCM_V1.c,534 :: 		StoreBytesIntoEEprom(0x08,(unsigned short *)&StartLoadsVoltage,4);   // save float number to eeprom
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
;Solar_Loads_Controller_SLCM_V1.c,535 :: 		}
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

;Solar_Loads_Controller_SLCM_V1.c,539 :: 		void Startup_Timers()
;Solar_Loads_Controller_SLCM_V1.c,541 :: 		while(Set==0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
L_Startup_Timers179:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_Startup_Timers180
;Solar_Loads_Controller_SLCM_V1.c,543 :: 		Display_On_7Segment_Character(0x92,0xC7,0x92);
	LDI        R27, 146
	MOV        R4, R27
	LDI        R27, 199
	MOV        R3, R27
	LDI        R27, 146
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,544 :: 		}
	JMP        L_Startup_Timers179
L_Startup_Timers180:
;Solar_Loads_Controller_SLCM_V1.c,545 :: 		Delay_ms(500);;
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Startup_Timers181:
	DEC        R16
	BRNE       L_Startup_Timers181
	DEC        R17
	BRNE       L_Startup_Timers181
	DEC        R18
	BRNE       L_Startup_Timers181
	NOP
;Solar_Loads_Controller_SLCM_V1.c,546 :: 		while(Set==0)
L_Startup_Timers183:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_Startup_Timers184
;Solar_Loads_Controller_SLCM_V1.c,548 :: 		Display_On_7Segment(startupTIme_1);
	LDS        R2, _startupTIme_1+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,549 :: 		while(Increment==1 || Decrement==1)
L_Startup_Timers185:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__Startup_Timers488
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__Startup_Timers487
	JMP        L_Startup_Timers186
L__Startup_Timers488:
L__Startup_Timers487:
;Solar_Loads_Controller_SLCM_V1.c,551 :: 		if(Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_Startup_Timers189
;Solar_Loads_Controller_SLCM_V1.c,554 :: 		Display_On_7Segment(startupTIme_1);
	LDS        R2, _startupTIme_1+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,555 :: 		Delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_Startup_Timers190:
	DEC        R16
	BRNE       L_Startup_Timers190
	DEC        R17
	BRNE       L_Startup_Timers190
	DEC        R18
	BRNE       L_Startup_Timers190
;Solar_Loads_Controller_SLCM_V1.c,556 :: 		startupTIme_1++;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _startupTIme_1+0, R16
	STS        _startupTIme_1+1, R17
;Solar_Loads_Controller_SLCM_V1.c,557 :: 		}
L_Startup_Timers189:
;Solar_Loads_Controller_SLCM_V1.c,558 :: 		if(Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
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
;Solar_Loads_Controller_SLCM_V1.c,563 :: 		startupTIme_1--;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _startupTIme_1+0, R16
	STS        _startupTIme_1+1, R17
;Solar_Loads_Controller_SLCM_V1.c,564 :: 		}
L_Startup_Timers192:
;Solar_Loads_Controller_SLCM_V1.c,565 :: 		if(startupTIme_1 > 600  ) startupTIme_1=0;
	LDS        R18, _startupTIme_1+0
	LDS        R19, _startupTIme_1+1
	LDI        R16, 88
	LDI        R17, 2
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Startup_Timers612
	JMP        L_Startup_Timers195
L__Startup_Timers612:
	LDI        R27, 0
	STS        _startupTIme_1+0, R27
	STS        _startupTIme_1+1, R27
L_Startup_Timers195:
;Solar_Loads_Controller_SLCM_V1.c,566 :: 		if (startupTIme_1<0) startupTIme_1=0;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CPI        R17, 0
	BRNE       L__Startup_Timers613
	CPI        R16, 0
L__Startup_Timers613:
	BRLO       L__Startup_Timers614
	JMP        L_Startup_Timers196
L__Startup_Timers614:
	LDI        R27, 0
	STS        _startupTIme_1+0, R27
	STS        _startupTIme_1+1, R27
L_Startup_Timers196:
;Solar_Loads_Controller_SLCM_V1.c,567 :: 		} // end  while increment decrement
	JMP        L_Startup_Timers185
L_Startup_Timers186:
;Solar_Loads_Controller_SLCM_V1.c,568 :: 		} // end while main while set
	JMP        L_Startup_Timers183
L_Startup_Timers184:
;Solar_Loads_Controller_SLCM_V1.c,569 :: 		StoreBytesIntoEEprom(0x12,(unsigned short *)&startupTIme_1,2);   // save float number to eeprom
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
;Solar_Loads_Controller_SLCM_V1.c,570 :: 		} // end  function
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

;Solar_Loads_Controller_SLCM_V1.c,573 :: 		void SetDS1307_Time()
;Solar_Loads_Controller_SLCM_V1.c,575 :: 		while(Set==0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
L_SetDS1307_Time197:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time198
;Solar_Loads_Controller_SLCM_V1.c,577 :: 		Display_On_7Segment(6);  // to indicate program 3
	LDI        R27, 6
	MOV        R2, R27
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,578 :: 		}
	JMP        L_SetDS1307_Time197
L_SetDS1307_Time198:
;Solar_Loads_Controller_SLCM_V1.c,579 :: 		set_ds1307_minutes=ReadMinutes();      // to read time now
	CALL       _ReadMinutes+0
	STS        _set_ds1307_minutes+0, R16
;Solar_Loads_Controller_SLCM_V1.c,580 :: 		set_ds1307_hours=ReadHours();          // to read time now
	CALL       _ReadHours+0
	STS        _set_ds1307_hours+0, R16
;Solar_Loads_Controller_SLCM_V1.c,581 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time199:
	DEC        R16
	BRNE       L_SetDS1307_Time199
	DEC        R17
	BRNE       L_SetDS1307_Time199
	DEC        R18
	BRNE       L_SetDS1307_Time199
	NOP
;Solar_Loads_Controller_SLCM_V1.c,582 :: 		while(Set==0)
L_SetDS1307_Time201:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time202
;Solar_Loads_Controller_SLCM_V1.c,584 :: 		Display_On_7Segment_Character(0x89,0xC0,0xC1);
	LDI        R27, 193
	MOV        R4, R27
	LDI        R27, 192
	MOV        R3, R27
	LDI        R27, 137
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,585 :: 		}
	JMP        L_SetDS1307_Time201
L_SetDS1307_Time202:
;Solar_Loads_Controller_SLCM_V1.c,586 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time203:
	DEC        R16
	BRNE       L_SetDS1307_Time203
	DEC        R17
	BRNE       L_SetDS1307_Time203
	DEC        R18
	BRNE       L_SetDS1307_Time203
	NOP
;Solar_Loads_Controller_SLCM_V1.c,587 :: 		while (Set==0)
L_SetDS1307_Time205:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time206
;Solar_Loads_Controller_SLCM_V1.c,589 :: 		Display_On_7Segment(set_ds1307_hours);
	LDS        R2, _set_ds1307_hours+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,590 :: 		while (Increment==1 || Decrement==1 )
L_SetDS1307_Time207:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetDS1307_Time499
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetDS1307_Time498
	JMP        L_SetDS1307_Time208
L__SetDS1307_Time499:
L__SetDS1307_Time498:
;Solar_Loads_Controller_SLCM_V1.c,592 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetDS1307_Time211
;Solar_Loads_Controller_SLCM_V1.c,594 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time212:
	DEC        R16
	BRNE       L_SetDS1307_Time212
	DEC        R17
	BRNE       L_SetDS1307_Time212
	DEC        R18
	BRNE       L_SetDS1307_Time212
;Solar_Loads_Controller_SLCM_V1.c,595 :: 		set_ds1307_hours++;
	LDS        R16, _set_ds1307_hours+0
	SUBI       R16, 255
	STS        _set_ds1307_hours+0, R16
;Solar_Loads_Controller_SLCM_V1.c,596 :: 		}
L_SetDS1307_Time211:
;Solar_Loads_Controller_SLCM_V1.c,597 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetDS1307_Time214
;Solar_Loads_Controller_SLCM_V1.c,599 :: 		delay_ms(ButtonDelay);
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
;Solar_Loads_Controller_SLCM_V1.c,600 :: 		set_ds1307_hours--;
	LDS        R16, _set_ds1307_hours+0
	SUBI       R16, 1
	STS        _set_ds1307_hours+0, R16
;Solar_Loads_Controller_SLCM_V1.c,601 :: 		}
L_SetDS1307_Time214:
;Solar_Loads_Controller_SLCM_V1.c,602 :: 		if(set_ds1307_hours>23) set_ds1307_hours=0;
	LDS        R17, _set_ds1307_hours+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetDS1307_Time616
	JMP        L_SetDS1307_Time217
L__SetDS1307_Time616:
	LDI        R27, 0
	STS        _set_ds1307_hours+0, R27
L_SetDS1307_Time217:
;Solar_Loads_Controller_SLCM_V1.c,603 :: 		if (set_ds1307_hours<0) set_ds1307_hours=0;
	LDS        R16, _set_ds1307_hours+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time617
	JMP        L_SetDS1307_Time218
L__SetDS1307_Time617:
	LDI        R27, 0
	STS        _set_ds1307_hours+0, R27
L_SetDS1307_Time218:
;Solar_Loads_Controller_SLCM_V1.c,604 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time207
L_SetDS1307_Time208:
;Solar_Loads_Controller_SLCM_V1.c,605 :: 		} // end first while
	JMP        L_SetDS1307_Time205
L_SetDS1307_Time206:
;Solar_Loads_Controller_SLCM_V1.c,607 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time219:
	DEC        R16
	BRNE       L_SetDS1307_Time219
	DEC        R17
	BRNE       L_SetDS1307_Time219
	DEC        R18
	BRNE       L_SetDS1307_Time219
	NOP
;Solar_Loads_Controller_SLCM_V1.c,608 :: 		while(Set==0)
L_SetDS1307_Time221:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time222
;Solar_Loads_Controller_SLCM_V1.c,610 :: 		Display_On_7Segment_Character(0xC8,0xC8,0xCF);
	LDI        R27, 207
	MOV        R4, R27
	LDI        R27, 200
	MOV        R3, R27
	LDI        R27, 200
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,611 :: 		}
	JMP        L_SetDS1307_Time221
L_SetDS1307_Time222:
;Solar_Loads_Controller_SLCM_V1.c,612 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time223:
	DEC        R16
	BRNE       L_SetDS1307_Time223
	DEC        R17
	BRNE       L_SetDS1307_Time223
	DEC        R18
	BRNE       L_SetDS1307_Time223
	NOP
;Solar_Loads_Controller_SLCM_V1.c,613 :: 		while (Set==0)
L_SetDS1307_Time225:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time226
;Solar_Loads_Controller_SLCM_V1.c,615 :: 		Display_On_7Segment(set_ds1307_minutes);
	LDS        R2, _set_ds1307_minutes+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,616 :: 		while (Increment==1 || Decrement==1)
L_SetDS1307_Time227:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetDS1307_Time501
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetDS1307_Time500
	JMP        L_SetDS1307_Time228
L__SetDS1307_Time501:
L__SetDS1307_Time500:
;Solar_Loads_Controller_SLCM_V1.c,618 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetDS1307_Time231
;Solar_Loads_Controller_SLCM_V1.c,620 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time232:
	DEC        R16
	BRNE       L_SetDS1307_Time232
	DEC        R17
	BRNE       L_SetDS1307_Time232
	DEC        R18
	BRNE       L_SetDS1307_Time232
;Solar_Loads_Controller_SLCM_V1.c,621 :: 		set_ds1307_minutes++;
	LDS        R16, _set_ds1307_minutes+0
	SUBI       R16, 255
	STS        _set_ds1307_minutes+0, R16
;Solar_Loads_Controller_SLCM_V1.c,622 :: 		}
L_SetDS1307_Time231:
;Solar_Loads_Controller_SLCM_V1.c,623 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetDS1307_Time234
;Solar_Loads_Controller_SLCM_V1.c,625 :: 		delay_ms(ButtonDelay);
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
;Solar_Loads_Controller_SLCM_V1.c,626 :: 		set_ds1307_minutes--;
	LDS        R16, _set_ds1307_minutes+0
	SUBI       R16, 1
	STS        _set_ds1307_minutes+0, R16
;Solar_Loads_Controller_SLCM_V1.c,627 :: 		}
L_SetDS1307_Time234:
;Solar_Loads_Controller_SLCM_V1.c,628 :: 		if(set_ds1307_minutes>59) set_ds1307_minutes=0;
	LDS        R17, _set_ds1307_minutes+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetDS1307_Time618
	JMP        L_SetDS1307_Time237
L__SetDS1307_Time618:
	LDI        R27, 0
	STS        _set_ds1307_minutes+0, R27
L_SetDS1307_Time237:
;Solar_Loads_Controller_SLCM_V1.c,629 :: 		if(set_ds1307_minutes<0) set_ds1307_minutes=0;
	LDS        R16, _set_ds1307_minutes+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time619
	JMP        L_SetDS1307_Time238
L__SetDS1307_Time619:
	LDI        R27, 0
	STS        _set_ds1307_minutes+0, R27
L_SetDS1307_Time238:
;Solar_Loads_Controller_SLCM_V1.c,630 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time227
L_SetDS1307_Time228:
;Solar_Loads_Controller_SLCM_V1.c,631 :: 		} // end first while
	JMP        L_SetDS1307_Time225
L_SetDS1307_Time226:
;Solar_Loads_Controller_SLCM_V1.c,633 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time239:
	DEC        R16
	BRNE       L_SetDS1307_Time239
	DEC        R17
	BRNE       L_SetDS1307_Time239
	DEC        R18
	BRNE       L_SetDS1307_Time239
	NOP
;Solar_Loads_Controller_SLCM_V1.c,634 :: 		while(Set==0)
L_SetDS1307_Time241:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time242
;Solar_Loads_Controller_SLCM_V1.c,636 :: 		Display_On_7Segment_Character(0x92,0x86,0xC6);
	LDI        R27, 198
	MOV        R4, R27
	LDI        R27, 134
	MOV        R3, R27
	LDI        R27, 146
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,637 :: 		}
	JMP        L_SetDS1307_Time241
L_SetDS1307_Time242:
;Solar_Loads_Controller_SLCM_V1.c,638 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time243:
	DEC        R16
	BRNE       L_SetDS1307_Time243
	DEC        R17
	BRNE       L_SetDS1307_Time243
	DEC        R18
	BRNE       L_SetDS1307_Time243
	NOP
;Solar_Loads_Controller_SLCM_V1.c,639 :: 		while (Set==0)
L_SetDS1307_Time245:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time246
;Solar_Loads_Controller_SLCM_V1.c,641 :: 		Display_On_7Segment(set_ds1307_seconds);
	LDS        R2, _set_ds1307_seconds+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,642 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time247:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetDS1307_Time503
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetDS1307_Time502
	JMP        L_SetDS1307_Time248
L__SetDS1307_Time503:
L__SetDS1307_Time502:
;Solar_Loads_Controller_SLCM_V1.c,644 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetDS1307_Time251
;Solar_Loads_Controller_SLCM_V1.c,646 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time252:
	DEC        R16
	BRNE       L_SetDS1307_Time252
	DEC        R17
	BRNE       L_SetDS1307_Time252
	DEC        R18
	BRNE       L_SetDS1307_Time252
;Solar_Loads_Controller_SLCM_V1.c,647 :: 		set_ds1307_seconds++;
	LDS        R16, _set_ds1307_seconds+0
	SUBI       R16, 255
	STS        _set_ds1307_seconds+0, R16
;Solar_Loads_Controller_SLCM_V1.c,648 :: 		}
L_SetDS1307_Time251:
;Solar_Loads_Controller_SLCM_V1.c,649 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetDS1307_Time254
;Solar_Loads_Controller_SLCM_V1.c,651 :: 		delay_ms(ButtonDelay);
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
;Solar_Loads_Controller_SLCM_V1.c,652 :: 		set_ds1307_seconds--;
	LDS        R16, _set_ds1307_seconds+0
	SUBI       R16, 1
	STS        _set_ds1307_seconds+0, R16
;Solar_Loads_Controller_SLCM_V1.c,653 :: 		}
L_SetDS1307_Time254:
;Solar_Loads_Controller_SLCM_V1.c,654 :: 		if (set_ds1307_seconds>59) set_ds1307_seconds=0;
	LDS        R17, _set_ds1307_seconds+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetDS1307_Time620
	JMP        L_SetDS1307_Time257
L__SetDS1307_Time620:
	LDI        R27, 0
	STS        _set_ds1307_seconds+0, R27
L_SetDS1307_Time257:
;Solar_Loads_Controller_SLCM_V1.c,655 :: 		if (set_ds1307_seconds<0) set_ds1307_seconds=0;
	LDS        R16, _set_ds1307_seconds+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time621
	JMP        L_SetDS1307_Time258
L__SetDS1307_Time621:
	LDI        R27, 0
	STS        _set_ds1307_seconds+0, R27
L_SetDS1307_Time258:
;Solar_Loads_Controller_SLCM_V1.c,658 :: 		Write_Time(Dec2Bcd(set_ds1307_seconds),Dec2Bcd(set_ds1307_minutes),Dec2Bcd(set_ds1307_hours)); // write time to DS1307
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
;Solar_Loads_Controller_SLCM_V1.c,659 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time247
L_SetDS1307_Time248:
;Solar_Loads_Controller_SLCM_V1.c,660 :: 		} // end first while
	JMP        L_SetDS1307_Time245
L_SetDS1307_Time246:
;Solar_Loads_Controller_SLCM_V1.c,662 :: 		set_ds1307_day=ReadDate(0x04);  // read day
	LDI        R27, 4
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_day+0, R16
;Solar_Loads_Controller_SLCM_V1.c,663 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time259:
	DEC        R16
	BRNE       L_SetDS1307_Time259
	DEC        R17
	BRNE       L_SetDS1307_Time259
	DEC        R18
	BRNE       L_SetDS1307_Time259
	NOP
;Solar_Loads_Controller_SLCM_V1.c,664 :: 		while(Set==0)
L_SetDS1307_Time261:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time262
;Solar_Loads_Controller_SLCM_V1.c,666 :: 		Display_On_7Segment_Character(0xC0,0x88,0x91);
	LDI        R27, 145
	MOV        R4, R27
	LDI        R27, 136
	MOV        R3, R27
	LDI        R27, 192
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,667 :: 		}
	JMP        L_SetDS1307_Time261
L_SetDS1307_Time262:
;Solar_Loads_Controller_SLCM_V1.c,668 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time263:
	DEC        R16
	BRNE       L_SetDS1307_Time263
	DEC        R17
	BRNE       L_SetDS1307_Time263
	DEC        R18
	BRNE       L_SetDS1307_Time263
	NOP
;Solar_Loads_Controller_SLCM_V1.c,669 :: 		while (Set==0)
L_SetDS1307_Time265:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time266
;Solar_Loads_Controller_SLCM_V1.c,671 :: 		Display_On_7Segment(set_ds1307_day);
	LDS        R2, _set_ds1307_day+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,672 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time267:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetDS1307_Time505
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetDS1307_Time504
	JMP        L_SetDS1307_Time268
L__SetDS1307_Time505:
L__SetDS1307_Time504:
;Solar_Loads_Controller_SLCM_V1.c,675 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetDS1307_Time271
;Solar_Loads_Controller_SLCM_V1.c,677 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time272:
	DEC        R16
	BRNE       L_SetDS1307_Time272
	DEC        R17
	BRNE       L_SetDS1307_Time272
	DEC        R18
	BRNE       L_SetDS1307_Time272
;Solar_Loads_Controller_SLCM_V1.c,678 :: 		set_ds1307_day++;
	LDS        R16, _set_ds1307_day+0
	SUBI       R16, 255
	STS        _set_ds1307_day+0, R16
;Solar_Loads_Controller_SLCM_V1.c,679 :: 		}
L_SetDS1307_Time271:
;Solar_Loads_Controller_SLCM_V1.c,680 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetDS1307_Time274
;Solar_Loads_Controller_SLCM_V1.c,682 :: 		delay_ms(ButtonDelay);
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
;Solar_Loads_Controller_SLCM_V1.c,683 :: 		set_ds1307_day--;
	LDS        R16, _set_ds1307_day+0
	SUBI       R16, 1
	STS        _set_ds1307_day+0, R16
;Solar_Loads_Controller_SLCM_V1.c,684 :: 		}
L_SetDS1307_Time274:
;Solar_Loads_Controller_SLCM_V1.c,685 :: 		if (set_ds1307_day>31) set_ds1307_day=0;
	LDS        R17, _set_ds1307_day+0
	LDI        R16, 31
	CP         R16, R17
	BRLO       L__SetDS1307_Time622
	JMP        L_SetDS1307_Time277
L__SetDS1307_Time622:
	LDI        R27, 0
	STS        _set_ds1307_day+0, R27
L_SetDS1307_Time277:
;Solar_Loads_Controller_SLCM_V1.c,686 :: 		if (set_ds1307_day<0) set_ds1307_day=0;
	LDS        R16, _set_ds1307_day+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time623
	JMP        L_SetDS1307_Time278
L__SetDS1307_Time623:
	LDI        R27, 0
	STS        _set_ds1307_day+0, R27
L_SetDS1307_Time278:
;Solar_Loads_Controller_SLCM_V1.c,687 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time267
L_SetDS1307_Time268:
;Solar_Loads_Controller_SLCM_V1.c,688 :: 		} //  end while set
	JMP        L_SetDS1307_Time265
L_SetDS1307_Time266:
;Solar_Loads_Controller_SLCM_V1.c,691 :: 		set_ds1307_month=ReadDate(0x05);     // month
	LDI        R27, 5
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_month+0, R16
;Solar_Loads_Controller_SLCM_V1.c,692 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time279:
	DEC        R16
	BRNE       L_SetDS1307_Time279
	DEC        R17
	BRNE       L_SetDS1307_Time279
	DEC        R18
	BRNE       L_SetDS1307_Time279
	NOP
;Solar_Loads_Controller_SLCM_V1.c,693 :: 		while(Set==0)
L_SetDS1307_Time281:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time282
;Solar_Loads_Controller_SLCM_V1.c,695 :: 		Display_On_7Segment_Character(0xC8,0xC0,0xC8);
	LDI        R27, 200
	MOV        R4, R27
	LDI        R27, 192
	MOV        R3, R27
	LDI        R27, 200
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,696 :: 		}
	JMP        L_SetDS1307_Time281
L_SetDS1307_Time282:
;Solar_Loads_Controller_SLCM_V1.c,697 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time283:
	DEC        R16
	BRNE       L_SetDS1307_Time283
	DEC        R17
	BRNE       L_SetDS1307_Time283
	DEC        R18
	BRNE       L_SetDS1307_Time283
	NOP
;Solar_Loads_Controller_SLCM_V1.c,698 :: 		while (Set==0)
L_SetDS1307_Time285:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time286
;Solar_Loads_Controller_SLCM_V1.c,700 :: 		Display_On_7Segment( set_ds1307_month);
	LDS        R2, _set_ds1307_month+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,701 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time287:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetDS1307_Time507
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetDS1307_Time506
	JMP        L_SetDS1307_Time288
L__SetDS1307_Time507:
L__SetDS1307_Time506:
;Solar_Loads_Controller_SLCM_V1.c,703 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetDS1307_Time291
;Solar_Loads_Controller_SLCM_V1.c,705 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time292:
	DEC        R16
	BRNE       L_SetDS1307_Time292
	DEC        R17
	BRNE       L_SetDS1307_Time292
	DEC        R18
	BRNE       L_SetDS1307_Time292
;Solar_Loads_Controller_SLCM_V1.c,706 :: 		set_ds1307_month++;
	LDS        R16, _set_ds1307_month+0
	SUBI       R16, 255
	STS        _set_ds1307_month+0, R16
;Solar_Loads_Controller_SLCM_V1.c,708 :: 		}
L_SetDS1307_Time291:
;Solar_Loads_Controller_SLCM_V1.c,709 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetDS1307_Time294
;Solar_Loads_Controller_SLCM_V1.c,711 :: 		delay_ms(ButtonDelay);
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
;Solar_Loads_Controller_SLCM_V1.c,712 :: 		set_ds1307_month--;
	LDS        R16, _set_ds1307_month+0
	SUBI       R16, 1
	STS        _set_ds1307_month+0, R16
;Solar_Loads_Controller_SLCM_V1.c,713 :: 		}
L_SetDS1307_Time294:
;Solar_Loads_Controller_SLCM_V1.c,714 :: 		if (set_ds1307_month>12) set_ds1307_month=0;
	LDS        R17, _set_ds1307_month+0
	LDI        R16, 12
	CP         R16, R17
	BRLO       L__SetDS1307_Time624
	JMP        L_SetDS1307_Time297
L__SetDS1307_Time624:
	LDI        R27, 0
	STS        _set_ds1307_month+0, R27
L_SetDS1307_Time297:
;Solar_Loads_Controller_SLCM_V1.c,715 :: 		if (set_ds1307_month<0) set_ds1307_month=0;
	LDS        R16, _set_ds1307_month+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time625
	JMP        L_SetDS1307_Time298
L__SetDS1307_Time625:
	LDI        R27, 0
	STS        _set_ds1307_month+0, R27
L_SetDS1307_Time298:
;Solar_Loads_Controller_SLCM_V1.c,716 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time287
L_SetDS1307_Time288:
;Solar_Loads_Controller_SLCM_V1.c,717 :: 		} //  end while set
	JMP        L_SetDS1307_Time285
L_SetDS1307_Time286:
;Solar_Loads_Controller_SLCM_V1.c,720 :: 		set_ds1307_year=ReadDate(0x06);
	LDI        R27, 6
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_year+0, R16
;Solar_Loads_Controller_SLCM_V1.c,721 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time299:
	DEC        R16
	BRNE       L_SetDS1307_Time299
	DEC        R17
	BRNE       L_SetDS1307_Time299
	DEC        R18
	BRNE       L_SetDS1307_Time299
	NOP
;Solar_Loads_Controller_SLCM_V1.c,722 :: 		while(Set==0)
L_SetDS1307_Time301:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time302
;Solar_Loads_Controller_SLCM_V1.c,724 :: 		Display_On_7Segment_Character(0x91,0x86,0x88);
	LDI        R27, 136
	MOV        R4, R27
	LDI        R27, 134
	MOV        R3, R27
	LDI        R27, 145
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,725 :: 		}
	JMP        L_SetDS1307_Time301
L_SetDS1307_Time302:
;Solar_Loads_Controller_SLCM_V1.c,726 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time303:
	DEC        R16
	BRNE       L_SetDS1307_Time303
	DEC        R17
	BRNE       L_SetDS1307_Time303
	DEC        R18
	BRNE       L_SetDS1307_Time303
	NOP
;Solar_Loads_Controller_SLCM_V1.c,727 :: 		while (Set==0)
L_SetDS1307_Time305:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time306
;Solar_Loads_Controller_SLCM_V1.c,729 :: 		Display_On_7Segment( set_ds1307_year);
	LDS        R2, _set_ds1307_year+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,730 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time307:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetDS1307_Time509
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetDS1307_Time508
	JMP        L_SetDS1307_Time308
L__SetDS1307_Time509:
L__SetDS1307_Time508:
;Solar_Loads_Controller_SLCM_V1.c,732 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetDS1307_Time311
;Solar_Loads_Controller_SLCM_V1.c,734 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_SetDS1307_Time312:
	DEC        R16
	BRNE       L_SetDS1307_Time312
	DEC        R17
	BRNE       L_SetDS1307_Time312
	DEC        R18
	BRNE       L_SetDS1307_Time312
;Solar_Loads_Controller_SLCM_V1.c,735 :: 		set_ds1307_year++;
	LDS        R16, _set_ds1307_year+0
	SUBI       R16, 255
	STS        _set_ds1307_year+0, R16
;Solar_Loads_Controller_SLCM_V1.c,737 :: 		}
L_SetDS1307_Time311:
;Solar_Loads_Controller_SLCM_V1.c,738 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetDS1307_Time314
;Solar_Loads_Controller_SLCM_V1.c,740 :: 		delay_ms(ButtonDelay);
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
;Solar_Loads_Controller_SLCM_V1.c,741 :: 		set_ds1307_year--;
	LDS        R16, _set_ds1307_year+0
	SUBI       R16, 1
	STS        _set_ds1307_year+0, R16
;Solar_Loads_Controller_SLCM_V1.c,742 :: 		}
L_SetDS1307_Time314:
;Solar_Loads_Controller_SLCM_V1.c,743 :: 		if (set_ds1307_year>99) set_ds1307_year=0;
	LDS        R17, _set_ds1307_year+0
	LDI        R16, 99
	CP         R16, R17
	BRLO       L__SetDS1307_Time626
	JMP        L_SetDS1307_Time317
L__SetDS1307_Time626:
	LDI        R27, 0
	STS        _set_ds1307_year+0, R27
L_SetDS1307_Time317:
;Solar_Loads_Controller_SLCM_V1.c,744 :: 		if (set_ds1307_year<0) set_ds1307_year=0;
	LDS        R16, _set_ds1307_year+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time627
	JMP        L_SetDS1307_Time318
L__SetDS1307_Time627:
	LDI        R27, 0
	STS        _set_ds1307_year+0, R27
L_SetDS1307_Time318:
;Solar_Loads_Controller_SLCM_V1.c,746 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time307
L_SetDS1307_Time308:
;Solar_Loads_Controller_SLCM_V1.c,747 :: 		Write_Date(Dec2Bcd(set_ds1307_day),Dec2Bcd(set_ds1307_month),Dec2Bcd(set_ds1307_year)); // write Date to DS1307
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
;Solar_Loads_Controller_SLCM_V1.c,748 :: 		} //  end while set
	JMP        L_SetDS1307_Time305
L_SetDS1307_Time306:
;Solar_Loads_Controller_SLCM_V1.c,749 :: 		}  // end setTimeAndData
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

;Solar_Loads_Controller_SLCM_V1.c,752 :: 		void RunOnBatteryVoltageWithoutTimer()
;Solar_Loads_Controller_SLCM_V1.c,754 :: 		Delay_ms(500);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_RunOnBatteryVoltageWithoutTimer319:
	DEC        R16
	BRNE       L_RunOnBatteryVoltageWithoutTimer319
	DEC        R17
	BRNE       L_RunOnBatteryVoltageWithoutTimer319
	DEC        R18
	BRNE       L_RunOnBatteryVoltageWithoutTimer319
	NOP
;Solar_Loads_Controller_SLCM_V1.c,755 :: 		while(Set==0)
L_RunOnBatteryVoltageWithoutTimer321:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_RunOnBatteryVoltageWithoutTimer322
;Solar_Loads_Controller_SLCM_V1.c,757 :: 		Display_On_7Segment_Character(0xC1,0xC0,0x80);   //VOB= voltage on battery
	LDI        R27, 128
	MOV        R4, R27
	LDI        R27, 192
	MOV        R3, R27
	LDI        R27, 193
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,758 :: 		}
	JMP        L_RunOnBatteryVoltageWithoutTimer321
L_RunOnBatteryVoltageWithoutTimer322:
;Solar_Loads_Controller_SLCM_V1.c,759 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_RunOnBatteryVoltageWithoutTimer323:
	DEC        R16
	BRNE       L_RunOnBatteryVoltageWithoutTimer323
	DEC        R17
	BRNE       L_RunOnBatteryVoltageWithoutTimer323
	DEC        R18
	BRNE       L_RunOnBatteryVoltageWithoutTimer323
	NOP
;Solar_Loads_Controller_SLCM_V1.c,760 :: 		while (Set==0)
L_RunOnBatteryVoltageWithoutTimer325:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_RunOnBatteryVoltageWithoutTimer326
;Solar_Loads_Controller_SLCM_V1.c,762 :: 		if(RunOnBatteryVoltageWithoutTimer_Flag==0)          Display_On_7Segment_Character(0xC0,0x8E,0x8E);        // mode is off so timer is on
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__RunOnBatteryVoltageWithoutTimer629
	JMP        L_RunOnBatteryVoltageWithoutTimer327
L__RunOnBatteryVoltageWithoutTimer629:
	LDI        R27, 142
	MOV        R4, R27
	LDI        R27, 142
	MOV        R3, R27
	LDI        R27, 192
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
L_RunOnBatteryVoltageWithoutTimer327:
;Solar_Loads_Controller_SLCM_V1.c,763 :: 		if(RunOnBatteryVoltageWithoutTimer_Flag==1)          Display_On_7Segment_Character(0xC0,0xC8,0xC8);       // mode is on so timer is off
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 1
	BREQ       L__RunOnBatteryVoltageWithoutTimer630
	JMP        L_RunOnBatteryVoltageWithoutTimer328
L__RunOnBatteryVoltageWithoutTimer630:
	LDI        R27, 200
	MOV        R4, R27
	LDI        R27, 200
	MOV        R3, R27
	LDI        R27, 192
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
L_RunOnBatteryVoltageWithoutTimer328:
;Solar_Loads_Controller_SLCM_V1.c,765 :: 		while (Increment == 1 || Decrement==1)
L_RunOnBatteryVoltageWithoutTimer329:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__RunOnBatteryVoltageWithoutTimer491
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__RunOnBatteryVoltageWithoutTimer490
	JMP        L_RunOnBatteryVoltageWithoutTimer330
L__RunOnBatteryVoltageWithoutTimer491:
L__RunOnBatteryVoltageWithoutTimer490:
;Solar_Loads_Controller_SLCM_V1.c,767 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_RunOnBatteryVoltageWithoutTimer333
;Solar_Loads_Controller_SLCM_V1.c,769 :: 		delay_ms(ButtonDelay);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_RunOnBatteryVoltageWithoutTimer334:
	DEC        R16
	BRNE       L_RunOnBatteryVoltageWithoutTimer334
	DEC        R17
	BRNE       L_RunOnBatteryVoltageWithoutTimer334
	DEC        R18
	BRNE       L_RunOnBatteryVoltageWithoutTimer334
;Solar_Loads_Controller_SLCM_V1.c,770 :: 		RunOnBatteryVoltageWithoutTimer_Flag=0;
	LDI        R27, 0
	STS        _RunOnBatteryVoltageWithoutTimer_Flag+0, R27
;Solar_Loads_Controller_SLCM_V1.c,771 :: 		}
L_RunOnBatteryVoltageWithoutTimer333:
;Solar_Loads_Controller_SLCM_V1.c,772 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_RunOnBatteryVoltageWithoutTimer336
;Solar_Loads_Controller_SLCM_V1.c,774 :: 		delay_ms(ButtonDelay);
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
;Solar_Loads_Controller_SLCM_V1.c,775 :: 		RunOnBatteryVoltageWithoutTimer_Flag=1;
	LDI        R27, 1
	STS        _RunOnBatteryVoltageWithoutTimer_Flag+0, R27
;Solar_Loads_Controller_SLCM_V1.c,776 :: 		}
L_RunOnBatteryVoltageWithoutTimer336:
;Solar_Loads_Controller_SLCM_V1.c,777 :: 		} // end while increment
	JMP        L_RunOnBatteryVoltageWithoutTimer329
L_RunOnBatteryVoltageWithoutTimer330:
;Solar_Loads_Controller_SLCM_V1.c,778 :: 		EEPROM_Write(0x14,RunOnBatteryVoltageWithoutTimer_Flag); // if zero timer is on and if 1 tiemr is off
	LDS        R4, _RunOnBatteryVoltageWithoutTimer_Flag+0
	LDI        R27, 20
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,779 :: 		} // end first while
	JMP        L_RunOnBatteryVoltageWithoutTimer325
L_RunOnBatteryVoltageWithoutTimer326:
;Solar_Loads_Controller_SLCM_V1.c,780 :: 		}
L_end_RunOnBatteryVoltageWithoutTimer:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _RunOnBatteryVoltageWithoutTimer

_Screen_1:

;Solar_Loads_Controller_SLCM_V1.c,782 :: 		void Screen_1()
;Solar_Loads_Controller_SLCM_V1.c,784 :: 		Read_Time();
	CALL       _Read_time+0
;Solar_Loads_Controller_SLCM_V1.c,786 :: 		}
L_end_Screen_1:
	RET
; end of _Screen_1

_ADCBattery:

;Solar_Loads_Controller_SLCM_V1.c,788 :: 		void ADCBattery()
;Solar_Loads_Controller_SLCM_V1.c,790 :: 		ADC_Init();
	PUSH       R2
	CALL       _ADC_Init+0
;Solar_Loads_Controller_SLCM_V1.c,791 :: 		ADC_Init_Advanced(_ADC_EXTERNAL_REF);
	CLR        R2
	CALL       _ADC_Init_Advanced+0
;Solar_Loads_Controller_SLCM_V1.c,792 :: 		ADPS2_Bit=1;
	IN         R27, ADPS2_bit+0
	SBR        R27, BitMask(ADPS2_bit+0)
	OUT        ADPS2_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,793 :: 		ADPS1_Bit=1;
	IN         R27, ADPS1_bit+0
	SBR        R27, BitMask(ADPS1_bit+0)
	OUT        ADPS1_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,794 :: 		ADPS0_Bit=0;
	IN         R27, ADPS0_bit+0
	CBR        R27, BitMask(ADPS0_bit+0)
	OUT        ADPS0_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,795 :: 		}
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

;Solar_Loads_Controller_SLCM_V1.c,797 :: 		void Read_Battery()
;Solar_Loads_Controller_SLCM_V1.c,799 :: 		float sum=0 , Battery[10];
	PUSH       R2
	LDI        R27, 0
	STD        Y+40, R27
	STD        Y+41, R27
	STD        Y+42, R27
	STD        Y+43, R27
;Solar_Loads_Controller_SLCM_V1.c,800 :: 		char i=0;
;Solar_Loads_Controller_SLCM_V1.c,801 :: 		ADC_Value=ADC_Read(1);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _ADC_Read+0
	STS        _ADC_Value+0, R16
	STS        _ADC_Value+1, R17
;Solar_Loads_Controller_SLCM_V1.c,802 :: 		Battery_Voltage=(ADC_Value *5.0)/1024.0;
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
;Solar_Loads_Controller_SLCM_V1.c,806 :: 		for ( i=0; i<10 ; i++)
	LDI        R27, 0
	STD        Y+44, R27
L_Read_Battery339:
	LDD        R16, Y+44
	CPI        R16, 10
	BRLO       L__Read_Battery634
	JMP        L_Read_Battery340
L__Read_Battery634:
;Solar_Loads_Controller_SLCM_V1.c,808 :: 		Battery[i]=((10.5/0.5)*Battery_Voltage);
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
;Solar_Loads_Controller_SLCM_V1.c,810 :: 		sum+=Battery[i];
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
;Solar_Loads_Controller_SLCM_V1.c,806 :: 		for ( i=0; i<10 ; i++)
	LDD        R16, Y+44
	SUBI       R16, 255
	STD        Y+44, R16
;Solar_Loads_Controller_SLCM_V1.c,811 :: 		}
	JMP        L_Read_Battery339
L_Read_Battery340:
;Solar_Loads_Controller_SLCM_V1.c,812 :: 		Vin_Battery= sum/10.0 ;
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
;Solar_Loads_Controller_SLCM_V1.c,814 :: 		}
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

;Solar_Loads_Controller_SLCM_V1.c,817 :: 		void Start_Timer_0_A()
;Solar_Loads_Controller_SLCM_V1.c,819 :: 		WGM00_bit=0;
	IN         R27, WGM00_bit+0
	CBR        R27, BitMask(WGM00_bit+0)
	OUT        WGM00_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,820 :: 		WGM01_bit=0;
	IN         R27, WGM01_bit+0
	CBR        R27, BitMask(WGM01_bit+0)
	OUT        WGM01_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,821 :: 		CS00_bit=1; // prescalar 1024
	IN         R27, CS00_bit+0
	SBR        R27, BitMask(CS00_bit+0)
	OUT        CS00_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,822 :: 		CS02_bit=1; //prescalar 1024
	IN         R27, CS02_bit+0
	SBR        R27, BitMask(CS02_bit+0)
	OUT        CS02_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,823 :: 		SREG_I_Bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,824 :: 		OCR0=0xFF;
	LDI        R27, 255
	OUT        OCR0+0, R27
;Solar_Loads_Controller_SLCM_V1.c,825 :: 		OCIE0_Bit=1;
	IN         R27, OCIE0_bit+0
	SBR        R27, BitMask(OCIE0_bit+0)
	OUT        OCIE0_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,826 :: 		}
L_end_Start_Timer_0_A:
	RET
; end of _Start_Timer_0_A

_Interupt_Timer_0_OFFTime:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Loads_Controller_SLCM_V1.c,829 :: 		void Interupt_Timer_0_OFFTime() iv IVT_ADDR_TIMER0_COMP
;Solar_Loads_Controller_SLCM_V1.c,831 :: 		SREG_I_Bit=0; // disable interrupts
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,832 :: 		Timer_Counter_3++;                // timer for battery voltage
	LDS        R16, _Timer_Counter_3+0
	LDS        R17, _Timer_Counter_3+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _Timer_Counter_3+0, R18
	STS        _Timer_Counter_3+1, R19
;Solar_Loads_Controller_SLCM_V1.c,833 :: 		Timer_Counter_4++;
	LDS        R16, _Timer_Counter_4+0
	LDS        R17, _Timer_Counter_4+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Timer_Counter_4+0, R16
	STS        _Timer_Counter_4+1, R17
;Solar_Loads_Controller_SLCM_V1.c,834 :: 		Timer_Counter_For_Grid_Turn_Off++;
	LDS        R16, _Timer_Counter_For_Grid_Turn_Off+0
	LDS        R17, _Timer_Counter_For_Grid_Turn_Off+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Timer_Counter_For_Grid_Turn_Off+0, R16
	STS        _Timer_Counter_For_Grid_Turn_Off+1, R17
;Solar_Loads_Controller_SLCM_V1.c,837 :: 		if (Timer_Counter_3==500)              // more than 10 seconds
	CPI        R19, 1
	BRNE       L__Interupt_Timer_0_OFFTime637
	CPI        R18, 244
L__Interupt_Timer_0_OFFTime637:
	BREQ       L__Interupt_Timer_0_OFFTime638
	JMP        L_Interupt_Timer_0_OFFTime342
L__Interupt_Timer_0_OFFTime638:
;Solar_Loads_Controller_SLCM_V1.c,839 :: 		if(Vin_Battery<Mini_Battery_Voltage && AC_Available==1)
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
	BREQ       L__Interupt_Timer_0_OFFTime639
	LDI        R16, 1
L__Interupt_Timer_0_OFFTime639:
	TST        R16
	BRNE       L__Interupt_Timer_0_OFFTime640
	JMP        L__Interupt_Timer_0_OFFTime512
L__Interupt_Timer_0_OFFTime640:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Interupt_Timer_0_OFFTime511
L__Interupt_Timer_0_OFFTime510:
;Solar_Loads_Controller_SLCM_V1.c,841 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,842 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Interupt_Timer_0_OFFTime346:
	DEC        R16
	BRNE       L_Interupt_Timer_0_OFFTime346
	DEC        R17
	BRNE       L_Interupt_Timer_0_OFFTime346
	DEC        R18
	BRNE       L_Interupt_Timer_0_OFFTime346
	NOP
;Solar_Loads_Controller_SLCM_V1.c,843 :: 		Relay_L_Solar=0;
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,839 :: 		if(Vin_Battery<Mini_Battery_Voltage && AC_Available==1)
L__Interupt_Timer_0_OFFTime512:
L__Interupt_Timer_0_OFFTime511:
;Solar_Loads_Controller_SLCM_V1.c,846 :: 		Timer_Counter_3=0;
	LDI        R27, 0
	STS        _Timer_Counter_3+0, R27
	STS        _Timer_Counter_3+1, R27
;Solar_Loads_Controller_SLCM_V1.c,847 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Loads_Controller_SLCM_V1.c,848 :: 		}
L_Interupt_Timer_0_OFFTime342:
;Solar_Loads_Controller_SLCM_V1.c,852 :: 		if (Timer_Counter_For_Grid_Turn_Off==1000)
	LDS        R16, _Timer_Counter_For_Grid_Turn_Off+0
	LDS        R17, _Timer_Counter_For_Grid_Turn_Off+1
	CPI        R17, 3
	BRNE       L__Interupt_Timer_0_OFFTime641
	CPI        R16, 232
L__Interupt_Timer_0_OFFTime641:
	BREQ       L__Interupt_Timer_0_OFFTime642
	JMP        L_Interupt_Timer_0_OFFTime348
L__Interupt_Timer_0_OFFTime642:
;Solar_Loads_Controller_SLCM_V1.c,854 :: 		if(AC_Available==0)
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L_Interupt_Timer_0_OFFTime349
;Solar_Loads_Controller_SLCM_V1.c,856 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,857 :: 		Relay_L_Solar=0;
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,858 :: 		}
L_Interupt_Timer_0_OFFTime349:
;Solar_Loads_Controller_SLCM_V1.c,859 :: 		Timer_Counter_For_Grid_Turn_Off=0;
	LDI        R27, 0
	STS        _Timer_Counter_For_Grid_Turn_Off+0, R27
	STS        _Timer_Counter_For_Grid_Turn_Off+1, R27
;Solar_Loads_Controller_SLCM_V1.c,860 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Loads_Controller_SLCM_V1.c,861 :: 		}
L_Interupt_Timer_0_OFFTime348:
;Solar_Loads_Controller_SLCM_V1.c,863 :: 		SREG_I_Bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,864 :: 		OCF0_Bit=1; // clear
	IN         R27, OCF0_bit+0
	SBR        R27, BitMask(OCF0_bit+0)
	OUT        OCF0_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,865 :: 		}
L_end_Interupt_Timer_0_OFFTime:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Interupt_Timer_0_OFFTime

_Stop_Timer_0:

;Solar_Loads_Controller_SLCM_V1.c,867 :: 		void Stop_Timer_0()
;Solar_Loads_Controller_SLCM_V1.c,869 :: 		CS00_bit=0;
	IN         R27, CS00_bit+0
	CBR        R27, BitMask(CS00_bit+0)
	OUT        CS00_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,870 :: 		CS01_bit=0;
	IN         R27, CS01_bit+0
	CBR        R27, BitMask(CS01_bit+0)
	OUT        CS01_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,871 :: 		CS02_bit=0;
	IN         R27, CS02_bit+0
	CBR        R27, BitMask(CS02_bit+0)
	OUT        CS02_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,872 :: 		}
L_end_Stop_Timer_0:
	RET
; end of _Stop_Timer_0

_EEPROM_FactorySettings:

;Solar_Loads_Controller_SLCM_V1.c,875 :: 		void EEPROM_FactorySettings(char period)
;Solar_Loads_Controller_SLCM_V1.c,877 :: 		if(period==1) // summer  timer
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, 1
	CP         R2, R27
	BREQ       L__EEPROM_FactorySettings645
	JMP        L_EEPROM_FactorySettings350
L__EEPROM_FactorySettings645:
;Solar_Loads_Controller_SLCM_V1.c,879 :: 		Mini_Battery_Voltage=24.5,
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	LDI        R27, 196
	STS        _Mini_Battery_Voltage+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage+3, R27
;Solar_Loads_Controller_SLCM_V1.c,880 :: 		StartLoadsVoltage=26.5,
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	LDI        R27, 212
	STS        _StartLoadsVoltage+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage+3, R27
;Solar_Loads_Controller_SLCM_V1.c,881 :: 		startupTIme_1 =180,
	LDI        R27, 180
	STS        _startupTIme_1+0, R27
	LDI        R27, 0
	STS        _startupTIme_1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,883 :: 		EEPROM_Write(0x00,8);  // writing start hours
	LDI        R27, 8
	MOV        R4, R27
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,884 :: 		EEPROM_Write(0x01,0);    // writing  start minutes
	CLR        R4
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,885 :: 		EEPROM_Write(0x02,17);    // writing off hours
	LDI        R27, 17
	MOV        R4, R27
	LDI        R27, 2
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,886 :: 		EEPROM_Write(0x03,0);    // writing off minutes
	CLR        R4
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,888 :: 		EEPROM_write(0x14,0);    // timer is on and RunOnBatteryVolatgeWithoutTimer is off
	CLR        R4
	LDI        R27, 20
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,890 :: 		StoreBytesIntoEEprom(0x04,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
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
;Solar_Loads_Controller_SLCM_V1.c,891 :: 		StoreBytesIntoEEprom(0x08,(unsigned short *)&StartLoadsVoltage,4);
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
;Solar_Loads_Controller_SLCM_V1.c,892 :: 		StoreBytesIntoEEprom(0x12,(unsigned short *)&startupTIme_1,2);
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
;Solar_Loads_Controller_SLCM_V1.c,893 :: 		}
L_EEPROM_FactorySettings350:
;Solar_Loads_Controller_SLCM_V1.c,894 :: 		}
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

;Solar_Loads_Controller_SLCM_V1.c,896 :: 		RunTimersNowCheck()
;Solar_Loads_Controller_SLCM_V1.c,899 :: 		if (Button(&PINA,5,1000,1 ) && Button(&PINA,6,1000,0 )) // if increment pressed for 1 second
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
	BRNE       L__RunTimersNowCheck647
	JMP        L__RunTimersNowCheck518
L__RunTimersNowCheck647:
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
	BRNE       L__RunTimersNowCheck648
	JMP        L__RunTimersNowCheck517
L__RunTimersNowCheck648:
L__RunTimersNowCheck516:
;Solar_Loads_Controller_SLCM_V1.c,901 :: 		RunLoadsByBass=1;
	LDI        R27, 1
	STS        _RunLoadsByBass+0, R27
;Solar_Loads_Controller_SLCM_V1.c,902 :: 		if (  RunLoadsByBass==1 ) Relay_L_Solar=1;
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,899 :: 		if (Button(&PINA,5,1000,1 ) && Button(&PINA,6,1000,0 )) // if increment pressed for 1 second
L__RunTimersNowCheck518:
L__RunTimersNowCheck517:
;Solar_Loads_Controller_SLCM_V1.c,905 :: 		if (Button(&PINA,6,1000,1)  && Button(&PINA,5,1000,1))     // up & Down for 1 seconds reset mode
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
	BRNE       L__RunTimersNowCheck649
	JMP        L__RunTimersNowCheck520
L__RunTimersNowCheck649:
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
	BRNE       L__RunTimersNowCheck650
	JMP        L__RunTimersNowCheck519
L__RunTimersNowCheck650:
L__RunTimersNowCheck515:
;Solar_Loads_Controller_SLCM_V1.c,907 :: 		EEPROM_FactorySettings(1);        // summer time in this version i deleted winter time
	LDI        R27, 1
	MOV        R2, R27
	CALL       _EEPROM_FactorySettings+0
;Solar_Loads_Controller_SLCM_V1.c,908 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_RunTimersNowCheck358:
	DEC        R16
	BRNE       L_RunTimersNowCheck358
	DEC        R17
	BRNE       L_RunTimersNowCheck358
	DEC        R18
	BRNE       L_RunTimersNowCheck358
;Solar_Loads_Controller_SLCM_V1.c,909 :: 		EEPROM_Load();    // read the new values from epprom
	CALL       _EEPROM_Load+0
;Solar_Loads_Controller_SLCM_V1.c,910 :: 		Delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_RunTimersNowCheck360:
	DEC        R16
	BRNE       L_RunTimersNowCheck360
	DEC        R17
	BRNE       L_RunTimersNowCheck360
	DEC        R18
	BRNE       L_RunTimersNowCheck360
	NOP
	NOP
	NOP
	NOP
;Solar_Loads_Controller_SLCM_V1.c,911 :: 		while(1)
L_RunTimersNowCheck362:
;Solar_Loads_Controller_SLCM_V1.c,913 :: 		Display_On_7Segment_Character(0x88,0x92,0xB8);     //RST
	LDI        R27, 184
	MOV        R4, R27
	LDI        R27, 146
	MOV        R3, R27
	LDI        R27, 136
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,914 :: 		}
	JMP        L_RunTimersNowCheck362
;Solar_Loads_Controller_SLCM_V1.c,905 :: 		if (Button(&PINA,6,1000,1)  && Button(&PINA,5,1000,1))     // up & Down for 1 seconds reset mode
L__RunTimersNowCheck520:
L__RunTimersNowCheck519:
;Solar_Loads_Controller_SLCM_V1.c,919 :: 		if(Decrement==1 && Increment==0)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L__RunTimersNowCheck524
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__RunTimersNowCheck523
L__RunTimersNowCheck514:
;Solar_Loads_Controller_SLCM_V1.c,921 :: 		Delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_RunTimersNowCheck369:
	DEC        R16
	BRNE       L_RunTimersNowCheck369
	DEC        R17
	BRNE       L_RunTimersNowCheck369
	DEC        R18
	BRNE       L_RunTimersNowCheck369
	NOP
	NOP
	NOP
	NOP
;Solar_Loads_Controller_SLCM_V1.c,922 :: 		if (Decrement==1 && Increment==0 )
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L__RunTimersNowCheck522
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__RunTimersNowCheck521
L__RunTimersNowCheck513:
;Solar_Loads_Controller_SLCM_V1.c,924 :: 		TurnOffLoadsByPass=1;
	LDI        R27, 1
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Loads_Controller_SLCM_V1.c,925 :: 		RunLoadsByBass=0;
	LDI        R27, 0
	STS        _RunLoadsByBass+0, R27
;Solar_Loads_Controller_SLCM_V1.c,926 :: 		Relay_L_Solar=0;
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,922 :: 		if (Decrement==1 && Increment==0 )
L__RunTimersNowCheck522:
L__RunTimersNowCheck521:
;Solar_Loads_Controller_SLCM_V1.c,919 :: 		if(Decrement==1 && Increment==0)
L__RunTimersNowCheck524:
L__RunTimersNowCheck523:
;Solar_Loads_Controller_SLCM_V1.c,929 :: 		}
L_end_RunTimersNowCheck:
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _RunTimersNowCheck

_AutoRunWithOutBatteryProtection:

;Solar_Loads_Controller_SLCM_V1.c,932 :: 		void AutoRunWithOutBatteryProtection()
;Solar_Loads_Controller_SLCM_V1.c,934 :: 		if (Vin_Battery==0)
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
	BREQ       L__AutoRunWithOutBatteryProtection652
	LDI        R16, 1
L__AutoRunWithOutBatteryProtection652:
	TST        R16
	BRNE       L__AutoRunWithOutBatteryProtection653
	JMP        L_AutoRunWithOutBatteryProtection374
L__AutoRunWithOutBatteryProtection653:
;Solar_Loads_Controller_SLCM_V1.c,936 :: 		RunWithOutBattery=true;
	LDI        R27, 1
	STS        _RunWithOutBattery+0, R27
;Solar_Loads_Controller_SLCM_V1.c,937 :: 		}
	JMP        L_AutoRunWithOutBatteryProtection375
L_AutoRunWithOutBatteryProtection374:
;Solar_Loads_Controller_SLCM_V1.c,940 :: 		RunWithOutBattery=false;
	LDI        R27, 0
	STS        _RunWithOutBattery+0, R27
;Solar_Loads_Controller_SLCM_V1.c,941 :: 		}
L_AutoRunWithOutBatteryProtection375:
;Solar_Loads_Controller_SLCM_V1.c,942 :: 		}
L_end_AutoRunWithOutBatteryProtection:
	RET
; end of _AutoRunWithOutBatteryProtection

_CheckForTimerActivationInRange:

;Solar_Loads_Controller_SLCM_V1.c,944 :: 		void CheckForTimerActivationInRange()
;Solar_Loads_Controller_SLCM_V1.c,948 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2  )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange655
	JMP        L__CheckForTimerActivationInRange529
L__CheckForTimerActivationInRange655:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange656
	JMP        L__CheckForTimerActivationInRange528
L__CheckForTimerActivationInRange656:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_2+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange657
	JMP        L__CheckForTimerActivationInRange527
L__CheckForTimerActivationInRange657:
L__CheckForTimerActivationInRange526:
;Solar_Loads_Controller_SLCM_V1.c,950 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,948 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2  )
L__CheckForTimerActivationInRange529:
L__CheckForTimerActivationInRange528:
L__CheckForTimerActivationInRange527:
;Solar_Loads_Controller_SLCM_V1.c,955 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2 )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange658
	JMP        L__CheckForTimerActivationInRange532
L__CheckForTimerActivationInRange658:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange659
	JMP        L__CheckForTimerActivationInRange531
L__CheckForTimerActivationInRange659:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_2+0
	CP         R16, R17
	BREQ       L__CheckForTimerActivationInRange660
	JMP        L__CheckForTimerActivationInRange530
L__CheckForTimerActivationInRange660:
L__CheckForTimerActivationInRange525:
;Solar_Loads_Controller_SLCM_V1.c,958 :: 		if(ReadMinutes() < minutes_lcd_2)        // starts the load
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_2+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange661
	JMP        L_CheckForTimerActivationInRange382
L__CheckForTimerActivationInRange661:
;Solar_Loads_Controller_SLCM_V1.c,960 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,961 :: 		}
L_CheckForTimerActivationInRange382:
;Solar_Loads_Controller_SLCM_V1.c,955 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2 )
L__CheckForTimerActivationInRange532:
L__CheckForTimerActivationInRange531:
L__CheckForTimerActivationInRange530:
;Solar_Loads_Controller_SLCM_V1.c,963 :: 		}  // end function
L_end_CheckForTimerActivationInRange:
	RET
; end of _CheckForTimerActivationInRange

_TurnLoadsOffWhenGridOff:

;Solar_Loads_Controller_SLCM_V1.c,966 :: 		void TurnLoadsOffWhenGridOff()
;Solar_Loads_Controller_SLCM_V1.c,969 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__TurnLoadsOffWhenGridOff536
	LDS        R16, _Timer_isOn+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff663
	JMP        L__TurnLoadsOffWhenGridOff535
L__TurnLoadsOffWhenGridOff663:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff664
	JMP        L__TurnLoadsOffWhenGridOff534
L__TurnLoadsOffWhenGridOff664:
L__TurnLoadsOffWhenGridOff533:
;Solar_Loads_Controller_SLCM_V1.c,971 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,972 :: 		Relay_L_Solar=0;
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,969 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 )
L__TurnLoadsOffWhenGridOff536:
L__TurnLoadsOffWhenGridOff535:
L__TurnLoadsOffWhenGridOff534:
;Solar_Loads_Controller_SLCM_V1.c,974 :: 		}
L_end_TurnLoadsOffWhenGridOff:
	RET
; end of _TurnLoadsOffWhenGridOff

_Display_On_7Segment_Battery:

;Solar_Loads_Controller_SLCM_V1.c,978 :: 		void Display_On_7Segment_Battery(float num)
;Solar_Loads_Controller_SLCM_V1.c,981 :: 		num = num*10;      //(Becuase there is just three digits that i want to Display
	MOVW       R16, R2
	MOVW       R18, R4
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 32
	LDI        R23, 65
	CALL       _float_fpmul1+0
	MOVW       R2, R16
	MOVW       R4, R18
;Solar_Loads_Controller_SLCM_V1.c,982 :: 		voltage_int=(int)num;      // Convert the Value to Int and Display just three Digits
	CALL       _float_fpint+0
	STS        _voltage_int+0, R16
	STS        _voltage_int+1, R17
;Solar_Loads_Controller_SLCM_V1.c,983 :: 		a=voltage_int%10;    //3th digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _a+0, R16
	STS        _a+1, R17
;Solar_Loads_Controller_SLCM_V1.c,984 :: 		b=voltage_int/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _voltage_int+0
	LDS        R17, _voltage_int+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _b+0, R16
	STS        _b+1, R17
;Solar_Loads_Controller_SLCM_V1.c,985 :: 		c=b%10;       //2rd digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _c+0, R16
	STS        _c+1, R17
;Solar_Loads_Controller_SLCM_V1.c,986 :: 		d=b/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _b+0
	LDS        R17, _b+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _d+0, R16
	STS        _d+1, R17
;Solar_Loads_Controller_SLCM_V1.c,987 :: 		e=d%10;      //1nd digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _e+0, R16
	STS        _e+1, R17
;Solar_Loads_Controller_SLCM_V1.c,988 :: 		f=d/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _d+0
	LDS        R17, _d+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _f+0, R16
	STS        _f+1, R17
;Solar_Loads_Controller_SLCM_V1.c,989 :: 		Display_3=1;    // 3 th digit
	IN         R27, PORTC+0
	SBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,990 :: 		PORTB=array[a];
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _a+0
	LDS        R17, _a+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,991 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Battery386:
	DEC        R16
	BRNE       L_Display_On_7Segment_Battery386
	DEC        R17
	BRNE       L_Display_On_7Segment_Battery386
;Solar_Loads_Controller_SLCM_V1.c,992 :: 		Display_3=0;
	IN         R27, PORTC+0
	CBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,993 :: 		Display_2=1;
	IN         R27, PORTC+0
	SBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,994 :: 		PORTB=array[c] & 0x7F;   // second    7F for turning on dp
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
;Solar_Loads_Controller_SLCM_V1.c,995 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Battery388:
	DEC        R16
	BRNE       L_Display_On_7Segment_Battery388
	DEC        R17
	BRNE       L_Display_On_7Segment_Battery388
;Solar_Loads_Controller_SLCM_V1.c,996 :: 		Display_2=0;
	IN         R27, PORTC+0
	CBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,997 :: 		if ( e!=0)  // if num=8.1 it will show 08.1 on 7 segment
	LDS        R16, _e+0
	LDS        R17, _e+1
	CPI        R17, 0
	BRNE       L__Display_On_7Segment_Battery666
	CPI        R16, 0
L__Display_On_7Segment_Battery666:
	BRNE       L__Display_On_7Segment_Battery667
	JMP        L_Display_On_7Segment_Battery390
L__Display_On_7Segment_Battery667:
;Solar_Loads_Controller_SLCM_V1.c,999 :: 		Display_1=1;
	IN         R27, PORTC+0
	SBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1000 :: 		PORTB=array[e];
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _e+0
	LDS        R17, _e+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1001 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Battery391:
	DEC        R16
	BRNE       L_Display_On_7Segment_Battery391
	DEC        R17
	BRNE       L_Display_On_7Segment_Battery391
;Solar_Loads_Controller_SLCM_V1.c,1002 :: 		Display_1=0;
	IN         R27, PORTC+0
	CBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1003 :: 		}
	JMP        L_Display_On_7Segment_Battery393
L_Display_On_7Segment_Battery390:
;Solar_Loads_Controller_SLCM_V1.c,1006 :: 		Display_1=0;
	IN         R27, PORTC+0
	CBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1007 :: 		}
L_Display_On_7Segment_Battery393:
;Solar_Loads_Controller_SLCM_V1.c,1008 :: 		}
L_end_Display_On_7Segment_Battery:
	RET
; end of _Display_On_7Segment_Battery

_Display_On_7Segment:

;Solar_Loads_Controller_SLCM_V1.c,1010 :: 		void Display_On_7Segment(unsigned short number)
;Solar_Loads_Controller_SLCM_V1.c,1012 :: 		number=number;
;Solar_Loads_Controller_SLCM_V1.c,1013 :: 		a=number%10;    //3th digit is saved here
	LDI        R20, 10
	MOV        R16, R2
	CALL       _Div_8x8_U+0
	MOV        R16, R25
	STS        _a+0, R16
	LDI        R27, 0
	STS        _a+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1014 :: 		b=number/10;
	LDI        R20, 10
	MOV        R16, R2
	CALL       _Div_8x8_U+0
	STS        _b+0, R16
	LDI        R27, 0
	STS        _b+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1015 :: 		c=b%10;       //2rd digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _b+0
	LDS        R17, _b+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _c+0, R16
	STS        _c+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1016 :: 		d=b/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _b+0
	LDS        R17, _b+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _d+0, R16
	STS        _d+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1017 :: 		e=d%10;      //1nd digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _e+0, R16
	STS        _e+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1018 :: 		f=d/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _d+0
	LDS        R17, _d+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _f+0, R16
	STS        _f+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1019 :: 		Display_3=1;    // 3 th digit
	IN         R27, PORTC+0
	SBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1020 :: 		PORTB=array[a];
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _a+0
	LDS        R17, _a+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1021 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment394:
	DEC        R16
	BRNE       L_Display_On_7Segment394
	DEC        R17
	BRNE       L_Display_On_7Segment394
;Solar_Loads_Controller_SLCM_V1.c,1022 :: 		Display_3=0;
	IN         R27, PORTC+0
	CBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1023 :: 		Display_2=1;
	IN         R27, PORTC+0
	SBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1024 :: 		PORTB=array[c] ;   // second    7F for turning on dp
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _c+0
	LDS        R17, _c+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1025 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment396:
	DEC        R16
	BRNE       L_Display_On_7Segment396
	DEC        R17
	BRNE       L_Display_On_7Segment396
;Solar_Loads_Controller_SLCM_V1.c,1026 :: 		Display_2=0;
	IN         R27, PORTC+0
	CBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1027 :: 		Display_1=1;
	IN         R27, PORTC+0
	SBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1028 :: 		PORTB=array[e];
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _e+0
	LDS        R17, _e+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1029 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment398:
	DEC        R16
	BRNE       L_Display_On_7Segment398
	DEC        R17
	BRNE       L_Display_On_7Segment398
;Solar_Loads_Controller_SLCM_V1.c,1030 :: 		Display_1=0;
	IN         R27, PORTC+0
	CBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1031 :: 		}
L_end_Display_On_7Segment:
	RET
; end of _Display_On_7Segment

_Display_On_7Segment_Float:

;Solar_Loads_Controller_SLCM_V1.c,1033 :: 		void Display_On_7Segment_Float(float number)
;Solar_Loads_Controller_SLCM_V1.c,1036 :: 		number=number*10;
	MOVW       R16, R2
	MOVW       R18, R4
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 32
	LDI        R23, 65
	CALL       _float_fpmul1+0
	MOVW       R2, R16
	MOVW       R4, R18
;Solar_Loads_Controller_SLCM_V1.c,1037 :: 		convertedNum=(int)Number;
	CALL       _float_fpint+0
; convertedNum start address is: 18 (R18)
	MOVW       R18, R16
;Solar_Loads_Controller_SLCM_V1.c,1038 :: 		a=convertedNum%10;    //3th digit is saved here
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
;Solar_Loads_Controller_SLCM_V1.c,1039 :: 		b=convertedNum/10;
	MOVW       R16, R18
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
; convertedNum end address is: 18 (R18)
	STS        _b+0, R16
	STS        _b+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1040 :: 		c=b%10;       //2rd digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _c+0, R16
	STS        _c+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1041 :: 		d=b/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _b+0
	LDS        R17, _b+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _d+0, R16
	STS        _d+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1042 :: 		e=d%10;      //1nd digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _e+0, R16
	STS        _e+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1043 :: 		f=d/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _d+0
	LDS        R17, _d+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _f+0, R16
	STS        _f+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1044 :: 		Display_3=1;    // 3 th digit
	IN         R27, PORTC+0
	SBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1045 :: 		PORTB=array[a];
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _a+0
	LDS        R17, _a+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1046 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Float400:
	DEC        R16
	BRNE       L_Display_On_7Segment_Float400
	DEC        R17
	BRNE       L_Display_On_7Segment_Float400
;Solar_Loads_Controller_SLCM_V1.c,1047 :: 		Display_3=0;
	IN         R27, PORTC+0
	CBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1048 :: 		Display_2=1;
	IN         R27, PORTC+0
	SBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1049 :: 		PORTB=array[c] &0x7F ;   // second    7F for turning on dp
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
;Solar_Loads_Controller_SLCM_V1.c,1050 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Float402:
	DEC        R16
	BRNE       L_Display_On_7Segment_Float402
	DEC        R17
	BRNE       L_Display_On_7Segment_Float402
;Solar_Loads_Controller_SLCM_V1.c,1051 :: 		Display_2=0;
	IN         R27, PORTC+0
	CBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1052 :: 		Display_1=1;
	IN         R27, PORTC+0
	SBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1053 :: 		PORTB=array[e];
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _e+0
	LDS        R17, _e+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1054 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Float404:
	DEC        R16
	BRNE       L_Display_On_7Segment_Float404
	DEC        R17
	BRNE       L_Display_On_7Segment_Float404
;Solar_Loads_Controller_SLCM_V1.c,1055 :: 		Display_1=0;
	IN         R27, PORTC+0
	CBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1056 :: 		}
L_end_Display_On_7Segment_Float:
	RET
; end of _Display_On_7Segment_Float

_Display_On_7Segment_Character:

;Solar_Loads_Controller_SLCM_V1.c,1059 :: 		void Display_On_7Segment_Character(char chr1,char chr2,char chr3)
;Solar_Loads_Controller_SLCM_V1.c,1061 :: 		Display_3=1;    // 3 th digit
	IN         R27, PORTC+0
	SBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1062 :: 		PORTB=chr3;
	OUT        PORTB+0, R4
;Solar_Loads_Controller_SLCM_V1.c,1063 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Character406:
	DEC        R16
	BRNE       L_Display_On_7Segment_Character406
	DEC        R17
	BRNE       L_Display_On_7Segment_Character406
;Solar_Loads_Controller_SLCM_V1.c,1064 :: 		Display_3=0;
	IN         R27, PORTC+0
	CBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1065 :: 		Display_2=1;
	IN         R27, PORTC+0
	SBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1066 :: 		PORTB=chr2 ;   // second    7F for turning on dp
	OUT        PORTB+0, R3
;Solar_Loads_Controller_SLCM_V1.c,1067 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Character408:
	DEC        R16
	BRNE       L_Display_On_7Segment_Character408
	DEC        R17
	BRNE       L_Display_On_7Segment_Character408
;Solar_Loads_Controller_SLCM_V1.c,1068 :: 		Display_2=0;
	IN         R27, PORTC+0
	CBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1069 :: 		Display_1=1;
	IN         R27, PORTC+0
	SBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1070 :: 		PORTB=chr1;
	OUT        PORTB+0, R2
;Solar_Loads_Controller_SLCM_V1.c,1071 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Character410:
	DEC        R16
	BRNE       L_Display_On_7Segment_Character410
	DEC        R17
	BRNE       L_Display_On_7Segment_Character410
;Solar_Loads_Controller_SLCM_V1.c,1072 :: 		Display_1=0;
	IN         R27, PORTC+0
	CBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1073 :: 		}
L_end_Display_On_7Segment_Character:
	RET
; end of _Display_On_7Segment_Character

_Timer_2_Init_Screen:

;Solar_Loads_Controller_SLCM_V1.c,1075 :: 		void Timer_2_Init_Screen()
;Solar_Loads_Controller_SLCM_V1.c,1083 :: 		SREG_I_bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1084 :: 		TCCR2|= (1<<WGM21);   //choosing compare output mode for timer 2
	IN         R27, TCCR2+0
	SBR        R27, 8
	OUT        TCCR2+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1085 :: 		TCCR2|=(1<<CS22) | (1 <<CS21 ) | ( 1<< CS20) ;    //choosing 1024 prescalar so we can get 1 ms delay for updating Dipslay
	IN         R16, TCCR2+0
	ORI        R16, 7
	OUT        TCCR2+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1086 :: 		OCR2=80;
	LDI        R27, 80
	OUT        OCR2+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1087 :: 		TIMSK |= (1<<OCIE2);     //enabling interrupt
	IN         R16, TIMSK+0
	ORI        R16, 128
	OUT        TIMSK+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1088 :: 		TIMSK |=(1<<OCF2);
	ORI        R16, 128
	OUT        TIMSK+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1089 :: 		}
L_end_Timer_2_Init_Screen:
	RET
; end of _Timer_2_Init_Screen

_Timer_Interrupt_UpdateScreen:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Loads_Controller_SLCM_V1.c,1091 :: 		void Timer_Interrupt_UpdateScreen() iv IVT_ADDR_TIMER2_COMP
;Solar_Loads_Controller_SLCM_V1.c,1093 :: 		Display_On_7Segment_Battery(Vin_Battery); // update display
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDS        R2, _Vin_Battery+0
	LDS        R3, _Vin_Battery+1
	LDS        R4, _Vin_Battery+2
	LDS        R5, _Vin_Battery+3
	CALL       _Display_On_7Segment_Battery+0
;Solar_Loads_Controller_SLCM_V1.c,1095 :: 		OCF1A_bit=1;               //clear flag
	IN         R27, OCF1A_bit+0
	SBR        R27, BitMask(OCF1A_bit+0)
	OUT        OCF1A_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1097 :: 		}
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

;Solar_Loads_Controller_SLCM_V1.c,1099 :: 		void CheckForSet()
;Solar_Loads_Controller_SLCM_V1.c,1101 :: 		SREG_I_Bit=0; // disable interrupts
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1102 :: 		if (Button(&PIND,3,1000,1 ))
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
	BRNE       L__CheckForSet674
	JMP        L_CheckForSet412
L__CheckForSet674:
;Solar_Loads_Controller_SLCM_V1.c,1104 :: 		SetUpProgram();
	CALL       _SetUpProgram+0
;Solar_Loads_Controller_SLCM_V1.c,1105 :: 		}
L_CheckForSet412:
;Solar_Loads_Controller_SLCM_V1.c,1106 :: 		SREG_I_Bit=1; // disable interrupts
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1107 :: 		}
L_end_CheckForSet:
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _CheckForSet

_Config_Interrupts:

;Solar_Loads_Controller_SLCM_V1.c,1110 :: 		void Config_Interrupts()
;Solar_Loads_Controller_SLCM_V1.c,1112 :: 		ISC10_bit=1;   // Config interrupts for setup program
	IN         R27, ISC10_bit+0
	SBR        R27, BitMask(ISC10_bit+0)
	OUT        ISC10_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1113 :: 		ISC11_bit=1;   // Config interrupts for setup program
	IN         R27, ISC11_bit+0
	SBR        R27, BitMask(ISC11_bit+0)
	OUT        ISC11_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1114 :: 		ISC00_bit=1;   //config interrupts for shutting loads off when grid is off
	IN         R27, ISC00_bit+0
	SBR        R27, BitMask(ISC00_bit+0)
	OUT        ISC00_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1115 :: 		ISC01_bit=1;   //config interrupts for shutting loads off when grid is off
	IN         R27, ISC01_bit+0
	SBR        R27, BitMask(ISC01_bit+0)
	OUT        ISC01_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1116 :: 		INT1_bit=1;
	IN         R27, INT1_bit+0
	SBR        R27, BitMask(INT1_bit+0)
	OUT        INT1_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1117 :: 		INT0_bit=1;
	IN         R27, INT0_bit+0
	SBR        R27, BitMask(INT0_bit+0)
	OUT        INT0_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1118 :: 		SREG_I_bit=1; // enable the global interrupt vector
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1119 :: 		}
L_end_Config_Interrupts:
	RET
; end of _Config_Interrupts

_Interrupt_INT1:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Loads_Controller_SLCM_V1.c,1122 :: 		void Interrupt_INT1 () iv IVT_ADDR_INT1
;Solar_Loads_Controller_SLCM_V1.c,1124 :: 		SREG_I_Bit=0; // disable interrupts
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1125 :: 		SetUpProgram();
	CALL       _SetUpProgram+0
;Solar_Loads_Controller_SLCM_V1.c,1126 :: 		SREG_I_Bit=1; // disable interrupts
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1127 :: 		INTF1_bit=1;     //clear  flag
	IN         R27, INTF1_bit+0
	SBR        R27, BitMask(INTF1_bit+0)
	OUT        INTF1_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1128 :: 		}
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

;Solar_Loads_Controller_SLCM_V1.c,1130 :: 		void Interrupt_INT0_GridOFF() iv IVT_ADDR_INT0
;Solar_Loads_Controller_SLCM_V1.c,1135 :: 		SREG_I_Bit=0; // disable interrupts
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1136 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Interrupt_INT0_GridOFF540
	LDS        R16, _Timer_isOn+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT0_GridOFF678
	JMP        L__Interrupt_INT0_GridOFF539
L__Interrupt_INT0_GridOFF678:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT0_GridOFF679
	JMP        L__Interrupt_INT0_GridOFF538
L__Interrupt_INT0_GridOFF679:
L__Interrupt_INT0_GridOFF537:
;Solar_Loads_Controller_SLCM_V1.c,1138 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1139 :: 		Relay_L_Solar=0;
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1136 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 )
L__Interrupt_INT0_GridOFF540:
L__Interrupt_INT0_GridOFF539:
L__Interrupt_INT0_GridOFF538:
;Solar_Loads_Controller_SLCM_V1.c,1141 :: 		SREG_I_Bit=1; // enable interrupts
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1142 :: 		INTF0_bit=1; // clear flag
	IN         R27, INTF0_bit+0
	SBR        R27, BitMask(INTF0_bit+0)
	OUT        INTF0_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1143 :: 		}
L_end_Interrupt_INT0_GridOFF:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Interrupt_INT0_GridOFF

_Timer_1_A_ReadBattery_Init:

;Solar_Loads_Controller_SLCM_V1.c,1146 :: 		void Timer_1_A_ReadBattery_Init()
;Solar_Loads_Controller_SLCM_V1.c,1148 :: 		SREG_I_bit=1 ;   // i already enabled interrupts in vl53l0x but just for make sure
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1149 :: 		WGM10_bit=0;
	IN         R27, WGM10_bit+0
	CBR        R27, BitMask(WGM10_bit+0)
	OUT        WGM10_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1150 :: 		WGM11_bit=0;
	IN         R27, WGM11_bit+0
	CBR        R27, BitMask(WGM11_bit+0)
	OUT        WGM11_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1151 :: 		WGM12_bit=1;
	IN         R27, WGM12_bit+0
	SBR        R27, BitMask(WGM12_bit+0)
	OUT        WGM12_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1152 :: 		WGM13_bit=0;    //mode 4 ctc mode OCR1A top
	IN         R27, WGM13_bit+0
	CBR        R27, BitMask(WGM13_bit+0)
	OUT        WGM13_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1153 :: 		CS12_bit=1;    //prescalr 1024
	IN         R27, CS12_bit+0
	SBR        R27, BitMask(CS12_bit+0)
	OUT        CS12_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1154 :: 		CS10_Bit=1;    //prescalr 1024
	IN         R27, CS10_bit+0
	SBR        R27, BitMask(CS10_bit+0)
	OUT        CS10_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1155 :: 		OCR1AH=0x1E;     //writing high bit first
	LDI        R27, 30
	OUT        OCR1AH+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1156 :: 		OCR1AL=0x84;     //writing high bit first
	LDI        R27, 132
	OUT        OCR1AL+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1157 :: 		OCIE1A_bit=1;    //Enable Interrupts CTC Mode
	IN         R27, OCIE1A_bit+0
	SBR        R27, BitMask(OCIE1A_bit+0)
	OUT        OCIE1A_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1158 :: 		OCF1A_Bit=1;    // clear interrupt flag
	IN         R27, OCF1A_bit+0
	SBR        R27, BitMask(OCF1A_bit+0)
	OUT        OCF1A_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1159 :: 		}
L_end_Timer_1_A_ReadBattery_Init:
	RET
; end of _Timer_1_A_ReadBattery_Init

_Timer_Interrupt_ReadBattery:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Loads_Controller_SLCM_V1.c,1160 :: 		void Timer_Interrupt_ReadBattery() iv IVT_ADDR_TIMER1_COMPA
;Solar_Loads_Controller_SLCM_V1.c,1162 :: 		Read_Battery();
	CALL       _Read_Battery+0
;Solar_Loads_Controller_SLCM_V1.c,1163 :: 		OCF1A_bit=1;               //clear flag
	IN         R27, OCF1A_bit+0
	SBR        R27, BitMask(OCF1A_bit+0)
	OUT        OCF1A_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1164 :: 		}
L_end_Timer_Interrupt_ReadBattery:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Timer_Interrupt_ReadBattery

_Stop_Timer_ReadBattery:

;Solar_Loads_Controller_SLCM_V1.c,1165 :: 		void Stop_Timer_ReadBattery()
;Solar_Loads_Controller_SLCM_V1.c,1167 :: 		CS10_Bit=0;
	IN         R27, CS10_bit+0
	CBR        R27, BitMask(CS10_bit+0)
	OUT        CS10_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1168 :: 		CS11_Bit=0;
	IN         R27, CS11_bit+0
	CBR        R27, BitMask(CS11_bit+0)
	OUT        CS11_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1169 :: 		CS12_Bit=0;
	IN         R27, CS12_bit+0
	CBR        R27, BitMask(CS12_bit+0)
	OUT        CS12_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1170 :: 		}
L_end_Stop_Timer_ReadBattery:
	RET
; end of _Stop_Timer_ReadBattery

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;Solar_Loads_Controller_SLCM_V1.c,1172 :: 		void main() {
;Solar_Loads_Controller_SLCM_V1.c,1173 :: 		Config();
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	CALL       _Config+0
;Solar_Loads_Controller_SLCM_V1.c,1174 :: 		EEPROM_Load(); // load params programs
	CALL       _EEPROM_Load+0
;Solar_Loads_Controller_SLCM_V1.c,1175 :: 		ADCBattery(); // adc configuartion for adc
	CALL       _ADCBattery+0
;Solar_Loads_Controller_SLCM_V1.c,1176 :: 		TWI_Config();
	CALL       _TWI_Config+0
;Solar_Loads_Controller_SLCM_V1.c,1177 :: 		Config_Interrupts();
	CALL       _Config_Interrupts+0
;Solar_Loads_Controller_SLCM_V1.c,1178 :: 		ReadBytesFromEEprom(0x04,(unsigned short *)&Mini_Battery_Voltage,4);       // Loads will cut of this voltgage
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
;Solar_Loads_Controller_SLCM_V1.c,1179 :: 		ReadBytesFromEEprom(0x08,(unsigned short *)&StartLoadsVoltage,4);         //Loads will start based on this voltage
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
;Solar_Loads_Controller_SLCM_V1.c,1180 :: 		ReadBytesFromEEprom(0x12,(unsigned short *)&startupTIme_1,2);
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
;Solar_Loads_Controller_SLCM_V1.c,1181 :: 		Timer_2_Init_Screen();  // this timer is for update screen
	CALL       _Timer_2_Init_Screen+0
;Solar_Loads_Controller_SLCM_V1.c,1182 :: 		Timer_1_A_ReadBattery_Init(); // timer for seconds
	CALL       _Timer_1_A_ReadBattery_Init+0
;Solar_Loads_Controller_SLCM_V1.c,1183 :: 		while(1)
L_main416:
;Solar_Loads_Controller_SLCM_V1.c,1185 :: 		CheckForSet();        // done in interrupt
	CALL       _CheckForSet+0
;Solar_Loads_Controller_SLCM_V1.c,1186 :: 		CheckForTimerActivationInRange();
	CALL       _CheckForTimerActivationInRange+0
;Solar_Loads_Controller_SLCM_V1.c,1187 :: 		AutoRunWithOutBatteryProtection(); // to auto select run with battery protection or not
	CALL       _AutoRunWithOutBatteryProtection+0
;Solar_Loads_Controller_SLCM_V1.c,1188 :: 		RunTimersNowCheck();
	CALL       _RunTimersNowCheck+0
;Solar_Loads_Controller_SLCM_V1.c,1189 :: 		Screen_1();       // for reading time
	CALL       _Screen_1+0
;Solar_Loads_Controller_SLCM_V1.c,1190 :: 		Check_Timers();
	CALL       _Check_Timers+0
;Solar_Loads_Controller_SLCM_V1.c,1191 :: 		TurnLoadsOffWhenGridOff();       // sometine when grid comes fast and cut it will not make interrupt so this second check for loads off
	CALL       _TurnLoadsOffWhenGridOff+0
;Solar_Loads_Controller_SLCM_V1.c,1192 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_main418:
	DEC        R16
	BRNE       L_main418
	DEC        R17
	BRNE       L_main418
	DEC        R18
	BRNE       L_main418
	NOP
;Solar_Loads_Controller_SLCM_V1.c,1197 :: 		}
	JMP        L_main416
;Solar_Loads_Controller_SLCM_V1.c,1198 :: 		}
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
