
_Gpio_Init:

;Solar_Loads_Controller_SLCM_V1.c,163 :: 		void Gpio_Init()
;Solar_Loads_Controller_SLCM_V1.c,165 :: 		DDRB=0xFF; // set as output for 7 segment
	LDI        R27, 255
	OUT        DDRB+0, R27
;Solar_Loads_Controller_SLCM_V1.c,166 :: 		DDRC.B4=1; // display 1
	IN         R27, DDRC+0
	SBR        R27, 16
	OUT        DDRC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,167 :: 		DDRC.B5=1; // display 2
	IN         R27, DDRC+0
	SBR        R27, 32
	OUT        DDRC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,168 :: 		DDRC.B6=1; // display 3
	IN         R27, DDRC+0
	SBR        R27, 64
	OUT        DDRC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,169 :: 		DDRA.B5=0; // increment as input
	IN         R27, DDRA+0
	CBR        R27, 32
	OUT        DDRA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,170 :: 		DDRA.B6=0; // decrement as input
	IN         R27, DDRA+0
	CBR        R27, 64
	OUT        DDRA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,171 :: 		DDRD.B3=0;  // set as input
	IN         R27, DDRD+0
	CBR        R27, 8
	OUT        DDRD+0, R27
;Solar_Loads_Controller_SLCM_V1.c,172 :: 		DDRD.B2=0; // ac available as input
	IN         R27, DDRD+0
	CBR        R27, 4
	OUT        DDRD+0, R27
;Solar_Loads_Controller_SLCM_V1.c,173 :: 		DDRA.B3=1; // relay as output
	IN         R27, DDRA+0
	SBR        R27, 8
	OUT        DDRA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,174 :: 		DDRC.B3=1; // grid indicator led
	IN         R27, DDRC+0
	SBR        R27, 8
	OUT        DDRC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,175 :: 		}      //------------------------------------------------------------------------------
L_end_Gpio_Init:
	RET
; end of _Gpio_Init

_Config:

;Solar_Loads_Controller_SLCM_V1.c,176 :: 		void Config()
;Solar_Loads_Controller_SLCM_V1.c,178 :: 		GPIO_Init();
	CALL       _Gpio_Init+0
;Solar_Loads_Controller_SLCM_V1.c,179 :: 		}
L_end_Config:
	RET
; end of _Config

_Write_Time:

;Solar_Loads_Controller_SLCM_V1.c,183 :: 		void Write_Time(unsigned int seconds,unsigned int minutes,unsigned int hours)
;Solar_Loads_Controller_SLCM_V1.c,185 :: 		write_Ds1307(0x00,seconds);           //seconds
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
;Solar_Loads_Controller_SLCM_V1.c,186 :: 		write_Ds1307(0x01,minutes);          // minutes
	MOVW       R16, R4
	MOV        R3, R16
	LDI        R27, 1
	MOV        R2, R27
	CALL       _write_Ds1307+0
	POP        R6
	POP        R7
;Solar_Loads_Controller_SLCM_V1.c,187 :: 		write_Ds1307(0x02,hours); // using the 24 hour system
	MOVW       R16, R6
	MOV        R3, R16
	LDI        R27, 2
	MOV        R2, R27
	CALL       _write_Ds1307+0
;Solar_Loads_Controller_SLCM_V1.c,188 :: 		}
L_end_Write_Time:
	POP        R3
	POP        R2
	RET
; end of _Write_Time

_Write_Date:

;Solar_Loads_Controller_SLCM_V1.c,191 :: 		void Write_Date(unsigned int day, unsigned int month,unsigned int year)
;Solar_Loads_Controller_SLCM_V1.c,193 :: 		write_Ds1307(0x04,day);          //01-31
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
;Solar_Loads_Controller_SLCM_V1.c,194 :: 		Write_Ds1307(0x05,month);       //01-12
	MOVW       R16, R4
	MOV        R3, R16
	LDI        R27, 5
	MOV        R2, R27
	CALL       _write_Ds1307+0
	POP        R6
	POP        R7
;Solar_Loads_Controller_SLCM_V1.c,195 :: 		Write_Ds1307(0x06,year);       // 00-99
	MOVW       R16, R6
	MOV        R3, R16
	LDI        R27, 6
	MOV        R2, R27
	CALL       _write_Ds1307+0
;Solar_Loads_Controller_SLCM_V1.c,196 :: 		}
L_end_Write_Date:
	POP        R3
	POP        R2
	RET
; end of _Write_Date

_EEPROM_Load:

;Solar_Loads_Controller_SLCM_V1.c,198 :: 		void EEPROM_Load()
;Solar_Loads_Controller_SLCM_V1.c,201 :: 		hours_lcd_1=EEPROM_Read(0x00);
	PUSH       R2
	PUSH       R3
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_1+0, R16
;Solar_Loads_Controller_SLCM_V1.c,202 :: 		minutes_lcd_1=EEPROM_Read(0x01);
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_1+0, R16
;Solar_Loads_Controller_SLCM_V1.c,203 :: 		hours_lcd_2=EEPROM_Read(0x02);
	LDI        R27, 2
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _hours_lcd_2+0, R16
;Solar_Loads_Controller_SLCM_V1.c,204 :: 		minutes_lcd_2=EEPROM_Read(0x03);
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _minutes_lcd_2+0, R16
;Solar_Loads_Controller_SLCM_V1.c,205 :: 		RunOnBatteryVoltageWithoutTimer_Flag=EEPROM_Read(0x14);
	LDI        R27, 20
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _RunOnBatteryVoltageWithoutTimer_Flag+0, R16
;Solar_Loads_Controller_SLCM_V1.c,206 :: 		UPS_Mode=EEPROM_Read(0x17);
	LDI        R27, 23
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _UPS_Mode+0, R16
;Solar_Loads_Controller_SLCM_V1.c,207 :: 		UPO_Mode=EEPROM_Read(0x18);
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _UPO_Mode+0, R16
;Solar_Loads_Controller_SLCM_V1.c,208 :: 		addError=EEPROM_Read(0x23);
	LDI        R27, 35
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _addError+0, R16
;Solar_Loads_Controller_SLCM_V1.c,210 :: 		ByPassState=0;   // enable is zero  // delete function to be programmed for rom spac
	LDI        R27, 0
	STS        _ByPassState+0, R27
;Solar_Loads_Controller_SLCM_V1.c,211 :: 		Timer_Enable=1;      // delete function to be programmed for rom space
	LDI        R27, 1
	STS        _Timer_Enable+0, R27
;Solar_Loads_Controller_SLCM_V1.c,213 :: 		}
L_end_EEPROM_Load:
	POP        R3
	POP        R2
	RET
; end of _EEPROM_Load

_StoreBytesIntoEEprom:

;Solar_Loads_Controller_SLCM_V1.c,216 :: 		void StoreBytesIntoEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
;Solar_Loads_Controller_SLCM_V1.c,219 :: 		for (j=0;j<SizeinBytes;j++)
; j start address is: 19 (R19)
	LDI        R19, 0
	LDI        R20, 0
; j end address is: 19 (R19)
L_StoreBytesIntoEEprom0:
; j start address is: 19 (R19)
	CP         R19, R6
	CPC        R20, R7
	BRLO       L__StoreBytesIntoEEprom784
	JMP        L_StoreBytesIntoEEprom1
L__StoreBytesIntoEEprom784:
;Solar_Loads_Controller_SLCM_V1.c,221 :: 		EEprom_Write(address+j,*(ptr+j));
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
;Solar_Loads_Controller_SLCM_V1.c,222 :: 		Delay_ms(50);
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
;Solar_Loads_Controller_SLCM_V1.c,219 :: 		for (j=0;j<SizeinBytes;j++)
	MOV        R16, R19
	MOV        R17, R20
	SUBI       R16, 255
	SBCI       R17, 255
	MOV        R19, R16
	MOV        R20, R17
;Solar_Loads_Controller_SLCM_V1.c,223 :: 		};
; j end address is: 19 (R19)
	JMP        L_StoreBytesIntoEEprom0
L_StoreBytesIntoEEprom1:
;Solar_Loads_Controller_SLCM_V1.c,224 :: 		}
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

;Solar_Loads_Controller_SLCM_V1.c,227 :: 		void ReadBytesFromEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
;Solar_Loads_Controller_SLCM_V1.c,230 :: 		for (j=0;j<SizeinBytes;j++)
; j start address is: 19 (R19)
	LDI        R19, 0
	LDI        R20, 0
; j end address is: 19 (R19)
L_ReadBytesFromEEprom5:
; j start address is: 19 (R19)
	CP         R19, R6
	CPC        R20, R7
	BRLO       L__ReadBytesFromEEprom786
	JMP        L_ReadBytesFromEEprom6
L__ReadBytesFromEEprom786:
;Solar_Loads_Controller_SLCM_V1.c,232 :: 		*(ptr+j)=EEPROM_Read(address+j);
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
;Solar_Loads_Controller_SLCM_V1.c,233 :: 		Delay_ms(50);
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
;Solar_Loads_Controller_SLCM_V1.c,230 :: 		for (j=0;j<SizeinBytes;j++)
	MOV        R16, R19
	MOV        R17, R20
	SUBI       R16, 255
	SBCI       R17, 255
	MOV        R19, R16
	MOV        R20, R17
;Solar_Loads_Controller_SLCM_V1.c,234 :: 		}
; j end address is: 19 (R19)
	JMP        L_ReadBytesFromEEprom5
L_ReadBytesFromEEprom6:
;Solar_Loads_Controller_SLCM_V1.c,235 :: 		}
L_end_ReadBytesFromEEprom:
	ADIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _ReadBytesFromEEprom

_Check_Timers:

;Solar_Loads_Controller_SLCM_V1.c,237 :: 		void Check_Timers()
;Solar_Loads_Controller_SLCM_V1.c,240 :: 		if(RunOnBatteryVoltageWithoutTimer_Flag==0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers788
	JMP        L_Check_Timers10
L__Check_Timers788:
;Solar_Loads_Controller_SLCM_V1.c,242 :: 		matched_timer_1_start=CheckTimeOccuredOn(seconds_lcd_1,minutes_lcd_1,hours_lcd_1);
	LDS        R4, _hours_lcd_1+0
	LDS        R3, _minutes_lcd_1+0
	LDS        R2, _seconds_lcd_1+0
	CALL       _CheckTimeOccuredOn+0
	STS        _matched_timer_1_start+0, R16
;Solar_Loads_Controller_SLCM_V1.c,243 :: 		matched_timer_1_stop=CheckTimeOccuredOff(seconds_lcd_2,minutes_lcd_2,hours_lcd_2);
	LDS        R4, _hours_lcd_2+0
	LDS        R3, _minutes_lcd_2+0
	LDS        R2, _seconds_lcd_2+0
	CALL       _CheckTimeOccuredOff+0
	STS        _matched_timer_1_stop+0, R16
;Solar_Loads_Controller_SLCM_V1.c,246 :: 		if (matched_timer_1_start==1)
	LDS        R16, _matched_timer_1_start+0
	CPI        R16, 1
	BREQ       L__Check_Timers789
	JMP        L_Check_Timers11
L__Check_Timers789:
;Solar_Loads_Controller_SLCM_V1.c,248 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,249 :: 		TurnOffLoadsByPass=0;
	LDI        R27, 0
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Loads_Controller_SLCM_V1.c,251 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && RunOnBatteryVoltageWithoutTimer_Flag==0)
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers589
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers790
	JMP        L__Check_Timers588
L__Check_Timers790:
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
	BREQ       L__Check_Timers791
	LDI        R16, 1
L__Check_Timers791:
	TST        R16
	BRNE       L__Check_Timers792
	JMP        L__Check_Timers587
L__Check_Timers792:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers793
	JMP        L__Check_Timers586
L__Check_Timers793:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers794
	JMP        L__Check_Timers585
L__Check_Timers794:
L__Check_Timers584:
;Solar_Loads_Controller_SLCM_V1.c,253 :: 		Relay_L_Solar=1;
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,251 :: 		if (AC_Available==1 && Timer_Enable==1  && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && RunOnBatteryVoltageWithoutTimer_Flag==0)
L__Check_Timers589:
L__Check_Timers588:
L__Check_Timers587:
L__Check_Timers586:
L__Check_Timers585:
;Solar_Loads_Controller_SLCM_V1.c,257 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true && RunOnBatteryVoltageWithoutTimer_Flag==0 )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers593
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers795
	JMP        L__Check_Timers592
L__Check_Timers795:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers796
	JMP        L__Check_Timers591
L__Check_Timers796:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers797
	JMP        L__Check_Timers590
L__Check_Timers797:
L__Check_Timers583:
;Solar_Loads_Controller_SLCM_V1.c,259 :: 		Relay_L_Solar=1;
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,257 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true && RunOnBatteryVoltageWithoutTimer_Flag==0 )
L__Check_Timers593:
L__Check_Timers592:
L__Check_Timers591:
L__Check_Timers590:
;Solar_Loads_Controller_SLCM_V1.c,261 :: 		} // end if ac_available
L_Check_Timers11:
;Solar_Loads_Controller_SLCM_V1.c,264 :: 		if (matched_timer_1_stop==1)
	LDS        R16, _matched_timer_1_stop+0
	CPI        R16, 1
	BREQ       L__Check_Timers798
	JMP        L_Check_Timers18
L__Check_Timers798:
;Solar_Loads_Controller_SLCM_V1.c,266 :: 		Timer_isOn=0;        // to continue the timer after breakout the timer when grid is available
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,269 :: 		if (AC_Available==1 && Timer_Enable==1  &&  RunWithOutBattery==false  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers597
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers799
	JMP        L__Check_Timers596
L__Check_Timers799:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers800
	JMP        L__Check_Timers595
L__Check_Timers800:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers801
	JMP        L__Check_Timers594
L__Check_Timers801:
L__Check_Timers582:
;Solar_Loads_Controller_SLCM_V1.c,272 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,273 :: 		CountSecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _CountSecondsRealTimePv_ReConnect_T1+0, R27
	STS        _CountSecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,274 :: 		Relay_L_Solar=0; // relay off
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,269 :: 		if (AC_Available==1 && Timer_Enable==1  &&  RunWithOutBattery==false  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
L__Check_Timers597:
L__Check_Timers596:
L__Check_Timers595:
L__Check_Timers594:
;Solar_Loads_Controller_SLCM_V1.c,276 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers601
	LDS        R16, _Timer_Enable+0
	CPI        R16, 1
	BREQ       L__Check_Timers802
	JMP        L__Check_Timers600
L__Check_Timers802:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers803
	JMP        L__Check_Timers599
L__Check_Timers803:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers804
	JMP        L__Check_Timers598
L__Check_Timers804:
L__Check_Timers581:
;Solar_Loads_Controller_SLCM_V1.c,279 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,280 :: 		CountSecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _CountSecondsRealTimePv_ReConnect_T1+0, R27
	STS        _CountSecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,281 :: 		Relay_L_Solar=0; // relay off
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,276 :: 		if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
L__Check_Timers601:
L__Check_Timers600:
L__Check_Timers599:
L__Check_Timers598:
;Solar_Loads_Controller_SLCM_V1.c,283 :: 		}
L_Check_Timers18:
;Solar_Loads_Controller_SLCM_V1.c,284 :: 		} // runs on battery if
L_Check_Timers10:
;Solar_Loads_Controller_SLCM_V1.c,289 :: 		if(AC_Available==0 && UPO_Mode==0 )
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L__Check_Timers605
	LDS        R16, _UPO_Mode+0
	CPI        R16, 0
	BREQ       L__Check_Timers805
	JMP        L__Check_Timers604
L__Check_Timers805:
L__Check_Timers580:
;Solar_Loads_Controller_SLCM_V1.c,293 :: 		CountSecondsRealTime=1;
	LDI        R27, 1
	STS        _CountSecondsRealTime+0, R27
	LDI        R27, 0
	STS        _CountSecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,294 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
	LDS        R18, _SecondsRealTime+0
	LDS        R19, _SecondsRealTime+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R18, R16
	CPC        R19, R17
	BRSH       L__Check_Timers806
	JMP        L__Check_Timers603
L__Check_Timers806:
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L__Check_Timers602
L__Check_Timers579:
;Solar_Loads_Controller_SLCM_V1.c,296 :: 		Relay_L_Solar=1;
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,294 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
L__Check_Timers603:
L__Check_Timers602:
;Solar_Loads_Controller_SLCM_V1.c,289 :: 		if(AC_Available==0 && UPO_Mode==0 )
L__Check_Timers605:
L__Check_Timers604:
;Solar_Loads_Controller_SLCM_V1.c,301 :: 		if (AC_Available==0 && UPO_Mode==1)
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L__Check_Timers612
	LDS        R16, _UPO_Mode+0
	CPI        R16, 1
	BREQ       L__Check_Timers807
	JMP        L__Check_Timers611
L__Check_Timers807:
L__Check_Timers578:
;Solar_Loads_Controller_SLCM_V1.c,305 :: 		CountSecondsRealTime=1;
	LDI        R27, 1
	STS        _CountSecondsRealTime+0, R27
	LDI        R27, 0
	STS        _CountSecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,306 :: 		if(AC_Available==0 && LoadsAlreadySwitchedOFF==0)
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L__Check_Timers607
	LDS        R16, _LoadsAlreadySwitchedOFF+0
	CPI        R16, 0
	BREQ       L__Check_Timers808
	JMP        L__Check_Timers606
L__Check_Timers808:
L__Check_Timers577:
;Solar_Loads_Controller_SLCM_V1.c,308 :: 		LoadsAlreadySwitchedOFF=1;
	LDI        R27, 1
	STS        _LoadsAlreadySwitchedOFF+0, R27
;Solar_Loads_Controller_SLCM_V1.c,309 :: 		Relay_L_Solar=0 ;
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,306 :: 		if(AC_Available==0 && LoadsAlreadySwitchedOFF==0)
L__Check_Timers607:
L__Check_Timers606:
;Solar_Loads_Controller_SLCM_V1.c,311 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0 && LoadsAlreadySwitchedOFF==1 )
	LDS        R18, _SecondsRealTime+0
	LDS        R19, _SecondsRealTime+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R18, R16
	CPC        R19, R17
	BRSH       L__Check_Timers809
	JMP        L__Check_Timers610
L__Check_Timers809:
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L__Check_Timers609
	LDS        R16, _LoadsAlreadySwitchedOFF+0
	CPI        R16, 1
	BREQ       L__Check_Timers810
	JMP        L__Check_Timers608
L__Check_Timers810:
L__Check_Timers576:
;Solar_Loads_Controller_SLCM_V1.c,313 :: 		Relay_L_Solar=1;
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,311 :: 		if(SecondsRealTime >= startupTIme_1 && AC_Available==0 && LoadsAlreadySwitchedOFF==1 )
L__Check_Timers610:
L__Check_Timers609:
L__Check_Timers608:
;Solar_Loads_Controller_SLCM_V1.c,301 :: 		if (AC_Available==0 && UPO_Mode==1)
L__Check_Timers612:
L__Check_Timers611:
;Solar_Loads_Controller_SLCM_V1.c,321 :: 		if (AC_Available==1 && Timer_isOn==1 && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0)
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers618
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers811
	JMP        L__Check_Timers617
L__Check_Timers811:
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
	BREQ       L__Check_Timers812
	LDI        R16, 1
L__Check_Timers812:
	TST        R16
	BRNE       L__Check_Timers813
	JMP        L__Check_Timers616
L__Check_Timers813:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers814
	JMP        L__Check_Timers615
L__Check_Timers814:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers815
	JMP        L__Check_Timers614
L__Check_Timers815:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers816
	JMP        L__Check_Timers613
L__Check_Timers816:
L__Check_Timers575:
;Solar_Loads_Controller_SLCM_V1.c,325 :: 		CountSecondsRealTimePv_ReConnect_T1=1;
	LDI        R27, 1
	STS        _CountSecondsRealTimePv_ReConnect_T1+0, R27
	LDI        R27, 0
	STS        _CountSecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,327 :: 		if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1)     Relay_L_Solar=1;
	LDS        R18, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T1+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers817
	JMP        L_Check_Timers43
L__Check_Timers817:
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
L_Check_Timers43:
;Solar_Loads_Controller_SLCM_V1.c,321 :: 		if (AC_Available==1 && Timer_isOn==1 && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0)
L__Check_Timers618:
L__Check_Timers617:
L__Check_Timers616:
L__Check_Timers615:
L__Check_Timers614:
L__Check_Timers613:
;Solar_Loads_Controller_SLCM_V1.c,330 :: 		if (AC_Available==1 && Timer_isOn==1  && RunWithOutBattery==true && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0 )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers623
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Check_Timers818
	JMP        L__Check_Timers622
L__Check_Timers818:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 1
	BREQ       L__Check_Timers819
	JMP        L__Check_Timers621
L__Check_Timers819:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers820
	JMP        L__Check_Timers620
L__Check_Timers820:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers821
	JMP        L__Check_Timers619
L__Check_Timers821:
L__Check_Timers574:
;Solar_Loads_Controller_SLCM_V1.c,333 :: 		CountSecondsRealTimePv_ReConnect_T1=1;
	LDI        R27, 1
	STS        _CountSecondsRealTimePv_ReConnect_T1+0, R27
	LDI        R27, 0
	STS        _CountSecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,336 :: 		if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1) Relay_L_Solar=1;
	LDS        R18, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T1+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers822
	JMP        L_Check_Timers47
L__Check_Timers822:
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
L_Check_Timers47:
;Solar_Loads_Controller_SLCM_V1.c,330 :: 		if (AC_Available==1 && Timer_isOn==1  && RunWithOutBattery==true && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0 )
L__Check_Timers623:
L__Check_Timers622:
L__Check_Timers621:
L__Check_Timers620:
L__Check_Timers619:
;Solar_Loads_Controller_SLCM_V1.c,340 :: 		if (AC_Available==1  && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==1)
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers628
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
	BREQ       L__Check_Timers823
	LDI        R16, 1
L__Check_Timers823:
	TST        R16
	BRNE       L__Check_Timers824
	JMP        L__Check_Timers627
L__Check_Timers824:
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers825
	JMP        L__Check_Timers626
L__Check_Timers825:
	LDS        R16, _TurnOffLoadsByPass+0
	CPI        R16, 0
	BREQ       L__Check_Timers826
	JMP        L__Check_Timers625
L__Check_Timers826:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 1
	BREQ       L__Check_Timers827
	JMP        L__Check_Timers624
L__Check_Timers827:
L__Check_Timers573:
;Solar_Loads_Controller_SLCM_V1.c,343 :: 		CountSecondsRealTimePv_ReConnect_T1=1;
	LDI        R27, 1
	STS        _CountSecondsRealTimePv_ReConnect_T1+0, R27
	LDI        R27, 0
	STS        _CountSecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,345 :: 		if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1)
	LDS        R18, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R19, _SecondsRealTimePv_ReConnect_T1+1
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Check_Timers828
	JMP        L_Check_Timers51
L__Check_Timers828:
;Solar_Loads_Controller_SLCM_V1.c,347 :: 		Relay_L_Solar=1;
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,348 :: 		}
L_Check_Timers51:
;Solar_Loads_Controller_SLCM_V1.c,340 :: 		if (AC_Available==1  && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==1)
L__Check_Timers628:
L__Check_Timers627:
L__Check_Timers626:
L__Check_Timers625:
L__Check_Timers624:
;Solar_Loads_Controller_SLCM_V1.c,354 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1  && RunWithOutBattery==false && RunOnBatteryVoltageWithoutTimer_Flag==0)
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
	BREQ       L__Check_Timers829
	LDI        R16, 1
L__Check_Timers829:
	TST        R16
	BRNE       L__Check_Timers830
	JMP        L__Check_Timers632
L__Check_Timers830:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers631
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers831
	JMP        L__Check_Timers630
L__Check_Timers831:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Check_Timers832
	JMP        L__Check_Timers629
L__Check_Timers832:
L__Check_Timers572:
;Solar_Loads_Controller_SLCM_V1.c,356 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,357 :: 		CountSecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _CountSecondsRealTimePv_ReConnect_T1+0, R27
	STS        _CountSecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,358 :: 		Start_Timer_0_A();         // give some time for battery voltage
	CALL       _Start_Timer_0_A+0
;Solar_Loads_Controller_SLCM_V1.c,354 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1  && RunWithOutBattery==false && RunOnBatteryVoltageWithoutTimer_Flag==0)
L__Check_Timers632:
L__Check_Timers631:
L__Check_Timers630:
L__Check_Timers629:
;Solar_Loads_Controller_SLCM_V1.c,361 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1 && RunWithOutBattery==false && RunOnBatteryVoltageWithoutTimer_Flag==1)
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
	BREQ       L__Check_Timers833
	LDI        R16, 1
L__Check_Timers833:
	TST        R16
	BRNE       L__Check_Timers834
	JMP        L__Check_Timers636
L__Check_Timers834:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Check_Timers635
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Check_Timers835
	JMP        L__Check_Timers634
L__Check_Timers835:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 1
	BREQ       L__Check_Timers836
	JMP        L__Check_Timers633
L__Check_Timers836:
L__Check_Timers571:
;Solar_Loads_Controller_SLCM_V1.c,363 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,364 :: 		CountSecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _CountSecondsRealTimePv_ReConnect_T1+0, R27
	STS        _CountSecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,365 :: 		Start_Timer_0_A();         // give some time for battery voltage
	CALL       _Start_Timer_0_A+0
