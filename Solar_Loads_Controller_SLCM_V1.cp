#line 1 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Controller Mini SLCM V1.0/MikroC/Solar_Loads_Controller_SLCM_V1.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for avr/include/stdint.h"




typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;



typedef signed char int_fast8_t;
typedef signed int int_fast16_t;
typedef signed long int int_fast32_t;


typedef unsigned char uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned long int uint_fast32_t;


typedef signed int intptr_t;
typedef unsigned int uintptr_t;


typedef signed long int intmax_t;
typedef unsigned long int uintmax_t;
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for avr/include/stdbool.h"



 typedef char _Bool;
#line 1 "f:/eng. riyad/ref/ref codes/riyad_complete_codes/atmega32a/solar auto switcher/solar loads controller mini slcm v1.0/mikroc/ds1307.h"
#line 1 "f:/eng. riyad/ref/ref codes/riyad_complete_codes/atmega32a/solar auto switcher/solar loads controller mini slcm v1.0/mikroc/ds1307.h"
#line 7 "f:/eng. riyad/ref/ref codes/riyad_complete_codes/atmega32a/solar auto switcher/solar loads controller mini slcm v1.0/mikroc/ds1307.h"
void write_Ds1307(unsigned short Address, unsigned short w_data);
unsigned short Read_DS1307(unsigned short Address);
void Read_time();
void TWI_Config();
char CheckTimeOccuredOn(char seconds_required, char minutes_required, char hours_required);
char CheckTimeOccuredOff(char seconds_required, char minutes_required, char hours_required);
char CorrectionLoad();
unsigned short ReadMinutes();
unsigned short ReadHours();




unsigned short ReadDate(unsigned short date_address);
#line 27 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Controller Mini SLCM V1.0/MikroC/Solar_Loads_Controller_SLCM_V1.c"
char array[]={0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x90};

int a,b,c,d,e,f,g,h;
float num;
float voltage;
int voltage_int;



char set_status=0;
char txt[21];
char seconds_lcd_1=0,minutes_lcd_1=0,hours_lcd_1=0;
char seconds_lcd_2=0,minutes_lcd_2=0,hours_lcd_2=0;
char Relay_State;
char set_ds1307_minutes=12,set_ds1307_hours=12,set_ds1307_seconds=0,set_ds1307_day=0,set_ds1307_month=0,set_ds1307_year=0;
char ByPassState=0;
float Battery_Voltage;
char BatteryVoltageSystem=0;
unsigned int ADC_Value;
float Vin_Battery;
float Mini_Battery_Voltage=0;
char Timer_Enable=1;
char CorrectionTime_State=0;
float v;
char matched_timer_1_start,matched_timer_1_stop, matched_timer_2_start,matched_timer_2_stop;
char Old_Reg=0;
char Timer_isOn=0,Timer_2_isOn=0;
unsigned int Timer_Counter_2=0, Timer_Counter_3=0,Timer_Counter_4=0;
 _Bool  Grid_Already_On= 0 ;
unsigned short old_timer_1=0,old_timer_2=0,temp=0;
unsigned int startupTIme_1=0,startupTIme_2=0;
char updateScreen=0;
float arrayBatt[21];
float StartLoadsVoltage=0,StartLoadsVoltage_T2=0;
float BuzzerVoltage=0.1;
unsigned short ReadMinutesMinusOldTimer_1=0;
unsigned short ReadMinutesMinusOldTimer_2=0;
unsigned int Timer_Counter_For_Grid_Turn_Off=0;
char RunTimersNowState=0;
unsigned int SecondsRealTime=0;
unsigned int SecondsRealTimePv_ReConnect_T1=0,SecondsRealTimePv_ReConnect_T2=0;
unsigned int realTimeLoop=0;
 _Bool  RunWithOutBattery= 1 ;
int const ButtonDelay=100;
char RunLoadsByBass=0;
char TurnOffLoadsByPass=0;
char VoltageProtectorEnableFlag=1;
char RunOnBatteryVoltageWithoutTimer_Flag=0;

