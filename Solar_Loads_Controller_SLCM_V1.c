/*
timers used:
timer 2    for 7 segment
timer 1 a  for  update battery reading
timer 0    for load off give some time to load

*/
//------------------------------------------------------------------------------
 /*
   memory map   in epprom is : 7
   
0x00 : hours_start
0x01 : minutes_start
0x02: hours_stop_timer
0x03: minutes_stop_timer
0x04 ~ 0x07: battery_cutoff_voltage
0x08 ~ 0x11 : starts_voltage
0x12~0x13: startup time
0x14: run on battery voltage with out timer
0x15~0x16 : cut time for loads
0x17: Ups_mode
0x18: UPO Mode
0x19~0x22 : VinBatteryDifference
0x23: add error
0x24 : run as timer with out battery mode

   */
   
   
 /*
P00: timer on
P01 : timer off
P02 : set battery cut down voltage
P03: start up voltage
P04: start time
P05: run on battery voltage mode
P06: cut time
P07: Ups mode
P08: upo mode
P09: Timer mode
P10: calibrate battery voltage
P11: set ds time

*/
//------------------------------------------------------------------------------
#include "stdint.h"
#include <stdbool.h>
#include "ds1307.h"
//--------------------------------Defines---------------------------------------
#define Relay_L_Solar PORTA.B3
#define Set PIND.B3
#define Decrement PINA.B6
#define Increment PINA.B5
#define AC_Available PIND.B2
#define Display_1 PORTC.B4
#define Display_2 PORTC.B5
#define Display_3 PORTC.B6
#define Grid_indicator PORTC.B3
//-------------------------------Display----------------------------------------
char array[]={0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x90};  //Common Anode Without dp
//-------------------------------Variables--------------------------------------
int a,b,c,d,e,f,g,h;
float num;
float voltage;
int voltage_int;
//------------------------------------------------------------------------------
//-----------------------------------------Variables----------------------------
//unsigned short old_time_compare_pv,old_time_update_pv,old_time_screen_1=0,old_time_screen_2=0; // to async
char set_status=0;    //variable for the set button state
char txt[21];
char seconds_lcd_1=0,minutes_lcd_1=0,hours_lcd_1=0;
char seconds_lcd_2=0,minutes_lcd_2=0,hours_lcd_2=0;
char Relay_State; // variable for toggling relay
char set_ds1307_minutes=12,set_ds1307_hours=12,set_ds1307_seconds=0,set_ds1307_day=0,set_ds1307_month=0,set_ds1307_year=0;
char ByPassState=0;    //enabled is default 0 is enabled and 1 is disabled
float Battery_Voltage;
char BatteryVoltageSystem=0; // to save the battery voltage system if it is 12v/24v/48v
unsigned int ADC_Value;   // adc value for battery voltage
float Vin_Battery;      //voltage of battery
float Mini_Battery_Voltage=0;
char Timer_Enable=1;   // timer 1
char CorrectionTime_State=0;  // this function to solve the error when battery is low and timer didn't start because of the low battery
float v; // ac voltage as global variable
char matched_timer_1_start,matched_timer_1_stop, matched_timer_2_start,matched_timer_2_stop;
char Old_Reg=0;
char Timer_isOn=0,Timer_2_isOn=0;
unsigned int Timer_Counter_2=0, Timer_Counter_3=0,Timer_Counter_4=0;
bool Grid_Already_On=false;            // to not enter conditions as the grid is available
unsigned short old_timer_1=0,old_timer_2=0,temp=0;
unsigned int startupTIme_1=0,startupTIme_2=0;  // 25 seconds for load one to start up and 50 seconds for load 2 to startup
char updateScreen=0;
float arrayBatt[21];
float StartLoadsVoltage=0,StartLoadsVoltage_T2=0;
float BuzzerVoltage=0.1; // voltage added to mini voltage to start giving the alarm before loads switches off
unsigned short ReadMinutesMinusOldTimer_1=0;
unsigned short ReadMinutesMinusOldTimer_2=0;
unsigned int Timer_Counter_For_Grid_Turn_Off=0;
char RunTimersNowState=0;
unsigned int SecondsRealTime=0;         // for holding reading seconds in real time for ac grid and startup timers
unsigned int SecondsRealTimePv_ReConnect_T1=0,SecondsRealTimePv_ReConnect_T2=0; // for reactive timers in sequence when timer switch off because off battery and wants to reload
unsigned int CountSecondsRealTime=0,CountSecondsRealTimePv_ReConnect_T1=0;
unsigned int realTimeLoop=0;
bool RunWithOutBattery=false;
int const ButtonDelay=150;
char RunLoadsByBass=0;
char TurnOffLoadsByPass=0; // to turn off for error
char VoltageProtectorEnableFlag=1;
char RunOnBatteryVoltageWithoutTimer_Flag=0;
char RunBatteryVoltgaeWithoutTimer_isOn=0;                // battery voltage is good
char UPS_Mode=0;                                         // this mode when grid is available and then grid off  it will switch the loads off and then other conditions reload this mode is for run on battery voltage mode   (����� ������� ��� ������ �������� ����� ��� ����� �� ����� ����� ��� ��� ��� ������(
char UPO_Mode=0;                                        // this mode is when grid is available turn loads off directly
unsigned int Cut_Time=0;  // time for cutting loads off
char LoadsAlreadySwitchedOFF=0;
char SystemBatteryMode=0;
unsigned int changeScreen=0;
double VinBatteryError=0.0;
double VinBatteryDifference=0.0;
char addError=0,MinusError=0;
float Vin_Battery_=0.0;
unsigned int DisplayBatteryVoltage=0,DisplayHours=0,DisplayMinutes=0;
unsigned int HoursNow,MinutesNow,SecondsNow;

//-----------------------------------Functions---------------------------------
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
void SetTimer();   // set timer to be activated or not activated
void LowBatteryVoltageAlarm();
unsigned int ReadAC();  //read ac voltage
void CalculateAC();   //calculate ac voltage
void DisplayTimerActivation(); // to display if timer is enabled or disabled on LCD
void SetHighVoltage();
void SetLowVoltage();
void VoltageProtector(unsigned long voltage);
void EnableBatteryGuard();         // this function is for enabling or disable the battery protection
void EnableVoltageGuard();   // AC voltage Protection
void SetACVoltageError() ; // this function to adjust differents in the reading volt because of the error in the resistors
void GetVoltageNow(); // get AC voltage at time
void ToggleBuzzer();
void Start_Timer();
void Stop_Timer();
void ReadPV_Voltage();
void SetLowPV_Voltage();
void RestoreFactorySettings();
void EEPROM_FactorySettings();
void Start_Timer_2_B();   // timer for updating screen
void Start_Timer_0_A();  // timer for pv voltage to shutdown
void Stop_Timer_0();
void Read_PV_Continues();  // to eep updating pv
void Startup_Timers();
void SetStartUpLoadsVoltage();
void RunTimersNow();
void TurnACLoadsByPassOn();
void RunTimersNowCheck();
void Write_Date(); // to set date of ds1307
void Display_On_7Segment(char number);
void Display_On_7Segment_Float(float number);
void Display_On_7Segment_Battery(float num);
void Display_On_7Segment_Character(char chr1,char chr2,char chr3);
void RunOnBatteryVoltageWithoutTimer();
void CutLoadsTime(); // time for cutting loads off when voltage is down
void UPSMode();
void UPOMode();
void WDT_Enable();
void WDT_Disable();
void SetBatteryVoltageError();
void Display_On_7Segment_Hours(unsigned short number);
void Display_On_7Segment_Minutes(unsigned short number);
void RunAsTimerMode();
void Display_OnJustOne_7Segment_Character(char chr1,char chr2, char chr3);
void LoadingScreen();
//------------------------------------------------------------------------------
void Gpio_Init()
{
DDRB=0xFF; // set as output for 7 segment
DDRC.B4=1; // display 1
DDRC.B5=1; // display 2
DDRC.B6=1; // display 3
DDRA.B5=0; // increment as input
DDRA.B6=0; // decrement as input
DDRD.B3=0;  // set as input
DDRD.B2=0; // ac available as input
DDRA.B3=1; // relay as output
DDRC.B3=1; // grid indicator led
}      //------------------------------------------------------------------------------
void Config()
{
GPIO_Init();
}
//------------------------------------------------------------------------------
//------------------------Write Time--------------------------------------------
//-> write time to DS1307
void Write_Time(unsigned int seconds,unsigned int minutes,unsigned int hours)
{
write_Ds1307(0x00,seconds);           //seconds
write_Ds1307(0x01,minutes);          // minutes
write_Ds1307(0x02,hours); // using the 24 hour system
}