;Solar_Loads_Controller_SLCM_V1.c,361 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1 && RunWithOutBattery==false && RunOnBatteryVoltageWithoutTimer_Flag==1)
L__Check_Timers636:
L__Check_Timers635:
L__Check_Timers634:
L__Check_Timers633:
;Solar_Loads_Controller_SLCM_V1.c,368 :: 		}// end of check timers
L_end_Check_Timers:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _Check_Timers

_SetUpProgram:

;Solar_Loads_Controller_SLCM_V1.c,373 :: 		void SetUpProgram()
;Solar_Loads_Controller_SLCM_V1.c,375 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram58:
	DEC        R16
	BRNE       L_SetUpProgram58
	DEC        R17
	BRNE       L_SetUpProgram58
	DEC        R18
	BRNE       L_SetUpProgram58
	NOP
;Solar_Loads_Controller_SLCM_V1.c,378 :: 		while (Set==0)
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetUpProgram61
;Solar_Loads_Controller_SLCM_V1.c,381 :: 		SetBatteryVoltageError();
	CALL       _SetBatteryVoltageError+0
;Solar_Loads_Controller_SLCM_V1.c,382 :: 		Delay_ms(500);
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
;Solar_Loads_Controller_SLCM_V1.c,383 :: 		SetTimerOn_1();
	CALL       _SetTimerOn_1+0
;Solar_Loads_Controller_SLCM_V1.c,384 :: 		Delay_ms(500);
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
;Solar_Loads_Controller_SLCM_V1.c,385 :: 		SetTimerOff_1();
	CALL       _SetTimerOff_1+0
;Solar_Loads_Controller_SLCM_V1.c,386 :: 		Delay_ms(500);
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
;Solar_Loads_Controller_SLCM_V1.c,387 :: 		SetLowBatteryVoltage();// program 3 to set low battery voltage
	CALL       _SetLowBatteryVoltage+0
;Solar_Loads_Controller_SLCM_V1.c,388 :: 		Delay_ms(500);
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
;Solar_Loads_Controller_SLCM_V1.c,389 :: 		SetStartUpLoadsVoltage(); // program 4 to enable timer or disable
	CALL       _SetStartUpLoadsVoltage+0
;Solar_Loads_Controller_SLCM_V1.c,390 :: 		Delay_ms(500);
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
;Solar_Loads_Controller_SLCM_V1.c,391 :: 		Startup_Timers();
	CALL       _Startup_Timers+0
;Solar_Loads_Controller_SLCM_V1.c,392 :: 		Delay_ms(500);
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
;Solar_Loads_Controller_SLCM_V1.c,393 :: 		RunOnBatteryVoltageWithoutTimer();
	CALL       _RunOnBatteryVoltageWithoutTimer+0
;Solar_Loads_Controller_SLCM_V1.c,394 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram74:
	DEC        R16
	BRNE       L_SetUpProgram74
	DEC        R17
	BRNE       L_SetUpProgram74
	DEC        R18
	BRNE       L_SetUpProgram74
	NOP
;Solar_Loads_Controller_SLCM_V1.c,395 :: 		CutLoadsTime();
	CALL       _CutLoadsTime+0
;Solar_Loads_Controller_SLCM_V1.c,396 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram76:
	DEC        R16
	BRNE       L_SetUpProgram76
	DEC        R17
	BRNE       L_SetUpProgram76
	DEC        R18
	BRNE       L_SetUpProgram76
	NOP
;Solar_Loads_Controller_SLCM_V1.c,397 :: 		UPSMode();
	CALL       _UPSMode+0
;Solar_Loads_Controller_SLCM_V1.c,398 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram78:
	DEC        R16
	BRNE       L_SetUpProgram78
	DEC        R17
	BRNE       L_SetUpProgram78
	DEC        R18
	BRNE       L_SetUpProgram78
	NOP
;Solar_Loads_Controller_SLCM_V1.c,399 :: 		UPOMode();
	CALL       _UPOMode+0
;Solar_Loads_Controller_SLCM_V1.c,400 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram80:
	DEC        R16
	BRNE       L_SetUpProgram80
	DEC        R17
	BRNE       L_SetUpProgram80
	DEC        R18
	BRNE       L_SetUpProgram80
	NOP
;Solar_Loads_Controller_SLCM_V1.c,402 :: 		SetDS1307_Time();   // program 6
	CALL       _SetDS1307_Time+0
;Solar_Loads_Controller_SLCM_V1.c,403 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetUpProgram82:
	DEC        R16
	BRNE       L_SetUpProgram82
	DEC        R17
	BRNE       L_SetUpProgram82
	DEC        R18
	BRNE       L_SetUpProgram82
	NOP
;Solar_Loads_Controller_SLCM_V1.c,405 :: 		} // end while
L_SetUpProgram61:
;Solar_Loads_Controller_SLCM_V1.c,406 :: 		}
L_end_SetUpProgram:
	RET
; end of _SetUpProgram

_SetTimerOn_1:

;Solar_Loads_Controller_SLCM_V1.c,408 :: 		void SetTimerOn_1()
;Solar_Loads_Controller_SLCM_V1.c,410 :: 		Delay_ms(500);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOn_184:
	DEC        R16
	BRNE       L_SetTimerOn_184
	DEC        R17
	BRNE       L_SetTimerOn_184
	DEC        R18
	BRNE       L_SetTimerOn_184
	NOP
;Solar_Loads_Controller_SLCM_V1.c,411 :: 		while(Set==0)
L_SetTimerOn_186:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetTimerOn_187
;Solar_Loads_Controller_SLCM_V1.c,413 :: 		Display_On_7Segment_Character(0x92,0x92,0xC7);
	LDI        R27, 199
	MOV        R4, R27
	LDI        R27, 146
	MOV        R3, R27
	LDI        R27, 146
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,414 :: 		}
	JMP        L_SetTimerOn_186
L_SetTimerOn_187:
;Solar_Loads_Controller_SLCM_V1.c,415 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOn_188:
	DEC        R16
	BRNE       L_SetTimerOn_188
	DEC        R17
	BRNE       L_SetTimerOn_188
	DEC        R18
	BRNE       L_SetTimerOn_188
	NOP
;Solar_Loads_Controller_SLCM_V1.c,416 :: 		while (Set==0)
L_SetTimerOn_190:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetTimerOn_191
;Solar_Loads_Controller_SLCM_V1.c,418 :: 		Display_On_7Segment(hours_lcd_1);
	LDS        R2, _hours_lcd_1+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,420 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_192:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetTimerOn_1643
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetTimerOn_1642
	JMP        L_SetTimerOn_193
L__SetTimerOn_1643:
L__SetTimerOn_1642:
;Solar_Loads_Controller_SLCM_V1.c,422 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetTimerOn_196
;Solar_Loads_Controller_SLCM_V1.c,424 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_197:
	DEC        R16
	BRNE       L_SetTimerOn_197
	DEC        R17
	BRNE       L_SetTimerOn_197
	DEC        R18
	BRNE       L_SetTimerOn_197
	NOP
;Solar_Loads_Controller_SLCM_V1.c,425 :: 		hours_lcd_1++;
	LDS        R16, _hours_lcd_1+0
	SUBI       R16, 255
	STS        _hours_lcd_1+0, R16
;Solar_Loads_Controller_SLCM_V1.c,426 :: 		}
L_SetTimerOn_196:
;Solar_Loads_Controller_SLCM_V1.c,427 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetTimerOn_199
;Solar_Loads_Controller_SLCM_V1.c,429 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1100:
	DEC        R16
	BRNE       L_SetTimerOn_1100
	DEC        R17
	BRNE       L_SetTimerOn_1100
	DEC        R18
	BRNE       L_SetTimerOn_1100
	NOP
;Solar_Loads_Controller_SLCM_V1.c,430 :: 		hours_lcd_1--;
	LDS        R16, _hours_lcd_1+0
	SUBI       R16, 1
	STS        _hours_lcd_1+0, R16
;Solar_Loads_Controller_SLCM_V1.c,431 :: 		}
L_SetTimerOn_199:
;Solar_Loads_Controller_SLCM_V1.c,433 :: 		if  (hours_lcd_1>23) hours_lcd_1=0;
	LDS        R17, _hours_lcd_1+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOn_1839
	JMP        L_SetTimerOn_1102
L__SetTimerOn_1839:
	LDI        R27, 0
	STS        _hours_lcd_1+0, R27
L_SetTimerOn_1102:
;Solar_Loads_Controller_SLCM_V1.c,434 :: 		if  (hours_lcd_1<0) hours_lcd_1=0;
	LDS        R16, _hours_lcd_1+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_1840
	JMP        L_SetTimerOn_1103
L__SetTimerOn_1840:
	LDI        R27, 0
	STS        _hours_lcd_1+0, R27
L_SetTimerOn_1103:
;Solar_Loads_Controller_SLCM_V1.c,435 :: 		Timer_isOn=0; //
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,436 :: 		SecondsRealTimePv_ReConnect_T1=0;    //
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,437 :: 		} // end while increment
	JMP        L_SetTimerOn_192
L_SetTimerOn_193:
;Solar_Loads_Controller_SLCM_V1.c,438 :: 		} // end first while
	JMP        L_SetTimerOn_190
L_SetTimerOn_191:
;Solar_Loads_Controller_SLCM_V1.c,441 :: 		EEPROM_Write(0x00,hours_lcd_1); // save hours 1 timer tp eeprom
	LDS        R4, _hours_lcd_1+0
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,442 :: 		Delay_ms(500);     //read time for state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOn_1104:
	DEC        R16
	BRNE       L_SetTimerOn_1104
	DEC        R17
	BRNE       L_SetTimerOn_1104
	DEC        R18
	BRNE       L_SetTimerOn_1104
	NOP
;Solar_Loads_Controller_SLCM_V1.c,443 :: 		while (Set==0)
L_SetTimerOn_1106:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetTimerOn_1107
;Solar_Loads_Controller_SLCM_V1.c,445 :: 		Display_On_7Segment(minutes_lcd_1);
	LDS        R2, _minutes_lcd_1+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,447 :: 		while (Increment == 1 || Decrement==1)
L_SetTimerOn_1108:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetTimerOn_1645
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetTimerOn_1644
	JMP        L_SetTimerOn_1109
L__SetTimerOn_1645:
L__SetTimerOn_1644:
;Solar_Loads_Controller_SLCM_V1.c,449 :: 		if (Increment==1  )
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetTimerOn_1112
;Solar_Loads_Controller_SLCM_V1.c,451 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1113:
	DEC        R16
	BRNE       L_SetTimerOn_1113
	DEC        R17
	BRNE       L_SetTimerOn_1113
	DEC        R18
	BRNE       L_SetTimerOn_1113
	NOP
;Solar_Loads_Controller_SLCM_V1.c,452 :: 		minutes_lcd_1++;
	LDS        R16, _minutes_lcd_1+0
	SUBI       R16, 255
	STS        _minutes_lcd_1+0, R16
;Solar_Loads_Controller_SLCM_V1.c,453 :: 		}
L_SetTimerOn_1112:
;Solar_Loads_Controller_SLCM_V1.c,454 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetTimerOn_1115
;Solar_Loads_Controller_SLCM_V1.c,456 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOn_1116:
	DEC        R16
	BRNE       L_SetTimerOn_1116
	DEC        R17
	BRNE       L_SetTimerOn_1116
	DEC        R18
	BRNE       L_SetTimerOn_1116
	NOP
;Solar_Loads_Controller_SLCM_V1.c,457 :: 		minutes_lcd_1--;
	LDS        R16, _minutes_lcd_1+0
	SUBI       R16, 1
	STS        _minutes_lcd_1+0, R16
;Solar_Loads_Controller_SLCM_V1.c,458 :: 		}
L_SetTimerOn_1115:
;Solar_Loads_Controller_SLCM_V1.c,460 :: 		if (minutes_lcd_1>59)    minutes_lcd_1=0;
	LDS        R17, _minutes_lcd_1+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOn_1841
	JMP        L_SetTimerOn_1118
L__SetTimerOn_1841:
	LDI        R27, 0
	STS        _minutes_lcd_1+0, R27
L_SetTimerOn_1118:
;Solar_Loads_Controller_SLCM_V1.c,461 :: 		if (minutes_lcd_1<0) minutes_lcd_1=0;
	LDS        R16, _minutes_lcd_1+0
	CPI        R16, 0
	BRLO       L__SetTimerOn_1842
	JMP        L_SetTimerOn_1119
L__SetTimerOn_1842:
	LDI        R27, 0
	STS        _minutes_lcd_1+0, R27
L_SetTimerOn_1119:
;Solar_Loads_Controller_SLCM_V1.c,462 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,463 :: 		Timer_isOn=0;
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,464 :: 		} // end while increment and decrement
	JMP        L_SetTimerOn_1108
L_SetTimerOn_1109:
;Solar_Loads_Controller_SLCM_V1.c,465 :: 		} // end first while
	JMP        L_SetTimerOn_1106
L_SetTimerOn_1107:
;Solar_Loads_Controller_SLCM_V1.c,467 :: 		EEPROM_Write(0x01,minutes_lcd_1); // save minutes 1 timer tp eeprom
	LDS        R4, _minutes_lcd_1+0
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,468 :: 		}
L_end_SetTimerOn_1:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOn_1

_SetTimerOff_1:

;Solar_Loads_Controller_SLCM_V1.c,470 :: 		void SetTimerOff_1()
;Solar_Loads_Controller_SLCM_V1.c,472 :: 		Delay_ms(500);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_1120:
	DEC        R16
	BRNE       L_SetTimerOff_1120
	DEC        R17
	BRNE       L_SetTimerOff_1120
	DEC        R18
	BRNE       L_SetTimerOff_1120
	NOP
;Solar_Loads_Controller_SLCM_V1.c,473 :: 		while(Set==0)
L_SetTimerOff_1122:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetTimerOff_1123
;Solar_Loads_Controller_SLCM_V1.c,475 :: 		Display_On_7Segment_Character(0x92,0xC0,0xC7);
	LDI        R27, 199
	MOV        R4, R27
	LDI        R27, 192
	MOV        R3, R27
	LDI        R27, 146
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,476 :: 		}
	JMP        L_SetTimerOff_1122
L_SetTimerOff_1123:
;Solar_Loads_Controller_SLCM_V1.c,477 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_1124:
	DEC        R16
	BRNE       L_SetTimerOff_1124
	DEC        R17
	BRNE       L_SetTimerOff_1124
	DEC        R18
	BRNE       L_SetTimerOff_1124
	NOP
;Solar_Loads_Controller_SLCM_V1.c,479 :: 		while (Set==0)
L_SetTimerOff_1126:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetTimerOff_1127
;Solar_Loads_Controller_SLCM_V1.c,481 :: 		Display_On_7Segment(hours_lcd_2);
	LDS        R2, _hours_lcd_2+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,483 :: 		while(Increment== 1 || Decrement==1)
L_SetTimerOff_1128:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetTimerOff_1649
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetTimerOff_1648
	JMP        L_SetTimerOff_1129
L__SetTimerOff_1649:
L__SetTimerOff_1648:
;Solar_Loads_Controller_SLCM_V1.c,485 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetTimerOff_1132
;Solar_Loads_Controller_SLCM_V1.c,487 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1133:
	DEC        R16
	BRNE       L_SetTimerOff_1133
	DEC        R17
	BRNE       L_SetTimerOff_1133
	DEC        R18
	BRNE       L_SetTimerOff_1133
	NOP
;Solar_Loads_Controller_SLCM_V1.c,488 :: 		hours_lcd_2++;
	LDS        R16, _hours_lcd_2+0
	SUBI       R16, 255
	STS        _hours_lcd_2+0, R16
;Solar_Loads_Controller_SLCM_V1.c,489 :: 		}
L_SetTimerOff_1132:
;Solar_Loads_Controller_SLCM_V1.c,490 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetTimerOff_1135
;Solar_Loads_Controller_SLCM_V1.c,492 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1136:
	DEC        R16
	BRNE       L_SetTimerOff_1136
	DEC        R17
	BRNE       L_SetTimerOff_1136
	DEC        R18
	BRNE       L_SetTimerOff_1136
	NOP
;Solar_Loads_Controller_SLCM_V1.c,493 :: 		hours_lcd_2--;
	LDS        R16, _hours_lcd_2+0
	SUBI       R16, 1
	STS        _hours_lcd_2+0, R16
;Solar_Loads_Controller_SLCM_V1.c,494 :: 		}
L_SetTimerOff_1135:
;Solar_Loads_Controller_SLCM_V1.c,495 :: 		if(hours_lcd_2>23) hours_lcd_2=0;
	LDS        R17, _hours_lcd_2+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetTimerOff_1844
	JMP        L_SetTimerOff_1138
L__SetTimerOff_1844:
	LDI        R27, 0
	STS        _hours_lcd_2+0, R27
L_SetTimerOff_1138:
;Solar_Loads_Controller_SLCM_V1.c,496 :: 		if (hours_lcd_2<0 ) hours_lcd_2=0;
	LDS        R16, _hours_lcd_2+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_1845
	JMP        L_SetTimerOff_1139
L__SetTimerOff_1845:
	LDI        R27, 0
	STS        _hours_lcd_2+0, R27
L_SetTimerOff_1139:
;Solar_Loads_Controller_SLCM_V1.c,497 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,498 :: 		Timer_isOn=0;
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,499 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_1128
L_SetTimerOff_1129:
;Solar_Loads_Controller_SLCM_V1.c,500 :: 		} // end first while
	JMP        L_SetTimerOff_1126
L_SetTimerOff_1127:
;Solar_Loads_Controller_SLCM_V1.c,502 :: 		EEPROM_Write(0x02,hours_lcd_2); // save hours off  timer_1 to eeprom
	LDS        R4, _hours_lcd_2+0
	LDI        R27, 2
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,503 :: 		Delay_ms(500); // read button state
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetTimerOff_1140:
	DEC        R16
	BRNE       L_SetTimerOff_1140
	DEC        R17
	BRNE       L_SetTimerOff_1140
	DEC        R18
	BRNE       L_SetTimerOff_1140
	NOP
;Solar_Loads_Controller_SLCM_V1.c,504 :: 		while (Set==0)
L_SetTimerOff_1142:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetTimerOff_1143
;Solar_Loads_Controller_SLCM_V1.c,506 :: 		Display_On_7Segment(minutes_lcd_2);
	LDS        R2, _minutes_lcd_2+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,508 :: 		while (Increment==1 || Decrement==1)
L_SetTimerOff_1144:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetTimerOff_1651
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetTimerOff_1650
	JMP        L_SetTimerOff_1145
L__SetTimerOff_1651:
L__SetTimerOff_1650:
;Solar_Loads_Controller_SLCM_V1.c,510 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetTimerOff_1148
;Solar_Loads_Controller_SLCM_V1.c,512 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1149:
	DEC        R16
	BRNE       L_SetTimerOff_1149
	DEC        R17
	BRNE       L_SetTimerOff_1149
	DEC        R18
	BRNE       L_SetTimerOff_1149
	NOP
;Solar_Loads_Controller_SLCM_V1.c,513 :: 		minutes_lcd_2++;
	LDS        R16, _minutes_lcd_2+0
	SUBI       R16, 255
	STS        _minutes_lcd_2+0, R16
;Solar_Loads_Controller_SLCM_V1.c,514 :: 		}
L_SetTimerOff_1148:
;Solar_Loads_Controller_SLCM_V1.c,515 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetTimerOff_1151
;Solar_Loads_Controller_SLCM_V1.c,517 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetTimerOff_1152:
	DEC        R16
	BRNE       L_SetTimerOff_1152
	DEC        R17
	BRNE       L_SetTimerOff_1152
	DEC        R18
	BRNE       L_SetTimerOff_1152
	NOP
;Solar_Loads_Controller_SLCM_V1.c,518 :: 		minutes_lcd_2--;
	LDS        R16, _minutes_lcd_2+0
	SUBI       R16, 1
	STS        _minutes_lcd_2+0, R16
;Solar_Loads_Controller_SLCM_V1.c,519 :: 		}
L_SetTimerOff_1151:
;Solar_Loads_Controller_SLCM_V1.c,521 :: 		if(minutes_lcd_2>59) minutes_lcd_2=0;
	LDS        R17, _minutes_lcd_2+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetTimerOff_1846
	JMP        L_SetTimerOff_1154
L__SetTimerOff_1846:
	LDI        R27, 0
	STS        _minutes_lcd_2+0, R27
L_SetTimerOff_1154:
;Solar_Loads_Controller_SLCM_V1.c,522 :: 		if (minutes_lcd_2<0) minutes_lcd_2=0;
	LDS        R16, _minutes_lcd_2+0
	CPI        R16, 0
	BRLO       L__SetTimerOff_1847
	JMP        L_SetTimerOff_1155
L__SetTimerOff_1847:
	LDI        R27, 0
	STS        _minutes_lcd_2+0, R27
L_SetTimerOff_1155:
;Solar_Loads_Controller_SLCM_V1.c,523 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,524 :: 		Timer_isOn=0;
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,525 :: 		} // end while increment or decrement
	JMP        L_SetTimerOff_1144
L_SetTimerOff_1145:
;Solar_Loads_Controller_SLCM_V1.c,526 :: 		} // end first while
	JMP        L_SetTimerOff_1142
L_SetTimerOff_1143:
;Solar_Loads_Controller_SLCM_V1.c,529 :: 		EEPROM_Write(0x03,minutes_lcd_2); // save minutes off timer_1 to eeprom
	LDS        R4, _minutes_lcd_2+0
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,530 :: 		}
L_end_SetTimerOff_1:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetTimerOff_1

_SetLowBatteryVoltage:

;Solar_Loads_Controller_SLCM_V1.c,532 :: 		void SetLowBatteryVoltage()
;Solar_Loads_Controller_SLCM_V1.c,534 :: 		while(Set==0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
L_SetLowBatteryVoltage156:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetLowBatteryVoltage157
;Solar_Loads_Controller_SLCM_V1.c,536 :: 		Display_On_7Segment_Character(0xC6,0xE3,0xC1);
	LDI        R27, 193
	MOV        R4, R27
	LDI        R27, 227
	MOV        R3, R27
	LDI        R27, 198
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,537 :: 		}
	JMP        L_SetLowBatteryVoltage156
L_SetLowBatteryVoltage157:
;Solar_Loads_Controller_SLCM_V1.c,538 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetLowBatteryVoltage158:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage158
	DEC        R17
	BRNE       L_SetLowBatteryVoltage158
	DEC        R18
	BRNE       L_SetLowBatteryVoltage158
	NOP
;Solar_Loads_Controller_SLCM_V1.c,539 :: 		while(Set==0)
L_SetLowBatteryVoltage160:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetLowBatteryVoltage161
;Solar_Loads_Controller_SLCM_V1.c,541 :: 		Display_On_7Segment_Float(Mini_Battery_Voltage);  // to indicate program 2
	LDS        R2, _Mini_Battery_Voltage+0
	LDS        R3, _Mini_Battery_Voltage+1
	LDS        R4, _Mini_Battery_Voltage+2
	LDS        R5, _Mini_Battery_Voltage+3
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,542 :: 		while (Increment==1 || Decrement==1)
L_SetLowBatteryVoltage162:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetLowBatteryVoltage654
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetLowBatteryVoltage653
	JMP        L_SetLowBatteryVoltage163
L__SetLowBatteryVoltage654:
L__SetLowBatteryVoltage653:
;Solar_Loads_Controller_SLCM_V1.c,544 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetLowBatteryVoltage166
;Solar_Loads_Controller_SLCM_V1.c,546 :: 		Display_On_7Segment_Float(Mini_Battery_Voltage);  // to indicate program 2
	LDS        R2, _Mini_Battery_Voltage+0
	LDS        R3, _Mini_Battery_Voltage+1
	LDS        R4, _Mini_Battery_Voltage+2
	LDS        R5, _Mini_Battery_Voltage+3
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,547 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage167:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage167
	DEC        R17
	BRNE       L_SetLowBatteryVoltage167
	DEC        R18
	BRNE       L_SetLowBatteryVoltage167
	NOP
;Solar_Loads_Controller_SLCM_V1.c,548 :: 		Mini_Battery_Voltage+=0.1;
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
;Solar_Loads_Controller_SLCM_V1.c,550 :: 		}
L_SetLowBatteryVoltage166:
;Solar_Loads_Controller_SLCM_V1.c,551 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetLowBatteryVoltage169
;Solar_Loads_Controller_SLCM_V1.c,553 :: 		Display_On_7Segment_Float(Mini_Battery_Voltage);  // to indicate program 2
	LDS        R2, _Mini_Battery_Voltage+0
	LDS        R3, _Mini_Battery_Voltage+1
	LDS        R4, _Mini_Battery_Voltage+2
	LDS        R5, _Mini_Battery_Voltage+3
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,554 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetLowBatteryVoltage170:
	DEC        R16
	BRNE       L_SetLowBatteryVoltage170
	DEC        R17
	BRNE       L_SetLowBatteryVoltage170
	DEC        R18
	BRNE       L_SetLowBatteryVoltage170
	NOP
;Solar_Loads_Controller_SLCM_V1.c,555 :: 		Mini_Battery_Voltage-=0.1;
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
;Solar_Loads_Controller_SLCM_V1.c,556 :: 		}
L_SetLowBatteryVoltage169:
;Solar_Loads_Controller_SLCM_V1.c,557 :: 		if (Mini_Battery_Voltage>65) Mini_Battery_Voltage=0;
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
	BREQ       L__SetLowBatteryVoltage849
	LDI        R16, 1