void EEPROM_Load();
void Gpio_Init();
void Write_Time();
void Config();
void Config_Interrupts();
void SetUpProgram();
void Timer_Delay_Config();
void SetTimerOn_1();
void SetTimerOff_1();
void SetTimerOn_2();
void SetTimerOff_2();
void SetDS1307_Time();
void SetDS1307Minutes_Program();
void SetDS1307Seconds_Program();
void TimerDelay();
void Read_Battery();
void SetLowBatteryVoltage();
void StoreBytesIntoEEprom();
void ReadBytesFromEEprom();
void SetTimer();
void LowBatteryVoltageAlarm();
unsigned int ReadAC();
void CalculateAC();
void DisplayTimerActivation();
void SetHighVoltage();
void SetLowVoltage();
void VoltageProtector(unsigned long voltage);
void EnableBatteryGuard();
void EnableVoltageGuard();
void SetACVoltageError() ;
void GetVoltageNow();
void ToggleBuzzer();
void Start_Timer();
void Stop_Timer();
void ReadPV_Voltage();
void SetLowPV_Voltage();
void RestoreFactorySettings();
void EEPROM_FactorySettings();
void Start_Timer_2_B();
void Start_Timer_0_A();
void Stop_Timer_0();
void Read_PV_Continues();
void Startup_Timers();
void SetStartUpLoadsVoltage();
void RunTimersNow();
void TurnACLoadsByPassOn();
void RunTimersNowCheck();
void Watch_Dog_Timer_Enable();
void Watch_Dog_Timer_Disable();
void Write_Date();
void Display_On_7Segment(char number);
void Display_On_7Segment_Float(float number);
void Display_On_7Segment_Battery(float num);
void Display_On_7Segment_Character(char chr1,char chr2,char chr3);
void RunOnBatteryVoltageWithoutTimer();

void Gpio_Init()
{
DDRB=0xFF;
DDRC.B4=1;
DDRC.B5=1;
DDRC.B6=1;
DDRA.B5=0;
DDRA.B6=0;
DDRD.B3=0;
DDRD.B2=0;
DDRA.B3=1;
DDRC.B3=1;
}
void Config()
{
GPIO_Init();
}



void Write_Time(unsigned int seconds,unsigned int minutes,unsigned int hours)
{
write_Ds1307(0x00,seconds);
write_Ds1307(0x01,minutes);
write_Ds1307(0x02,hours);
}


void Write_Date(unsigned int day, unsigned int month,unsigned int year)
{
write_Ds1307(0x04,day);
Write_Ds1307(0x05,month);
Write_Ds1307(0x06,year);
}

void EEPROM_Load()
{

hours_lcd_1=EEPROM_Read(0x00);
minutes_lcd_1=EEPROM_Read(0x01);
hours_lcd_2=EEPROM_Read(0x02);
minutes_lcd_2=EEPROM_Read(0x03);
RunOnBatteryVoltageWithoutTimer_Flag=EEPROM_Read(0x14);

ByPassState=0;
Timer_Enable=1;

}


void StoreBytesIntoEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
{
unsigned int j;
for (j=0;j<SizeinBytes;j++)
{
EEprom_Write(address+j,*(ptr+j));
Delay_ms(50);
};
}


void ReadBytesFromEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
{
unsigned int j;
for (j=0;j<SizeinBytes;j++)
{
*(ptr+j)=EEPROM_Read(address+j);
Delay_ms(50);
}
}