//-------------------------Write Data-------------------------------------------
void Write_Date(unsigned int day, unsigned int month,unsigned int year)
{
write_Ds1307(0x04,day);          //01-31
Write_Ds1307(0x05,month);       //01-12
Write_Ds1307(0x06,year);       // 00-99
}
//----------------------------------EEPROM--------------------------------------
void EEPROM_Load()
{
//*****************timer 1****************
hours_lcd_1=EEPROM_Read(0x00);
minutes_lcd_1=EEPROM_Read(0x01);
hours_lcd_2=EEPROM_Read(0x02);
minutes_lcd_2=EEPROM_Read(0x03);
RunOnBatteryVoltageWithoutTimer_Flag=EEPROM_Read(0x14);
UPS_Mode=EEPROM_Read(0x17);
UPO_Mode=EEPROM_Read(0x18);
addError=EEPROM_Read(0x23);
RunWithOutBattery=EEPROM_Read(0x24);  // timer mode with out battery
//**********************************************
ByPassState=0;   // enable is zero  // delete function to be programmed for rom spac
Timer_Enable=1;      // delete function to be programmed for rom space

}
//------------------------------------------------------------------------------
//-> Saving Float Value to EEPROM
void StoreBytesIntoEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
{
unsigned int j;
for (j=0;j<SizeinBytes;j++)
{
EEprom_Write(address+j,*(ptr+j));
Delay_ms(50);
};
}
//------------------------------------------------------------------------------
//-> Reading Float Value from EEPROM
void ReadBytesFromEEprom(unsigned int address,unsigned short *ptr,unsigned int SizeinBytes)
{
unsigned int j;
for (j=0;j<SizeinBytes;j++)
{
*(ptr+j)=EEPROM_Read(address+j);
Delay_ms(50);
}
}
//-------------------------------Check if timers time occured-------------------
void Check_Timers()
{
//-> timer start
if(RunOnBatteryVoltageWithoutTimer_Flag==0)
{
matched_timer_1_start=CheckTimeOccuredOn(seconds_lcd_1,minutes_lcd_1,hours_lcd_1);
matched_timer_1_stop=CheckTimeOccuredOff(seconds_lcd_2,minutes_lcd_2,hours_lcd_2);

//---------------------------- Timer 1 -----------------------------------------
//-> turn Load On
if (matched_timer_1_start==1)
{
Timer_isOn=1;
TurnOffLoadsByPass=0;
//-> when grid is available and timer is on after grid so access the condition to active timer after grid is off
if (AC_Available==1 && Timer_Enable==1  && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && RunOnBatteryVoltageWithoutTimer_Flag==0)
{
Relay_L_Solar=1;

}
//-> if run with out battery is selected
if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true && RunOnBatteryVoltageWithoutTimer_Flag==0 )
{
Relay_L_Solar=1;
}
} // end if ac_available
//-> Turn Load off
//******************************************************************************
if (matched_timer_1_stop==1)
{
Timer_isOn=0;        // to continue the timer after breakout the timer when grid is available
///EEPROM_write(0x49,0);        //- save it to eeprom if power is cut
//-> when grid is available and timer is on after grid so access the condition to active timer after grid is off
if (AC_Available==1 && Timer_Enable==1  &&  RunWithOutBattery==false  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
{
//for the turn off there is no need for delay
SecondsRealTimePv_ReConnect_T1=0;
CountSecondsRealTimePv_ReConnect_T1=0;
Relay_L_Solar=0; // relay off
}
if (AC_Available==1 && Timer_Enable==1  && RunWithOutBattery==true  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
{
//for the turn off there is no need for delay
SecondsRealTimePv_ReConnect_T1=0;
CountSecondsRealTimePv_ReConnect_T1=0;
Relay_L_Solar=0; // relay off
}
}
} // runs on battery if
//}// end if of ac_available
//-------------------------- Timer 1 End----------------------------------------
//**************************Bypass System**************************************

if(AC_Available==0 && UPO_Mode==0 )
{
//Delay_ms(300);       // for error to get one seconds approxmiallty
//SecondsRealTime++;

CountSecondsRealTime=1;
if(SecondsRealTime >= startupTIme_1 && AC_Available==0)
{
Relay_L_Solar=1;
}
} // end function
//---------------------------UPO Mode-------------------------------------------
if (AC_Available==0 && UPO_Mode==1)
{
//Delay_ms(300);
//SecondsRealTime++;

CountSecondsRealTime=1;
if(AC_Available==0 && LoadsAlreadySwitchedOFF==0)
{
LoadsAlreadySwitchedOFF=1;
Relay_L_Solar=0 ;
}
if(SecondsRealTime >= startupTIme_1 && AC_Available==0 && LoadsAlreadySwitchedOFF==1 )
{
Relay_L_Solar=1;
}
}
//------------------------Functions for reactiving timers------------------------
/*
 these function is used for reactiving timers when grid available in the same timer is on or off
*/
//-> if the  ac is shutdown and timer is steel in the range of being on  so reactive timer 1
if (AC_Available==1 && Timer_isOn==1 && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0)
{

//SecondsRealTimePv_ReConnect_T1++;
CountSecondsRealTimePv_ReConnect_T1=1;
//Delay_ms(200);
if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1)     Relay_L_Solar=1;

}
//-> FOR BYPASS MODE
if (AC_Available==1 && Timer_isOn==1  && RunWithOutBattery==true && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0 )
{
//SecondsRealTimePv_ReConnect_T1++;
CountSecondsRealTimePv_ReConnect_T1=1;
//Delay_ms(200);

if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1) Relay_L_Solar=1;

}
//******************Run on Battery Voltage without Timer Mode is ON*************
if (AC_Available==1  && Vin_Battery >= StartLoadsVoltage && RunWithOutBattery==false && TurnOffLoadsByPass==0 && RunOnBatteryVoltageWithoutTimer_Flag==1)
{
//SecondsRealTimePv_ReConnect_T1++;
CountSecondsRealTimePv_ReConnect_T1=1;
//Delay_ms(200);
if (  SecondsRealTimePv_ReConnect_T1 > startupTIme_1)   
{
Relay_L_Solar=1;
}
}

//--------------------------Turn Off Loads for Low battery----------------------