L__SetLowBatteryVoltage849:
	TST        R16
	BRNE       L__SetLowBatteryVoltage850
	JMP        L_SetLowBatteryVoltage172
L__SetLowBatteryVoltage850:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	STS        _Mini_Battery_Voltage+2, R27
	STS        _Mini_Battery_Voltage+3, R27
L_SetLowBatteryVoltage172:
;Solar_Loads_Controller_SLCM_V1.c,558 :: 		if (Mini_Battery_Voltage<0) Mini_Battery_Voltage=0;
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
	BREQ       L__SetLowBatteryVoltage851
	LDI        R16, 1
L__SetLowBatteryVoltage851:
	TST        R16
	BRNE       L__SetLowBatteryVoltage852
	JMP        L_SetLowBatteryVoltage173
L__SetLowBatteryVoltage852:
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	STS        _Mini_Battery_Voltage+2, R27
	STS        _Mini_Battery_Voltage+3, R27
L_SetLowBatteryVoltage173:
;Solar_Loads_Controller_SLCM_V1.c,559 :: 		} //end wile increment and decrement
	JMP        L_SetLowBatteryVoltage162
L_SetLowBatteryVoltage163:
;Solar_Loads_Controller_SLCM_V1.c,560 :: 		}// end first while set
	JMP        L_SetLowBatteryVoltage160
L_SetLowBatteryVoltage161:
;Solar_Loads_Controller_SLCM_V1.c,561 :: 		StoreBytesIntoEEprom(0x04,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
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
;Solar_Loads_Controller_SLCM_V1.c,562 :: 		}
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

;Solar_Loads_Controller_SLCM_V1.c,565 :: 		void SetStartUpLoadsVoltage()
;Solar_Loads_Controller_SLCM_V1.c,567 :: 		while(Set==0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
L_SetStartUpLoadsVoltage174:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetStartUpLoadsVoltage175
;Solar_Loads_Controller_SLCM_V1.c,569 :: 		Display_On_7Segment_Character(0x92,0x83,0x9D);
	LDI        R27, 157
	MOV        R4, R27
	LDI        R27, 131
	MOV        R3, R27
	LDI        R27, 146
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,570 :: 		}
	JMP        L_SetStartUpLoadsVoltage174
L_SetStartUpLoadsVoltage175:
;Solar_Loads_Controller_SLCM_V1.c,571 :: 		Delay_ms(500);;
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetStartUpLoadsVoltage176:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage176
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage176
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage176
	NOP
;Solar_Loads_Controller_SLCM_V1.c,572 :: 		while(Set==0)
L_SetStartUpLoadsVoltage178:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetStartUpLoadsVoltage179
;Solar_Loads_Controller_SLCM_V1.c,574 :: 		Display_On_7Segment_Float(StartLoadsVoltage);
	LDS        R2, _StartLoadsVoltage+0
	LDS        R3, _StartLoadsVoltage+1
	LDS        R4, _StartLoadsVoltage+2
	LDS        R5, _StartLoadsVoltage+3
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,575 :: 		while (Increment==1 || Decrement==1)
L_SetStartUpLoadsVoltage180:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetStartUpLoadsVoltage657
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetStartUpLoadsVoltage656
	JMP        L_SetStartUpLoadsVoltage181
L__SetStartUpLoadsVoltage657:
L__SetStartUpLoadsVoltage656:
;Solar_Loads_Controller_SLCM_V1.c,577 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetStartUpLoadsVoltage184
;Solar_Loads_Controller_SLCM_V1.c,579 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetStartUpLoadsVoltage185:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage185
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage185
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage185
	NOP
;Solar_Loads_Controller_SLCM_V1.c,580 :: 		StartLoadsVoltage+=0.1;
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
;Solar_Loads_Controller_SLCM_V1.c,581 :: 		Display_On_7Segment_Float(StartLoadsVoltage);
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,582 :: 		}
L_SetStartUpLoadsVoltage184:
;Solar_Loads_Controller_SLCM_V1.c,583 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetStartUpLoadsVoltage187
;Solar_Loads_Controller_SLCM_V1.c,585 :: 		Delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetStartUpLoadsVoltage188:
	DEC        R16
	BRNE       L_SetStartUpLoadsVoltage188
	DEC        R17
	BRNE       L_SetStartUpLoadsVoltage188
	DEC        R18
	BRNE       L_SetStartUpLoadsVoltage188
	NOP
;Solar_Loads_Controller_SLCM_V1.c,586 :: 		StartLoadsVoltage-=0.1;
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
;Solar_Loads_Controller_SLCM_V1.c,587 :: 		Display_On_7Segment_Float(StartLoadsVoltage);
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,588 :: 		}
L_SetStartUpLoadsVoltage187:
;Solar_Loads_Controller_SLCM_V1.c,589 :: 		if (StartLoadsVoltage>65) StartLoadsVoltage=0;
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
	BREQ       L__SetStartUpLoadsVoltage854
	LDI        R16, 1
L__SetStartUpLoadsVoltage854:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage855
	JMP        L_SetStartUpLoadsVoltage190
L__SetStartUpLoadsVoltage855:
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	STS        _StartLoadsVoltage+2, R27
	STS        _StartLoadsVoltage+3, R27
L_SetStartUpLoadsVoltage190:
;Solar_Loads_Controller_SLCM_V1.c,590 :: 		if (StartLoadsVoltage<0) StartLoadsVoltage=0;
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
	BREQ       L__SetStartUpLoadsVoltage856
	LDI        R16, 1
L__SetStartUpLoadsVoltage856:
	TST        R16
	BRNE       L__SetStartUpLoadsVoltage857
	JMP        L_SetStartUpLoadsVoltage191
L__SetStartUpLoadsVoltage857:
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	STS        _StartLoadsVoltage+2, R27
	STS        _StartLoadsVoltage+3, R27
L_SetStartUpLoadsVoltage191:
;Solar_Loads_Controller_SLCM_V1.c,591 :: 		} //end wile increment and decrement
	JMP        L_SetStartUpLoadsVoltage180
L_SetStartUpLoadsVoltage181:
;Solar_Loads_Controller_SLCM_V1.c,592 :: 		}// end first while
	JMP        L_SetStartUpLoadsVoltage178
L_SetStartUpLoadsVoltage179:
;Solar_Loads_Controller_SLCM_V1.c,593 :: 		StoreBytesIntoEEprom(0x08,(unsigned short *)&StartLoadsVoltage,4);   // save float number to eeprom
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
;Solar_Loads_Controller_SLCM_V1.c,594 :: 		}
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

;Solar_Loads_Controller_SLCM_V1.c,598 :: 		void Startup_Timers()
;Solar_Loads_Controller_SLCM_V1.c,600 :: 		while(Set==0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
L_Startup_Timers192:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_Startup_Timers193
;Solar_Loads_Controller_SLCM_V1.c,602 :: 		Display_On_7Segment_Character(0x92,0xC7,0x92);
	LDI        R27, 146
	MOV        R4, R27
	LDI        R27, 199
	MOV        R3, R27
	LDI        R27, 146
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,603 :: 		}
	JMP        L_Startup_Timers192
L_Startup_Timers193:
;Solar_Loads_Controller_SLCM_V1.c,604 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_Startup_Timers194:
	DEC        R16
	BRNE       L_Startup_Timers194
	DEC        R17
	BRNE       L_Startup_Timers194
	DEC        R18
	BRNE       L_Startup_Timers194
	NOP
;Solar_Loads_Controller_SLCM_V1.c,605 :: 		while(Set==0)
L_Startup_Timers196:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_Startup_Timers197
;Solar_Loads_Controller_SLCM_V1.c,607 :: 		Display_On_7Segment(startupTIme_1);
	LDS        R2, _startupTIme_1+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,608 :: 		while(Increment==1 || Decrement==1)
L_Startup_Timers198:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__Startup_Timers660
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__Startup_Timers659
	JMP        L_Startup_Timers199
L__Startup_Timers660:
L__Startup_Timers659:
;Solar_Loads_Controller_SLCM_V1.c,610 :: 		if(Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_Startup_Timers202
;Solar_Loads_Controller_SLCM_V1.c,613 :: 		Display_On_7Segment(startupTIme_1);
	LDS        R2, _startupTIme_1+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,614 :: 		Delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_Startup_Timers203:
	DEC        R16
	BRNE       L_Startup_Timers203
	DEC        R17
	BRNE       L_Startup_Timers203
	DEC        R18
	BRNE       L_Startup_Timers203
;Solar_Loads_Controller_SLCM_V1.c,615 :: 		startupTIme_1++;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _startupTIme_1+0, R16
	STS        _startupTIme_1+1, R17
;Solar_Loads_Controller_SLCM_V1.c,616 :: 		}
L_Startup_Timers202:
;Solar_Loads_Controller_SLCM_V1.c,617 :: 		if(Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_Startup_Timers205
;Solar_Loads_Controller_SLCM_V1.c,620 :: 		Display_On_7Segment(startupTIme_1);
	LDS        R2, _startupTIme_1+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,621 :: 		Delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_Startup_Timers206:
	DEC        R16
	BRNE       L_Startup_Timers206
	DEC        R17
	BRNE       L_Startup_Timers206
	DEC        R18
	BRNE       L_Startup_Timers206
;Solar_Loads_Controller_SLCM_V1.c,622 :: 		startupTIme_1--;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _startupTIme_1+0, R16
	STS        _startupTIme_1+1, R17
;Solar_Loads_Controller_SLCM_V1.c,623 :: 		}
L_Startup_Timers205:
;Solar_Loads_Controller_SLCM_V1.c,624 :: 		if(startupTIme_1 > 600  ) startupTIme_1=0;
	LDS        R18, _startupTIme_1+0
	LDS        R19, _startupTIme_1+1
	LDI        R16, 88
	LDI        R17, 2
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__Startup_Timers859
	JMP        L_Startup_Timers208
L__Startup_Timers859:
	LDI        R27, 0
	STS        _startupTIme_1+0, R27
	STS        _startupTIme_1+1, R27
L_Startup_Timers208:
;Solar_Loads_Controller_SLCM_V1.c,625 :: 		if (startupTIme_1<0) startupTIme_1=0;
	LDS        R16, _startupTIme_1+0
	LDS        R17, _startupTIme_1+1
	CPI        R17, 0
	BRNE       L__Startup_Timers860
	CPI        R16, 0
L__Startup_Timers860:
	BRLO       L__Startup_Timers861
	JMP        L_Startup_Timers209
L__Startup_Timers861:
	LDI        R27, 0
	STS        _startupTIme_1+0, R27
	STS        _startupTIme_1+1, R27
L_Startup_Timers209:
;Solar_Loads_Controller_SLCM_V1.c,626 :: 		} // end  while increment decrement
	JMP        L_Startup_Timers198
L_Startup_Timers199:
;Solar_Loads_Controller_SLCM_V1.c,627 :: 		} // end while main while set
	JMP        L_Startup_Timers196
L_Startup_Timers197:
;Solar_Loads_Controller_SLCM_V1.c,628 :: 		StoreBytesIntoEEprom(0x12,(unsigned short *)&startupTIme_1,2);   // save float number to eeprom
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
;Solar_Loads_Controller_SLCM_V1.c,629 :: 		} // end  function
L_end_Startup_Timers:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _Startup_Timers

_SetBatteryVoltageError:

;Solar_Loads_Controller_SLCM_V1.c,631 :: 		void SetBatteryVoltageError()
;Solar_Loads_Controller_SLCM_V1.c,633 :: 		while(Set==0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
L_SetBatteryVoltageError210:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetBatteryVoltageError211
;Solar_Loads_Controller_SLCM_V1.c,635 :: 		Display_On_7Segment_Character(0x80,0xC1,0x86);
	LDI        R27, 134
	MOV        R4, R27
	LDI        R27, 193
	MOV        R3, R27
	LDI        R27, 128
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,636 :: 		}
	JMP        L_SetBatteryVoltageError210
L_SetBatteryVoltageError211:
;Solar_Loads_Controller_SLCM_V1.c,637 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetBatteryVoltageError212:
	DEC        R16
	BRNE       L_SetBatteryVoltageError212
	DEC        R17
	BRNE       L_SetBatteryVoltageError212
	DEC        R18
	BRNE       L_SetBatteryVoltageError212
	NOP
;Solar_Loads_Controller_SLCM_V1.c,638 :: 		VinBatteryError=Vin_Battery;
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	STS        _VinBatteryError+0, R16
	STS        _VinBatteryError+1, R17
	STS        _VinBatteryError+2, R18
	STS        _VinBatteryError+3, R19
;Solar_Loads_Controller_SLCM_V1.c,639 :: 		while(Set==0)
L_SetBatteryVoltageError214:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetBatteryVoltageError215
;Solar_Loads_Controller_SLCM_V1.c,641 :: 		Display_On_7Segment_Float(VinBatteryError);
	LDS        R2, _VinBatteryError+0
	LDS        R3, _VinBatteryError+1
	LDS        R4, _VinBatteryError+2
	LDS        R5, _VinBatteryError+3
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,643 :: 		while(Increment==1 || Decrement==1)
L_SetBatteryVoltageError216:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetBatteryVoltageError639
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetBatteryVoltageError638
	JMP        L_SetBatteryVoltageError217
L__SetBatteryVoltageError639:
L__SetBatteryVoltageError638:
;Solar_Loads_Controller_SLCM_V1.c,645 :: 		if(Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetBatteryVoltageError220
;Solar_Loads_Controller_SLCM_V1.c,648 :: 		Display_On_7Segment_Float(VinBatteryError);
	LDS        R2, _VinBatteryError+0
	LDS        R3, _VinBatteryError+1
	LDS        R4, _VinBatteryError+2
	LDS        R5, _VinBatteryError+3
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,649 :: 		Delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_SetBatteryVoltageError221:
	DEC        R16
	BRNE       L_SetBatteryVoltageError221
	DEC        R17
	BRNE       L_SetBatteryVoltageError221
	DEC        R18
	BRNE       L_SetBatteryVoltageError221
;Solar_Loads_Controller_SLCM_V1.c,650 :: 		VinBatteryError+=0.1;
	LDS        R16, _VinBatteryError+0
	LDS        R17, _VinBatteryError+1
	LDS        R18, _VinBatteryError+2
	LDS        R19, _VinBatteryError+3
	LDI        R20, 205
	LDI        R21, 204
	LDI        R22, 204
	LDI        R23, 61
	CALL       _float_fpadd1+0
	STS        _VinBatteryError+0, R16
	STS        _VinBatteryError+1, R17
	STS        _VinBatteryError+2, R18
	STS        _VinBatteryError+3, R19
;Solar_Loads_Controller_SLCM_V1.c,651 :: 		}
L_SetBatteryVoltageError220:
;Solar_Loads_Controller_SLCM_V1.c,652 :: 		if(Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetBatteryVoltageError223
;Solar_Loads_Controller_SLCM_V1.c,655 :: 		Display_On_7Segment_float(VinBatteryError);
	LDS        R2, _VinBatteryError+0
	LDS        R3, _VinBatteryError+1
	LDS        R4, _VinBatteryError+2
	LDS        R5, _VinBatteryError+3
	CALL       _Display_On_7Segment_Float+0
;Solar_Loads_Controller_SLCM_V1.c,656 :: 		Delay_ms(50);
	LDI        R18, 3
	LDI        R17, 8
	LDI        R16, 120
L_SetBatteryVoltageError224:
	DEC        R16
	BRNE       L_SetBatteryVoltageError224
	DEC        R17
	BRNE       L_SetBatteryVoltageError224
	DEC        R18
	BRNE       L_SetBatteryVoltageError224
;Solar_Loads_Controller_SLCM_V1.c,657 :: 		VinBatteryError-=0.1;
	LDI        R20, 205
	LDI        R21, 204
	LDI        R22, 204
	LDI        R23, 61
	LDS        R16, _VinBatteryError+0
	LDS        R17, _VinBatteryError+1
	LDS        R18, _VinBatteryError+2
	LDS        R19, _VinBatteryError+3
	CALL       _float_fpsub1+0
	STS        _VinBatteryError+0, R16
	STS        _VinBatteryError+1, R17
	STS        _VinBatteryError+2, R18
	STS        _VinBatteryError+3, R19
;Solar_Loads_Controller_SLCM_V1.c,658 :: 		}
L_SetBatteryVoltageError223:
;Solar_Loads_Controller_SLCM_V1.c,659 :: 		if(VinBatteryError > 60.0  ) VinBatteryError=0;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 112
	LDI        R23, 66
	LDS        R16, _VinBatteryError+0
	LDS        R17, _VinBatteryError+1
	LDS        R18, _VinBatteryError+2
	LDS        R19, _VinBatteryError+3
	CALL       _float_op_big+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__SetBatteryVoltageError863
	LDI        R16, 1
L__SetBatteryVoltageError863:
	TST        R16
	BRNE       L__SetBatteryVoltageError864
	JMP        L_SetBatteryVoltageError226
L__SetBatteryVoltageError864:
	LDI        R27, 0
	STS        _VinBatteryError+0, R27
	STS        _VinBatteryError+1, R27
	STS        _VinBatteryError+2, R27
	STS        _VinBatteryError+3, R27
L_SetBatteryVoltageError226:
;Solar_Loads_Controller_SLCM_V1.c,660 :: 		if (VinBatteryError<0) VinBatteryError=0;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 0
	LDI        R23, 0
	LDS        R16, _VinBatteryError+0
	LDS        R17, _VinBatteryError+1
	LDS        R18, _VinBatteryError+2
	LDS        R19, _VinBatteryError+3
	CALL       _float_op_less+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__SetBatteryVoltageError865
	LDI        R16, 1
L__SetBatteryVoltageError865:
	TST        R16
	BRNE       L__SetBatteryVoltageError866
	JMP        L_SetBatteryVoltageError227
L__SetBatteryVoltageError866:
	LDI        R27, 0
	STS        _VinBatteryError+0, R27
	STS        _VinBatteryError+1, R27
	STS        _VinBatteryError+2, R27
	STS        _VinBatteryError+3, R27
L_SetBatteryVoltageError227:
;Solar_Loads_Controller_SLCM_V1.c,661 :: 		} // end  while increment decrement
	JMP        L_SetBatteryVoltageError216
L_SetBatteryVoltageError217:
;Solar_Loads_Controller_SLCM_V1.c,662 :: 		} // end while main while set
	JMP        L_SetBatteryVoltageError214
L_SetBatteryVoltageError215:
;Solar_Loads_Controller_SLCM_V1.c,663 :: 		if (VinBatteryError>Vin_Battery_) addError=1;    // add
	LDS        R20, _Vin_Battery_+0
	LDS        R21, _Vin_Battery_+1
	LDS        R22, _Vin_Battery_+2
	LDS        R23, _Vin_Battery_+3
	LDS        R16, _VinBatteryError+0
	LDS        R17, _VinBatteryError+1
	LDS        R18, _VinBatteryError+2
	LDS        R19, _VinBatteryError+3
	CALL       _float_op_big+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__SetBatteryVoltageError867
	LDI        R16, 1
L__SetBatteryVoltageError867:
	TST        R16
	BRNE       L__SetBatteryVoltageError868
	JMP        L_SetBatteryVoltageError228
L__SetBatteryVoltageError868:
	LDI        R27, 1
	STS        _addError+0, R27
L_SetBatteryVoltageError228:
;Solar_Loads_Controller_SLCM_V1.c,664 :: 		if (VinBatteryError<Vin_Battery_) addError=0;    // minus
	LDS        R20, _Vin_Battery_+0
	LDS        R21, _Vin_Battery_+1
	LDS        R22, _Vin_Battery_+2
	LDS        R23, _Vin_Battery_+3
	LDS        R16, _VinBatteryError+0
	LDS        R17, _VinBatteryError+1
	LDS        R18, _VinBatteryError+2
	LDS        R19, _VinBatteryError+3
	CALL       _float_op_less+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__SetBatteryVoltageError869
	LDI        R16, 1
L__SetBatteryVoltageError869:
	TST        R16
	BRNE       L__SetBatteryVoltageError870
	JMP        L_SetBatteryVoltageError229
L__SetBatteryVoltageError870:
	LDI        R27, 0
	STS        _addError+0, R27
L_SetBatteryVoltageError229:
;Solar_Loads_Controller_SLCM_V1.c,665 :: 		VinBatteryDifference=fabs(VinBatteryError-Vin_Battery_);
	LDS        R20, _Vin_Battery_+0
	LDS        R21, _Vin_Battery_+1
	LDS        R22, _Vin_Battery_+2
	LDS        R23, _Vin_Battery_+3
	LDS        R16, _VinBatteryError+0
	LDS        R17, _VinBatteryError+1
	LDS        R18, _VinBatteryError+2
	LDS        R19, _VinBatteryError+3
	CALL       _float_fpsub1+0
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _fabs+0
	STS        _VinBatteryDifference+0, R16
	STS        _VinBatteryDifference+1, R17
	STS        _VinBatteryDifference+2, R18
	STS        _VinBatteryDifference+3, R19
;Solar_Loads_Controller_SLCM_V1.c,666 :: 		StoreBytesIntoEEprom(0x19,(unsigned short *)&VinBatteryDifference,4);   // save float number to eeprom
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_VinBatteryDifference+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_VinBatteryDifference+0)
	MOV        R5, R27
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Loads_Controller_SLCM_V1.c,667 :: 		EEPROM_Write(0x23,addError);
	LDS        R4, _addError+0
	LDI        R27, 35
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,668 :: 		}
L_end_SetBatteryVoltageError:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _SetBatteryVoltageError

_SetDS1307_Time:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;Solar_Loads_Controller_SLCM_V1.c,671 :: 		void SetDS1307_Time()
;Solar_Loads_Controller_SLCM_V1.c,673 :: 		while(Set==0)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
L_SetDS1307_Time230:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time231
;Solar_Loads_Controller_SLCM_V1.c,675 :: 		Display_On_7Segment(6);  // to indicate program 3
	LDI        R27, 6
	MOV        R2, R27
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,676 :: 		}
	JMP        L_SetDS1307_Time230
L_SetDS1307_Time231:
;Solar_Loads_Controller_SLCM_V1.c,677 :: 		set_ds1307_minutes=ReadMinutes();      // to read time now
	CALL       _ReadMinutes+0
	STS        _set_ds1307_minutes+0, R16
;Solar_Loads_Controller_SLCM_V1.c,678 :: 		set_ds1307_hours=ReadHours();          // to read time now
	CALL       _ReadHours+0
	STS        _set_ds1307_hours+0, R16
;Solar_Loads_Controller_SLCM_V1.c,679 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time232:
	DEC        R16
	BRNE       L_SetDS1307_Time232
	DEC        R17
	BRNE       L_SetDS1307_Time232
	DEC        R18
	BRNE       L_SetDS1307_Time232
	NOP
;Solar_Loads_Controller_SLCM_V1.c,680 :: 		while(Set==0)
L_SetDS1307_Time234:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time235
;Solar_Loads_Controller_SLCM_V1.c,682 :: 		Display_On_7Segment_Character(0x89,0xC0,0xC1);
	LDI        R27, 193
	MOV        R4, R27
	LDI        R27, 192
	MOV        R3, R27
	LDI        R27, 137
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,683 :: 		}
	JMP        L_SetDS1307_Time234
L_SetDS1307_Time235:
;Solar_Loads_Controller_SLCM_V1.c,684 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time236:
	DEC        R16
	BRNE       L_SetDS1307_Time236
	DEC        R17
	BRNE       L_SetDS1307_Time236
	DEC        R18
	BRNE       L_SetDS1307_Time236
	NOP
;Solar_Loads_Controller_SLCM_V1.c,685 :: 		while (Set==0)
L_SetDS1307_Time238:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time239
;Solar_Loads_Controller_SLCM_V1.c,687 :: 		Display_On_7Segment(set_ds1307_hours);
	LDS        R2, _set_ds1307_hours+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,688 :: 		while (Increment==1 || Decrement==1 )
L_SetDS1307_Time240:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetDS1307_Time680
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetDS1307_Time679
	JMP        L_SetDS1307_Time241
L__SetDS1307_Time680:
L__SetDS1307_Time679:
;Solar_Loads_Controller_SLCM_V1.c,690 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetDS1307_Time244
;Solar_Loads_Controller_SLCM_V1.c,692 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time245:
	DEC        R16
	BRNE       L_SetDS1307_Time245
	DEC        R17
	BRNE       L_SetDS1307_Time245
	DEC        R18
	BRNE       L_SetDS1307_Time245
	NOP
;Solar_Loads_Controller_SLCM_V1.c,693 :: 		set_ds1307_hours++;
	LDS        R16, _set_ds1307_hours+0
	SUBI       R16, 255
	STS        _set_ds1307_hours+0, R16
;Solar_Loads_Controller_SLCM_V1.c,694 :: 		}
L_SetDS1307_Time244:
;Solar_Loads_Controller_SLCM_V1.c,695 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetDS1307_Time247
;Solar_Loads_Controller_SLCM_V1.c,697 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time248:
	DEC        R16
	BRNE       L_SetDS1307_Time248
	DEC        R17
	BRNE       L_SetDS1307_Time248
	DEC        R18
	BRNE       L_SetDS1307_Time248
	NOP
;Solar_Loads_Controller_SLCM_V1.c,698 :: 		set_ds1307_hours--;
	LDS        R16, _set_ds1307_hours+0
	SUBI       R16, 1
	STS        _set_ds1307_hours+0, R16