void Check_Timers()
{

matched_timer_1_start=CheckTimeOccuredOn(seconds_lcd_1,minutes_lcd_1,hours_lcd_1);
matched_timer_1_stop=CheckTimeOccuredOff(seconds_lcd_2,minutes_lcd_2,hours_lcd_2);


if (matched_timer_1_start==1)
{
Timer_isOn=1;
TurnOffLoadsByPass=0;

if ( PIND.B2 ==1 && Timer_Enable==1 && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery== 0  && RunOnBatteryVoltageWithoutTimer_Flag==0)
{
 PORTA.B3 =1;

}

if ( PIND.B2 ==1 && Timer_Enable==1 && RunWithOutBattery== 1  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
{
 PORTA.B3 =1;
}
}


if (matched_timer_1_stop==1)
{
Timer_isOn=0;


if ( PIND.B2 ==1 && Timer_Enable==1 && RunWithOutBattery== 0  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
{

SecondsRealTimePv_ReConnect_T1=0;
 PORTA.B3 =0;
}
if ( PIND.B2 ==1 && Timer_Enable==1 && RunWithOutBattery== 1  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
{

SecondsRealTimePv_ReConnect_T1=0;
 PORTA.B3 =0;
}
}
#line 264 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Controller Mini SLCM V1.0/MikroC/Solar_Loads_Controller_SLCM_V1.c"
if( PIND.B2 ==0 )
{
Delay_ms(300);
SecondsRealTime++;
if(SecondsRealTime >= startupTIme_1 &&  PIND.B2 ==0)
{
 PORTA.B3 =1;
}
}
#line 278 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Controller Mini SLCM V1.0/MikroC/Solar_Loads_Controller_SLCM_V1.c"
if ( PIND.B2 ==1 && Timer_isOn==1 && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery== 0  && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0)
{

SecondsRealTimePv_ReConnect_T1++;
Delay_ms(200);
if ( SecondsRealTimePv_ReConnect_T1 > startupTIme_1)  PORTA.B3 =1;

}
if ( PIND.B2 ==1 && Timer_isOn==1 && RunWithOutBattery== 1  && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0 )
{
SecondsRealTimePv_ReConnect_T1++;
Delay_ms(200);

if ( SecondsRealTimePv_ReConnect_T1 > startupTIme_1)  PORTA.B3 =1;

}

if ( PIND.B2 ==1 && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery== 0  && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==1)
{

SecondsRealTimePv_ReConnect_T1++;
Delay_ms(200);
if ( SecondsRealTimePv_ReConnect_T1 > startupTIme_1)  PORTA.B3 =1;
}



if (Vin_Battery<Mini_Battery_Voltage &&  PIND.B2 ==1 && Timer_isOn==1 && RunWithOutBattery== 0 )
{
SecondsRealTimePv_ReConnect_T1=0;
Start_Timer_0_A();
}
}




void SetUpProgram()
{
Delay_ms(500);
#line 322 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Controller Mini SLCM V1.0/MikroC/Solar_Loads_Controller_SLCM_V1.c"
Delay_ms(500);



while ( PIND.B3 ==0)
{


SetTimerOn_1();
Delay_ms(500);
SetTimerOff_1();
Delay_ms(500);
SetLowBatteryVoltage();
Delay_ms(500);
SetStartUpLoadsVoltage();
Delay_ms(500);
Startup_Timers();
Delay_ms(500);
RunOnBatteryVoltageWithoutTimer();
Delay_ms(500);
SetDS1307_Time();
Delay_ms(500);

break;
}
}

void SetTimerOn_1()
{
Delay_ms(500);
while( PIND.B3 ==0)
{
Display_On_7Segment_Character(0x92,0x92,0xC7);
}
Delay_ms(500);
while ( PIND.B3 ==0)
{
Display_On_7Segment(hours_lcd_1);

while ( PINA.B5  == 1 ||  PINA.B6 ==1)
{
if ( PINA.B5 ==1)
{
delay_ms(ButtonDelay);
hours_lcd_1++;
}
if ( PINA.B6 ==1)
{
delay_ms(ButtonDelay);
hours_lcd_1--;
}

if (hours_lcd_1>23) hours_lcd_1=0;
if (hours_lcd_1<0) hours_lcd_1=0;
Timer_isOn=0;
SecondsRealTimePv_ReConnect_T1=0;
}
}


EEPROM_Write(0x00,hours_lcd_1);
Delay_ms(500);
while ( PIND.B3 ==0)
{
Display_On_7Segment(minutes_lcd_1);

while ( PINA.B5  == 1 ||  PINA.B6 ==1)
{
if ( PINA.B5 ==1 )
{
delay_ms(ButtonDelay);
minutes_lcd_1++;
}
if ( PINA.B6 ==1)
{
delay_ms(ButtonDelay);
minutes_lcd_1--;
}

if (minutes_lcd_1>59) minutes_lcd_1=0;
if (minutes_lcd_1<0) minutes_lcd_1=0;
SecondsRealTimePv_ReConnect_T1=0;
Timer_isOn=0;
}
}

EEPROM_Write(0x01,minutes_lcd_1);
}

void SetTimerOff_1()
{
Delay_ms(500);
while( PIND.B3 ==0)
{
Display_On_7Segment_Character(0x92,0xC0,0xC7);
}
Delay_ms(500);

while ( PIND.B3 ==0)
{
Display_On_7Segment(hours_lcd_2);

while( PINA.B5 == 1 ||  PINA.B6 ==1)
{
if ( PINA.B5 ==1)
{
delay_ms(ButtonDelay);
hours_lcd_2++;
}
if ( PINA.B6 ==1)
{
delay_ms(ButtonDelay);
hours_lcd_2--;
}
if(hours_lcd_2>23) hours_lcd_2=0;
if (hours_lcd_2<0 ) hours_lcd_2=0;
SecondsRealTimePv_ReConnect_T1=0;
Timer_isOn=0;
}
}

EEPROM_Write(0x02,hours_lcd_2);
Delay_ms(500);
while ( PIND.B3 ==0)
{
Display_On_7Segment(minutes_lcd_2);

while ( PINA.B5 ==1 ||  PINA.B6 ==1)
{
if ( PINA.B5 ==1)
{
delay_ms(ButtonDelay);
minutes_lcd_2++;
}
if ( PINA.B6 ==1)
{
delay_ms(ButtonDelay);
minutes_lcd_2--;
}

if(minutes_lcd_2>59) minutes_lcd_2=0;
if (minutes_lcd_2<0) minutes_lcd_2=0;
SecondsRealTimePv_ReConnect_T1=0;
Timer_isOn=0;
}
}


EEPROM_Write(0x03,minutes_lcd_2);
}

void SetLowBatteryVoltage()
{
while( PIND.B3 ==0)
{
Display_On_7Segment_Character(0xC6,0xE3,0xC1);
}
Delay_ms(500);
while( PIND.B3 ==0)
{
Display_On_7Segment_Float(Mini_Battery_Voltage);
while ( PINA.B5 ==1 ||  PINA.B6 ==1)
{
if ( PINA.B5 ==1)
{
Display_On_7Segment_Float(Mini_Battery_Voltage);
Delay_ms(ButtonDelay);
Mini_Battery_Voltage+=0.1;

}
if ( PINA.B6 ==1)
{
Display_On_7Segment_Float(Mini_Battery_Voltage);
Delay_ms(ButtonDelay);
Mini_Battery_Voltage-=0.1;
}
if (Mini_Battery_Voltage>65) Mini_Battery_Voltage=0;
if (Mini_Battery_Voltage<0) Mini_Battery_Voltage=0;
}
}
StoreBytesIntoEEprom(0x04,(unsigned short *)&Mini_Battery_Voltage,4);
}


void SetStartUpLoadsVoltage()
{
while( PIND.B3 ==0)
{
Display_On_7Segment_Character(0x92,0x83,0x9D);
}
Delay_ms(500);;
while( PIND.B3 ==0)
{
Display_On_7Segment_Float(StartLoadsVoltage);
while ( PINA.B5 ==1 ||  PINA.B6 ==1)
{
if ( PINA.B5 ==1)
{
Delay_ms(ButtonDelay);
StartLoadsVoltage+=0.1;
Display_On_7Segment_Float(StartLoadsVoltage);
}
if ( PINA.B6 ==1)
{
Delay_ms(ButtonDelay);
StartLoadsVoltage-=0.1;
Display_On_7Segment_Float(StartLoadsVoltage);
}
if (StartLoadsVoltage>65) StartLoadsVoltage=0;
if (StartLoadsVoltage<0) StartLoadsVoltage=0;
}
}
StoreBytesIntoEEprom(0x08,(unsigned short *)&StartLoadsVoltage,4);
}



void Startup_Timers()
{
while( PIND.B3 ==0)
{
Display_On_7Segment_Character(0x92,0xC7,0x92);
}
Delay_ms(500);;
while( PIND.B3 ==0)
{
Display_On_7Segment(startupTIme_1);
while( PINA.B5 ==1 ||  PINA.B6 ==1)
{
if( PINA.B5 ==1)
{

Display_On_7Segment(startupTIme_1);
Delay_ms(50);
startupTIme_1++;
}
if( PINA.B6 ==1)
{

Display_On_7Segment(startupTIme_1);
Delay_ms(50);
startupTIme_1--;
}
if(startupTIme_1 > 600 ) startupTIme_1=0;
if (startupTIme_1<0) startupTIme_1=0;
}
}
StoreBytesIntoEEprom(0x12,(unsigned short *)&startupTIme_1,2);
}


void SetDS1307_Time()
{
while( PIND.B3 ==0)
{
Display_On_7Segment(6);
}
set_ds1307_minutes=ReadMinutes();
set_ds1307_hours=ReadHours();
Delay_ms(500);
while( PIND.B3 ==0)
{
Display_On_7Segment_Character(0x89,0xC0,0xC1);
}
Delay_ms(500);
while ( PIND.B3 ==0)
{
Display_On_7Segment(set_ds1307_hours);
while ( PINA.B5 ==1 ||  PINA.B6 ==1 )
{
if ( PINA.B5 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_hours++;
}
if ( PINA.B6 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_hours--;
}
if(set_ds1307_hours>23) set_ds1307_hours=0;
if (set_ds1307_hours<0) set_ds1307_hours=0;
}
}

Delay_ms(500);
while( PIND.B3 ==0)
{
Display_On_7Segment_Character(0xC8,0xC8,0xCF);
}
Delay_ms(500);
while ( PIND.B3 ==0)
{
Display_On_7Segment(set_ds1307_minutes);
while ( PINA.B5 ==1 ||  PINA.B6 ==1)
{
if ( PINA.B5 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_minutes++;
}
if ( PINA.B6 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_minutes--;
}
if(set_ds1307_minutes>59) set_ds1307_minutes=0;
if(set_ds1307_minutes<0) set_ds1307_minutes=0;
}
}

Delay_ms(500);
while( PIND.B3 ==0)
{
Display_On_7Segment_Character(0x92,0x86,0xC6);
}
Delay_ms(500);
while ( PIND.B3 ==0)
{
Display_On_7Segment(set_ds1307_seconds);
while( PINA.B5 ==1 ||  PINA.B6 ==1)
{
if ( PINA.B5 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_seconds++;
}
if ( PINA.B6 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_seconds--;
}
if (set_ds1307_seconds>59) set_ds1307_seconds=0;
if (set_ds1307_seconds<0) set_ds1307_seconds=0;


Write_Time(Dec2Bcd(set_ds1307_seconds),Dec2Bcd(set_ds1307_minutes),Dec2Bcd(set_ds1307_hours));
}
}

set_ds1307_day=ReadDate(0x04);
Delay_ms(500);
while( PIND.B3 ==0)
{
Display_On_7Segment_Character(0xC0,0x88,0x91);
}
Delay_ms(500);
while ( PIND.B3 ==0)
{
Display_On_7Segment(set_ds1307_day);
while( PINA.B5 ==1 ||  PINA.B6 ==1)
{

if ( PINA.B5 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_day++;
}
if ( PINA.B6 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_day--;
}
if (set_ds1307_day>31) set_ds1307_day=0;
if (set_ds1307_day<0) set_ds1307_day=0;
}
}


set_ds1307_month=ReadDate(0x05);
Delay_ms(500);
while( PIND.B3 ==0)
{
Display_On_7Segment_Character(0xC8,0xC0,0xC8);
}
Delay_ms(500);
while ( PIND.B3 ==0)
{
Display_On_7Segment( set_ds1307_month);
while( PINA.B5 ==1 ||  PINA.B6 ==1)
{
if ( PINA.B5 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_month++;

}
if ( PINA.B6 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_month--;
}
if (set_ds1307_month>12) set_ds1307_month=0;
if (set_ds1307_month<0) set_ds1307_month=0;
}
}


set_ds1307_year=ReadDate(0x06);
Delay_ms(500);
while( PIND.B3 ==0)
{
Display_On_7Segment_Character(0x91,0x86,0x88);
}
Delay_ms(500);
while ( PIND.B3 ==0)
{
Display_On_7Segment( set_ds1307_year);
while( PINA.B5 ==1 ||  PINA.B6 ==1)
{
if ( PINA.B5 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_year++;

}
if ( PINA.B6 ==1)
{
delay_ms(ButtonDelay);
set_ds1307_year--;
}
if (set_ds1307_year>99) set_ds1307_year=0;
if (set_ds1307_year<0) set_ds1307_year=0;

}
Write_Date(Dec2Bcd(set_ds1307_day),Dec2Bcd(set_ds1307_month),Dec2Bcd(set_ds1307_year));
}
}


void RunOnBatteryVoltageWithoutTimer()
{
Delay_ms(500);
while( PIND.B3 ==0)
{
Display_On_7Segment_Character(0xC1,0xC0,0x80);
}
Delay_ms(500);
while ( PIND.B3 ==0)
{
if(RunOnBatteryVoltageWithoutTimer_Flag==0) Display_On_7Segment_Character(0xC0,0x8E,0x8E);
if(RunOnBatteryVoltageWithoutTimer_Flag==1) Display_On_7Segment_Character(0xC0,0xC8,0xC8);

while ( PINA.B5  == 1 ||  PINA.B6 ==1)
{
if ( PINA.B5 ==1)
{
delay_ms(ButtonDelay);
RunOnBatteryVoltageWithoutTimer_Flag=0;
}
if ( PINA.B6 ==1)
{
delay_ms(ButtonDelay);
RunOnBatteryVoltageWithoutTimer_Flag=1;
}
}
EEPROM_Write(0x14,RunOnBatteryVoltageWithoutTimer_Flag);
}
}

void Screen_1()
{
Read_Time();

}

void ADCBattery()
{
ADC_Init();
ADC_Init_Advanced(_ADC_EXTERNAL_REF);
ADPS2_Bit=1;
ADPS1_Bit=1;
ADPS0_Bit=0;
}

void Read_Battery()
{
float sum=0 , Battery[10];
char i=0;
ADC_Value=ADC_Read(1);
Battery_Voltage=(ADC_Value *5.0)/1024.0;



for ( i=0; i<10 ; i++)
{
Battery[i]=((10.5/0.5)*Battery_Voltage);

sum+=Battery[i];
}
Vin_Battery= sum/10.0 ;

}


void Start_Timer_0_A()
{
WGM00_bit=0;
WGM01_bit=0;
CS00_bit=1;
CS02_bit=1;
SREG_I_Bit=1;
OCR0=0xFF;
OCIE0_Bit=1;
}


void Interupt_Timer_0_OFFTime() iv IVT_ADDR_TIMER0_COMP
{
SREG_I_Bit=0;
Timer_Counter_3++;
Timer_Counter_4++;
Timer_Counter_For_Grid_Turn_Off++;


if (Timer_Counter_3==500)
{
if(Vin_Battery<Mini_Battery_Voltage &&  PIND.B2 ==1)
{
SecondsRealTime=0;
Delay_ms(500);
 PORTA.B3 =0;

}
Timer_Counter_3=0;
Stop_Timer_0();
}



if (Timer_Counter_For_Grid_Turn_Off==1000)
{
if( PIND.B2 ==0)
{
SecondsRealTime=0;
 PORTA.B3 =0;
}
Timer_Counter_For_Grid_Turn_Off=0;
Stop_Timer_0();
}

SREG_I_Bit=1;
OCF0_Bit=1;
}

void Stop_Timer_0()
{
CS00_bit=0;
CS01_bit=0;
CS02_bit=0;
}


void EEPROM_FactorySettings(char period)
{
if(period==1)
{
Mini_Battery_Voltage=24.5,
StartLoadsVoltage=26.5,
startupTIme_1 =180,

EEPROM_Write(0x00,8);
EEPROM_Write(0x01,0);
EEPROM_Write(0x02,17);
EEPROM_Write(0x03,0);

EEPROM_write(0x14,0);

StoreBytesIntoEEprom(0x04,(unsigned short *)&Mini_Battery_Voltage,4);
StoreBytesIntoEEprom(0x08,(unsigned short *)&StartLoadsVoltage,4);
StoreBytesIntoEEprom(0x12,(unsigned short *)&startupTIme_1,2);
}
}

RunTimersNowCheck()
{

if (Button(&PINA,5,1000,1 ) && Button(&PINA,6,1000,0 ))
{
RunLoadsByBass=1;
if ( RunLoadsByBass==1 )  PORTA.B3 =1;
}

if (Button(&PINA,6,1000,1) && Button(&PINA,5,1000,1))
{
EEPROM_FactorySettings(1);
Delay_ms(100);
EEPROM_Load();
Delay_ms(2000);
while(1)
{
Display_On_7Segment_Character(0x88,0x92,0xB8);
}
Delay_ms(2000);
}


if( PINA.B6 ==1 &&  PINA.B5 ==0)
{
Delay_ms(2000);
if ( PINA.B6 ==1 &&  PINA.B5 ==0 )
{
TurnOffLoadsByPass=1;
RunLoadsByBass=0;
 PORTA.B3 =0;
}
}
}


void AutoRunWithOutBatteryProtection()
{
if (Vin_Battery==0)
{
RunWithOutBattery= 1 ;
}
else
{
RunWithOutBattery= 0 ;
}
}

void CheckForTimerActivationInRange()
{


if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2 )
{
Timer_isOn=1;

}


if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2 )
{

if(ReadMinutes() < minutes_lcd_2)
{
Timer_isOn=1;
}
}
}


void TurnLoadsOffWhenGridOff()
{

if( PIND.B2 ==1 && Timer_isOn==0 && RunLoadsByBass==0 )
{
SecondsRealTime=0;
 PORTA.B3 =0;
}
}



void Display_On_7Segment_Battery(float num)
{

num = num*10;
voltage_int=(int)num;
a=voltage_int%10;
b=voltage_int/10;
c=b%10;
d=b/10;
e=d%10;
f=d/10;
 PORTC.B6 =1;
PORTB=array[a];
Delay_ms(1);
 PORTC.B6 =0;
 PORTC.B5 =1;
PORTB=array[c] & 0x7F;
Delay_ms(1);
 PORTC.B5 =0;
if ( e!=0)
{
 PORTC.B4 =1;
PORTB=array[e];
Delay_ms(1);
 PORTC.B4 =0;
}
else
{
 PORTC.B4 =0;
}
}

void Display_On_7Segment(unsigned short number)
{
number=number;
a=number%10;
b=number/10;
c=b%10;
d=b/10;
e=d%10;
f=d/10;
 PORTC.B6 =1;
PORTB=array[a];
Delay_ms(1);
 PORTC.B6 =0;
 PORTC.B5 =1;
PORTB=array[c] ;
Delay_ms(1);
 PORTC.B5 =0;
 PORTC.B4 =1;
PORTB=array[e];
Delay_ms(1);
 PORTC.B4 =0;
}

void Display_On_7Segment_Float(float number)
{
int convertedNum;
number=number*10;
convertedNum=(int)Number;
a=convertedNum%10;
b=convertedNum/10;
c=b%10;
d=b/10;
e=d%10;
f=d/10;
 PORTC.B6 =1;
PORTB=array[a];
Delay_ms(1);
 PORTC.B6 =0;
 PORTC.B5 =1;
PORTB=array[c] &0x7F ;
Delay_ms(1);
 PORTC.B5 =0;
 PORTC.B4 =1;
PORTB=array[e];
Delay_ms(1);
 PORTC.B4 =0;
}


void Display_On_7Segment_Character(char chr1,char chr2,char chr3)
{
 PORTC.B6 =1;
PORTB=chr3;
Delay_ms(1);
 PORTC.B6 =0;
 PORTC.B5 =1;
PORTB=chr2 ;
Delay_ms(1);
 PORTC.B5 =0;
 PORTC.B4 =1;
PORTB=chr1;
Delay_ms(1);
 PORTC.B4 =0;
}

void Timer_2_Init_Screen()
{
#line 1083 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Controller Mini SLCM V1.0/MikroC/Solar_Loads_Controller_SLCM_V1.c"
SREG_I_bit=1;
TCCR2|= (1<<WGM21);
TCCR2|=(1<<CS22) | (1 <<CS21 ) | ( 1<< CS20) ;
OCR2=80;
TIMSK |= (1<<OCIE2);
TIMSK |=(1<<OCF2);
}

void Timer_Interrupt_UpdateScreen() iv IVT_ADDR_TIMER2_COMP
{
Display_On_7Segment_Battery(Vin_Battery);

OCF1A_bit=1;

}

void CheckForSet()
{
SREG_I_Bit=0;
if (Button(&PIND,3,1000,1 ))
{
SetUpProgram();
}
SREG_I_Bit=1;
}


void Config_Interrupts()
{
ISC10_bit=1;
ISC11_bit=1;
ISC00_bit=1;
ISC01_bit=1;
INT1_bit=1;
INT0_bit=1;
SREG_I_bit=1;
}


void Interrupt_INT1 () iv IVT_ADDR_INT1
{
SREG_I_Bit=0;
SetUpProgram();
SREG_I_Bit=1;
INTF1_bit=1;
}

void Interrupt_INT0_GridOFF() iv IVT_ADDR_INT0
{
#line 1135 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Controller Mini SLCM V1.0/MikroC/Solar_Loads_Controller_SLCM_V1.c"
SREG_I_Bit=0;
if( PIND.B2 ==1 && Timer_isOn==0 && RunLoadsByBass==0 )
{
SecondsRealTime=0;
 PORTA.B3 =0;
}
SREG_I_Bit=1;
INTF0_bit=1;
}


void Timer_1_A_ReadBattery_Init()
{
SREG_I_bit=1 ;
WGM10_bit=0;
WGM11_bit=0;
WGM12_bit=1;
WGM13_bit=0;
CS12_bit=1;
CS10_Bit=1;
OCR1AH=0x1E;
OCR1AL=0x84;
OCIE1A_bit=1;
OCF1A_Bit=1;
}
void Timer_Interrupt_ReadBattery() iv IVT_ADDR_TIMER1_COMPA
{
Read_Battery();
OCF1A_bit=1;
}
void Stop_Timer_ReadBattery()
{
CS10_Bit=0;
CS11_Bit=0;
CS12_Bit=0;
}

void main() {
Config();
EEPROM_Load();
ADCBattery();
TWI_Config();
Config_Interrupts();
ReadBytesFromEEprom(0x04,(unsigned short *)&Mini_Battery_Voltage,4);
ReadBytesFromEEprom(0x08,(unsigned short *)&StartLoadsVoltage,4);
ReadBytesFromEEprom(0x12,(unsigned short *)&startupTIme_1,2);
Timer_2_Init_Screen();
Timer_1_A_ReadBattery_Init();
while(1)
{
CheckForSet();
CheckForTimerActivationInRange();
AutoRunWithOutBatteryProtection();
RunTimersNowCheck();
Screen_1();
Check_Timers();
TurnLoadsOffWhenGridOff();
Delay_ms(200);
#line 1197 "F:/ENG. RIYAD/Ref/Ref Codes/Riyad_Complete_Codes/ATMEGA32A/Solar Auto Switcher/Solar Loads Controller Mini SLCM V1.0/MikroC/Solar_Loads_Controller_SLCM_V1.c"
}
}