//--Turn Load off when battery Voltage  is Low and AC Not available and Bypass is enabled and timer is enabled
if (Vin_Battery<=Mini_Battery_Voltage && AC_Available==1  && RunWithOutBattery==false && RunLoadsByBass==0 )
{
SecondsRealTimePv_ReConnect_T1=0;
CountSecondsRealTimePv_ReConnect_T1=0;
Start_Timer_0_A();         // give some time for battery voltage
}

}// end of check timers
//******************************************************************************
//---------------------------------Enter Programs ------------------------------
//----------------------------Set up Program------------------------------------
//@ Note: Ente this program if user pressed the button ten seconds
void SetUpProgram()
{  
Delay_ms(500);
//---------------------------------Enter Programs ------------------------------
//-> enter setup mode and don't exit it until the user hit set button
while (Set==0)
{
//-> Enter First Timer Setting and test for exit button at every screen moving in and out
//Delay_ms(500);
SetTimerOn_1();
Delay_ms(500);
SetTimerOff_1();
Delay_ms(500);
SetLowBatteryVoltage();// program 3 to set low battery voltage
Delay_ms(500);
SetStartUpLoadsVoltage(); // program 4 to enable timer or disable
Delay_ms(500);
Startup_Timers();
Delay_ms(500);
RunOnBatteryVoltageWithoutTimer();
Delay_ms(500);
CutLoadsTime();
Delay_ms(500);
UPSMode();
Delay_ms(500);
UPOMode();
Delay_ms(500);
RunAsTimerMode();
Delay_ms(500);
SetBatteryVoltageError();
Delay_ms(500);
SetDS1307_Time();   // program 10
break;   // to break the while
} // end while
}
//-----------------------------Setting Hour Timer 1-----------------------------
void SetTimerOn_1()
{
Delay_ms(500);
while(Set==0)
{
Display_On_7Segment_Character(0x8C,0xC0,0xC0);
}
Delay_ms(500);
while (Set==0)
{
Display_On_7Segment_Hours(hours_lcd_1);
//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment == 1 || Decrement==1)
{
Display_On_7Segment_Hours(hours_lcd_1);
if (Increment==1)
{
delay_ms(ButtonDelay);
hours_lcd_1++;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
hours_lcd_1--;
}

if  (hours_lcd_1>23) hours_lcd_1=0;
if  (hours_lcd_1<0) hours_lcd_1=0;
Timer_isOn=0; //
SecondsRealTimePv_ReConnect_T1=0;    //
} // end while increment
} // end first while

//******************************************************************************
EEPROM_Write(0x00,hours_lcd_1); // save hours 1 timer tp eeprom
Delay_ms(500);     //read time for state
while (Set==0)
{
Display_On_7Segment_Minutes(minutes_lcd_1);
//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment == 1 || Decrement==1)
{
Display_On_7Segment_Minutes(minutes_lcd_1);
if (Increment==1  )
{
delay_ms(ButtonDelay);
minutes_lcd_1++;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
minutes_lcd_1--;
}
//-> perfect
if (minutes_lcd_1>59)    minutes_lcd_1=0;
if (minutes_lcd_1<0) minutes_lcd_1=0;
SecondsRealTimePv_ReConnect_T1=0;
Timer_isOn=0;
} // end while increment and decrement
} // end first while

EEPROM_Write(0x01,minutes_lcd_1); // save minutes 1 timer tp eeprom
}
//--------------------------------Set Timer 1 Off ------------------------------
void SetTimerOff_1()
{
Delay_ms(500);
while(Set==0)
{
Display_On_7Segment_Character(0x8C,0xC0,0xF9);
}
Delay_ms(500);

while (Set==0)
{
Display_On_7Segment_Hours(hours_lcd_2);
//-> to make sure that the value will never be changed until the user press increment or decrement
while(Increment== 1 || Decrement==1)
{
Display_On_7Segment_Hours(hours_lcd_2);
if (Increment==1)
{
delay_ms(ButtonDelay);
hours_lcd_2++;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
hours_lcd_2--;
}
if(hours_lcd_2>23) hours_lcd_2=0;
if (hours_lcd_2<0 ) hours_lcd_2=0;
SecondsRealTimePv_ReConnect_T1=0;
Timer_isOn=0;
} // end while increment or decrement
} // end first while
//******************************************************************************
EEPROM_Write(0x02,hours_lcd_2); // save hours off  timer_1 to eeprom
Delay_ms(500); // read button state
while (Set==0)
{
Display_On_7Segment_Minutes(minutes_lcd_2);
//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment==1 || Decrement==1)
{
Display_On_7Segment_Minutes(minutes_lcd_2);
if (Increment==1)
{

delay_ms(ButtonDelay);
minutes_lcd_2++;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
minutes_lcd_2--;
}

if(minutes_lcd_2>59) minutes_lcd_2=0;
if (minutes_lcd_2<0) minutes_lcd_2=0;
SecondsRealTimePv_ReConnect_T1=0;
Timer_isOn=0;
} // end while increment or decrement
} // end first while
//*********************************Minutes Off**********************************
EEPROM_Write(0x03,minutes_lcd_2); // save minutes off timer_1 to eeprom
}
//----------------------SetLowBatteryVoltage------------------------------------
void SetLowBatteryVoltage()
{
while(Set==0)
{
Display_On_7Segment_Character(0x8C,0xC0,0xA4);
}
Delay_ms(500);
while(Set==0)
{
Display_On_7Segment_Float(Mini_Battery_Voltage);  // to indicate program 2
while (Increment==1 || Decrement==1)
{
Display_On_7Segment_Float(Mini_Battery_Voltage);  // to indicate program 2
if (Increment==1)
{
//Display_On_7Segment_Float(Mini_Battery_Voltage);  // to indicate program 2
Delay_ms(150);
Mini_Battery_Voltage+=0.1;

}
if (Decrement==1)
{
//Display_On_7Segment_Float(Mini_Battery_Voltage);  // to indicate program 2
Delay_ms(150);
Mini_Battery_Voltage-=0.1;
}
if (Mini_Battery_Voltage>65) Mini_Battery_Voltage=0;
if (Mini_Battery_Voltage<0) Mini_Battery_Voltage=0;
} //end wile increment and decrement
}// end first while set
StoreBytesIntoEEprom(0x04,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
}

//---------------------StatrtUp Battery Voltage for Loads-----------------------
void SetStartUpLoadsVoltage()
{
while(Set==0)
{
Display_On_7Segment_Character(0x8C,0xC0,0xB0);
}
Delay_ms(500);;
while(Set==0)
{
Display_On_7Segment_Float(StartLoadsVoltage);
while (Increment==1 || Decrement==1)
{
Display_On_7Segment_Float(StartLoadsVoltage);
if (Increment==1)
{
Delay_ms(150);
StartLoadsVoltage+=0.1;
//Display_On_7Segment_Float(StartLoadsVoltage);
}
if (Decrement==1)
{
Delay_ms(150);
StartLoadsVoltage-=0.1;
//Display_On_7Segment_Float(StartLoadsVoltage);
}
if (StartLoadsVoltage>65) StartLoadsVoltage=0;
if (StartLoadsVoltage<0) StartLoadsVoltage=0;
} //end wile increment and decrement
}// end first while
StoreBytesIntoEEprom(0x08,(unsigned short *)&StartLoadsVoltage,4);   // save float number to eeprom
}
//------------------------------ StartUp Timer----------------------------------
//- > when grid is available and load must turn on they must have time between each
//-> other so solar inverter don't switch off
void Startup_Timers()
{
while(Set==0)
{
Display_On_7Segment_Character(0x8C,0xC0,0x99);          // program 4
}
Delay_ms(500);
while(Set==0)
{
Display_On_7Segment(startupTIme_1);
while(Increment==1 || Decrement==1)
{
Display_On_7Segment(startupTIme_1);
if(Increment==1)
{
//Delay_ms(ButtonDelay);
//Display_On_7Segment(startupTIme_1);
Delay_ms(50);
startupTIme_1++;
}
if(Decrement==1)
{
//Delay_ms(ButtonDelay);
//Display_On_7Segment(startupTIme_1);
Delay_ms(50);
startupTIme_1--;
}
if(startupTIme_1 > 600  ) startupTIme_1=0;
if (startupTIme_1<0) startupTIme_1=0;
} // end  while increment decrement
} // end while main while set
StoreBytesIntoEEprom(0x12,(unsigned short *)&startupTIme_1,2);   // save float number to eeprom
} // end  function
//-----------------------------Set battery Voltage Error------------------------
void SetBatteryVoltageError()
{
while(Set==0)
{
Display_On_7Segment_Character(0x8C,0xF9,0xC0);  // program 10
}
Delay_ms(500);
VinBatteryError=Vin_Battery;
while(Set==0)
{
Display_On_7Segment_Float(VinBatteryError);
while(Increment==1 || Decrement==1)
{
Display_On_7Segment_Float(VinBatteryError);
if(Increment==1)
{
Delay_ms(150);
VinBatteryError+=0.1;
}
if(Decrement==1)
{

Delay_ms(150);
VinBatteryError-=0.1;
}
if(VinBatteryError > 60.0  ) VinBatteryError=0;
if (VinBatteryError<0) VinBatteryError=0;
if (VinBatteryError>Vin_Battery_) addError=1;    // add
if (VinBatteryError<Vin_Battery_) addError=0;    // minus
VinBatteryDifference=fabs(VinBatteryError-Vin_Battery_);
EEPROM_Write(0x23,addError);
StoreBytesIntoEEprom(0x19,(unsigned short *)&VinBatteryDifference,4);   // save float number to eeprom
} // end  while increment decrement
} // end while main while set

}
//----------------------run as timer without battery protection-----------------
void RunAsTimerMode()
{
Delay_ms(500);
while(Set==0)
{
Display_On_7Segment_Character(0x8C,0xC0,0x90);        // program 9
}
Delay_ms(500);
while (Set==0)
{
if(RunWithOutBattery==0)          Display_On_7Segment_Character(0xC0,0x8E,0x8E);        // mode is off
if(RunWithOutBattery==1)          Display_On_7Segment_Character(0xC0,0xC8,0xC8);       // mode is on
//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment == 1 || Decrement==1)
{
if (Increment==1)
{
delay_ms(ButtonDelay);
RunWithOutBattery=1;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
RunWithOutBattery=0;
}
} // end while increment
} // end first while
EEPROM_Write(0x24,RunWithOutBattery); // if zero timer is on and if 1 tiemr is off
}
 //-----------------------------------Set Time----------------------------------
  //-------------------------------SetDS1307HoursDSProgram----------------------
void SetDS1307_Time()
{
/*while(Set==0)
{
Display_On_7Segment(6);  // to indicate program 3
}*/
set_ds1307_minutes=ReadMinutes();      // to read time now
set_ds1307_hours=ReadHours();          // to read time now

Delay_ms(500);
while(Set==0)
{
Display_On_7Segment_Character(0x8C,0xF9,0xF9);        // program 11
}
Delay_ms(500);
while (Set==0)
{
Display_On_7Segment(set_ds1307_hours);
while (Increment==1 || Decrement==1 )
{
Display_On_7Segment(set_ds1307_hours);
if (Increment==1)
{
delay_ms(ButtonDelay);
set_ds1307_hours++;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
set_ds1307_hours--;
}
if(set_ds1307_hours>23) set_ds1307_hours=0;
if (set_ds1307_hours<0) set_ds1307_hours=0;
} // end while decrement or increment
} // end first while
//******************************?Minutes Program********************************
Delay_ms(500);
while(Set==0)
{
Display_On_7Segment_Character(0xC8,0xC8,0xCF);
}
Delay_ms(500);
while (Set==0)
{
Display_On_7Segment(set_ds1307_minutes);
while (Increment==1 || Decrement==1)
{
Display_On_7Segment(set_ds1307_minutes);
if (Increment==1)
{
delay_ms(ButtonDelay);
set_ds1307_minutes++;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
set_ds1307_minutes--;
}
if(set_ds1307_minutes>59) set_ds1307_minutes=0;
if(set_ds1307_minutes<0) set_ds1307_minutes=0;
} // end while decrement or increment
} // end first while
//*******************************Seconds****************************************
Delay_ms(500);
while(Set==0)
{
Display_On_7Segment_Character(0x92,0x86,0xC6);
}
Delay_ms(500);
while (Set==0)
{
Display_On_7Segment(set_ds1307_seconds);
while(Increment==1 || Decrement==1)
{
Display_On_7Segment(set_ds1307_seconds);
if (Increment==1)
{
delay_ms(ButtonDelay);
set_ds1307_seconds++;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
set_ds1307_seconds--;
}
if (set_ds1307_seconds>59) set_ds1307_seconds=0;
if (set_ds1307_seconds<0) set_ds1307_seconds=0;
//-> Send Now time to ds1307 to be set
//-> to force user to change the time when the last seconds options is changing it must be saved
Write_Time(Dec2Bcd(set_ds1307_seconds),Dec2Bcd(set_ds1307_minutes),Dec2Bcd(set_ds1307_hours)); // write time to DS1307
} // end while decrement or increment
} // end first while
//---------------------------------Set Date-------------------------------------
set_ds1307_day=ReadDate(0x04);  // read day
Delay_ms(500);
while(Set==0)
{
Display_On_7Segment_Character(0xC0,0x88,0x91);
}
Delay_ms(500);
while (Set==0)
{
Display_On_7Segment(set_ds1307_day);
while(Increment==1 || Decrement==1)
{
Display_On_7Segment(set_ds1307_day);
if (Increment==1)
{
delay_ms(ButtonDelay);
set_ds1307_day++;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
set_ds1307_day--;
}
if (set_ds1307_day>31) set_ds1307_day=0;
if (set_ds1307_day<0) set_ds1307_day=0;
}  // end while increment or decrement
} //  end while set
//********************************Months****************************************

set_ds1307_month=ReadDate(0x05);     // month
Delay_ms(500);
while(Set==0)
{
Display_On_7Segment_Character(0xC8,0xC0,0xC8);
}
Delay_ms(500);
while (Set==0)
{
Display_On_7Segment( set_ds1307_month);
while(Increment==1 || Decrement==1)
{
Display_On_7Segment( set_ds1307_month);
if (Increment==1)
{
delay_ms(ButtonDelay);
set_ds1307_month++;

}
if (Decrement==1)
{
delay_ms(ButtonDelay);
set_ds1307_month--;
}
if (set_ds1307_month>12) set_ds1307_month=0;
if (set_ds1307_month<0) set_ds1307_month=0;
}  // end while increment or decrement
} //  end while set
//*************************************Years************************************

set_ds1307_year=ReadDate(0x06);
Delay_ms(500);
while(Set==0)
{
Display_On_7Segment_Character(0x91,0x86,0x88);
}
Delay_ms(500);
while (Set==0)
{
Display_On_7Segment( set_ds1307_year);
while(Increment==1 || Decrement==1)
{
Display_On_7Segment( set_ds1307_year);
if (Increment==1)
{
delay_ms(ButtonDelay);
set_ds1307_year++;

}
if (Decrement==1)
{
delay_ms(ButtonDelay);
set_ds1307_year--;
}
if (set_ds1307_year>99) set_ds1307_year=0;
if (set_ds1307_year<0) set_ds1307_year=0;

}  // end while increment or decrement
} //  end while set
Write_Date(Dec2Bcd(set_ds1307_day),Dec2Bcd(set_ds1307_month),Dec2Bcd(set_ds1307_year)); // write Date to DS1307
}  // end setTimeAndData

//---------------Disable Timers for running on voltage battery------------------
void RunOnBatteryVoltageWithoutTimer()
{
Delay_ms(500);
while(Set==0)
{
Display_On_7Segment_Character(0x8C,0xC0,0x92);        // program 5
}
Delay_ms(500);
while (Set==0)
{
if(RunOnBatteryVoltageWithoutTimer_Flag==0)          Display_On_7Segment_Character(0xC0,0x8E,0x8E);        // mode is off so timer is on
if(RunOnBatteryVoltageWithoutTimer_Flag==1)          Display_On_7Segment_Character(0xC0,0xC8,0xC8);       // mode is on so timer is off
//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment == 1 || Decrement==1)
{
if (Increment==1)
{
delay_ms(ButtonDelay);
RunOnBatteryVoltageWithoutTimer_Flag=0;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
RunOnBatteryVoltageWithoutTimer_Flag=1;
}
} // end while increment
} // end first while
EEPROM_Write(0x14,RunOnBatteryVoltageWithoutTimer_Flag); // if zero timer is on and if 1 tiemr is off
}
//------------------------------Cut Loads Time----------------------------------
void CutLoadsTime()
{
Delay_ms(500);
while(Set==0)
{
Display_On_7Segment_Character(0x8C,0xC0,0x82);        // program 6
}
Delay_ms(500);
while (Set==0)
{
Display_On_7Segment(Cut_Time);
//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment == 1 || Decrement==1)
{
Display_On_7Segment(Cut_Time);
if (Increment==1)
{
delay_ms(50);
Cut_Time++;
}
if (Decrement==1)
{
delay_ms(50);
Cut_Time--;
}
} // end while increment
} // end first while
StoreBytesIntoEEprom(0x15,(unsigned short *)&Cut_Time,4);   // save float number to eeprom
}
//------------------------------UPS Mode----------------------------------------
/*
@Note: UPS Mode when this mode is activated then when grid is on and then off 
the loads will switch off and then run again according to the conditions
*/
void UPSMode()
{
Delay_ms(500);
while(Set==0)
{
Display_On_7Segment_Character(0x8C,0xC0,0xF8);        // program 7
}
Delay_ms(500);
while (Set==0)
{
if(UPS_Mode==0)          Display_On_7Segment_Character(0xC0,0x8E,0x8E);        // mode is off
if(UPS_Mode==1)          Display_On_7Segment_Character(0xC0,0xC8,0xC8);       // mode is on
//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment == 1 || Decrement==1)
{
if (Increment==1)
{
delay_ms(ButtonDelay);
UPS_Mode=1;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
UPS_Mode=0;
}
} // end while increment
} // end first while
EEPROM_Write(0x17,UPS_Mode); // if zero timer is on and if 1 tiemr is off
}

//-------------------------------UPO Mode---------------------------------------
/*
UPO Mode: when activated when grid is on the load will switch off and then reload
*/
void UPOMode()
{
Delay_ms(500);
while(Set==0)
{
Display_On_7Segment_Character(0x8C,0xC0,0x80);        // program 8
}
Delay_ms(500);
while (Set==0)
{
if(UPO_Mode==0)          Display_On_7Segment_Character(0xC0,0x8E,0x8E);        // mode is off
if(UPO_Mode==1)          Display_On_7Segment_Character(0xC0,0xC8,0xC8);       // mode is on
//-> to make sure that the value will never be changed until the user press increment or decrement
while (Increment == 1 || Decrement==1)
{
if (Increment==1)
{
delay_ms(ButtonDelay);
UPO_Mode=1;
}
if (Decrement==1)
{
delay_ms(ButtonDelay);
UPO_Mode=0;
}
} // end while increment
} // end first while
EEPROM_Write(0x18,UPO_Mode); // if zero timer is on and if 1 tiemr is off
}
 //----------------------------Screen 1-----------------------------------------
void Screen_1()
{
if (RunOnBatteryVoltageWithoutTimer_Flag==0)    Read_Time();

//Read_Battery();
}
//----------------------------ADC Battery Voltage 12v/24v/48v-------------------
void ADCBattery()
{
ADC_Init();
ADC_Init_Advanced(_ADC_EXTERNAL_REF);
ADPS2_Bit=1;
ADPS1_Bit=1;
ADPS0_Bit=0;
}
//--------------------------Read Battery Voltage--------------------------------
void Read_Battery()
{
float sum=0 , Battery[10];
char i=0;
ADC_Value=ADC_Read(1);
Battery_Voltage=(ADC_Value *5.0)/1024.0;
/*Vadc=Vin* (4.7K /100K) => Vin=(104.7/4.7k) * VADC*/
//100k*1.01=99K , 4.7K *1.01=4.653
///Vin_Battery=((10.5/0.5)*Battery_Voltage); // 0.3 volt error from reading
for ( i=0; i<10 ; i++)
{
Battery[i]=((10.5/0.5)*Battery_Voltage);
//delay_ms(1);
sum+=Battery[i];
}
Vin_Battery_= sum/10.0 ;
if (addError==1) Vin_Battery=Vin_Battery_+VinBatteryDifference;
else if(addError==0)  Vin_Battery=Vin_Battery_-VinBatteryDifference;

}
//-----------------------------------Timer 3 -----------------------------------
//-> this timer is used for giving some time to pv to turn off the loads
void Start_Timer_0_A()
{
WGM00_bit=0;
WGM01_bit=0;
CS00_bit=1; // prescalar 1024
CS02_bit=1; //prescalar 1024
SREG_I_Bit=1;
OCR0=0xFF;
OCIE0_Bit=1;
}

//------------------------------------------------------------------------------
void Interupt_Timer_0_OFFTime() iv IVT_ADDR_TIMER0_COMP
{
SREG_I_Bit=0; // disable interrupts
Timer_Counter_3++;                // timer for battery voltage
Timer_Counter_For_Grid_Turn_Off++;   // timer for switching load off

if(Timer_Counter_3==30*Cut_time)   // 1 seconds  for timer counter is 30 counts                7812 / 255 count =  1 second
{
if(Vin_Battery<=Mini_Battery_Voltage && AC_Available==1 && RunLoadsByBass==0)
{
SecondsRealTime=0;
Relay_L_Solar=0;
}
Timer_Counter_3=0;
Stop_Timer_0();
}
SREG_I_Bit=1;
OCF0_Bit=1; // clear
}
//------------------------------------------------------------------------------
void Stop_Timer_0()
{
CS00_bit=0;
CS01_bit=0;
CS02_bit=0;
}

//---------------------------Load EEPROM Factory Settings-----------------------
void EEPROM_FactorySettings(char period)
{
if(period==1) // summer  timer
{
if(SystemBatteryMode==12)
{
Mini_Battery_Voltage=12.5;
StartLoadsVoltage=13.5;
}
if(SystemBatteryMode==24)
{
Mini_Battery_Voltage=25.0;
StartLoadsVoltage=27.0;
}
if(SystemBatteryMode==48)
{
Mini_Battery_Voltage=50;
StartLoadsVoltage=54.0;
}

startupTIme_1 =180;
Cut_Time=15;
VinBatteryDifference=0.0;
addError=1;
//*****************timer 1****************
EEPROM_Write(0x00,8);  // writing start hours
EEPROM_Write(0x01,0);    // writing  start minutes
EEPROM_Write(0x02,17);    // writing off hours
EEPROM_Write(0x03,0);    // writing off minutes
//**********************************************
EEPROM_write(0x14,0);    // timer is on and RunOnBatteryVolatgeWithoutTimer is off
EEPROM_Write(0x17,0);    // ups mode is off
EEPROM_Write(0x18,0);     //upo mode
EEPROM_Write(0x23,1);     //add error is on so add error to vin battery
EEPROM_Write(0x24,0);     //run as timer without battery protection
//--------------------------------
StoreBytesIntoEEprom(0x04,(unsigned short *)&Mini_Battery_Voltage,4);   // save float number to eeprom
StoreBytesIntoEEprom(0x08,(unsigned short *)&StartLoadsVoltage,4);
StoreBytesIntoEEprom(0x12,(unsigned short *)&startupTIme_1,2);
StoreBytesIntoEEprom(0x15,(unsigned short *)&Cut_Time,2);
StoreBytesIntoEEprom(0x19,(unsigned short *)&VinBatteryDifference,4);
}
}
//---------------This function is for making timers run now---------------------
void RunTimersNowCheck()
{
SREG_I_bit=0;
if (Button(&PINA,5,1000,1 ) && Button(&PINA,6,1000,0 )) // if increment pressed for 1 second
{
RunLoadsByBass=1;
if (  RunLoadsByBass==1 ) Relay_L_Solar=1;
}
//---------------------------------Reset to Summer time-------------------------
if (Button(&PINA,6,1000,1)  && Button(&PINA,5,1000,1))     // up & Down for 1 seconds reset mode
{
char esc=0;
EEPROM_FactorySettings(1);        // summer time in this version i deleted winter time
Delay_ms(100);
EEPROM_Load();    // read the new values from epprom
Delay_ms(100);
while(esc!=255)
{
esc++;
Display_On_7Segment_Character(0x88,0x92,0xB8);     //RST
}
}
///-----------------------------ShutDown Loads-----------------------------------

if(Decrement==1 && Increment==0)
{
Delay_ms(2000);
if (Decrement==1 && Increment==0 )
{
TurnOffLoadsByPass=1;    // this variable if user shutdown loads it will not reactive  until next timer or restart the controller
RunLoadsByBass=0;
Relay_L_Solar=0;
}
}
SREG_I_bit=1;
}
//------------------------Auto program For battery------------------------------
//@this program used for running timers without battery and to be set auto
void AutoRunWithOutBatteryProtection()
{
if (Vin_Battery==0)
{
RunWithOutBattery=true;
}
else
{
RunWithOutBattery=false;
}
}
//-------------------Check for timer activation inside range--------------------
void CheckForTimerActivationInRange()
{
if (RunOnBatteryVoltageWithoutTimer_Flag==0)
{
//-> first compare is hours
if(ReadHours() > hours_lcd_1 && ReadHours()< hours_lcd_2)
{
Timer_isOn=1;
}
//-> seconds compare hours if equal now then compare minutes
if(ReadHours()== hours_lcd_1 || ReadHours()== hours_lcd_2)
{
if(ReadHours()==hours_lcd_1)
{
//-> minutes must be bigger
if(ReadMinutes()>=minutes_lcd_1) Timer_isOn=1;
}
if(ReadHours()==hours_lcd_2)
{
//-> minutes must be less
if(ReadMinutes()<= minutes_lcd_2) Timer_isOn=1;
}
}
/*//-a to turn on loadsinside range
if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() < hours_lcd_2 && RunOnBatteryVoltageWithoutTimer_Flag==0  )
{
Timer_isOn=1;
}

//-b----------------------------------------------------------------------------
if (ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() == hours_lcd_2  && RunOnBatteryVoltageWithoutTimer_Flag==0)
{
// study the state
if(ReadMinutes() < minutes_lcd_2)        // starts the load
{
Timer_isOn=1;
}
}*/
} // runs on battery voltage
}  // end function
//**************************** Check timer out of range ************************
void CheckForTimerActivationOutRange()
{
if (RunOnBatteryVoltageWithoutTimer_Flag==0)
{
 //-a turn off loads out of time range  range
/*if(ReadHours() >= hours_lcd_1 && ReadMinutes() >= minutes_lcd_1 && ReadHours() >= hours_lcd_2 && ReadMinutes()>=minutes_lcd_2  && RunOnBatteryVoltageWithoutTimer_Flag==0 )
{
Timer_isOn=0;
}*/

if (ReadHours() < hours_lcd_1  && ReadHours() < hours_lcd_2 )
{
Timer_isOn=0;
}

if (ReadHours() > hours_lcd_1  && ReadHours() > hours_lcd_2 )
{
Timer_isOn=0;
}


if (ReadHours()==hours_lcd_1)
{
if(ReadMinutes() < minutes_lcd_1)
{
Timer_isOn=0;
}
}
//-> check for hours
if (ReadHours()==hours_lcd_2)
{
if(ReadMinutes() > minutes_lcd_2)
{
Timer_isOn=0;
}
}
}
}

//-------------------Function for turning off loads-----------------------------
void TurnLoadsOffWhenGridOff()
{
//-> working on timer mode
/*
 ��� ������ �������� ���� ���� ����� ������ ���� ���� ������� ����

*/
if(AC_Available==1 && Timer_isOn==0 && RunLoadsByBass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0  )
{
SecondsRealTime=0;
CountSecondsRealTime=0;
SecondsRealTimePv_ReConnect_T1=0;
CountSecondsRealTimePv_ReConnect_T1=0;
Relay_L_Solar=0;
LoadsAlreadySwitchedOFF=0;
}
/*
UPO Mode:
��� ���� �������� ��� ��� ����� �� ����� ������ �������� ��� ������ �������� ���� ������� ����� ��� ����� ����� ���� ��� �����
��� ���� ��� �������� ���� ���� ����� ����� �����
�������� ��� �� ����� ��� �������� ����� ����� ���� ������ ��� ����� ������� �������� ���� ������ ��� ���� ������� ��� ���� ���� ����� �����
���� ����� �����  ������ ���  290
*/
if(AC_Available==1 &&  RunLoadsByBass==0 && UPO_Mode==1 && LoadsAlreadySwitchedOFF==1)
{
LoadsAlreadySwitchedOFF=0;
SecondsRealTime=0;
SecondsRealTimePv_ReConnect_T1=0;
CountSecondsRealTimePv_ReConnect_T1=0;
CountSecondsRealTime=0;
}
//-> end of working on timer mode
}
//##############################################################################
//******************************7Segmen Functions-------------------------------
//------------------------------------------------------------------------------
void Display_On_7Segment_Battery(float num)
{
///////////to Display Floating Number with Just three Digits ////////////////////
num = num*10;      //(Becuase there is just three digits that i want to Display
voltage_int=(int)num;      // Convert the Value to Int and Display just three Digits
a=voltage_int%10;    //3th digit is saved here
b=voltage_int/10;
c=b%10;       //2rd digit is saved here
d=b/10;
e=d%10;      //1nd digit is saved here
f=d/10;
Display_3=1;    // 3 th digit
PORTB=array[a];
Delay_ms(1);
Display_3=0;
Display_2=1;
PORTB=array[c] & 0x7F;   // second    7F for turning on dp
Delay_ms(1);
Display_2=0;
if ( e!=0)  // if num=8.1 it will show 08.1 on 7 segment
{
Display_1=1;
PORTB=array[e];
Delay_ms(1);
Display_1=0;
}
else
{
Display_1=0;
}
}
//--------------------------------Display---------------------------------------
void Display_On_7Segment(unsigned short number)
{
number=number;
a=number%10;    //3th digit is saved here
b=number/10;
c=b%10;       //2rd digit is saved here
d=b/10;
e=d%10;      //1nd digit is saved here
f=d/10;
Display_3=1;    // 3 th digit
PORTB=array[a];
Delay_ms(1);
Display_3=0;
Display_2=1;
PORTB=array[c] ;   // second    7F for turning on dp
Delay_ms(1);
Display_2=0;
Display_1=1;
PORTB=array[e];
Delay_ms(1);
Display_1=0;
}
//------------------------------------------------------------------------------
void Display_On_7Segment_Float(float number)
{
int convertedNum;
number=number*10;
convertedNum=(int)Number;
a=convertedNum%10;    //3th digit is saved here
b=convertedNum/10;
c=b%10;       //2rd digit is saved here
d=b/10;
e=d%10;      //1nd digit is saved here
f=d/10;
Display_3=1;    // 3 th digit
PORTB=array[a];
Delay_ms(1);
Display_3=0;
Display_2=1;
PORTB=array[c] &0x7F ;   // second    7F for turning on dp
Delay_ms(1);
Display_2=0;
Display_1=1;
PORTB=array[e];
Delay_ms(1);
Display_1=0;
}
//---------------------------------Display Character on 7 Segment---------------
//------------------------------------------------------------------------------
void Display_On_7Segment_Character(char chr1,char chr2,char chr3)
{
Display_3=1;    // 3 th digit
PORTB=chr3;
Delay_ms(1);
Display_3=0;
Display_2=1;
PORTB=chr2 ;   // second    7F for turning on dp
Delay_ms(1);
Display_2=0;
Display_1=1;
PORTB=chr1;
Delay_ms(1);
Display_1=0;
}
//------------------------Display On Just one 7 Segment-------------------------
void Display_OnJustOne_7Segment_Character(char chr1,char chr2,char chr3)
{
if(chr3!=0x00)
{
Display_3=1;    // 3 th digit
PORTB=chr3;
Delay_ms(1);
Display_3=0;
}
if(chr2!=0x00)
{
Display_2=1;
PORTB=chr2 ;   // second    7F for turning on dp
Delay_ms(1);
Display_2=0;
}
if(chr1!=0x00)
{
Display_1=1;
PORTB=chr1;
Delay_ms(1);
Display_1=0;
}
}
//------------------------------Display Hours-----------------------------------
void Display_On_7Segment_Hours(unsigned short number)
{
number=number;
a=number%10;    //3th digit is saved here
b=number/10;
c=b%10;       //2rd digit is saved here
d=b/10;
e=d%10;      //1nd digit is saved here
f=d/10;
Display_3=1;    // 3 th digit
PORTB=array[a];
Delay_ms(1);
Display_3=0;
Display_2=1;
PORTB=array[c] ;   // second    7F for turning on dp
Delay_ms(1);
Display_2=0;
Display_1=1;
PORTB=0x89;
Delay_ms(1);
Display_1=0;
}
//-----------------------------Display Minutes----------------------------------
void Display_On_7Segment_Minutes(unsigned short number)
{
number=number;
a=number%10;    //3th digit is saved here
b=number/10;
c=b%10;       //2rd digit is saved here
d=b/10;
e=d%10;      //1nd digit is saved here
f=d/10;
Display_3=1;    // 3 th digit
PORTB=array[a];
Delay_ms(1);
Display_3=0;
Display_2=1;
PORTB=array[c] ;   // second    7F for turning on dp
Delay_ms(1);
Display_2=0;
Display_1=1;
PORTB=0xC8;
Delay_ms(1);
Display_1=0;
}
//-----------------------------Read Seconds-------------------------------------
void Display_On_7Segment_Seconds(unsigned short number)
{
number=number;
a=number%10;    //3th digit is saved here
b=number/10;
c=b%10;       //2rd digit is saved here
d=b/10;
e=d%10;      //1nd digit is saved here
f=d/10;
Display_3=1;    // 3 th digit
PORTB=array[a];
Delay_ms(1);
Display_3=0;
Display_2=1;
PORTB=array[c] ;   // second    7F for turning on dp
Delay_ms(1);
Display_2=0;
Display_1=1;
PORTB=0x92;
Delay_ms(1);
Display_1=0;
}
//------------------------------Timer Delay-------------------------------------
void Timer_2_Init_Screen()
{
/*
* Timer Delay function for making 1000ms delay and trigger interrupt ecery 10000ms
* Target Timer Count= (Target time * fosc) / Prescalar
* Target Timer Count= (10 x10^-3 * 8 x 10^6) / 256 = 312 ~ 400 count;
* Timer 1 : 16 Bit
 this function for creating a timer interrupt for making the Display work evry specific time so the entire program will continus working */
SREG_I_bit=1;
TCCR2|= (1<<WGM21);   //choosing compare output mode for timer 2
TCCR2|=(1<<CS22) | (1 <<CS21 ) | ( 1<< CS20) ;    //choosing 1024 prescalar so we can get 1 ms delay for updating Dipslay
OCR2=80;
TIMSK |= (1<<OCIE2);     //enabling interrupt
TIMSK |=(1<<OCF2);
}

void Timer_Interrupt_UpdateScreen() iv IVT_ADDR_TIMER2_COMP
{
//changeScreen++;
if (RunOnBatteryVoltageWithoutTimer_Flag==0)
{
DisplayBatteryVoltage++;
//------------------------------Display Battery---------------------------------
if ( DisplayBatteryVoltage < 5000)
{
Display_On_7Segment_Battery(Vin_Battery); // update display
}
/*//------------------------------Loading Screen----------------------------------
if ( DisplayBatteryVoltage > 5000  && DisplayBatteryVoltage < 5300)
{
LoadingScreen();
}*/
//--------------------------------Display Time----------------------------------

if ( DisplayBatteryVoltage > 5000  && DisplayBatteryVoltage < 5300)
{
Display_On_7Segment_Hours(HoursNow);
}

if ( DisplayBatteryVoltage > 5300  && DisplayBatteryVoltage < 5600)
{
Display_On_7Segment_Minutes(MinutesNow);
}

if (DisplayBatteryVoltage>5600) DisplayBatteryVoltage=0;
} // endif  of run on battery voltage
//-> if battery voltage is not enabled don't display time
else
{
Display_On_7Segment_Battery(Vin_Battery); // update display
}
//------------------------------------------------------------------------------
OCF1A_bit=1;
}
//------------------------------------------------------------------------------
void CheckForSet()
{
SREG_I_Bit=0; // disable interrupts
if (Button(&PIND,3,200,1 ))
{
SetUpProgram();
}
SREG_I_Bit=1; // disable interrupts
}
//-------------------------------------Interrupts-------------------------------
//-> Config the interrupts on ac_avilable pin for when grid is off cut off the loads
void Config_Interrupts()
{
ISC10_bit=1;   // Config interrupts for setup program
ISC11_bit=1;   // Config interrupts for setup program
ISC00_bit=1;   //config interrupts for shutting loads off when grid is off
ISC01_bit=1;   //config interrupts for shutting loads off when grid is off
INT1_bit=1;
INT0_bit=1;
SREG_I_bit=1; // enable the global interrupt vector
}

//---------------External Interrupts for INT1 for ac available------------------
void Interrupt_INT1 () iv IVT_ADDR_INT1
{
SREG_I_Bit=0; // disable interrupts

if (Button(&PIND,3,200,1 ))
{
SetUpProgram();
}
SREG_I_Bit=1; // disable interrupts
INTF1_bit=1;     //clear  flag
}

void Interrupt_INT0_GridOFF() iv IVT_ADDR_INT0
{
/*
when grid goes of make fast turn off loads
*/
SREG_I_Bit=0; // disable interrupts
/*
TIMER MODE WITH UPS IN CUT AC
timer is  activated but working in timr mode and ups is enabled
//@note: i can not use this line in turnoffloads grid main function
*/
/*if(AC_Available==1 && Timer_isOn==1 && RunLoadsByBass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0 && UPS_Mode==1)
{
SecondsRealTime=0;
CountSecondsRealTime=0;
SecondsRealTimePv_ReConnect_T1=0;
CountSecondsRealTimePv_ReConnect_T1=0;
Relay_L_Solar=0;
LoadsAlreadySwitchedOFF=0;
}*/

/*
ups mode : if it is activated switch off loads what ever timer is on or off
run on battery voltage mode is off

*/
if(AC_Available==1 && RunLoadsByBass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0 && UPS_Mode==1  )
{
LoadsAlreadySwitchedOFF=0;
SecondsRealTime=0;
CountSecondsRealTime=0;
SecondsRealTimePv_ReConnect_T1=0;
CountSecondsRealTimePv_ReConnect_T1=0;
Relay_L_Solar=0;
}
/*
WORKING IN TIMER MODE BUT TIMER IS OUT OF RANGE
DON'T MATTER UPS IS ON OR OFF BECAUSE IT WILL TURN OFF LOAD DIRECTLY
*/
if(AC_Available==1 && Timer_isOn==0  && RunLoadsByBass==0 && RunOnBatteryVoltageWithoutTimer_Flag==0 )
{
SecondsRealTime=0;
CountSecondsRealTime=0;
SecondsRealTimePv_ReConnect_T1=0;
CountSecondsRealTimePv_ReConnect_T1=0;
Relay_L_Solar=0;
LoadsAlreadySwitchedOFF=0;
}

//******************************************************************************
//->WORKING ON BATTERY VOLTAGE MODE AND UPS MODE
//@note: i can not use this line in turnoffloads grid main function
/*
ups mode:
��� ���� �������� ������ ��� ��� ����� ������ ������ ������ ����� ���� ���� ������ ���� ������� �������� ���� ����� ��� � ��� ���� ����� ��� �� ��� ����� ����� ��� ����� ���
��� ��� ������ �������� ��� ��� �� ����� ���� ���� �������� ��� ��� ����� �� ���� ������ ��������
*/
if(AC_Available==1 && RunLoadsByBass==0 && RunOnBatteryVoltageWithoutTimer_Flag==1 && UPS_Mode==1  )
{
LoadsAlreadySwitchedOFF=0;
SecondsRealTime=0;
CountSecondsRealTime=0;
SecondsRealTimePv_ReConnect_T1=0;
CountSecondsRealTimePv_ReConnect_T1=0;
Relay_L_Solar=0;
}
/*
UPO Mode:
��� ���� �������� ��� ��� ����� �� ����� ������ �������� ��� ������ �������� ���� ������� ����� ��� ����� ����� ���� ��� �����
��� ���� ��� �������� ���� ���� ����� ����� �����
�������� ��� �� ��    ��� ��� �������� ����� ����� ���� ������ ��� ����� ������� �������� ���� ������ ��� ���� ������� ��� ���� ���� ����� �����
���� ����� �����  ������ ���  290
*/
if(AC_Available==1 &&  RunLoadsByBass==0  && UPO_Mode==1 && LoadsAlreadySwitchedOFF==1)
{
LoadsAlreadySwitchedOFF=0;
SecondsRealTime=0;
SecondsRealTimePv_ReConnect_T1=0;
CountSecondsRealTimePv_ReConnect_T1=0;
CountSecondsRealTime=0;
}

SREG_I_Bit=1; // enable interrupts
INTF0_bit=1; // clear flag
}
//------------------------------------------------------------------------------
//-> timer for reading battery every second
void Timer_1_A_ReadBattery_Init()
{
SREG_I_bit=1 ;   // i already enabled interrupts in vl53l0x but just for make sure
WGM10_bit=0;
WGM11_bit=0;
WGM12_bit=1;
WGM13_bit=0;    //mode 4 ctc mode OCR1A top
CS12_bit=1;    //prescalr 1024
CS10_Bit=1;    //prescalr 1024
OCR1AH=0x14;     //writing high bit first
OCR1AL=0x58;      // (1000*10-3 * 8 *10^6 ) / 1024 = 7812 but found  every 86.8 is 1 second
OCIE1A_bit=1;    //Enable Interrupts CTC Mode
OCF1A_Bit=1;    // clear interrupt flag
}
void Timer_Interrupt_ReadBattery() iv IVT_ADDR_TIMER1_COMPA
{
Read_Battery();     // read battery using timer interrupt

if (CountSecondsRealTime==1) SecondsRealTime++;                                     // for counting real time for  grid count
if (CountSecondsRealTimePv_ReConnect_T1==1) SecondsRealTimePv_ReConnect_T1++; // for counting real time for pv connect
//--Turn Load off when battery Voltage  is Low and AC Not available and Bypass is enabled and timer is enabled
if (Vin_Battery<Mini_Battery_Voltage && AC_Available==1  && RunWithOutBattery==false && RunLoadsByBass==0)
{
SecondsRealTimePv_ReConnect_T1=0;
CountSecondsRealTimePv_ReConnect_T1=0;
Start_Timer_0_A();         // give some time for battery voltage
}

TurnLoadsOffWhenGridOff();

OCF1A_bit=1;               //clear flag
} // end function
void Stop_Timer_ReadBattery()
{
CS10_Bit=0;
CS11_Bit=0;
CS12_Bit=0;
}
//--------------------------Working Mode Flashing Led---------------------------
void WorkingMode()
{
if(RunOnBatteryVoltageWithoutTimer_Flag==1 && AC_Available==1)
{
// flashing fast
Delay_ms(200);
Grid_indicator=1;
Delay_ms(200);
Grid_indicator=0;
}
//-> to indicate time is on
else if( Timer_isOn== 1 && AC_Available==1)
{
// flashing fast
Delay_ms(500);
Grid_indicator=1;
Delay_ms(500);
Grid_indicator=0;
}
//-> to indicate out of range
else if (Timer_isOn==0 && AC_Available==1 && RunOnBatteryVoltageWithoutTimer_Flag==0)
{
// flashing stop
Grid_indicator=0;

}
else if (AC_Available==0)
{
Grid_indicator=1;
}
}
//********************************System Battery Mode 12V/24/48------------------
void CheckSystemBatteryMode() 
{
if      (Vin_Battery>= 35 && Vin_Battery <= 60) SystemBatteryMode=48;
else if (Vin_Battery>=18 && Vin_Battery <=32) SystemBatteryMode=24;
else if (Vin_Battery >=1 && Vin_Battery<= 16 ) SystemBatteryMode=12;
else SystemBatteryMode=24; // take it as default
}
//----------------------------Welcome Message-----------------------------------
void WelcomeScreen()
{
char esc=0;
while(esc!= 255)
{
esc++;
Display_On_7Segment_Character(0x92,0xC7,0xC6);
}

esc=0;
Delay_ms(200);
while (esc!=255)
{
esc++;
Display_On_7Segment_Character(0xC1,0x79,0xB0);       // v1.3e
}
esc=0;
Delay_ms(200);

}

//**************************Watch dog timer*************************************
void WDT_Enable()
{
//asm cli;
//asm wdr;
SREG_I_bit=0;
WDTCR |= (1<<WDTOE) | (1<<WDE);
WDTCR |=  (1<<WDE);               //logic one must be written to WDE regardless of the previous value of the WDE bit.
WDTCR  = (1<<WDE) | (1<<WDP2)| (1<<WDP1) | (1<<WDP0);     // very important the equal as in datasheet examples code
SREG_I_bit=1;
}

void WDT_Disable()
{
SREG_I_bit=0;
WDTCR |= (1<<WDTOE) | (1<<WDE);
//Turn off WDT
WDTCR = 0x00;
//asm sei;
SREG_I_bit=1;
}
//-------------------------Save Time Reading Now--------------------------------
//-> THIS FUNCTION FOR READING TIME AND SAVING THE VALUES INTO VARIABLES BECUASE
// I CAN NOT READ TIME IN TIMER INTERRUPTS BECAUSE DS1307 IS TO SLOW OR THE THE TIME
// WILL BE SLOW CUASING WATCH DOG TIMER TO REST
void ReadTimeNow()
{
if (RunOnBatteryVoltageWithoutTimer_Flag==0)
{
HoursNow=ReadHours();
MinutesNow =ReadMinutes();
SecondsNow=ReadSeconds();
}
}
//--------------------------Loading Screen--------------------------------------
void LoadingScreen()
{
char timeout=0;
char time=150;
while(timeout!=time)
{
 timeout++ ;
 Display_OnJustOne_7Segment_Character(0xFE,0x00,0x00);     // one
}
 timeout=0;
//-------------------------------
while(timeout!=time)
{
 timeout++ ;
Display_OnJustOne_7Segment_Character(0x00,0xFE,0x00);      // one
}
 timeout=0;
//----------------------
while(timeout!=time)
{
 timeout++ ;
Display_OnJustOne_7Segment_Character(0x00,0x00,0xFE);        // one
}
 timeout=0;
//------------------------------------

while(timeout!=time)
{
 timeout++ ;
 Display_OnJustOne_7Segment_Character(0x00,0x00,0xFD);         //two
}
 timeout=0;
//-------------------------------
while(timeout!=time)
{
 timeout++ ;                                                    // two
Display_OnJustOne_7Segment_Character(0x00,0x00,0xFB);
}
 timeout=0;
//----------------------
while(timeout!=time)
{
 timeout++ ;
Display_OnJustOne_7Segment_Character(0x00,0x00,0xF7);           //two
}
 timeout=0;
 //--------------------------three------------------------------
while(timeout!=time)
{
 timeout++ ;
Display_OnJustOne_7Segment_Character(0x00,0xF7,0x00);
}
 timeout=0;
 
 while(timeout!=time)
{
 timeout++ ;
Display_OnJustOne_7Segment_Character(0xF7,0x00,0x00);
}
 timeout=0;
 
  while(timeout!=time)
{
 timeout++ ;
Display_OnJustOne_7Segment_Character(0xEF,0x00,0x00);
}
 timeout=0;
 
    while(timeout!=time)
{
 timeout++ ;
Display_OnJustOne_7Segment_Character(0xDF,0x00,0x00);
}
 timeout=0;
 Delay_ms(1000);
}
//******************************************************************************
void main() {
Config();
EEPROM_Load(); // load params programs
ADCBattery(); // adc configuartion for adc
TWI_Config();
Config_Interrupts();
ReadBytesFromEEprom(0x04,(unsigned short *)&Mini_Battery_Voltage,4);       // Loads will cut of this voltgage
ReadBytesFromEEprom(0x08,(unsigned short *)&StartLoadsVoltage,4);         //Loads will start based on this voltage
ReadBytesFromEEprom(0x12,(unsigned short *)&startupTIme_1,2);
ReadBytesFromEEprom(0x15,(unsigned short *)&Cut_Time,2);
ReadBytesFromEEprom(0x19,(unsigned short *)&VinBatteryDifference,4);         //Loads will start based on this voltage
LoadingScreen();
WelcomeScreen();
Timer_2_Init_Screen();  // this timer is for update screen
Timer_1_A_ReadBattery_Init(); // timer for seconds
while(1)
{ 
CheckForSet();       // done in interrupt
CheckSystemBatteryMode();
RunTimersNowCheck();
WorkingMode();
WDT_Enable(); // critical part may
ReadTimeNow();
CheckForTimerActivationInRange();
CheckForTimerActivationOutRange();
Screen_1();       // for reading time
Check_Timers();
WDT_Disable();
TurnLoadsOffWhenGridOff();       // sometine when grid comes fast and cut it will not make interrupt so this second check for loads off
Delay_ms(200);
}
}