;Solar_Loads_Controller_SLCM_V1.c,699 :: 		}
L_SetDS1307_Time247:
;Solar_Loads_Controller_SLCM_V1.c,700 :: 		if(set_ds1307_hours>23) set_ds1307_hours=0;
	LDS        R17, _set_ds1307_hours+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__SetDS1307_Time872
	JMP        L_SetDS1307_Time250
L__SetDS1307_Time872:
	LDI        R27, 0
	STS        _set_ds1307_hours+0, R27
L_SetDS1307_Time250:
;Solar_Loads_Controller_SLCM_V1.c,701 :: 		if (set_ds1307_hours<0) set_ds1307_hours=0;
	LDS        R16, _set_ds1307_hours+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time873
	JMP        L_SetDS1307_Time251
L__SetDS1307_Time873:
	LDI        R27, 0
	STS        _set_ds1307_hours+0, R27
L_SetDS1307_Time251:
;Solar_Loads_Controller_SLCM_V1.c,702 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time240
L_SetDS1307_Time241:
;Solar_Loads_Controller_SLCM_V1.c,703 :: 		} // end first while
	JMP        L_SetDS1307_Time238
L_SetDS1307_Time239:
;Solar_Loads_Controller_SLCM_V1.c,705 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time252:
	DEC        R16
	BRNE       L_SetDS1307_Time252
	DEC        R17
	BRNE       L_SetDS1307_Time252
	DEC        R18
	BRNE       L_SetDS1307_Time252
	NOP
;Solar_Loads_Controller_SLCM_V1.c,706 :: 		while(Set==0)
L_SetDS1307_Time254:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time255
;Solar_Loads_Controller_SLCM_V1.c,708 :: 		Display_On_7Segment_Character(0xC8,0xC8,0xCF);
	LDI        R27, 207
	MOV        R4, R27
	LDI        R27, 200
	MOV        R3, R27
	LDI        R27, 200
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,709 :: 		}
	JMP        L_SetDS1307_Time254
L_SetDS1307_Time255:
;Solar_Loads_Controller_SLCM_V1.c,710 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time256:
	DEC        R16
	BRNE       L_SetDS1307_Time256
	DEC        R17
	BRNE       L_SetDS1307_Time256
	DEC        R18
	BRNE       L_SetDS1307_Time256
	NOP
;Solar_Loads_Controller_SLCM_V1.c,711 :: 		while (Set==0)
L_SetDS1307_Time258:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time259
;Solar_Loads_Controller_SLCM_V1.c,713 :: 		Display_On_7Segment(set_ds1307_minutes);
	LDS        R2, _set_ds1307_minutes+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,714 :: 		while (Increment==1 || Decrement==1)
L_SetDS1307_Time260:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetDS1307_Time682
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetDS1307_Time681
	JMP        L_SetDS1307_Time261
L__SetDS1307_Time682:
L__SetDS1307_Time681:
;Solar_Loads_Controller_SLCM_V1.c,716 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetDS1307_Time264
;Solar_Loads_Controller_SLCM_V1.c,718 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time265:
	DEC        R16
	BRNE       L_SetDS1307_Time265
	DEC        R17
	BRNE       L_SetDS1307_Time265
	DEC        R18
	BRNE       L_SetDS1307_Time265
	NOP
;Solar_Loads_Controller_SLCM_V1.c,719 :: 		set_ds1307_minutes++;
	LDS        R16, _set_ds1307_minutes+0
	SUBI       R16, 255
	STS        _set_ds1307_minutes+0, R16
;Solar_Loads_Controller_SLCM_V1.c,720 :: 		}
L_SetDS1307_Time264:
;Solar_Loads_Controller_SLCM_V1.c,721 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetDS1307_Time267
;Solar_Loads_Controller_SLCM_V1.c,723 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time268:
	DEC        R16
	BRNE       L_SetDS1307_Time268
	DEC        R17
	BRNE       L_SetDS1307_Time268
	DEC        R18
	BRNE       L_SetDS1307_Time268
	NOP
;Solar_Loads_Controller_SLCM_V1.c,724 :: 		set_ds1307_minutes--;
	LDS        R16, _set_ds1307_minutes+0
	SUBI       R16, 1
	STS        _set_ds1307_minutes+0, R16
;Solar_Loads_Controller_SLCM_V1.c,725 :: 		}
L_SetDS1307_Time267:
;Solar_Loads_Controller_SLCM_V1.c,726 :: 		if(set_ds1307_minutes>59) set_ds1307_minutes=0;
	LDS        R17, _set_ds1307_minutes+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetDS1307_Time874
	JMP        L_SetDS1307_Time270
L__SetDS1307_Time874:
	LDI        R27, 0
	STS        _set_ds1307_minutes+0, R27
L_SetDS1307_Time270:
;Solar_Loads_Controller_SLCM_V1.c,727 :: 		if(set_ds1307_minutes<0) set_ds1307_minutes=0;
	LDS        R16, _set_ds1307_minutes+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time875
	JMP        L_SetDS1307_Time271
L__SetDS1307_Time875:
	LDI        R27, 0
	STS        _set_ds1307_minutes+0, R27
L_SetDS1307_Time271:
;Solar_Loads_Controller_SLCM_V1.c,728 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time260
L_SetDS1307_Time261:
;Solar_Loads_Controller_SLCM_V1.c,729 :: 		} // end first while
	JMP        L_SetDS1307_Time258
L_SetDS1307_Time259:
;Solar_Loads_Controller_SLCM_V1.c,731 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time272:
	DEC        R16
	BRNE       L_SetDS1307_Time272
	DEC        R17
	BRNE       L_SetDS1307_Time272
	DEC        R18
	BRNE       L_SetDS1307_Time272
	NOP
;Solar_Loads_Controller_SLCM_V1.c,732 :: 		while(Set==0)
L_SetDS1307_Time274:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time275
;Solar_Loads_Controller_SLCM_V1.c,734 :: 		Display_On_7Segment_Character(0x92,0x86,0xC6);
	LDI        R27, 198
	MOV        R4, R27
	LDI        R27, 134
	MOV        R3, R27
	LDI        R27, 146
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,735 :: 		}
	JMP        L_SetDS1307_Time274
L_SetDS1307_Time275:
;Solar_Loads_Controller_SLCM_V1.c,736 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time276:
	DEC        R16
	BRNE       L_SetDS1307_Time276
	DEC        R17
	BRNE       L_SetDS1307_Time276
	DEC        R18
	BRNE       L_SetDS1307_Time276
	NOP
;Solar_Loads_Controller_SLCM_V1.c,737 :: 		while (Set==0)
L_SetDS1307_Time278:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time279
;Solar_Loads_Controller_SLCM_V1.c,739 :: 		Display_On_7Segment(set_ds1307_seconds);
	LDS        R2, _set_ds1307_seconds+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,740 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time280:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetDS1307_Time684
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetDS1307_Time683
	JMP        L_SetDS1307_Time281
L__SetDS1307_Time684:
L__SetDS1307_Time683:
;Solar_Loads_Controller_SLCM_V1.c,742 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetDS1307_Time284
;Solar_Loads_Controller_SLCM_V1.c,744 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time285:
	DEC        R16
	BRNE       L_SetDS1307_Time285
	DEC        R17
	BRNE       L_SetDS1307_Time285
	DEC        R18
	BRNE       L_SetDS1307_Time285
	NOP
;Solar_Loads_Controller_SLCM_V1.c,745 :: 		set_ds1307_seconds++;
	LDS        R16, _set_ds1307_seconds+0
	SUBI       R16, 255
	STS        _set_ds1307_seconds+0, R16
;Solar_Loads_Controller_SLCM_V1.c,746 :: 		}
L_SetDS1307_Time284:
;Solar_Loads_Controller_SLCM_V1.c,747 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetDS1307_Time287
;Solar_Loads_Controller_SLCM_V1.c,749 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time288:
	DEC        R16
	BRNE       L_SetDS1307_Time288
	DEC        R17
	BRNE       L_SetDS1307_Time288
	DEC        R18
	BRNE       L_SetDS1307_Time288
	NOP
;Solar_Loads_Controller_SLCM_V1.c,750 :: 		set_ds1307_seconds--;
	LDS        R16, _set_ds1307_seconds+0
	SUBI       R16, 1
	STS        _set_ds1307_seconds+0, R16
;Solar_Loads_Controller_SLCM_V1.c,751 :: 		}
L_SetDS1307_Time287:
;Solar_Loads_Controller_SLCM_V1.c,752 :: 		if (set_ds1307_seconds>59) set_ds1307_seconds=0;
	LDS        R17, _set_ds1307_seconds+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__SetDS1307_Time876
	JMP        L_SetDS1307_Time290
L__SetDS1307_Time876:
	LDI        R27, 0
	STS        _set_ds1307_seconds+0, R27
L_SetDS1307_Time290:
;Solar_Loads_Controller_SLCM_V1.c,753 :: 		if (set_ds1307_seconds<0) set_ds1307_seconds=0;
	LDS        R16, _set_ds1307_seconds+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time877
	JMP        L_SetDS1307_Time291
L__SetDS1307_Time877:
	LDI        R27, 0
	STS        _set_ds1307_seconds+0, R27
L_SetDS1307_Time291:
;Solar_Loads_Controller_SLCM_V1.c,756 :: 		Write_Time(Dec2Bcd(set_ds1307_seconds),Dec2Bcd(set_ds1307_minutes),Dec2Bcd(set_ds1307_hours)); // write time to DS1307
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
;Solar_Loads_Controller_SLCM_V1.c,757 :: 		} // end while decrement or increment
	JMP        L_SetDS1307_Time280
L_SetDS1307_Time281:
;Solar_Loads_Controller_SLCM_V1.c,758 :: 		} // end first while
	JMP        L_SetDS1307_Time278
L_SetDS1307_Time279:
;Solar_Loads_Controller_SLCM_V1.c,760 :: 		set_ds1307_day=ReadDate(0x04);  // read day
	LDI        R27, 4
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_day+0, R16
;Solar_Loads_Controller_SLCM_V1.c,761 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time292:
	DEC        R16
	BRNE       L_SetDS1307_Time292
	DEC        R17
	BRNE       L_SetDS1307_Time292
	DEC        R18
	BRNE       L_SetDS1307_Time292
	NOP
;Solar_Loads_Controller_SLCM_V1.c,762 :: 		while(Set==0)
L_SetDS1307_Time294:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time295
;Solar_Loads_Controller_SLCM_V1.c,764 :: 		Display_On_7Segment_Character(0xC0,0x88,0x91);
	LDI        R27, 145
	MOV        R4, R27
	LDI        R27, 136
	MOV        R3, R27
	LDI        R27, 192
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,765 :: 		}
	JMP        L_SetDS1307_Time294
L_SetDS1307_Time295:
;Solar_Loads_Controller_SLCM_V1.c,766 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time296:
	DEC        R16
	BRNE       L_SetDS1307_Time296
	DEC        R17
	BRNE       L_SetDS1307_Time296
	DEC        R18
	BRNE       L_SetDS1307_Time296
	NOP
;Solar_Loads_Controller_SLCM_V1.c,767 :: 		while (Set==0)
L_SetDS1307_Time298:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time299
;Solar_Loads_Controller_SLCM_V1.c,769 :: 		Display_On_7Segment(set_ds1307_day);
	LDS        R2, _set_ds1307_day+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,770 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time300:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetDS1307_Time686
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetDS1307_Time685
	JMP        L_SetDS1307_Time301
L__SetDS1307_Time686:
L__SetDS1307_Time685:
;Solar_Loads_Controller_SLCM_V1.c,773 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetDS1307_Time304
;Solar_Loads_Controller_SLCM_V1.c,775 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time305:
	DEC        R16
	BRNE       L_SetDS1307_Time305
	DEC        R17
	BRNE       L_SetDS1307_Time305
	DEC        R18
	BRNE       L_SetDS1307_Time305
	NOP
;Solar_Loads_Controller_SLCM_V1.c,776 :: 		set_ds1307_day++;
	LDS        R16, _set_ds1307_day+0
	SUBI       R16, 255
	STS        _set_ds1307_day+0, R16
;Solar_Loads_Controller_SLCM_V1.c,777 :: 		}
L_SetDS1307_Time304:
;Solar_Loads_Controller_SLCM_V1.c,778 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetDS1307_Time307
;Solar_Loads_Controller_SLCM_V1.c,780 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time308:
	DEC        R16
	BRNE       L_SetDS1307_Time308
	DEC        R17
	BRNE       L_SetDS1307_Time308
	DEC        R18
	BRNE       L_SetDS1307_Time308
	NOP
;Solar_Loads_Controller_SLCM_V1.c,781 :: 		set_ds1307_day--;
	LDS        R16, _set_ds1307_day+0
	SUBI       R16, 1
	STS        _set_ds1307_day+0, R16
;Solar_Loads_Controller_SLCM_V1.c,782 :: 		}
L_SetDS1307_Time307:
;Solar_Loads_Controller_SLCM_V1.c,783 :: 		if (set_ds1307_day>31) set_ds1307_day=0;
	LDS        R17, _set_ds1307_day+0
	LDI        R16, 31
	CP         R16, R17
	BRLO       L__SetDS1307_Time878
	JMP        L_SetDS1307_Time310
L__SetDS1307_Time878:
	LDI        R27, 0
	STS        _set_ds1307_day+0, R27
L_SetDS1307_Time310:
;Solar_Loads_Controller_SLCM_V1.c,784 :: 		if (set_ds1307_day<0) set_ds1307_day=0;
	LDS        R16, _set_ds1307_day+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time879
	JMP        L_SetDS1307_Time311
L__SetDS1307_Time879:
	LDI        R27, 0
	STS        _set_ds1307_day+0, R27
L_SetDS1307_Time311:
;Solar_Loads_Controller_SLCM_V1.c,785 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time300
L_SetDS1307_Time301:
;Solar_Loads_Controller_SLCM_V1.c,786 :: 		} //  end while set
	JMP        L_SetDS1307_Time298
L_SetDS1307_Time299:
;Solar_Loads_Controller_SLCM_V1.c,789 :: 		set_ds1307_month=ReadDate(0x05);     // month
	LDI        R27, 5
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_month+0, R16
;Solar_Loads_Controller_SLCM_V1.c,790 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time312:
	DEC        R16
	BRNE       L_SetDS1307_Time312
	DEC        R17
	BRNE       L_SetDS1307_Time312
	DEC        R18
	BRNE       L_SetDS1307_Time312
	NOP
;Solar_Loads_Controller_SLCM_V1.c,791 :: 		while(Set==0)
L_SetDS1307_Time314:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time315
;Solar_Loads_Controller_SLCM_V1.c,793 :: 		Display_On_7Segment_Character(0xC8,0xC0,0xC8);
	LDI        R27, 200
	MOV        R4, R27
	LDI        R27, 192
	MOV        R3, R27
	LDI        R27, 200
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,794 :: 		}
	JMP        L_SetDS1307_Time314
L_SetDS1307_Time315:
;Solar_Loads_Controller_SLCM_V1.c,795 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time316:
	DEC        R16
	BRNE       L_SetDS1307_Time316
	DEC        R17
	BRNE       L_SetDS1307_Time316
	DEC        R18
	BRNE       L_SetDS1307_Time316
	NOP
;Solar_Loads_Controller_SLCM_V1.c,796 :: 		while (Set==0)
L_SetDS1307_Time318:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time319
;Solar_Loads_Controller_SLCM_V1.c,798 :: 		Display_On_7Segment( set_ds1307_month);
	LDS        R2, _set_ds1307_month+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,799 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time320:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetDS1307_Time688
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetDS1307_Time687
	JMP        L_SetDS1307_Time321
L__SetDS1307_Time688:
L__SetDS1307_Time687:
;Solar_Loads_Controller_SLCM_V1.c,801 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetDS1307_Time324
;Solar_Loads_Controller_SLCM_V1.c,803 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time325:
	DEC        R16
	BRNE       L_SetDS1307_Time325
	DEC        R17
	BRNE       L_SetDS1307_Time325
	DEC        R18
	BRNE       L_SetDS1307_Time325
	NOP
;Solar_Loads_Controller_SLCM_V1.c,804 :: 		set_ds1307_month++;
	LDS        R16, _set_ds1307_month+0
	SUBI       R16, 255
	STS        _set_ds1307_month+0, R16
;Solar_Loads_Controller_SLCM_V1.c,806 :: 		}
L_SetDS1307_Time324:
;Solar_Loads_Controller_SLCM_V1.c,807 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetDS1307_Time327
;Solar_Loads_Controller_SLCM_V1.c,809 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time328:
	DEC        R16
	BRNE       L_SetDS1307_Time328
	DEC        R17
	BRNE       L_SetDS1307_Time328
	DEC        R18
	BRNE       L_SetDS1307_Time328
	NOP
;Solar_Loads_Controller_SLCM_V1.c,810 :: 		set_ds1307_month--;
	LDS        R16, _set_ds1307_month+0
	SUBI       R16, 1
	STS        _set_ds1307_month+0, R16
;Solar_Loads_Controller_SLCM_V1.c,811 :: 		}
L_SetDS1307_Time327:
;Solar_Loads_Controller_SLCM_V1.c,812 :: 		if (set_ds1307_month>12) set_ds1307_month=0;
	LDS        R17, _set_ds1307_month+0
	LDI        R16, 12
	CP         R16, R17
	BRLO       L__SetDS1307_Time880
	JMP        L_SetDS1307_Time330
L__SetDS1307_Time880:
	LDI        R27, 0
	STS        _set_ds1307_month+0, R27
L_SetDS1307_Time330:
;Solar_Loads_Controller_SLCM_V1.c,813 :: 		if (set_ds1307_month<0) set_ds1307_month=0;
	LDS        R16, _set_ds1307_month+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time881
	JMP        L_SetDS1307_Time331
L__SetDS1307_Time881:
	LDI        R27, 0
	STS        _set_ds1307_month+0, R27
L_SetDS1307_Time331:
;Solar_Loads_Controller_SLCM_V1.c,814 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time320
L_SetDS1307_Time321:
;Solar_Loads_Controller_SLCM_V1.c,815 :: 		} //  end while set
	JMP        L_SetDS1307_Time318
L_SetDS1307_Time319:
;Solar_Loads_Controller_SLCM_V1.c,818 :: 		set_ds1307_year=ReadDate(0x06);
	LDI        R27, 6
	MOV        R2, R27
	CALL       _ReadDate+0
	STS        _set_ds1307_year+0, R16
;Solar_Loads_Controller_SLCM_V1.c,819 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time332:
	DEC        R16
	BRNE       L_SetDS1307_Time332
	DEC        R17
	BRNE       L_SetDS1307_Time332
	DEC        R18
	BRNE       L_SetDS1307_Time332
	NOP
;Solar_Loads_Controller_SLCM_V1.c,820 :: 		while(Set==0)
L_SetDS1307_Time334:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time335
;Solar_Loads_Controller_SLCM_V1.c,822 :: 		Display_On_7Segment_Character(0x91,0x86,0x88);
	LDI        R27, 136
	MOV        R4, R27
	LDI        R27, 134
	MOV        R3, R27
	LDI        R27, 145
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,823 :: 		}
	JMP        L_SetDS1307_Time334
L_SetDS1307_Time335:
;Solar_Loads_Controller_SLCM_V1.c,824 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_SetDS1307_Time336:
	DEC        R16
	BRNE       L_SetDS1307_Time336
	DEC        R17
	BRNE       L_SetDS1307_Time336
	DEC        R18
	BRNE       L_SetDS1307_Time336
	NOP
;Solar_Loads_Controller_SLCM_V1.c,825 :: 		while (Set==0)
L_SetDS1307_Time338:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_SetDS1307_Time339
;Solar_Loads_Controller_SLCM_V1.c,827 :: 		Display_On_7Segment( set_ds1307_year);
	LDS        R2, _set_ds1307_year+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,828 :: 		while(Increment==1 || Decrement==1)
L_SetDS1307_Time340:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__SetDS1307_Time690
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__SetDS1307_Time689
	JMP        L_SetDS1307_Time341
L__SetDS1307_Time690:
L__SetDS1307_Time689:
;Solar_Loads_Controller_SLCM_V1.c,830 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_SetDS1307_Time344
;Solar_Loads_Controller_SLCM_V1.c,832 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time345:
	DEC        R16
	BRNE       L_SetDS1307_Time345
	DEC        R17
	BRNE       L_SetDS1307_Time345
	DEC        R18
	BRNE       L_SetDS1307_Time345
	NOP
;Solar_Loads_Controller_SLCM_V1.c,833 :: 		set_ds1307_year++;
	LDS        R16, _set_ds1307_year+0
	SUBI       R16, 255
	STS        _set_ds1307_year+0, R16
;Solar_Loads_Controller_SLCM_V1.c,835 :: 		}
L_SetDS1307_Time344:
;Solar_Loads_Controller_SLCM_V1.c,836 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_SetDS1307_Time347
;Solar_Loads_Controller_SLCM_V1.c,838 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_SetDS1307_Time348:
	DEC        R16
	BRNE       L_SetDS1307_Time348
	DEC        R17
	BRNE       L_SetDS1307_Time348
	DEC        R18
	BRNE       L_SetDS1307_Time348
	NOP
;Solar_Loads_Controller_SLCM_V1.c,839 :: 		set_ds1307_year--;
	LDS        R16, _set_ds1307_year+0
	SUBI       R16, 1
	STS        _set_ds1307_year+0, R16
;Solar_Loads_Controller_SLCM_V1.c,840 :: 		}
L_SetDS1307_Time347:
;Solar_Loads_Controller_SLCM_V1.c,841 :: 		if (set_ds1307_year>99) set_ds1307_year=0;
	LDS        R17, _set_ds1307_year+0
	LDI        R16, 99
	CP         R16, R17
	BRLO       L__SetDS1307_Time882
	JMP        L_SetDS1307_Time350
L__SetDS1307_Time882:
	LDI        R27, 0
	STS        _set_ds1307_year+0, R27
L_SetDS1307_Time350:
;Solar_Loads_Controller_SLCM_V1.c,842 :: 		if (set_ds1307_year<0) set_ds1307_year=0;
	LDS        R16, _set_ds1307_year+0
	CPI        R16, 0
	BRLO       L__SetDS1307_Time883
	JMP        L_SetDS1307_Time351
L__SetDS1307_Time883:
	LDI        R27, 0
	STS        _set_ds1307_year+0, R27
L_SetDS1307_Time351:
;Solar_Loads_Controller_SLCM_V1.c,844 :: 		}  // end while increment or decrement
	JMP        L_SetDS1307_Time340
L_SetDS1307_Time341:
;Solar_Loads_Controller_SLCM_V1.c,845 :: 		} //  end while set
	JMP        L_SetDS1307_Time338
L_SetDS1307_Time339:
;Solar_Loads_Controller_SLCM_V1.c,846 :: 		Write_Date(Dec2Bcd(set_ds1307_day),Dec2Bcd(set_ds1307_month),Dec2Bcd(set_ds1307_year)); // write Date to DS1307
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
;Solar_Loads_Controller_SLCM_V1.c,847 :: 		}  // end setTimeAndData
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

;Solar_Loads_Controller_SLCM_V1.c,850 :: 		void RunOnBatteryVoltageWithoutTimer()
;Solar_Loads_Controller_SLCM_V1.c,852 :: 		Delay_ms(500);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_RunOnBatteryVoltageWithoutTimer352:
	DEC        R16
	BRNE       L_RunOnBatteryVoltageWithoutTimer352
	DEC        R17
	BRNE       L_RunOnBatteryVoltageWithoutTimer352
	DEC        R18
	BRNE       L_RunOnBatteryVoltageWithoutTimer352
	NOP
;Solar_Loads_Controller_SLCM_V1.c,853 :: 		while(Set==0)
L_RunOnBatteryVoltageWithoutTimer354:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_RunOnBatteryVoltageWithoutTimer355
;Solar_Loads_Controller_SLCM_V1.c,855 :: 		Display_On_7Segment_Character(0xC1,0xC0,0x80);   //VOB= voltage on battery
	LDI        R27, 128
	MOV        R4, R27
	LDI        R27, 192
	MOV        R3, R27
	LDI        R27, 193
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,856 :: 		}
	JMP        L_RunOnBatteryVoltageWithoutTimer354
L_RunOnBatteryVoltageWithoutTimer355:
;Solar_Loads_Controller_SLCM_V1.c,857 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_RunOnBatteryVoltageWithoutTimer356:
	DEC        R16
	BRNE       L_RunOnBatteryVoltageWithoutTimer356
	DEC        R17
	BRNE       L_RunOnBatteryVoltageWithoutTimer356
	DEC        R18
	BRNE       L_RunOnBatteryVoltageWithoutTimer356
	NOP
;Solar_Loads_Controller_SLCM_V1.c,858 :: 		while (Set==0)
L_RunOnBatteryVoltageWithoutTimer358:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_RunOnBatteryVoltageWithoutTimer359
;Solar_Loads_Controller_SLCM_V1.c,860 :: 		if(RunOnBatteryVoltageWithoutTimer_Flag==0)          Display_On_7Segment_Character(0xC0,0x8E,0x8E);        // mode is off so timer is on
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__RunOnBatteryVoltageWithoutTimer885
	JMP        L_RunOnBatteryVoltageWithoutTimer360
L__RunOnBatteryVoltageWithoutTimer885:
	LDI        R27, 142
	MOV        R4, R27
	LDI        R27, 142
	MOV        R3, R27
	LDI        R27, 192
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
L_RunOnBatteryVoltageWithoutTimer360:
;Solar_Loads_Controller_SLCM_V1.c,861 :: 		if(RunOnBatteryVoltageWithoutTimer_Flag==1)          Display_On_7Segment_Character(0xC0,0xC8,0xC8);       // mode is on so timer is off
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 1
	BREQ       L__RunOnBatteryVoltageWithoutTimer886
	JMP        L_RunOnBatteryVoltageWithoutTimer361
L__RunOnBatteryVoltageWithoutTimer886:
	LDI        R27, 200
	MOV        R4, R27
	LDI        R27, 200
	MOV        R3, R27
	LDI        R27, 192
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
L_RunOnBatteryVoltageWithoutTimer361:
;Solar_Loads_Controller_SLCM_V1.c,863 :: 		while (Increment == 1 || Decrement==1)
L_RunOnBatteryVoltageWithoutTimer362:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__RunOnBatteryVoltageWithoutTimer663
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__RunOnBatteryVoltageWithoutTimer662
	JMP        L_RunOnBatteryVoltageWithoutTimer363
L__RunOnBatteryVoltageWithoutTimer663:
L__RunOnBatteryVoltageWithoutTimer662:
;Solar_Loads_Controller_SLCM_V1.c,865 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_RunOnBatteryVoltageWithoutTimer366
;Solar_Loads_Controller_SLCM_V1.c,867 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_RunOnBatteryVoltageWithoutTimer367:
	DEC        R16
	BRNE       L_RunOnBatteryVoltageWithoutTimer367
	DEC        R17
	BRNE       L_RunOnBatteryVoltageWithoutTimer367
	DEC        R18
	BRNE       L_RunOnBatteryVoltageWithoutTimer367
	NOP
;Solar_Loads_Controller_SLCM_V1.c,868 :: 		RunOnBatteryVoltageWithoutTimer_Flag=0;
	LDI        R27, 0
	STS        _RunOnBatteryVoltageWithoutTimer_Flag+0, R27
;Solar_Loads_Controller_SLCM_V1.c,869 :: 		}
L_RunOnBatteryVoltageWithoutTimer366:
;Solar_Loads_Controller_SLCM_V1.c,870 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_RunOnBatteryVoltageWithoutTimer369
;Solar_Loads_Controller_SLCM_V1.c,872 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_RunOnBatteryVoltageWithoutTimer370:
	DEC        R16
	BRNE       L_RunOnBatteryVoltageWithoutTimer370
	DEC        R17
	BRNE       L_RunOnBatteryVoltageWithoutTimer370
	DEC        R18
	BRNE       L_RunOnBatteryVoltageWithoutTimer370
	NOP
;Solar_Loads_Controller_SLCM_V1.c,873 :: 		RunOnBatteryVoltageWithoutTimer_Flag=1;
	LDI        R27, 1
	STS        _RunOnBatteryVoltageWithoutTimer_Flag+0, R27
;Solar_Loads_Controller_SLCM_V1.c,874 :: 		}
L_RunOnBatteryVoltageWithoutTimer369:
;Solar_Loads_Controller_SLCM_V1.c,875 :: 		} // end while increment
	JMP        L_RunOnBatteryVoltageWithoutTimer362
L_RunOnBatteryVoltageWithoutTimer363:
;Solar_Loads_Controller_SLCM_V1.c,876 :: 		} // end first while
	JMP        L_RunOnBatteryVoltageWithoutTimer358
L_RunOnBatteryVoltageWithoutTimer359:
;Solar_Loads_Controller_SLCM_V1.c,877 :: 		EEPROM_Write(0x14,RunOnBatteryVoltageWithoutTimer_Flag); // if zero timer is on and if 1 tiemr is off
	LDS        R4, _RunOnBatteryVoltageWithoutTimer_Flag+0
	LDI        R27, 20
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,878 :: 		}
L_end_RunOnBatteryVoltageWithoutTimer:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _RunOnBatteryVoltageWithoutTimer

_CutLoadsTime:

;Solar_Loads_Controller_SLCM_V1.c,880 :: 		void CutLoadsTime()
;Solar_Loads_Controller_SLCM_V1.c,882 :: 		Delay_ms(500);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_CutLoadsTime372:
	DEC        R16
	BRNE       L_CutLoadsTime372
	DEC        R17
	BRNE       L_CutLoadsTime372
	DEC        R18
	BRNE       L_CutLoadsTime372
	NOP
;Solar_Loads_Controller_SLCM_V1.c,883 :: 		while(Set==0)
L_CutLoadsTime374:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_CutLoadsTime375
;Solar_Loads_Controller_SLCM_V1.c,885 :: 		Display_On_7Segment_Character(0xC6,0xC1,0xF8);   //VOB= voltage on battery
	LDI        R27, 248
	MOV        R4, R27
	LDI        R27, 193
	MOV        R3, R27
	LDI        R27, 198
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,886 :: 		}
	JMP        L_CutLoadsTime374
L_CutLoadsTime375:
;Solar_Loads_Controller_SLCM_V1.c,887 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_CutLoadsTime376:
	DEC        R16
	BRNE       L_CutLoadsTime376
	DEC        R17
	BRNE       L_CutLoadsTime376
	DEC        R18
	BRNE       L_CutLoadsTime376
	NOP
;Solar_Loads_Controller_SLCM_V1.c,888 :: 		while (Set==0)
L_CutLoadsTime378:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_CutLoadsTime379
;Solar_Loads_Controller_SLCM_V1.c,890 :: 		Display_On_7Segment(Cut_Time);
	LDS        R2, _Cut_Time+0
	CALL       _Display_On_7Segment+0
;Solar_Loads_Controller_SLCM_V1.c,892 :: 		while (Increment == 1 || Decrement==1)
L_CutLoadsTime380:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__CutLoadsTime666
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__CutLoadsTime665
	JMP        L_CutLoadsTime381
L__CutLoadsTime666:
L__CutLoadsTime665:
;Solar_Loads_Controller_SLCM_V1.c,894 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_CutLoadsTime384
;Solar_Loads_Controller_SLCM_V1.c,896 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_CutLoadsTime385:
	DEC        R16
	BRNE       L_CutLoadsTime385
	DEC        R17
	BRNE       L_CutLoadsTime385
	DEC        R18
	BRNE       L_CutLoadsTime385
	NOP
;Solar_Loads_Controller_SLCM_V1.c,897 :: 		Cut_Time++;
	LDS        R16, _Cut_Time+0
	LDS        R17, _Cut_Time+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Cut_Time+0, R16
	STS        _Cut_Time+1, R17
;Solar_Loads_Controller_SLCM_V1.c,898 :: 		}
L_CutLoadsTime384:
;Solar_Loads_Controller_SLCM_V1.c,899 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_CutLoadsTime387
;Solar_Loads_Controller_SLCM_V1.c,901 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_CutLoadsTime388:
	DEC        R16
	BRNE       L_CutLoadsTime388
	DEC        R17
	BRNE       L_CutLoadsTime388
	DEC        R18
	BRNE       L_CutLoadsTime388
	NOP
;Solar_Loads_Controller_SLCM_V1.c,902 :: 		Cut_Time--;
	LDS        R16, _Cut_Time+0
	LDS        R17, _Cut_Time+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _Cut_Time+0, R16
	STS        _Cut_Time+1, R17
;Solar_Loads_Controller_SLCM_V1.c,903 :: 		}
L_CutLoadsTime387:
;Solar_Loads_Controller_SLCM_V1.c,904 :: 		} // end while increment
	JMP        L_CutLoadsTime380
L_CutLoadsTime381:
;Solar_Loads_Controller_SLCM_V1.c,905 :: 		} // end first while
	JMP        L_CutLoadsTime378
L_CutLoadsTime379:
;Solar_Loads_Controller_SLCM_V1.c,906 :: 		StoreBytesIntoEEprom(0x15,(unsigned short *)&Cut_Time,4);   // save float number to eeprom
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_Cut_Time+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_Cut_Time+0)
	MOV        R5, R27
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Loads_Controller_SLCM_V1.c,907 :: 		}
L_end_CutLoadsTime:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _CutLoadsTime

_UPSMode:

;Solar_Loads_Controller_SLCM_V1.c,913 :: 		void UPSMode()
;Solar_Loads_Controller_SLCM_V1.c,915 :: 		Delay_ms(500);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_UPSMode390:
	DEC        R16
	BRNE       L_UPSMode390
	DEC        R17
	BRNE       L_UPSMode390
	DEC        R18
	BRNE       L_UPSMode390
	NOP
;Solar_Loads_Controller_SLCM_V1.c,916 :: 		while(Set==0)
L_UPSMode392:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_UPSMode393
;Solar_Loads_Controller_SLCM_V1.c,918 :: 		Display_On_7Segment_Character(0xC1,0x8C,0x92);   //VOB= voltage on battery
	LDI        R27, 146
	MOV        R4, R27
	LDI        R27, 140
	MOV        R3, R27
	LDI        R27, 193
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,919 :: 		}
	JMP        L_UPSMode392
L_UPSMode393:
;Solar_Loads_Controller_SLCM_V1.c,920 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_UPSMode394:
	DEC        R16
	BRNE       L_UPSMode394
	DEC        R17
	BRNE       L_UPSMode394
	DEC        R18
	BRNE       L_UPSMode394
	NOP
;Solar_Loads_Controller_SLCM_V1.c,921 :: 		while (Set==0)
L_UPSMode396:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_UPSMode397
;Solar_Loads_Controller_SLCM_V1.c,923 :: 		if(UPS_Mode==0)          Display_On_7Segment_Character(0xC0,0x8E,0x8E);        // mode is off
	LDS        R16, _UPS_Mode+0
	CPI        R16, 0
	BREQ       L__UPSMode889
	JMP        L_UPSMode398
L__UPSMode889:
	LDI        R27, 142
	MOV        R4, R27
	LDI        R27, 142
	MOV        R3, R27
	LDI        R27, 192
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
L_UPSMode398:
;Solar_Loads_Controller_SLCM_V1.c,924 :: 		if(UPS_Mode==1)          Display_On_7Segment_Character(0xC0,0xC8,0xC8);       // mode is on
	LDS        R16, _UPS_Mode+0
	CPI        R16, 1
	BREQ       L__UPSMode890
	JMP        L_UPSMode399
L__UPSMode890:
	LDI        R27, 200
	MOV        R4, R27
	LDI        R27, 200
	MOV        R3, R27
	LDI        R27, 192
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
L_UPSMode399:
;Solar_Loads_Controller_SLCM_V1.c,926 :: 		while (Increment == 1 || Decrement==1)
L_UPSMode400:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__UPSMode669
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__UPSMode668
	JMP        L_UPSMode401
L__UPSMode669:
L__UPSMode668:
;Solar_Loads_Controller_SLCM_V1.c,928 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_UPSMode404
;Solar_Loads_Controller_SLCM_V1.c,930 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_UPSMode405:
	DEC        R16
	BRNE       L_UPSMode405
	DEC        R17
	BRNE       L_UPSMode405
	DEC        R18
	BRNE       L_UPSMode405
	NOP
;Solar_Loads_Controller_SLCM_V1.c,931 :: 		UPS_Mode=1;
	LDI        R27, 1
	STS        _UPS_Mode+0, R27
;Solar_Loads_Controller_SLCM_V1.c,932 :: 		}
L_UPSMode404:
;Solar_Loads_Controller_SLCM_V1.c,933 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_UPSMode407
;Solar_Loads_Controller_SLCM_V1.c,935 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_UPSMode408:
	DEC        R16
	BRNE       L_UPSMode408
	DEC        R17
	BRNE       L_UPSMode408
	DEC        R18
	BRNE       L_UPSMode408
	NOP
;Solar_Loads_Controller_SLCM_V1.c,936 :: 		UPS_Mode=0;
	LDI        R27, 0
	STS        _UPS_Mode+0, R27
;Solar_Loads_Controller_SLCM_V1.c,937 :: 		}
L_UPSMode407:
;Solar_Loads_Controller_SLCM_V1.c,938 :: 		} // end while increment
	JMP        L_UPSMode400
L_UPSMode401:
;Solar_Loads_Controller_SLCM_V1.c,939 :: 		} // end first while
	JMP        L_UPSMode396
L_UPSMode397:
;Solar_Loads_Controller_SLCM_V1.c,940 :: 		EEPROM_Write(0x17,UPS_Mode); // if zero timer is on and if 1 tiemr is off
	LDS        R4, _UPS_Mode+0
	LDI        R27, 23
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,941 :: 		}
L_end_UPSMode:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _UPSMode

_UPOMode:

;Solar_Loads_Controller_SLCM_V1.c,947 :: 		void UPOMode()
;Solar_Loads_Controller_SLCM_V1.c,949 :: 		Delay_ms(500);
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_UPOMode410:
	DEC        R16
	BRNE       L_UPOMode410
	DEC        R17
	BRNE       L_UPOMode410
	DEC        R18
	BRNE       L_UPOMode410
	NOP
;Solar_Loads_Controller_SLCM_V1.c,950 :: 		while(Set==0)
L_UPOMode412:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_UPOMode413
;Solar_Loads_Controller_SLCM_V1.c,952 :: 		Display_On_7Segment_Character(0xC1,0x8C,0xC0);
	LDI        R27, 192
	MOV        R4, R27
	LDI        R27, 140
	MOV        R3, R27
	LDI        R27, 193
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,953 :: 		}
	JMP        L_UPOMode412
L_UPOMode413:
;Solar_Loads_Controller_SLCM_V1.c,954 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_UPOMode414:
	DEC        R16
	BRNE       L_UPOMode414
	DEC        R17
	BRNE       L_UPOMode414
	DEC        R18
	BRNE       L_UPOMode414
	NOP
;Solar_Loads_Controller_SLCM_V1.c,955 :: 		while (Set==0)
L_UPOMode416:
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_UPOMode417
;Solar_Loads_Controller_SLCM_V1.c,957 :: 		if(UPO_Mode==0)          Display_On_7Segment_Character(0xC0,0x8E,0x8E);        // mode is off
	LDS        R16, _UPO_Mode+0
	CPI        R16, 0
	BREQ       L__UPOMode892
	JMP        L_UPOMode418
L__UPOMode892:
	LDI        R27, 142
	MOV        R4, R27
	LDI        R27, 142
	MOV        R3, R27
	LDI        R27, 192
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
L_UPOMode418:
;Solar_Loads_Controller_SLCM_V1.c,958 :: 		if(UPO_Mode==1)          Display_On_7Segment_Character(0xC0,0xC8,0xC8);       // mode is on
	LDS        R16, _UPO_Mode+0
	CPI        R16, 1
	BREQ       L__UPOMode893
	JMP        L_UPOMode419
L__UPOMode893:
	LDI        R27, 200
	MOV        R4, R27
	LDI        R27, 200
	MOV        R3, R27
	LDI        R27, 192
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
L_UPOMode419:
;Solar_Loads_Controller_SLCM_V1.c,960 :: 		while (Increment == 1 || Decrement==1)
L_UPOMode420:
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__UPOMode672
	IN         R27, PINA+0
	SBRC       R27, 6
	JMP        L__UPOMode671
	JMP        L_UPOMode421
L__UPOMode672:
L__UPOMode671:
;Solar_Loads_Controller_SLCM_V1.c,962 :: 		if (Increment==1)
	IN         R27, PINA+0
	SBRS       R27, 5
	JMP        L_UPOMode424
;Solar_Loads_Controller_SLCM_V1.c,964 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_UPOMode425:
	DEC        R16
	BRNE       L_UPOMode425
	DEC        R17
	BRNE       L_UPOMode425
	DEC        R18
	BRNE       L_UPOMode425
	NOP
;Solar_Loads_Controller_SLCM_V1.c,965 :: 		UPO_Mode=1;
	LDI        R27, 1
	STS        _UPO_Mode+0, R27
;Solar_Loads_Controller_SLCM_V1.c,966 :: 		}
L_UPOMode424:
;Solar_Loads_Controller_SLCM_V1.c,967 :: 		if (Decrement==1)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L_UPOMode427
;Solar_Loads_Controller_SLCM_V1.c,969 :: 		delay_ms(ButtonDelay);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_UPOMode428:
	DEC        R16
	BRNE       L_UPOMode428
	DEC        R17
	BRNE       L_UPOMode428
	DEC        R18
	BRNE       L_UPOMode428
	NOP
;Solar_Loads_Controller_SLCM_V1.c,970 :: 		UPO_Mode=0;
	LDI        R27, 0
	STS        _UPO_Mode+0, R27
;Solar_Loads_Controller_SLCM_V1.c,971 :: 		}
L_UPOMode427:
;Solar_Loads_Controller_SLCM_V1.c,972 :: 		} // end while increment
	JMP        L_UPOMode420
L_UPOMode421:
;Solar_Loads_Controller_SLCM_V1.c,973 :: 		} // end first while
	JMP        L_UPOMode416
L_UPOMode417:
;Solar_Loads_Controller_SLCM_V1.c,974 :: 		EEPROM_Write(0x18,UPO_Mode); // if zero timer is on and if 1 tiemr is off
	LDS        R4, _UPO_Mode+0
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,975 :: 		}
L_end_UPOMode:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _UPOMode

_Screen_1:

;Solar_Loads_Controller_SLCM_V1.c,977 :: 		void Screen_1()
;Solar_Loads_Controller_SLCM_V1.c,979 :: 		if (RunOnBatteryVoltageWithoutTimer_Flag==0)    Read_Time();
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Screen_1895
	JMP        L_Screen_1430
L__Screen_1895:
	CALL       _Read_time+0
L_Screen_1430:
;Solar_Loads_Controller_SLCM_V1.c,982 :: 		}
L_end_Screen_1:
	RET
; end of _Screen_1

_ADCBattery:

;Solar_Loads_Controller_SLCM_V1.c,984 :: 		void ADCBattery()
;Solar_Loads_Controller_SLCM_V1.c,986 :: 		ADC_Init();
	PUSH       R2
	CALL       _ADC_Init+0
;Solar_Loads_Controller_SLCM_V1.c,987 :: 		ADC_Init_Advanced(_ADC_EXTERNAL_REF);
	CLR        R2
	CALL       _ADC_Init_Advanced+0
;Solar_Loads_Controller_SLCM_V1.c,988 :: 		ADPS2_Bit=1;
	IN         R27, ADPS2_bit+0
	SBR        R27, BitMask(ADPS2_bit+0)
	OUT        ADPS2_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,989 :: 		ADPS1_Bit=1;
	IN         R27, ADPS1_bit+0
	SBR        R27, BitMask(ADPS1_bit+0)
	OUT        ADPS1_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,990 :: 		ADPS0_Bit=0;
	IN         R27, ADPS0_bit+0
	CBR        R27, BitMask(ADPS0_bit+0)
	OUT        ADPS0_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,991 :: 		}
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

;Solar_Loads_Controller_SLCM_V1.c,993 :: 		void Read_Battery()
;Solar_Loads_Controller_SLCM_V1.c,995 :: 		float sum=0 , Battery[10];
	PUSH       R2
	LDI        R27, 0
	STD        Y+40, R27
	STD        Y+41, R27
	STD        Y+42, R27
	STD        Y+43, R27
;Solar_Loads_Controller_SLCM_V1.c,996 :: 		char i=0;
;Solar_Loads_Controller_SLCM_V1.c,997 :: 		ADC_Value=ADC_Read(1);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _ADC_Read+0
	STS        _ADC_Value+0, R16
	STS        _ADC_Value+1, R17
;Solar_Loads_Controller_SLCM_V1.c,998 :: 		Battery_Voltage=(ADC_Value *5.0)/1024.0;
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
;Solar_Loads_Controller_SLCM_V1.c,1002 :: 		for ( i=0; i<10 ; i++)
	LDI        R27, 0
	STD        Y+44, R27
L_Read_Battery431:
	LDD        R16, Y+44
	CPI        R16, 10
	BRLO       L__Read_Battery898
	JMP        L_Read_Battery432
L__Read_Battery898:
;Solar_Loads_Controller_SLCM_V1.c,1004 :: 		Battery[i]=((10.5/0.5)*Battery_Voltage);
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
;Solar_Loads_Controller_SLCM_V1.c,1006 :: 		sum+=Battery[i];
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
;Solar_Loads_Controller_SLCM_V1.c,1002 :: 		for ( i=0; i<10 ; i++)
	LDD        R16, Y+44
	SUBI       R16, 255
	STD        Y+44, R16
;Solar_Loads_Controller_SLCM_V1.c,1007 :: 		}
	JMP        L_Read_Battery431
L_Read_Battery432:
;Solar_Loads_Controller_SLCM_V1.c,1008 :: 		Vin_Battery_= sum/10.0 ;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 32
	LDI        R23, 65
	LDD        R16, Y+40
	LDD        R17, Y+41
	LDD        R18, Y+42
	LDD        R19, Y+43
	CALL       _float_fpdiv1+0
	STS        _Vin_Battery_+0, R16
	STS        _Vin_Battery_+1, R17
	STS        _Vin_Battery_+2, R18
	STS        _Vin_Battery_+3, R19
;Solar_Loads_Controller_SLCM_V1.c,1009 :: 		if (addError==1) Vin_Battery=Vin_Battery_+VinBatteryDifference;
	LDS        R16, _addError+0
	CPI        R16, 1
	BREQ       L__Read_Battery899
	JMP        L_Read_Battery434
L__Read_Battery899:
	LDS        R16, _Vin_Battery_+0
	LDS        R17, _Vin_Battery_+1
	LDS        R18, _Vin_Battery_+2
	LDS        R19, _Vin_Battery_+3
	LDS        R20, _VinBatteryDifference+0
	LDS        R21, _VinBatteryDifference+1
	LDS        R22, _VinBatteryDifference+2
	LDS        R23, _VinBatteryDifference+3
	CALL       _float_fpadd1+0
	STS        _Vin_Battery+0, R16
	STS        _Vin_Battery+1, R17
	STS        _Vin_Battery+2, R18
	STS        _Vin_Battery+3, R19
	JMP        L_Read_Battery435
L_Read_Battery434:
;Solar_Loads_Controller_SLCM_V1.c,1010 :: 		else if(addError==0)  Vin_Battery=Vin_Battery_-VinBatteryDifference;
	LDS        R16, _addError+0
	CPI        R16, 0
	BREQ       L__Read_Battery900
	JMP        L_Read_Battery436
L__Read_Battery900:
	LDS        R20, _VinBatteryDifference+0
	LDS        R21, _VinBatteryDifference+1
	LDS        R22, _VinBatteryDifference+2
	LDS        R23, _VinBatteryDifference+3
	LDS        R16, _Vin_Battery_+0
	LDS        R17, _Vin_Battery_+1
	LDS        R18, _Vin_Battery_+2
	LDS        R19, _Vin_Battery_+3
	CALL       _float_fpsub1+0
	STS        _Vin_Battery+0, R16
	STS        _Vin_Battery+1, R17
	STS        _Vin_Battery+2, R18
	STS        _Vin_Battery+3, R19
L_Read_Battery436:
L_Read_Battery435:
;Solar_Loads_Controller_SLCM_V1.c,1012 :: 		}
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

;Solar_Loads_Controller_SLCM_V1.c,1015 :: 		void Start_Timer_0_A()
;Solar_Loads_Controller_SLCM_V1.c,1017 :: 		WGM00_bit=0;
	IN         R27, WGM00_bit+0
	CBR        R27, BitMask(WGM00_bit+0)
	OUT        WGM00_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1018 :: 		WGM01_bit=0;
	IN         R27, WGM01_bit+0
	CBR        R27, BitMask(WGM01_bit+0)
	OUT        WGM01_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1019 :: 		CS00_bit=1; // prescalar 1024
	IN         R27, CS00_bit+0
	SBR        R27, BitMask(CS00_bit+0)
	OUT        CS00_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1020 :: 		CS02_bit=1; //prescalar 1024
	IN         R27, CS02_bit+0
	SBR        R27, BitMask(CS02_bit+0)
	OUT        CS02_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1021 :: 		SREG_I_Bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1022 :: 		OCR0=0xFF;
	LDI        R27, 255
	OUT        OCR0+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1023 :: 		OCIE0_Bit=1;
	IN         R27, OCIE0_bit+0
	SBR        R27, BitMask(OCIE0_bit+0)
	OUT        OCIE0_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1024 :: 		}
L_end_Start_Timer_0_A:
	RET
; end of _Start_Timer_0_A

_Interupt_Timer_0_OFFTime:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Loads_Controller_SLCM_V1.c,1027 :: 		void Interupt_Timer_0_OFFTime() iv IVT_ADDR_TIMER0_COMP
;Solar_Loads_Controller_SLCM_V1.c,1029 :: 		SREG_I_Bit=0; // disable interrupts
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1030 :: 		Timer_Counter_3++;                // timer for battery voltage
	LDS        R16, _Timer_Counter_3+0
	LDS        R17, _Timer_Counter_3+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Timer_Counter_3+0, R16
	STS        _Timer_Counter_3+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1031 :: 		Timer_Counter_For_Grid_Turn_Off++;   // timer for switching load off
	LDS        R16, _Timer_Counter_For_Grid_Turn_Off+0
	LDS        R17, _Timer_Counter_For_Grid_Turn_Off+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _Timer_Counter_For_Grid_Turn_Off+0, R16
	STS        _Timer_Counter_For_Grid_Turn_Off+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1059 :: 		if(Timer_Counter_3==30*Cut_time)   // 1 seconds  for timer counter is 30 counts                7812 / 255 count =  1 second
	LDI        R16, 30
	LDI        R17, 0
	LDS        R20, _Cut_Time+0
	LDS        R21, _Cut_Time+1
	CALL       _HWMul_16x16+0
	LDS        R18, _Timer_Counter_3+0
	LDS        R19, _Timer_Counter_3+1
	CP         R18, R16
	CPC        R19, R17
	BREQ       L__Interupt_Timer_0_OFFTime903
	JMP        L_Interupt_Timer_0_OFFTime437
L__Interupt_Timer_0_OFFTime903:
;Solar_Loads_Controller_SLCM_V1.c,1061 :: 		if(Vin_Battery<Mini_Battery_Voltage && AC_Available==1)
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
	BREQ       L__Interupt_Timer_0_OFFTime904
	LDI        R16, 1
L__Interupt_Timer_0_OFFTime904:
	TST        R16
	BRNE       L__Interupt_Timer_0_OFFTime905
	JMP        L__Interupt_Timer_0_OFFTime693
L__Interupt_Timer_0_OFFTime905:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Interupt_Timer_0_OFFTime692
L__Interupt_Timer_0_OFFTime691:
;Solar_Loads_Controller_SLCM_V1.c,1063 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1064 :: 		Relay_L_Solar=0;
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1061 :: 		if(Vin_Battery<Mini_Battery_Voltage && AC_Available==1)
L__Interupt_Timer_0_OFFTime693:
L__Interupt_Timer_0_OFFTime692:
;Solar_Loads_Controller_SLCM_V1.c,1066 :: 		Timer_Counter_3=0;
	LDI        R27, 0
	STS        _Timer_Counter_3+0, R27
	STS        _Timer_Counter_3+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1067 :: 		Stop_Timer_0();
	CALL       _Stop_Timer_0+0
;Solar_Loads_Controller_SLCM_V1.c,1068 :: 		}
L_Interupt_Timer_0_OFFTime437:
;Solar_Loads_Controller_SLCM_V1.c,1070 :: 		SREG_I_Bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1071 :: 		OCF0_Bit=1; // clear
	IN         R27, OCF0_bit+0
	SBR        R27, BitMask(OCF0_bit+0)
	OUT        OCF0_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1072 :: 		}
L_end_Interupt_Timer_0_OFFTime:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Interupt_Timer_0_OFFTime

_Stop_Timer_0:

;Solar_Loads_Controller_SLCM_V1.c,1074 :: 		void Stop_Timer_0()
;Solar_Loads_Controller_SLCM_V1.c,1076 :: 		CS00_bit=0;
	IN         R27, CS00_bit+0
	CBR        R27, BitMask(CS00_bit+0)
	OUT        CS00_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1077 :: 		CS01_bit=0;
	IN         R27, CS01_bit+0
	CBR        R27, BitMask(CS01_bit+0)
	OUT        CS01_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1078 :: 		CS02_bit=0;
	IN         R27, CS02_bit+0
	CBR        R27, BitMask(CS02_bit+0)
	OUT        CS02_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1079 :: 		}
L_end_Stop_Timer_0:
	RET
; end of _Stop_Timer_0

_EEPROM_FactorySettings:

;Solar_Loads_Controller_SLCM_V1.c,1082 :: 		void EEPROM_FactorySettings(char period)
;Solar_Loads_Controller_SLCM_V1.c,1084 :: 		if(period==1) // summer  timer
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	LDI        R27, 1
	CP         R2, R27
	BREQ       L__EEPROM_FactorySettings908
	JMP        L_EEPROM_FactorySettings441
L__EEPROM_FactorySettings908:
;Solar_Loads_Controller_SLCM_V1.c,1086 :: 		if(SystemBatteryMode==12)
	LDS        R16, _SystemBatteryMode+0
	CPI        R16, 12
	BREQ       L__EEPROM_FactorySettings909
	JMP        L_EEPROM_FactorySettings442
L__EEPROM_FactorySettings909:
;Solar_Loads_Controller_SLCM_V1.c,1088 :: 		Mini_Battery_Voltage=12.0;
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	LDI        R27, 64
	STS        _Mini_Battery_Voltage+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage+3, R27
;Solar_Loads_Controller_SLCM_V1.c,1089 :: 		StartLoadsVoltage=13.5;
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	LDI        R27, 88
	STS        _StartLoadsVoltage+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage+3, R27
;Solar_Loads_Controller_SLCM_V1.c,1090 :: 		}
L_EEPROM_FactorySettings442:
;Solar_Loads_Controller_SLCM_V1.c,1091 :: 		if(SystemBatteryMode==24)
	LDS        R16, _SystemBatteryMode+0
	CPI        R16, 24
	BREQ       L__EEPROM_FactorySettings910
	JMP        L_EEPROM_FactorySettings443
L__EEPROM_FactorySettings910:
;Solar_Loads_Controller_SLCM_V1.c,1093 :: 		Mini_Battery_Voltage=24.5;
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	LDI        R27, 196
	STS        _Mini_Battery_Voltage+2, R27
	LDI        R27, 65
	STS        _Mini_Battery_Voltage+3, R27
;Solar_Loads_Controller_SLCM_V1.c,1094 :: 		StartLoadsVoltage=26.5;
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	LDI        R27, 212
	STS        _StartLoadsVoltage+2, R27
	LDI        R27, 65
	STS        _StartLoadsVoltage+3, R27
;Solar_Loads_Controller_SLCM_V1.c,1095 :: 		}
L_EEPROM_FactorySettings443:
;Solar_Loads_Controller_SLCM_V1.c,1096 :: 		if(SystemBatteryMode==48)
	LDS        R16, _SystemBatteryMode+0
	CPI        R16, 48
	BREQ       L__EEPROM_FactorySettings911
	JMP        L_EEPROM_FactorySettings444
L__EEPROM_FactorySettings911:
;Solar_Loads_Controller_SLCM_V1.c,1098 :: 		Mini_Battery_Voltage=48.5;
	LDI        R27, 0
	STS        _Mini_Battery_Voltage+0, R27
	STS        _Mini_Battery_Voltage+1, R27
	LDI        R27, 66
	STS        _Mini_Battery_Voltage+2, R27
	STS        _Mini_Battery_Voltage+3, R27
;Solar_Loads_Controller_SLCM_V1.c,1099 :: 		StartLoadsVoltage=54.0;
	LDI        R27, 0
	STS        _StartLoadsVoltage+0, R27
	STS        _StartLoadsVoltage+1, R27
	LDI        R27, 88
	STS        _StartLoadsVoltage+2, R27
	LDI        R27, 66
	STS        _StartLoadsVoltage+3, R27
;Solar_Loads_Controller_SLCM_V1.c,1100 :: 		}
L_EEPROM_FactorySettings444:
;Solar_Loads_Controller_SLCM_V1.c,1102 :: 		startupTIme_1 =180;
	LDI        R27, 180
	STS        _startupTIme_1+0, R27
	LDI        R27, 0
	STS        _startupTIme_1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1103 :: 		Cut_Time=15;
	LDI        R27, 15
	STS        _Cut_Time+0, R27
	LDI        R27, 0
	STS        _Cut_Time+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1104 :: 		VinBatteryDifference=0.0;
	LDI        R27, 0
	STS        _VinBatteryDifference+0, R27
	STS        _VinBatteryDifference+1, R27
	STS        _VinBatteryDifference+2, R27
	STS        _VinBatteryDifference+3, R27
;Solar_Loads_Controller_SLCM_V1.c,1105 :: 		addError=1;
	LDI        R27, 1
	STS        _addError+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1107 :: 		EEPROM_Write(0x00,8);  // writing start hours
	LDI        R27, 8
	MOV        R4, R27
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,1108 :: 		EEPROM_Write(0x01,0);    // writing  start minutes
	CLR        R4
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,1109 :: 		EEPROM_Write(0x02,17);    // writing off hours
	LDI        R27, 17
	MOV        R4, R27
	LDI        R27, 2
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,1110 :: 		EEPROM_Write(0x03,0);    // writing off minutes
	CLR        R4
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,1112 :: 		EEPROM_write(0x14,0);    // timer is on and RunOnBatteryVolatgeWithoutTimer is off
	CLR        R4
	LDI        R27, 20
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,1113 :: 		EEPROM_Write(0x17,0);    // ups mode is off
	CLR        R4
	LDI        R27, 23
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,1114 :: 		EEPROM_Write(0x18,0);     //upo mode
	CLR        R4
	LDI        R27, 24
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,1115 :: 		EEPROM_Write(0x23,1);     //add error is on so add error to vin battery
	LDI        R27, 1
	MOV        R4, R27
	LDI        R27, 35
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Solar_Loads_Controller_SLCM_V1.c,1117 :: 		StoreBytesIntoEEprom(0x04,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
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
;Solar_Loads_Controller_SLCM_V1.c,1118 :: 		StoreBytesIntoEEprom(0x08,(unsigned short *)&StartLoadsVoltage,4);
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
;Solar_Loads_Controller_SLCM_V1.c,1119 :: 		StoreBytesIntoEEprom(0x12,(unsigned short *)&startupTIme_1,2);
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
;Solar_Loads_Controller_SLCM_V1.c,1120 :: 		StoreBytesIntoEEprom(0x15,(unsigned short *)&Cut_Time,2);
	LDI        R27, 2
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_Cut_Time+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_Cut_Time+0)
	MOV        R5, R27
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Loads_Controller_SLCM_V1.c,1121 :: 		StoreBytesIntoEEprom(0x19,(unsigned short *)&VinBatteryDifference,4);
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_VinBatteryDifference+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_VinBatteryDifference+0)
	MOV        R5, R27
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _StoreBytesIntoEEprom+0
;Solar_Loads_Controller_SLCM_V1.c,1122 :: 		}
L_EEPROM_FactorySettings441:
;Solar_Loads_Controller_SLCM_V1.c,1123 :: 		}
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
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;Solar_Loads_Controller_SLCM_V1.c,1125 :: 		void RunTimersNowCheck()
;Solar_Loads_Controller_SLCM_V1.c,1127 :: 		SREG_I_bit=0;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1128 :: 		if (Button(&PINA,5,1000,1 ) && Button(&PINA,6,1000,0 )) // if increment pressed for 1 second
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
	BRNE       L__RunTimersNowCheck913
	JMP        L__RunTimersNowCheck699
L__RunTimersNowCheck913:
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
	BRNE       L__RunTimersNowCheck914
	JMP        L__RunTimersNowCheck698
L__RunTimersNowCheck914:
L__RunTimersNowCheck697:
;Solar_Loads_Controller_SLCM_V1.c,1130 :: 		RunLoadsByBass=1;
	LDI        R27, 1
	STS        _RunLoadsByBass+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1131 :: 		if (  RunLoadsByBass==1 ) Relay_L_Solar=1;
	IN         R27, PORTA+0
	SBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1128 :: 		if (Button(&PINA,5,1000,1 ) && Button(&PINA,6,1000,0 )) // if increment pressed for 1 second
L__RunTimersNowCheck699:
L__RunTimersNowCheck698:
;Solar_Loads_Controller_SLCM_V1.c,1134 :: 		if (Button(&PINA,6,1000,1)  && Button(&PINA,5,1000,1))     // up & Down for 1 seconds reset mode
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
	BRNE       L__RunTimersNowCheck915
	JMP        L__RunTimersNowCheck701
L__RunTimersNowCheck915:
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
	BRNE       L__RunTimersNowCheck916
	JMP        L__RunTimersNowCheck700
L__RunTimersNowCheck916:
L__RunTimersNowCheck696:
;Solar_Loads_Controller_SLCM_V1.c,1136 :: 		char esc=0;
	LDI        R27, 0
	STD        Y+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1137 :: 		EEPROM_FactorySettings(1);        // summer time in this version i deleted winter time
	LDI        R27, 1
	MOV        R2, R27
	CALL       _EEPROM_FactorySettings+0
;Solar_Loads_Controller_SLCM_V1.c,1138 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_RunTimersNowCheck452:
	DEC        R16
	BRNE       L_RunTimersNowCheck452
	DEC        R17
	BRNE       L_RunTimersNowCheck452
	DEC        R18
	BRNE       L_RunTimersNowCheck452
;Solar_Loads_Controller_SLCM_V1.c,1139 :: 		EEPROM_Load();    // read the new values from epprom
	CALL       _EEPROM_Load+0
;Solar_Loads_Controller_SLCM_V1.c,1140 :: 		Delay_ms(1000);
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_RunTimersNowCheck454:
	DEC        R16
	BRNE       L_RunTimersNowCheck454
	DEC        R17
	BRNE       L_RunTimersNowCheck454
	DEC        R18
	BRNE       L_RunTimersNowCheck454
;Solar_Loads_Controller_SLCM_V1.c,1141 :: 		while(esc!=255)
L_RunTimersNowCheck456:
	LDD        R16, Y+0
	CPI        R16, 255
	BRNE       L__RunTimersNowCheck917
	JMP        L_RunTimersNowCheck457
L__RunTimersNowCheck917:
;Solar_Loads_Controller_SLCM_V1.c,1143 :: 		esc++;
	LDD        R16, Y+0
	SUBI       R16, 255
	STD        Y+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1144 :: 		Display_On_7Segment_Character(0x88,0x92,0xB8);     //RST
	LDI        R27, 184
	MOV        R4, R27
	LDI        R27, 146
	MOV        R3, R27
	LDI        R27, 136
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,1145 :: 		}
	JMP        L_RunTimersNowCheck456
L_RunTimersNowCheck457:
;Solar_Loads_Controller_SLCM_V1.c,1134 :: 		if (Button(&PINA,6,1000,1)  && Button(&PINA,5,1000,1))     // up & Down for 1 seconds reset mode
L__RunTimersNowCheck701:
L__RunTimersNowCheck700:
;Solar_Loads_Controller_SLCM_V1.c,1149 :: 		if(Decrement==1 && Increment==0)
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L__RunTimersNowCheck705
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__RunTimersNowCheck704
L__RunTimersNowCheck695:
;Solar_Loads_Controller_SLCM_V1.c,1151 :: 		Delay_ms(2000);
	LDI        R18, 82
	LDI        R17, 43
	LDI        R16, 0
L_RunTimersNowCheck461:
	DEC        R16
	BRNE       L_RunTimersNowCheck461
	DEC        R17
	BRNE       L_RunTimersNowCheck461
	DEC        R18
	BRNE       L_RunTimersNowCheck461
	NOP
	NOP
	NOP
	NOP
;Solar_Loads_Controller_SLCM_V1.c,1152 :: 		if (Decrement==1 && Increment==0 )
	IN         R27, PINA+0
	SBRS       R27, 6
	JMP        L__RunTimersNowCheck703
	IN         R27, PINA+0
	SBRC       R27, 5
	JMP        L__RunTimersNowCheck702
L__RunTimersNowCheck694:
;Solar_Loads_Controller_SLCM_V1.c,1154 :: 		TurnOffLoadsByPass=1;
	LDI        R27, 1
	STS        _TurnOffLoadsByPass+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1155 :: 		RunLoadsByBass=0;
	LDI        R27, 0
	STS        _RunLoadsByBass+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1156 :: 		Relay_L_Solar=0;
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1152 :: 		if (Decrement==1 && Increment==0 )
L__RunTimersNowCheck703:
L__RunTimersNowCheck702:
;Solar_Loads_Controller_SLCM_V1.c,1149 :: 		if(Decrement==1 && Increment==0)
L__RunTimersNowCheck705:
L__RunTimersNowCheck704:
;Solar_Loads_Controller_SLCM_V1.c,1159 :: 		SREG_I_bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1160 :: 		}
L_end_RunTimersNowCheck:
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _RunTimersNowCheck

_AutoRunWithOutBatteryProtection:

;Solar_Loads_Controller_SLCM_V1.c,1163 :: 		void AutoRunWithOutBatteryProtection()
;Solar_Loads_Controller_SLCM_V1.c,1165 :: 		if (Vin_Battery==0)
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
	BREQ       L__AutoRunWithOutBatteryProtection919
	LDI        R16, 1
L__AutoRunWithOutBatteryProtection919:
	TST        R16
	BRNE       L__AutoRunWithOutBatteryProtection920
	JMP        L_AutoRunWithOutBatteryProtection466
L__AutoRunWithOutBatteryProtection920:
;Solar_Loads_Controller_SLCM_V1.c,1167 :: 		RunWithOutBattery=true;
	LDI        R27, 1
	STS        _RunWithOutBattery+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1168 :: 		}
	JMP        L_AutoRunWithOutBatteryProtection467
L_AutoRunWithOutBatteryProtection466:
;Solar_Loads_Controller_SLCM_V1.c,1171 :: 		RunWithOutBattery=false;
	LDI        R27, 0
	STS        _RunWithOutBattery+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1172 :: 		}
L_AutoRunWithOutBatteryProtection467:
;Solar_Loads_Controller_SLCM_V1.c,1173 :: 		}
L_end_AutoRunWithOutBatteryProtection:
	RET
; end of _AutoRunWithOutBatteryProtection

_CheckForTimerActivationInRange:

;Solar_Loads_Controller_SLCM_V1.c,1175 :: 		void CheckForTimerActivationInRange()
;Solar_Loads_Controller_SLCM_V1.c,1177 :: 		if (RunOnBatteryVoltageWithoutTimer_Flag==0)
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__CheckForTimerActivationInRange922
	JMP        L_CheckForTimerActivationInRange468
L__CheckForTimerActivationInRange922:
;Solar_Loads_Controller_SLCM_V1.c,1180 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2 && RunOnBatteryVoltageWithoutTimer_Flag==0  )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange923
	JMP        L__CheckForTimerActivationInRange711
L__CheckForTimerActivationInRange923:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange924
	JMP        L__CheckForTimerActivationInRange710
L__CheckForTimerActivationInRange924:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_2+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange925
	JMP        L__CheckForTimerActivationInRange709
L__CheckForTimerActivationInRange925:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__CheckForTimerActivationInRange926
	JMP        L__CheckForTimerActivationInRange708
L__CheckForTimerActivationInRange926:
L__CheckForTimerActivationInRange707:
;Solar_Loads_Controller_SLCM_V1.c,1182 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1180 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2 && RunOnBatteryVoltageWithoutTimer_Flag==0  )
L__CheckForTimerActivationInRange711:
L__CheckForTimerActivationInRange710:
L__CheckForTimerActivationInRange709:
L__CheckForTimerActivationInRange708:
;Solar_Loads_Controller_SLCM_V1.c,1187 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2  && RunOnBatteryVoltageWithoutTimer_Flag==0)
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange927
	JMP        L__CheckForTimerActivationInRange715
L__CheckForTimerActivationInRange927:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationInRange928
	JMP        L__CheckForTimerActivationInRange714
L__CheckForTimerActivationInRange928:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_2+0
	CP         R16, R17
	BREQ       L__CheckForTimerActivationInRange929
	JMP        L__CheckForTimerActivationInRange713
L__CheckForTimerActivationInRange929:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__CheckForTimerActivationInRange930
	JMP        L__CheckForTimerActivationInRange712
L__CheckForTimerActivationInRange930:
L__CheckForTimerActivationInRange706:
;Solar_Loads_Controller_SLCM_V1.c,1190 :: 		if(ReadMinutes() < minutes_lcd_2)        // starts the load
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_2+0
	CP         R16, R17
	BRLO       L__CheckForTimerActivationInRange931
	JMP        L_CheckForTimerActivationInRange475
L__CheckForTimerActivationInRange931:
;Solar_Loads_Controller_SLCM_V1.c,1192 :: 		Timer_isOn=1;
	LDI        R27, 1
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1193 :: 		}
L_CheckForTimerActivationInRange475:
;Solar_Loads_Controller_SLCM_V1.c,1187 :: 		if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2  && RunOnBatteryVoltageWithoutTimer_Flag==0)
L__CheckForTimerActivationInRange715:
L__CheckForTimerActivationInRange714:
L__CheckForTimerActivationInRange713:
L__CheckForTimerActivationInRange712:
;Solar_Loads_Controller_SLCM_V1.c,1195 :: 		} // runs on battery voltage
L_CheckForTimerActivationInRange468:
;Solar_Loads_Controller_SLCM_V1.c,1196 :: 		}  // end function
L_end_CheckForTimerActivationInRange:
	RET
; end of _CheckForTimerActivationInRange

_CheckForTimerActivationOutRange:

;Solar_Loads_Controller_SLCM_V1.c,1198 :: 		void CheckForTimerActivationOutRange()
;Solar_Loads_Controller_SLCM_V1.c,1201 :: 		if(ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() >= hours_lcd_2 && ReadMinutes()>=minutes_lcd_2  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange933
	JMP        L__CheckForTimerActivationOutRange721
L__CheckForTimerActivationOutRange933:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_1+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange934
	JMP        L__CheckForTimerActivationOutRange720
L__CheckForTimerActivationOutRange934:
	CALL       _ReadHours+0
	LDS        R17, _hours_lcd_2+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange935
	JMP        L__CheckForTimerActivationOutRange719
L__CheckForTimerActivationOutRange935:
	CALL       _ReadMinutes+0
	LDS        R17, _minutes_lcd_2+0
	CP         R16, R17
	BRSH       L__CheckForTimerActivationOutRange936
	JMP        L__CheckForTimerActivationOutRange718
L__CheckForTimerActivationOutRange936:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__CheckForTimerActivationOutRange937
	JMP        L__CheckForTimerActivationOutRange717
L__CheckForTimerActivationOutRange937:
L__CheckForTimerActivationOutRange716:
;Solar_Loads_Controller_SLCM_V1.c,1203 :: 		Timer_isOn=0;
	LDI        R27, 0
	STS        _Timer_isOn+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1201 :: 		if(ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() >= hours_lcd_2 && ReadMinutes()>=minutes_lcd_2  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
L__CheckForTimerActivationOutRange721:
L__CheckForTimerActivationOutRange720:
L__CheckForTimerActivationOutRange719:
L__CheckForTimerActivationOutRange718:
L__CheckForTimerActivationOutRange717:
;Solar_Loads_Controller_SLCM_V1.c,1205 :: 		}
L_end_CheckForTimerActivationOutRange:
	RET
; end of _CheckForTimerActivationOutRange

_TurnLoadsOffWhenGridOff:

;Solar_Loads_Controller_SLCM_V1.c,1208 :: 		void TurnLoadsOffWhenGridOff()
;Solar_Loads_Controller_SLCM_V1.c,1215 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0  )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__TurnLoadsOffWhenGridOff727
	LDS        R16, _Timer_isOn+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff939
	JMP        L__TurnLoadsOffWhenGridOff726
L__TurnLoadsOffWhenGridOff939:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff940
	JMP        L__TurnLoadsOffWhenGridOff725
L__TurnLoadsOffWhenGridOff940:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff941
	JMP        L__TurnLoadsOffWhenGridOff724
L__TurnLoadsOffWhenGridOff941:
L__TurnLoadsOffWhenGridOff723:
;Solar_Loads_Controller_SLCM_V1.c,1217 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1218 :: 		CountSecondsRealTime=0;
	LDI        R27, 0
	STS        _CountSecondsRealTime+0, R27
	STS        _CountSecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1219 :: 		Relay_L_Solar=0;
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1220 :: 		LoadsAlreadySwitchedOFF=0;
	LDI        R27, 0
	STS        _LoadsAlreadySwitchedOFF+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1215 :: 		if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0  )
L__TurnLoadsOffWhenGridOff727:
L__TurnLoadsOffWhenGridOff726:
L__TurnLoadsOffWhenGridOff725:
L__TurnLoadsOffWhenGridOff724:
;Solar_Loads_Controller_SLCM_V1.c,1229 :: 		if(AC_Available==1 &&  RunLoadsByBass==0 && UPO_Mode==1 && LoadsAlreadySwitchedOFF==1)
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__TurnLoadsOffWhenGridOff731
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__TurnLoadsOffWhenGridOff942
	JMP        L__TurnLoadsOffWhenGridOff730
L__TurnLoadsOffWhenGridOff942:
	LDS        R16, _UPO_Mode+0
	CPI        R16, 1
	BREQ       L__TurnLoadsOffWhenGridOff943
	JMP        L__TurnLoadsOffWhenGridOff729
L__TurnLoadsOffWhenGridOff943:
	LDS        R16, _LoadsAlreadySwitchedOFF+0
	CPI        R16, 1
	BREQ       L__TurnLoadsOffWhenGridOff944
	JMP        L__TurnLoadsOffWhenGridOff728
L__TurnLoadsOffWhenGridOff944:
L__TurnLoadsOffWhenGridOff722:
;Solar_Loads_Controller_SLCM_V1.c,1231 :: 		LoadsAlreadySwitchedOFF=0;
	LDI        R27, 0
	STS        _LoadsAlreadySwitchedOFF+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1232 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1233 :: 		CountSecondsRealTime=0;
	LDI        R27, 0
	STS        _CountSecondsRealTime+0, R27
	STS        _CountSecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1229 :: 		if(AC_Available==1 &&  RunLoadsByBass==0 && UPO_Mode==1 && LoadsAlreadySwitchedOFF==1)
L__TurnLoadsOffWhenGridOff731:
L__TurnLoadsOffWhenGridOff730:
L__TurnLoadsOffWhenGridOff729:
L__TurnLoadsOffWhenGridOff728:
;Solar_Loads_Controller_SLCM_V1.c,1236 :: 		}
L_end_TurnLoadsOffWhenGridOff:
	RET
; end of _TurnLoadsOffWhenGridOff

_Display_On_7Segment_Battery:

;Solar_Loads_Controller_SLCM_V1.c,1240 :: 		void Display_On_7Segment_Battery(float num)
;Solar_Loads_Controller_SLCM_V1.c,1243 :: 		num = num*10;      //(Becuase there is just three digits that i want to Display
	MOVW       R16, R2
	MOVW       R18, R4
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 32
	LDI        R23, 65
	CALL       _float_fpmul1+0
	MOVW       R2, R16
	MOVW       R4, R18
;Solar_Loads_Controller_SLCM_V1.c,1244 :: 		voltage_int=(int)num;      // Convert the Value to Int and Display just three Digits
	CALL       _float_fpint+0
	STS        _voltage_int+0, R16
	STS        _voltage_int+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1245 :: 		a=voltage_int%10;    //3th digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _a+0, R16
	STS        _a+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1246 :: 		b=voltage_int/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _voltage_int+0
	LDS        R17, _voltage_int+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _b+0, R16
	STS        _b+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1247 :: 		c=b%10;       //2rd digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _c+0, R16
	STS        _c+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1248 :: 		d=b/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _b+0
	LDS        R17, _b+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _d+0, R16
	STS        _d+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1249 :: 		e=d%10;      //1nd digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _e+0, R16
	STS        _e+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1250 :: 		f=d/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _d+0
	LDS        R17, _d+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _f+0, R16
	STS        _f+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1251 :: 		Display_3=1;    // 3 th digit
	IN         R27, PORTC+0
	SBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1252 :: 		PORTB=array[a];
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _a+0
	LDS        R17, _a+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1253 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Battery485:
	DEC        R16
	BRNE       L_Display_On_7Segment_Battery485
	DEC        R17
	BRNE       L_Display_On_7Segment_Battery485
;Solar_Loads_Controller_SLCM_V1.c,1254 :: 		Display_3=0;
	IN         R27, PORTC+0
	CBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1255 :: 		Display_2=1;
	IN         R27, PORTC+0
	SBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1256 :: 		PORTB=array[c] & 0x7F;   // second    7F for turning on dp
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
;Solar_Loads_Controller_SLCM_V1.c,1257 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Battery487:
	DEC        R16
	BRNE       L_Display_On_7Segment_Battery487
	DEC        R17
	BRNE       L_Display_On_7Segment_Battery487
;Solar_Loads_Controller_SLCM_V1.c,1258 :: 		Display_2=0;
	IN         R27, PORTC+0
	CBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1259 :: 		if ( e!=0)  // if num=8.1 it will show 08.1 on 7 segment
	LDS        R16, _e+0
	LDS        R17, _e+1
	CPI        R17, 0
	BRNE       L__Display_On_7Segment_Battery946
	CPI        R16, 0
L__Display_On_7Segment_Battery946:
	BRNE       L__Display_On_7Segment_Battery947
	JMP        L_Display_On_7Segment_Battery489
L__Display_On_7Segment_Battery947:
;Solar_Loads_Controller_SLCM_V1.c,1261 :: 		Display_1=1;
	IN         R27, PORTC+0
	SBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1262 :: 		PORTB=array[e];
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _e+0
	LDS        R17, _e+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1263 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Battery490:
	DEC        R16
	BRNE       L_Display_On_7Segment_Battery490
	DEC        R17
	BRNE       L_Display_On_7Segment_Battery490
;Solar_Loads_Controller_SLCM_V1.c,1264 :: 		Display_1=0;
	IN         R27, PORTC+0
	CBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1265 :: 		}
	JMP        L_Display_On_7Segment_Battery492
L_Display_On_7Segment_Battery489:
;Solar_Loads_Controller_SLCM_V1.c,1268 :: 		Display_1=0;
	IN         R27, PORTC+0
	CBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1269 :: 		}
L_Display_On_7Segment_Battery492:
;Solar_Loads_Controller_SLCM_V1.c,1270 :: 		}
L_end_Display_On_7Segment_Battery:
	RET
; end of _Display_On_7Segment_Battery

_Display_On_7Segment:

;Solar_Loads_Controller_SLCM_V1.c,1272 :: 		void Display_On_7Segment(unsigned short number)
;Solar_Loads_Controller_SLCM_V1.c,1274 :: 		number=number;
;Solar_Loads_Controller_SLCM_V1.c,1275 :: 		a=number%10;    //3th digit is saved here
	LDI        R20, 10
	MOV        R16, R2
	CALL       _Div_8x8_U+0
	MOV        R16, R25
	STS        _a+0, R16
	LDI        R27, 0
	STS        _a+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1276 :: 		b=number/10;
	LDI        R20, 10
	MOV        R16, R2
	CALL       _Div_8x8_U+0
	STS        _b+0, R16
	LDI        R27, 0
	STS        _b+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1277 :: 		c=b%10;       //2rd digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _b+0
	LDS        R17, _b+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _c+0, R16
	STS        _c+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1278 :: 		d=b/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _b+0
	LDS        R17, _b+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _d+0, R16
	STS        _d+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1279 :: 		e=d%10;      //1nd digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _e+0, R16
	STS        _e+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1280 :: 		f=d/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _d+0
	LDS        R17, _d+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _f+0, R16
	STS        _f+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1281 :: 		Display_3=1;    // 3 th digit
	IN         R27, PORTC+0
	SBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1282 :: 		PORTB=array[a];
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _a+0
	LDS        R17, _a+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1283 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment493:
	DEC        R16
	BRNE       L_Display_On_7Segment493
	DEC        R17
	BRNE       L_Display_On_7Segment493
;Solar_Loads_Controller_SLCM_V1.c,1284 :: 		Display_3=0;
	IN         R27, PORTC+0
	CBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1285 :: 		Display_2=1;
	IN         R27, PORTC+0
	SBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1286 :: 		PORTB=array[c] ;   // second    7F for turning on dp
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _c+0
	LDS        R17, _c+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1287 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment495:
	DEC        R16
	BRNE       L_Display_On_7Segment495
	DEC        R17
	BRNE       L_Display_On_7Segment495
;Solar_Loads_Controller_SLCM_V1.c,1288 :: 		Display_2=0;
	IN         R27, PORTC+0
	CBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1289 :: 		Display_1=1;
	IN         R27, PORTC+0
	SBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1290 :: 		PORTB=array[e];
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _e+0
	LDS        R17, _e+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1291 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment497:
	DEC        R16
	BRNE       L_Display_On_7Segment497
	DEC        R17
	BRNE       L_Display_On_7Segment497
;Solar_Loads_Controller_SLCM_V1.c,1292 :: 		Display_1=0;
	IN         R27, PORTC+0
	CBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1293 :: 		}
L_end_Display_On_7Segment:
	RET
; end of _Display_On_7Segment

_Display_On_7Segment_Float:

;Solar_Loads_Controller_SLCM_V1.c,1295 :: 		void Display_On_7Segment_Float(float number)
;Solar_Loads_Controller_SLCM_V1.c,1298 :: 		number=number*10;
	MOVW       R16, R2
	MOVW       R18, R4
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 32
	LDI        R23, 65
	CALL       _float_fpmul1+0
	MOVW       R2, R16
	MOVW       R4, R18
;Solar_Loads_Controller_SLCM_V1.c,1299 :: 		convertedNum=(int)Number;
	CALL       _float_fpint+0
; convertedNum start address is: 18 (R18)
	MOVW       R18, R16
;Solar_Loads_Controller_SLCM_V1.c,1300 :: 		a=convertedNum%10;    //3th digit is saved here
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
;Solar_Loads_Controller_SLCM_V1.c,1301 :: 		b=convertedNum/10;
	MOVW       R16, R18
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
; convertedNum end address is: 18 (R18)
	STS        _b+0, R16
	STS        _b+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1302 :: 		c=b%10;       //2rd digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _c+0, R16
	STS        _c+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1303 :: 		d=b/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _b+0
	LDS        R17, _b+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _d+0, R16
	STS        _d+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1304 :: 		e=d%10;      //1nd digit is saved here
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STS        _e+0, R16
	STS        _e+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1305 :: 		f=d/10;
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _d+0
	LDS        R17, _d+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _f+0, R16
	STS        _f+1, R17
;Solar_Loads_Controller_SLCM_V1.c,1306 :: 		Display_3=1;    // 3 th digit
	IN         R27, PORTC+0
	SBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1307 :: 		PORTB=array[a];
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _a+0
	LDS        R17, _a+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1308 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Float499:
	DEC        R16
	BRNE       L_Display_On_7Segment_Float499
	DEC        R17
	BRNE       L_Display_On_7Segment_Float499
;Solar_Loads_Controller_SLCM_V1.c,1309 :: 		Display_3=0;
	IN         R27, PORTC+0
	CBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1310 :: 		Display_2=1;
	IN         R27, PORTC+0
	SBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1311 :: 		PORTB=array[c] &0x7F ;   // second    7F for turning on dp
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
;Solar_Loads_Controller_SLCM_V1.c,1312 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Float501:
	DEC        R16
	BRNE       L_Display_On_7Segment_Float501
	DEC        R17
	BRNE       L_Display_On_7Segment_Float501
;Solar_Loads_Controller_SLCM_V1.c,1313 :: 		Display_2=0;
	IN         R27, PORTC+0
	CBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1314 :: 		Display_1=1;
	IN         R27, PORTC+0
	SBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1315 :: 		PORTB=array[e];
	LDI        R18, #lo_addr(_array+0)
	LDI        R19, hi_addr(_array+0)
	LDS        R16, _e+0
	LDS        R17, _e+1
	MOVW       R30, R16
	ADD        R30, R18
	ADC        R31, R19
	LD         R16, Z
	OUT        PORTB+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1316 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Float503:
	DEC        R16
	BRNE       L_Display_On_7Segment_Float503
	DEC        R17
	BRNE       L_Display_On_7Segment_Float503
;Solar_Loads_Controller_SLCM_V1.c,1317 :: 		Display_1=0;
	IN         R27, PORTC+0
	CBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1318 :: 		}
L_end_Display_On_7Segment_Float:
	RET
; end of _Display_On_7Segment_Float

_Display_On_7Segment_Character:

;Solar_Loads_Controller_SLCM_V1.c,1321 :: 		void Display_On_7Segment_Character(char chr1,char chr2,char chr3)
;Solar_Loads_Controller_SLCM_V1.c,1323 :: 		Display_3=1;    // 3 th digit
	IN         R27, PORTC+0
	SBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1324 :: 		PORTB=chr3;
	OUT        PORTB+0, R4
;Solar_Loads_Controller_SLCM_V1.c,1325 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Character505:
	DEC        R16
	BRNE       L_Display_On_7Segment_Character505
	DEC        R17
	BRNE       L_Display_On_7Segment_Character505
;Solar_Loads_Controller_SLCM_V1.c,1326 :: 		Display_3=0;
	IN         R27, PORTC+0
	CBR        R27, 64
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1327 :: 		Display_2=1;
	IN         R27, PORTC+0
	SBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1328 :: 		PORTB=chr2 ;   // second    7F for turning on dp
	OUT        PORTB+0, R3
;Solar_Loads_Controller_SLCM_V1.c,1329 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Character507:
	DEC        R16
	BRNE       L_Display_On_7Segment_Character507
	DEC        R17
	BRNE       L_Display_On_7Segment_Character507
;Solar_Loads_Controller_SLCM_V1.c,1330 :: 		Display_2=0;
	IN         R27, PORTC+0
	CBR        R27, 32
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1331 :: 		Display_1=1;
	IN         R27, PORTC+0
	SBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1332 :: 		PORTB=chr1;
	OUT        PORTB+0, R2
;Solar_Loads_Controller_SLCM_V1.c,1333 :: 		Delay_ms(1);
	LDI        R17, 11
	LDI        R16, 99
L_Display_On_7Segment_Character509:
	DEC        R16
	BRNE       L_Display_On_7Segment_Character509
	DEC        R17
	BRNE       L_Display_On_7Segment_Character509
;Solar_Loads_Controller_SLCM_V1.c,1334 :: 		Display_1=0;
	IN         R27, PORTC+0
	CBR        R27, 16
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1335 :: 		}
L_end_Display_On_7Segment_Character:
	RET
; end of _Display_On_7Segment_Character

_Timer_2_Init_Screen:

;Solar_Loads_Controller_SLCM_V1.c,1337 :: 		void Timer_2_Init_Screen()
;Solar_Loads_Controller_SLCM_V1.c,1345 :: 		SREG_I_bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1346 :: 		TCCR2|= (1<<WGM21);   //choosing compare output mode for timer 2
	IN         R27, TCCR2+0
	SBR        R27, 8
	OUT        TCCR2+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1347 :: 		TCCR2|=(1<<CS22) | (1 <<CS21 ) | ( 1<< CS20) ;    //choosing 1024 prescalar so we can get 1 ms delay for updating Dipslay
	IN         R16, TCCR2+0
	ORI        R16, 7
	OUT        TCCR2+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1348 :: 		OCR2=80;
	LDI        R27, 80
	OUT        OCR2+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1349 :: 		TIMSK |= (1<<OCIE2);     //enabling interrupt
	IN         R16, TIMSK+0
	ORI        R16, 128
	OUT        TIMSK+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1350 :: 		TIMSK |=(1<<OCF2);
	ORI        R16, 128
	OUT        TIMSK+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1351 :: 		}
L_end_Timer_2_Init_Screen:
	RET
; end of _Timer_2_Init_Screen

_Timer_Interrupt_UpdateScreen:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Loads_Controller_SLCM_V1.c,1353 :: 		void Timer_Interrupt_UpdateScreen() iv IVT_ADDR_TIMER2_COMP
;Solar_Loads_Controller_SLCM_V1.c,1356 :: 		Display_On_7Segment_Battery(Vin_Battery); // update display
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDS        R2, _Vin_Battery+0
	LDS        R3, _Vin_Battery+1
	LDS        R4, _Vin_Battery+2
	LDS        R5, _Vin_Battery+3
	CALL       _Display_On_7Segment_Battery+0
;Solar_Loads_Controller_SLCM_V1.c,1364 :: 		OCF1A_bit=1;
	IN         R27, OCF1A_bit+0
	SBR        R27, BitMask(OCF1A_bit+0)
	OUT        OCF1A_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1365 :: 		}
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

;Solar_Loads_Controller_SLCM_V1.c,1367 :: 		void CheckForSet()
;Solar_Loads_Controller_SLCM_V1.c,1369 :: 		SREG_I_Bit=0; // disable interrupts
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1370 :: 		if (Button(&PIND,3,1000,1 ))
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
	BRNE       L__CheckForSet954
	JMP        L_CheckForSet511
L__CheckForSet954:
;Solar_Loads_Controller_SLCM_V1.c,1372 :: 		SetUpProgram();
	CALL       _SetUpProgram+0
;Solar_Loads_Controller_SLCM_V1.c,1373 :: 		}
L_CheckForSet511:
;Solar_Loads_Controller_SLCM_V1.c,1374 :: 		SREG_I_Bit=1; // disable interrupts
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1375 :: 		}
L_end_CheckForSet:
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _CheckForSet

_Config_Interrupts:

;Solar_Loads_Controller_SLCM_V1.c,1378 :: 		void Config_Interrupts()
;Solar_Loads_Controller_SLCM_V1.c,1380 :: 		ISC10_bit=1;   // Config interrupts for setup program
	IN         R27, ISC10_bit+0
	SBR        R27, BitMask(ISC10_bit+0)
	OUT        ISC10_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1381 :: 		ISC11_bit=1;   // Config interrupts for setup program
	IN         R27, ISC11_bit+0
	SBR        R27, BitMask(ISC11_bit+0)
	OUT        ISC11_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1382 :: 		ISC00_bit=1;   //config interrupts for shutting loads off when grid is off
	IN         R27, ISC00_bit+0
	SBR        R27, BitMask(ISC00_bit+0)
	OUT        ISC00_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1383 :: 		ISC01_bit=1;   //config interrupts for shutting loads off when grid is off
	IN         R27, ISC01_bit+0
	SBR        R27, BitMask(ISC01_bit+0)
	OUT        ISC01_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1384 :: 		INT1_bit=1;
	IN         R27, INT1_bit+0
	SBR        R27, BitMask(INT1_bit+0)
	OUT        INT1_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1385 :: 		INT0_bit=1;
	IN         R27, INT0_bit+0
	SBR        R27, BitMask(INT0_bit+0)
	OUT        INT0_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1386 :: 		SREG_I_bit=1; // enable the global interrupt vector
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1387 :: 		}
L_end_Config_Interrupts:
	RET
; end of _Config_Interrupts

_Interrupt_INT1:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Loads_Controller_SLCM_V1.c,1390 :: 		void Interrupt_INT1 () iv IVT_ADDR_INT1
;Solar_Loads_Controller_SLCM_V1.c,1392 :: 		SREG_I_Bit=0; // disable interrupts
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1393 :: 		SetUpProgram();
	CALL       _SetUpProgram+0
;Solar_Loads_Controller_SLCM_V1.c,1394 :: 		SREG_I_Bit=1; // disable interrupts
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1395 :: 		INTF1_bit=1;     //clear  flag
	IN         R27, INTF1_bit+0
	SBR        R27, BitMask(INTF1_bit+0)
	OUT        INTF1_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1396 :: 		}
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

;Solar_Loads_Controller_SLCM_V1.c,1398 :: 		void Interrupt_INT0_GridOFF() iv IVT_ADDR_INT0
;Solar_Loads_Controller_SLCM_V1.c,1403 :: 		SREG_I_Bit=0; // disable interrupts
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1409 :: 		if(AC_Available==1 && Timer_isOn==1 && RunLoadsByBass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0 && UPS_Mode==1)
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Interrupt_INT0_GridOFF740
	LDS        R16, _Timer_isOn+0
	CPI        R16, 1
	BREQ       L__Interrupt_INT0_GridOFF958
	JMP        L__Interrupt_INT0_GridOFF739
L__Interrupt_INT0_GridOFF958:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT0_GridOFF959
	JMP        L__Interrupt_INT0_GridOFF738
L__Interrupt_INT0_GridOFF959:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT0_GridOFF960
	JMP        L__Interrupt_INT0_GridOFF737
L__Interrupt_INT0_GridOFF960:
	LDS        R16, _UPS_Mode+0
	CPI        R16, 1
	BREQ       L__Interrupt_INT0_GridOFF961
	JMP        L__Interrupt_INT0_GridOFF736
L__Interrupt_INT0_GridOFF961:
L__Interrupt_INT0_GridOFF735:
;Solar_Loads_Controller_SLCM_V1.c,1411 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1412 :: 		CountSecondsRealTime=0;
	LDI        R27, 0
	STS        _CountSecondsRealTime+0, R27
	STS        _CountSecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1413 :: 		Relay_L_Solar=0;
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1414 :: 		LoadsAlreadySwitchedOFF=0;
	LDI        R27, 0
	STS        _LoadsAlreadySwitchedOFF+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1409 :: 		if(AC_Available==1 && Timer_isOn==1 && RunLoadsByBass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0 && UPS_Mode==1)
L__Interrupt_INT0_GridOFF740:
L__Interrupt_INT0_GridOFF739:
L__Interrupt_INT0_GridOFF738:
L__Interrupt_INT0_GridOFF737:
L__Interrupt_INT0_GridOFF736:
;Solar_Loads_Controller_SLCM_V1.c,1420 :: 		if(AC_Available==1 && Timer_isOn==0  && RunLoadsByBass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0 )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Interrupt_INT0_GridOFF744
	LDS        R16, _Timer_isOn+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT0_GridOFF962
	JMP        L__Interrupt_INT0_GridOFF743
L__Interrupt_INT0_GridOFF962:
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT0_GridOFF963
	JMP        L__Interrupt_INT0_GridOFF742
L__Interrupt_INT0_GridOFF963:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT0_GridOFF964
	JMP        L__Interrupt_INT0_GridOFF741
L__Interrupt_INT0_GridOFF964:
L__Interrupt_INT0_GridOFF734:
;Solar_Loads_Controller_SLCM_V1.c,1422 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1423 :: 		CountSecondsRealTime=0;
	LDI        R27, 0
	STS        _CountSecondsRealTime+0, R27
	STS        _CountSecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1424 :: 		Relay_L_Solar=0;
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1425 :: 		LoadsAlreadySwitchedOFF=0;
	LDI        R27, 0
	STS        _LoadsAlreadySwitchedOFF+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1420 :: 		if(AC_Available==1 && Timer_isOn==0  && RunLoadsByBass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0 )
L__Interrupt_INT0_GridOFF744:
L__Interrupt_INT0_GridOFF743:
L__Interrupt_INT0_GridOFF742:
L__Interrupt_INT0_GridOFF741:
;Solar_Loads_Controller_SLCM_V1.c,1436 :: 		if(AC_Available==1 && RunLoadsByBass==0 && RunOnBatteryVoltageWithoutTimer_Flag==1 && UPS_Mode==1  )
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Interrupt_INT0_GridOFF748
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT0_GridOFF965
	JMP        L__Interrupt_INT0_GridOFF747
L__Interrupt_INT0_GridOFF965:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 1
	BREQ       L__Interrupt_INT0_GridOFF966
	JMP        L__Interrupt_INT0_GridOFF746
L__Interrupt_INT0_GridOFF966:
	LDS        R16, _UPS_Mode+0
	CPI        R16, 1
	BREQ       L__Interrupt_INT0_GridOFF967
	JMP        L__Interrupt_INT0_GridOFF745
L__Interrupt_INT0_GridOFF967:
L__Interrupt_INT0_GridOFF733:
;Solar_Loads_Controller_SLCM_V1.c,1438 :: 		LoadsAlreadySwitchedOFF=0;
	LDI        R27, 0
	STS        _LoadsAlreadySwitchedOFF+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1439 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1440 :: 		CountSecondsRealTime=0;
	LDI        R27, 0
	STS        _CountSecondsRealTime+0, R27
	STS        _CountSecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1441 :: 		Relay_L_Solar=0;
	IN         R27, PORTA+0
	CBR        R27, 8
	OUT        PORTA+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1436 :: 		if(AC_Available==1 && RunLoadsByBass==0 && RunOnBatteryVoltageWithoutTimer_Flag==1 && UPS_Mode==1  )
L__Interrupt_INT0_GridOFF748:
L__Interrupt_INT0_GridOFF747:
L__Interrupt_INT0_GridOFF746:
L__Interrupt_INT0_GridOFF745:
;Solar_Loads_Controller_SLCM_V1.c,1450 :: 		if(AC_Available==1 &&  RunLoadsByBass==0  && UPO_Mode==1 && LoadsAlreadySwitchedOFF==1)
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Interrupt_INT0_GridOFF752
	LDS        R16, _RunLoadsByBass+0
	CPI        R16, 0
	BREQ       L__Interrupt_INT0_GridOFF968
	JMP        L__Interrupt_INT0_GridOFF751
L__Interrupt_INT0_GridOFF968:
	LDS        R16, _UPO_Mode+0
	CPI        R16, 1
	BREQ       L__Interrupt_INT0_GridOFF969
	JMP        L__Interrupt_INT0_GridOFF750
L__Interrupt_INT0_GridOFF969:
	LDS        R16, _LoadsAlreadySwitchedOFF+0
	CPI        R16, 1
	BREQ       L__Interrupt_INT0_GridOFF970
	JMP        L__Interrupt_INT0_GridOFF749
L__Interrupt_INT0_GridOFF970:
L__Interrupt_INT0_GridOFF732:
;Solar_Loads_Controller_SLCM_V1.c,1452 :: 		LoadsAlreadySwitchedOFF=0;
	LDI        R27, 0
	STS        _LoadsAlreadySwitchedOFF+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1453 :: 		SecondsRealTime=0;
	LDI        R27, 0
	STS        _SecondsRealTime+0, R27
	STS        _SecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1454 :: 		CountSecondsRealTime=0;
	LDI        R27, 0
	STS        _CountSecondsRealTime+0, R27
	STS        _CountSecondsRealTime+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1450 :: 		if(AC_Available==1 &&  RunLoadsByBass==0  && UPO_Mode==1 && LoadsAlreadySwitchedOFF==1)
L__Interrupt_INT0_GridOFF752:
L__Interrupt_INT0_GridOFF751:
L__Interrupt_INT0_GridOFF750:
L__Interrupt_INT0_GridOFF749:
;Solar_Loads_Controller_SLCM_V1.c,1469 :: 		SREG_I_Bit=1; // enable interrupts
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1470 :: 		INTF0_bit=1; // clear flag
	IN         R27, INTF0_bit+0
	SBR        R27, BitMask(INTF0_bit+0)
	OUT        INTF0_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1471 :: 		}
L_end_Interrupt_INT0_GridOFF:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Interrupt_INT0_GridOFF

_Timer_1_A_ReadBattery_Init:

;Solar_Loads_Controller_SLCM_V1.c,1474 :: 		void Timer_1_A_ReadBattery_Init()
;Solar_Loads_Controller_SLCM_V1.c,1476 :: 		SREG_I_bit=1 ;   // i already enabled interrupts in vl53l0x but just for make sure
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1477 :: 		WGM10_bit=0;
	IN         R27, WGM10_bit+0
	CBR        R27, BitMask(WGM10_bit+0)
	OUT        WGM10_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1478 :: 		WGM11_bit=0;
	IN         R27, WGM11_bit+0
	CBR        R27, BitMask(WGM11_bit+0)
	OUT        WGM11_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1479 :: 		WGM12_bit=1;
	IN         R27, WGM12_bit+0
	SBR        R27, BitMask(WGM12_bit+0)
	OUT        WGM12_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1480 :: 		WGM13_bit=0;    //mode 4 ctc mode OCR1A top
	IN         R27, WGM13_bit+0
	CBR        R27, BitMask(WGM13_bit+0)
	OUT        WGM13_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1481 :: 		CS12_bit=1;    //prescalr 1024
	IN         R27, CS12_bit+0
	SBR        R27, BitMask(CS12_bit+0)
	OUT        CS12_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1482 :: 		CS10_Bit=1;    //prescalr 1024
	IN         R27, CS10_bit+0
	SBR        R27, BitMask(CS10_bit+0)
	OUT        CS10_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1485 :: 		OCR1AH=0x0F;     //writing high bit first
	LDI        R27, 15
	OUT        OCR1AH+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1486 :: 		OCR1AL=0x46;
	LDI        R27, 70
	OUT        OCR1AL+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1487 :: 		OCIE1A_bit=1;    //Enable Interrupts CTC Mode
	IN         R27, OCIE1A_bit+0
	SBR        R27, BitMask(OCIE1A_bit+0)
	OUT        OCIE1A_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1488 :: 		OCF1A_Bit=1;    // clear interrupt flag
	IN         R27, OCF1A_bit+0
	SBR        R27, BitMask(OCF1A_bit+0)
	OUT        OCF1A_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1489 :: 		}
L_end_Timer_1_A_ReadBattery_Init:
	RET
; end of _Timer_1_A_ReadBattery_Init

_Timer_Interrupt_ReadBattery:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Solar_Loads_Controller_SLCM_V1.c,1490 :: 		void Timer_Interrupt_ReadBattery() iv IVT_ADDR_TIMER1_COMPA
;Solar_Loads_Controller_SLCM_V1.c,1492 :: 		Read_Battery();     // read battery using timer interrupt
	CALL       _Read_Battery+0
;Solar_Loads_Controller_SLCM_V1.c,1493 :: 		if (CountSecondsRealTime==1) SecondsRealTime++;                                     // for counting real time for  grid count
	LDS        R16, _CountSecondsRealTime+0
	LDS        R17, _CountSecondsRealTime+1
	CPI        R17, 0
	BRNE       L__Timer_Interrupt_ReadBattery973
	CPI        R16, 1
L__Timer_Interrupt_ReadBattery973:
	BREQ       L__Timer_Interrupt_ReadBattery974
	JMP        L_Timer_Interrupt_ReadBattery524
L__Timer_Interrupt_ReadBattery974:
	LDS        R16, _SecondsRealTime+0
	LDS        R17, _SecondsRealTime+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTime+0, R16
	STS        _SecondsRealTime+1, R17
L_Timer_Interrupt_ReadBattery524:
;Solar_Loads_Controller_SLCM_V1.c,1494 :: 		if (CountSecondsRealTimePv_ReConnect_T1==1) SecondsRealTimePv_ReConnect_T1++; // for counting real time for pv connect
	LDS        R16, _CountSecondsRealTimePv_ReConnect_T1+0
	LDS        R17, _CountSecondsRealTimePv_ReConnect_T1+1
	CPI        R17, 0
	BRNE       L__Timer_Interrupt_ReadBattery975
	CPI        R16, 1
L__Timer_Interrupt_ReadBattery975:
	BREQ       L__Timer_Interrupt_ReadBattery976
	JMP        L_Timer_Interrupt_ReadBattery525
L__Timer_Interrupt_ReadBattery976:
	LDS        R16, _SecondsRealTimePv_ReConnect_T1+0
	LDS        R17, _SecondsRealTimePv_ReConnect_T1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _SecondsRealTimePv_ReConnect_T1+0, R16
	STS        _SecondsRealTimePv_ReConnect_T1+1, R17
L_Timer_Interrupt_ReadBattery525:
;Solar_Loads_Controller_SLCM_V1.c,1496 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1  && RunWithOutBattery==false && RunOnBatteryVoltageWithoutTimer_Flag==0)
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
	BREQ       L__Timer_Interrupt_ReadBattery977
	LDI        R16, 1
L__Timer_Interrupt_ReadBattery977:
	TST        R16
	BRNE       L__Timer_Interrupt_ReadBattery978
	JMP        L__Timer_Interrupt_ReadBattery758
L__Timer_Interrupt_ReadBattery978:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Timer_Interrupt_ReadBattery757
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Timer_Interrupt_ReadBattery979
	JMP        L__Timer_Interrupt_ReadBattery756
L__Timer_Interrupt_ReadBattery979:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__Timer_Interrupt_ReadBattery980
	JMP        L__Timer_Interrupt_ReadBattery755
L__Timer_Interrupt_ReadBattery980:
L__Timer_Interrupt_ReadBattery754:
;Solar_Loads_Controller_SLCM_V1.c,1498 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1499 :: 		CountSecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _CountSecondsRealTimePv_ReConnect_T1+0, R27
	STS        _CountSecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1500 :: 		Start_Timer_0_A();         // give some time for battery voltage
	CALL       _Start_Timer_0_A+0
;Solar_Loads_Controller_SLCM_V1.c,1496 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1  && RunWithOutBattery==false && RunOnBatteryVoltageWithoutTimer_Flag==0)
L__Timer_Interrupt_ReadBattery758:
L__Timer_Interrupt_ReadBattery757:
L__Timer_Interrupt_ReadBattery756:
L__Timer_Interrupt_ReadBattery755:
;Solar_Loads_Controller_SLCM_V1.c,1503 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1 && RunWithOutBattery==false && RunOnBatteryVoltageWithoutTimer_Flag==1)
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
	BREQ       L__Timer_Interrupt_ReadBattery981
	LDI        R16, 1
L__Timer_Interrupt_ReadBattery981:
	TST        R16
	BRNE       L__Timer_Interrupt_ReadBattery982
	JMP        L__Timer_Interrupt_ReadBattery762
L__Timer_Interrupt_ReadBattery982:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__Timer_Interrupt_ReadBattery761
	LDS        R16, _RunWithOutBattery+0
	CPI        R16, 0
	BREQ       L__Timer_Interrupt_ReadBattery983
	JMP        L__Timer_Interrupt_ReadBattery760
L__Timer_Interrupt_ReadBattery983:
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 1
	BREQ       L__Timer_Interrupt_ReadBattery984
	JMP        L__Timer_Interrupt_ReadBattery759
L__Timer_Interrupt_ReadBattery984:
L__Timer_Interrupt_ReadBattery753:
;Solar_Loads_Controller_SLCM_V1.c,1505 :: 		SecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _SecondsRealTimePv_ReConnect_T1+0, R27
	STS        _SecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1506 :: 		CountSecondsRealTimePv_ReConnect_T1=0;
	LDI        R27, 0
	STS        _CountSecondsRealTimePv_ReConnect_T1+0, R27
	STS        _CountSecondsRealTimePv_ReConnect_T1+1, R27
;Solar_Loads_Controller_SLCM_V1.c,1507 :: 		Start_Timer_0_A();         // give some time for battery voltage
	CALL       _Start_Timer_0_A+0
;Solar_Loads_Controller_SLCM_V1.c,1503 :: 		if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1 && RunWithOutBattery==false && RunOnBatteryVoltageWithoutTimer_Flag==1)
L__Timer_Interrupt_ReadBattery762:
L__Timer_Interrupt_ReadBattery761:
L__Timer_Interrupt_ReadBattery760:
L__Timer_Interrupt_ReadBattery759:
;Solar_Loads_Controller_SLCM_V1.c,1509 :: 		TurnLoadsOffWhenGridOff();
	CALL       _TurnLoadsOffWhenGridOff+0
;Solar_Loads_Controller_SLCM_V1.c,1511 :: 		OCF1A_bit=1;               //clear flag
	IN         R27, OCF1A_bit+0
	SBR        R27, BitMask(OCF1A_bit+0)
	OUT        OCF1A_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1512 :: 		} // end function
L_end_Timer_Interrupt_ReadBattery:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Timer_Interrupt_ReadBattery

_Stop_Timer_ReadBattery:

;Solar_Loads_Controller_SLCM_V1.c,1513 :: 		void Stop_Timer_ReadBattery()
;Solar_Loads_Controller_SLCM_V1.c,1515 :: 		CS10_Bit=0;
	IN         R27, CS10_bit+0
	CBR        R27, BitMask(CS10_bit+0)
	OUT        CS10_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1516 :: 		CS11_Bit=0;
	IN         R27, CS11_bit+0
	CBR        R27, BitMask(CS11_bit+0)
	OUT        CS11_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1517 :: 		CS12_Bit=0;
	IN         R27, CS12_bit+0
	CBR        R27, BitMask(CS12_bit+0)
	OUT        CS12_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1518 :: 		}
L_end_Stop_Timer_ReadBattery:
	RET
; end of _Stop_Timer_ReadBattery

_WorkingMode:

;Solar_Loads_Controller_SLCM_V1.c,1520 :: 		void WorkingMode()
;Solar_Loads_Controller_SLCM_V1.c,1522 :: 		if(RunOnBatteryVoltageWithoutTimer_Flag==1 && AC_Available==1)
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 1
	BREQ       L__WorkingMode987
	JMP        L__WorkingMode766
L__WorkingMode987:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__WorkingMode765
L__WorkingMode764:
;Solar_Loads_Controller_SLCM_V1.c,1525 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_WorkingMode535:
	DEC        R16
	BRNE       L_WorkingMode535
	DEC        R17
	BRNE       L_WorkingMode535
	DEC        R18
	BRNE       L_WorkingMode535
	NOP
;Solar_Loads_Controller_SLCM_V1.c,1526 :: 		Grid_indicator=1;
	IN         R27, PORTC+0
	SBR        R27, 8
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1527 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_WorkingMode537:
	DEC        R16
	BRNE       L_WorkingMode537
	DEC        R17
	BRNE       L_WorkingMode537
	DEC        R18
	BRNE       L_WorkingMode537
	NOP
;Solar_Loads_Controller_SLCM_V1.c,1528 :: 		Grid_indicator=0;
	IN         R27, PORTC+0
	CBR        R27, 8
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1529 :: 		}
	JMP        L_WorkingMode539
;Solar_Loads_Controller_SLCM_V1.c,1522 :: 		if(RunOnBatteryVoltageWithoutTimer_Flag==1 && AC_Available==1)
L__WorkingMode766:
L__WorkingMode765:
;Solar_Loads_Controller_SLCM_V1.c,1530 :: 		else if( RunOnBatteryVoltageWithoutTimer_Flag== 0 && AC_Available==1)
	LDS        R16, _RunOnBatteryVoltageWithoutTimer_Flag+0
	CPI        R16, 0
	BREQ       L__WorkingMode988
	JMP        L__WorkingMode768
L__WorkingMode988:
	IN         R27, PIND+0
	SBRS       R27, 2
	JMP        L__WorkingMode767
L__WorkingMode763:
;Solar_Loads_Controller_SLCM_V1.c,1533 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_WorkingMode543:
	DEC        R16
	BRNE       L_WorkingMode543
	DEC        R17
	BRNE       L_WorkingMode543
	DEC        R18
	BRNE       L_WorkingMode543
	NOP
;Solar_Loads_Controller_SLCM_V1.c,1534 :: 		Grid_indicator=1;
	IN         R27, PORTC+0
	SBR        R27, 8
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1535 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_WorkingMode545:
	DEC        R16
	BRNE       L_WorkingMode545
	DEC        R17
	BRNE       L_WorkingMode545
	DEC        R18
	BRNE       L_WorkingMode545
	NOP
;Solar_Loads_Controller_SLCM_V1.c,1536 :: 		Grid_indicator=0;
	IN         R27, PORTC+0
	CBR        R27, 8
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1537 :: 		}
	JMP        L_WorkingMode547
;Solar_Loads_Controller_SLCM_V1.c,1530 :: 		else if( RunOnBatteryVoltageWithoutTimer_Flag== 0 && AC_Available==1)
L__WorkingMode768:
L__WorkingMode767:
;Solar_Loads_Controller_SLCM_V1.c,1538 :: 		else if (AC_Available==0)
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L_WorkingMode548
;Solar_Loads_Controller_SLCM_V1.c,1540 :: 		Grid_indicator=1;
	IN         R27, PORTC+0
	SBR        R27, 8
	OUT        PORTC+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1541 :: 		}
L_WorkingMode548:
L_WorkingMode547:
L_WorkingMode539:
;Solar_Loads_Controller_SLCM_V1.c,1542 :: 		}
L_end_WorkingMode:
	RET
; end of _WorkingMode

_CheckSystemBatteryMode:

;Solar_Loads_Controller_SLCM_V1.c,1544 :: 		void CheckSystemBatteryMode()
;Solar_Loads_Controller_SLCM_V1.c,1546 :: 		if      (Vin_Battery>= 35 && Vin_Battery <= 60) SystemBatteryMode=48;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 12
	LDI        R23, 66
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_gequ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__CheckSystemBatteryMode990
	LDI        R16, 1
L__CheckSystemBatteryMode990:
	TST        R16
	BRNE       L__CheckSystemBatteryMode991
	JMP        L__CheckSystemBatteryMode773
L__CheckSystemBatteryMode991:
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 112
	LDI        R23, 66
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_lequ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__CheckSystemBatteryMode992
	LDI        R16, 1
L__CheckSystemBatteryMode992:
	TST        R16
	BRNE       L__CheckSystemBatteryMode993
	JMP        L__CheckSystemBatteryMode772
L__CheckSystemBatteryMode993:
L__CheckSystemBatteryMode771:
	LDI        R27, 48
	STS        _SystemBatteryMode+0, R27
	JMP        L_CheckSystemBatteryMode552
L__CheckSystemBatteryMode773:
L__CheckSystemBatteryMode772:
;Solar_Loads_Controller_SLCM_V1.c,1547 :: 		else if (Vin_Battery>=18 && Vin_Battery <=32) SystemBatteryMode=24;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 144
	LDI        R23, 65
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_gequ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__CheckSystemBatteryMode994
	LDI        R16, 1
L__CheckSystemBatteryMode994:
	TST        R16
	BRNE       L__CheckSystemBatteryMode995
	JMP        L__CheckSystemBatteryMode775
L__CheckSystemBatteryMode995:
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 0
	LDI        R23, 66
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_lequ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__CheckSystemBatteryMode996
	LDI        R16, 1
L__CheckSystemBatteryMode996:
	TST        R16
	BRNE       L__CheckSystemBatteryMode997
	JMP        L__CheckSystemBatteryMode774
L__CheckSystemBatteryMode997:
L__CheckSystemBatteryMode770:
	LDI        R27, 24
	STS        _SystemBatteryMode+0, R27
	JMP        L_CheckSystemBatteryMode556
L__CheckSystemBatteryMode775:
L__CheckSystemBatteryMode774:
;Solar_Loads_Controller_SLCM_V1.c,1548 :: 		else if (Vin_Battery >=1 && Vin_Battery<= 16 ) SystemBatteryMode=12;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 128
	LDI        R23, 63
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_gequ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__CheckSystemBatteryMode998
	LDI        R16, 1
L__CheckSystemBatteryMode998:
	TST        R16
	BRNE       L__CheckSystemBatteryMode999
	JMP        L__CheckSystemBatteryMode777
L__CheckSystemBatteryMode999:
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 128
	LDI        R23, 65
	LDS        R16, _Vin_Battery+0
	LDS        R17, _Vin_Battery+1
	LDS        R18, _Vin_Battery+2
	LDS        R19, _Vin_Battery+3
	CALL       _float_op_lequ+0
	OR         R0, R0
	LDI        R16, 0
	BREQ       L__CheckSystemBatteryMode1000
	LDI        R16, 1
L__CheckSystemBatteryMode1000:
	TST        R16
	BRNE       L__CheckSystemBatteryMode1001
	JMP        L__CheckSystemBatteryMode776
L__CheckSystemBatteryMode1001:
L__CheckSystemBatteryMode769:
	LDI        R27, 12
	STS        _SystemBatteryMode+0, R27
	JMP        L_CheckSystemBatteryMode560
L__CheckSystemBatteryMode777:
L__CheckSystemBatteryMode776:
;Solar_Loads_Controller_SLCM_V1.c,1549 :: 		else SystemBatteryMode=24; // take it as default
	LDI        R27, 24
	STS        _SystemBatteryMode+0, R27
L_CheckSystemBatteryMode560:
L_CheckSystemBatteryMode556:
L_CheckSystemBatteryMode552:
;Solar_Loads_Controller_SLCM_V1.c,1550 :: 		}
L_end_CheckSystemBatteryMode:
	RET
; end of _CheckSystemBatteryMode

_WelcomeScreen:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;Solar_Loads_Controller_SLCM_V1.c,1552 :: 		void WelcomeScreen()
;Solar_Loads_Controller_SLCM_V1.c,1554 :: 		char esc=0;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R27, 0
	STD        Y+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1555 :: 		while(esc!= 255)
L_WelcomeScreen561:
	LDD        R16, Y+0
	CPI        R16, 255
	BRNE       L__WelcomeScreen1003
	JMP        L_WelcomeScreen562
L__WelcomeScreen1003:
;Solar_Loads_Controller_SLCM_V1.c,1557 :: 		esc++;
	LDD        R16, Y+0
	SUBI       R16, 255
	STD        Y+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1558 :: 		Display_On_7Segment_Character(0x92,0xC7,0xC6);
	LDI        R27, 198
	MOV        R4, R27
	LDI        R27, 199
	MOV        R3, R27
	LDI        R27, 146
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,1559 :: 		}
	JMP        L_WelcomeScreen561
L_WelcomeScreen562:
;Solar_Loads_Controller_SLCM_V1.c,1560 :: 		esc=0;
	LDI        R27, 0
	STD        Y+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1561 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_WelcomeScreen563:
	DEC        R16
	BRNE       L_WelcomeScreen563
	DEC        R17
	BRNE       L_WelcomeScreen563
	DEC        R18
	BRNE       L_WelcomeScreen563
	NOP
;Solar_Loads_Controller_SLCM_V1.c,1562 :: 		while (esc!=255)
L_WelcomeScreen565:
	LDD        R16, Y+0
	CPI        R16, 255
	BRNE       L__WelcomeScreen1004
	JMP        L_WelcomeScreen566
L__WelcomeScreen1004:
;Solar_Loads_Controller_SLCM_V1.c,1564 :: 		esc++;
	LDD        R16, Y+0
	SUBI       R16, 255
	STD        Y+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1565 :: 		Display_On_7Segment_Character(0xC1,0x79,0xC0);
	LDI        R27, 192
	MOV        R4, R27
	LDI        R27, 121
	MOV        R3, R27
	LDI        R27, 193
	MOV        R2, R27
	CALL       _Display_On_7Segment_Character+0
;Solar_Loads_Controller_SLCM_V1.c,1566 :: 		}
	JMP        L_WelcomeScreen565
L_WelcomeScreen566:
;Solar_Loads_Controller_SLCM_V1.c,1568 :: 		}
L_end_WelcomeScreen:
	POP        R4
	POP        R3
	POP        R2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _WelcomeScreen

_WDT_Enable:

;Solar_Loads_Controller_SLCM_V1.c,1571 :: 		void WDT_Enable()
;Solar_Loads_Controller_SLCM_V1.c,1575 :: 		SREG_I_bit=0;
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1576 :: 		WDTCR |= (1<<WDTOE) | (1<<WDE);
	IN         R16, WDTCR+0
	ORI        R16, 24
	OUT        WDTCR+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1577 :: 		WDTCR |=  (1<<WDE);               //logic one must be written to WDE regardless of the previous value of the WDE bit.
	IN         R27, WDTCR+0
	SBR        R27, 8
	OUT        WDTCR+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1578 :: 		WDTCR  = (1<<WDE) | (1<<WDP2)| (1<<WDP1) | (1<<WDP0);     // very important the equal as in datasheet examples code
	LDI        R27, 15
	OUT        WDTCR+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1579 :: 		SREG_I_bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1580 :: 		}
L_end_WDT_Enable:
	RET
; end of _WDT_Enable

_WDT_Disable:

;Solar_Loads_Controller_SLCM_V1.c,1582 :: 		void WDT_Disable()
;Solar_Loads_Controller_SLCM_V1.c,1584 :: 		SREG_I_bit=0;
	IN         R27, SREG_I_bit+0
	CBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1585 :: 		WDTCR |= (1<<WDTOE) | (1<<WDE);
	IN         R16, WDTCR+0
	ORI        R16, 24
	OUT        WDTCR+0, R16
;Solar_Loads_Controller_SLCM_V1.c,1587 :: 		WDTCR = 0x00;
	LDI        R27, 0
	OUT        WDTCR+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1589 :: 		SREG_I_bit=1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;Solar_Loads_Controller_SLCM_V1.c,1590 :: 		}
L_end_WDT_Disable:
	RET
; end of _WDT_Disable

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;Solar_Loads_Controller_SLCM_V1.c,1592 :: 		void main() {
;Solar_Loads_Controller_SLCM_V1.c,1593 :: 		Config();
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	CALL       _Config+0
;Solar_Loads_Controller_SLCM_V1.c,1594 :: 		EEPROM_Load(); // load params programs
	CALL       _EEPROM_Load+0
;Solar_Loads_Controller_SLCM_V1.c,1595 :: 		ADCBattery(); // adc configuartion for adc
	CALL       _ADCBattery+0
;Solar_Loads_Controller_SLCM_V1.c,1596 :: 		TWI_Config();
	CALL       _TWI_Config+0
;Solar_Loads_Controller_SLCM_V1.c,1597 :: 		Config_Interrupts();
	CALL       _Config_Interrupts+0
;Solar_Loads_Controller_SLCM_V1.c,1598 :: 		ReadBytesFromEEprom(0x04,(unsigned short *)&Mini_Battery_Voltage,4);       // Loads will cut of this voltgage
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
;Solar_Loads_Controller_SLCM_V1.c,1599 :: 		ReadBytesFromEEprom(0x08,(unsigned short *)&StartLoadsVoltage,4);         //Loads will start based on this voltage
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
;Solar_Loads_Controller_SLCM_V1.c,1600 :: 		ReadBytesFromEEprom(0x12,(unsigned short *)&startupTIme_1,2);
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
;Solar_Loads_Controller_SLCM_V1.c,1601 :: 		ReadBytesFromEEprom(0x15,(unsigned short *)&Cut_Time,2);
	LDI        R27, 2
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_Cut_Time+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_Cut_Time+0)
	MOV        R5, R27
	LDI        R27, 21
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _ReadBytesFromEEprom+0
;Solar_Loads_Controller_SLCM_V1.c,1602 :: 		ReadBytesFromEEprom(0x19,(unsigned short *)&VinBatteryDifference,4);         //Loads will start based on this voltage
	LDI        R27, 4
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(_VinBatteryDifference+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_VinBatteryDifference+0)
	MOV        R5, R27
	LDI        R27, 25
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _ReadBytesFromEEprom+0
;Solar_Loads_Controller_SLCM_V1.c,1603 :: 		WelcomeScreen();
	CALL       _WelcomeScreen+0
;Solar_Loads_Controller_SLCM_V1.c,1604 :: 		Timer_2_Init_Screen();  // this timer is for update screen
	CALL       _Timer_2_Init_Screen+0
;Solar_Loads_Controller_SLCM_V1.c,1605 :: 		Timer_1_A_ReadBattery_Init(); // timer for seconds
	CALL       _Timer_1_A_ReadBattery_Init+0
;Solar_Loads_Controller_SLCM_V1.c,1606 :: 		while(1)
L_main567:
;Solar_Loads_Controller_SLCM_V1.c,1608 :: 		CheckForSet();       // done in interrupt
	CALL       _CheckForSet+0
;Solar_Loads_Controller_SLCM_V1.c,1609 :: 		CheckSystemBatteryMode();
	CALL       _CheckSystemBatteryMode+0
;Solar_Loads_Controller_SLCM_V1.c,1610 :: 		RunTimersNowCheck();
	CALL       _RunTimersNowCheck+0
;Solar_Loads_Controller_SLCM_V1.c,1611 :: 		WorkingMode();
	CALL       _WorkingMode+0
;Solar_Loads_Controller_SLCM_V1.c,1612 :: 		WDT_Enable(); // critical part may
	CALL       _WDT_Enable+0
;Solar_Loads_Controller_SLCM_V1.c,1613 :: 		CheckForTimerActivationInRange();
	CALL       _CheckForTimerActivationInRange+0
;Solar_Loads_Controller_SLCM_V1.c,1614 :: 		CheckForTimerActivationOutRange();
	CALL       _CheckForTimerActivationOutRange+0
;Solar_Loads_Controller_SLCM_V1.c,1616 :: 		Screen_1();       // for reading time
	CALL       _Screen_1+0
;Solar_Loads_Controller_SLCM_V1.c,1617 :: 		Check_Timers();
	CALL       _Check_Timers+0
;Solar_Loads_Controller_SLCM_V1.c,1618 :: 		WDT_Disable();
	CALL       _WDT_Disable+0
;Solar_Loads_Controller_SLCM_V1.c,1619 :: 		TurnLoadsOffWhenGridOff();       // sometine when grid comes fast and cut it will not make interrupt so this second check for loads off
	CALL       _TurnLoadsOffWhenGridOff+0
;Solar_Loads_Controller_SLCM_V1.c,1620 :: 		Delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_main569:
	DEC        R16
	BRNE       L_main569
	DEC        R17
	BRNE       L_main569
	DEC        R18
	BRNE       L_main569
	NOP
;Solar_Loads_Controller_SLCM_V1.c,1621 :: 		}
	JMP        L_main567
;Solar_Loads_Controller_SLCM_V1.c,1622 :: 		}
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
