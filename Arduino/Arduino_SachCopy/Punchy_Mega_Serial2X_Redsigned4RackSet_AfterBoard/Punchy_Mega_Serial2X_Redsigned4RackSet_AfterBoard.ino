#include <EEPROM.h>
#include <LiquidCrystal.h>
#include <Keypad.h>


String cmdStr;

int HW_ID_eeAddress = 0;   //Location we want the data to be put.
String HW_ID = "123456";//'HWID:10101001010100'

int punch_Direction_eeAddress = 128;
String punch_Direction_value = "10101001010100";
String punch_Direction_default = "10101001010100";

bool cardReady = false;

int opListSize = 15;
char* About[] = {"GeekSynergy" , "AG PUNCH" , "GURU BRAMHA TECH"};
char* opList[] = {"CAR", "REL", "TES", "CST", "CSF", "PUN", "RES" , "HID" , "RDS" , "PND" , "END" , "MHD" , "RBK" , "PDR" , "PDP"};
char* errDescription[] = {"DEVICE NOT READY", "Invalid CMD/DATA", "TERMX UNexpected", "USER-TERMINATED!" , "SEN/SYSTEM ERROR" , "BROKEN CARD" , "INVALID DEVICE", "CARD OVERFLOW", "DEFAULT PNCH DIR" , "DEFAULT PNCH DEPTH"};
char* errCode[] = {"ERR0", "ERR1" , "ERR2" , "ERR3" , "ERR4" , "ERR5" , "ERR6" , "ERR7"};
char* infDescription[] = {"", "MOTOR SPD RANDOM", "RST RACK & START", "PNCH DIR UPDATED" , "TESTING " , "OPERN TERMINATED"};
char* infCode[] = {"INF0", "INF1" , "INF2" , "INF3" , "INF4" , "INF5" , "INF6" , "INF7"};

char* retText[] = {"TES X", "CRST:" , "PNCHD: " , "RTOA" , "HWID:" , "ENTD: ", "PNCD:"};

bool prnt_Updn_Rev = false;

char* menuSelection[] = {"Choose an Option",  "MotorRPM", "Clutch   " , "  Rack  " , "  Brake " , "  Coil  " ,  "ALL Pins" , "MoveHead" , "RackBack" , " Sensors" , " NPrint " , "Invalid KeyInput", "Buzzzzz"};
char* operation[] = {"Opertn Cancelled", "TESTING " , "SUCCESSFUL" , "WAITING FOR DATA"};

bool relayState[] = {false, false, false, false, false}; //<Motor/Klutch/Coil/Brake/Printing><0/1>
int rM = 0;
int rK = 1;
int rC = 2;
int rB = 3;
int rP = 4;

bool opcancelled = false;
char oldval = NO_KEY;

bool punchState[] = {false, false, false, false, false, false, false, false, false, false, false, false, false , false}; //Pins 1-12 and 13
bool punchDirection[] = {true, false, true, false, true, false, false, true, false, true, false, true, false , false}; //Pins 1-12 and 13

int punchDepth = 7;
int punchReleaseDelay = 30;
int testpunchReleaseDelay = 500;

int rackTestSteps = 25;


int entryDistance = 13;

int card_Loc = 0;
int card_Max = 99;
int card_Set[100];
int Nprint_Count = 12;

char* driveDirection[5][2] = {
  {"0011", "1100"},
  {"1001", "1001"},
  {"1100", "0011"},
  {"0110", "0110"},
  {"1111", "1111"}
};



//Pin Configurations
//Mega_Pins Destination_Device Destination_Pins and Info
///////////////// LPT Connections ///////////////////////////////////

int LPT_Address0 = 47;
int LPT_Address1 = 49;
int LPT_Address2 = 51;

int LPT_DSensor = 19;
int LPT_BSensor = 21;
int LPT_FSensor = 20;

int LPT_DATA0 = 22;
int LPT_DATA1 = 23;
int LPT_DATA2 = 24;
int LPT_DATA3 = 25;
int LPT_DATA4 = 26;
int LPT_DATA5 = 27;
int LPT_DATA6 = 28;
int LPT_DATA7 = 29;

int LPT_SysEnable = 53;

/////////////////// LCD 16x02 /////////////////////////////////
#define LCD_RS  30
#define LCD_RW  32
#define LCD_EN  34
#define LCD_D4  42
#define LCD_D5  44
#define LCD_D6  46
#define LCD_D7  48
/////////////////////////////////////////////////////////////
int BUZZ_Pin = 52;

/////////////////////Switches//////////////////////////////
int cancel_Button = 3;
int mode_Button = 18;
int ok_Button = 2;

long debouncing_time = 15; //Debouncing Time in Milliseconds
volatile unsigned long last_micros;

volatile int upstate = LOW;
volatile int dnstate = LOW;
volatile int okstate = LOW;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


const byte ROWS = 4; //four rows
const byte COLS = 4; //three columns
//char keys[ROWS][COLS] = {
//  {'1', '2', '3', 'A'},
//  {'4', '5', '6', 'B'},
//  {'7', '8', '9', 'C'},
//  {'*', '0', '#', 'D'}
//};
char keys[ROWS][COLS] = {
  {'D', 'C', 'B', 'A'},
  {'#', '9', '6', '3'},
  {'0', '8', '5', '2'},
  {'*', '7', '4', '1'}
};
byte rowPins[ROWS] = {A7, A6, A5, A4}; //connect to the row pinouts of the keypad
byte colPins[COLS] = {A3, A2, A1, A0}; //connect to the column pinouts of the keypad

Keypad keypad = Keypad( makeKeymap(keys), rowPins, colPins, ROWS, COLS );

LiquidCrystal lcd(LCD_RS, LCD_EN, LCD_D4, LCD_D5, LCD_D6, LCD_D7);

int reset_idle_Count = 2000;
int Keep_it_Idle = 0;
void setupLCD()
{
  pinMode(LCD_RW, OUTPUT);
  digitalWrite(LCD_RW, LOW);
  lcd.begin (16, 2); //  <<----- My LCD was 16x2
  lcd.home ();
}

void(* resetFunc) (void) = 0; //declare reset function @ address 0

char FetchKeySelection()
{
  char key = keypad.getKey();
  if (key != NO_KEY)
  {
    Serial.println(key);
    return (key);
  }
  else
    return (NO_KEY); //Send an Invalid Entry or Blank Selection
}

void setup()
{
  setupLCD();
  lcd.write(About[2]);
  lcd.setCursor(0, 1);
  lcd.write(errDescription[0]);
  delay(500);

  //  Serial.begin(115200);
  Serial.begin(115200);
  cmdStr.reserve(200);
  initPins();
  initRelays();
  get_set_HID("?");

  attachInterrupt(0, CancelButn, FALLING);
  //  attachInterrupt(5, ShiftButn, FALLING);
  attachInterrupt(1, OKButn, FALLING);



  resetLcd();
  lcd.write(About[2]);
//  rackBack();

}


void resetLcd()
{
  lcd.clear();
  lcd.home();
}

void CancelButn()
{
  lcd.setCursor(0, 1);
  lcd.write(errDescription[3]);
  squeak(10);
  Serial.println("CNCL");
  opcancelled = true;
  // delay(5000);
}

void ShiftButn()
{
  Serial.println("You just pressed the Shift Button");
}

void OKButn()
{
  //  Serial.println("You just pressed the OK Button");
  //  lcd.setCursor(0, 1);
  //  lcd.write(errDescription[3]);
  if (opcancelled == false)
  {
    opcancelled = true;

    squeak(10);
    // Serial.println("RESET / MV HEAD");
    rackBack();
    initRelays();
    relayState[rM] = true;
    relayState[rC] = true;
    driveRelay();
    delay(50000);
    initRelays();
  }

}

void keepAllUnderReset(bool reset)
{
  if (reset)
  { //Turn Off all latches in the following order 012345607012345607
    int i;
    for (i = 0; i < 7; i++)
    {
      if (i == 7)
        driveLatches(0, 0, 0, 0, 0, 0, 0, 0, 0);
      driveLatches(i, 0, 0, 0, 0, 0, 0, 0, 0);
    }
  }

}

void loop()
{
  if (opcancelled | cmdStr == "TES Q") // Should Cancel both hardware and software commands
  {
    lcd.setCursor(0, 1);
    lcd.write(operation[0]);
    cmdStr = opList[2];
    cmdStr.concat(" X");
    opcancelled = false;
    oldval = NO_KEY;
  }

  if (!digitalRead(mode_Button))
  {
    // Do things related to hardware // no sofware inputs affects this operation
    // stop the current action and reset the menu
    // Serial.println("The Device is now in Hardware Mode");
    char newval = FetchKeySelection();
    lcd.setCursor(0, 0);
    lcd.write(menuSelection[0]);
    if (newval != oldval & newval != NO_KEY)
    {
      oldval = newval;
      cmdStr = opList[2]; cmdStr.concat(" X");
    }
    else if (oldval == NO_KEY);
    else
      switch (oldval)
      {
        case '1' :  cmdStr = opList[2]; cmdStr.concat(" M"); break;
        case '2' :  cmdStr = opList[2]; cmdStr.concat(" C"); break;
        case '3' :  cmdStr = opList[2]; cmdStr.concat(" K"); break;
        case 'A' :  cmdStr = opList[2]; cmdStr.concat(" B"); break;
        case '4' :  cmdStr = opList[2]; cmdStr.concat(" S"); break;
        case '5' :  cmdStr = opList[2]; cmdStr.concat(" 8191"); break;
        case '6' :  cmdStr = opList[2]; cmdStr.concat(" R"); break;
        case 'B' :  cmdStr = opList[2]; cmdStr.concat(" Q");  break;
        case 'C' :  cmdStr = opList[2]; cmdStr.concat(" P");  break;
        case '7' :  singlePinTest(); break;// opcancelled = true;
        default :   lcd.setCursor(0, 1); lcd.write(menuSelection[11]); oldval = NO_KEY; squeak(1); break;
      }
  }
  else
  {
    if (Keep_it_Idle  < 500) //    if (Keep_it_Idle  < 500 && Keep_it_Idle  > 100 )
    {
      Keep_it_Idle = 100;
      initRelays();
    }
    if (Keep_it_Idle  > 400)
    {
      Keep_it_Idle--;
    }

    if (Serial.available() > 0)
    {
      cmdStr.remove(0);
      //  firstMicros = micros();
    }
    else
    {
      lcd.setCursor(0, 0);
      lcd.write(operation[3]);
    }
    while (Serial.available() > 0 & !opcancelled)
    {
      char carbyte = Serial.read();
      if (carbyte == ',')
        break;
      else
        cmdStr += carbyte;
      delayMicroseconds(80);

    }
  }
  // Lets wait for something here
  keepAllUnderReset(cmdStr.length() ==  0);
  if (cmdStr.length() > 3)
  {
    //Data is Pouring In Keep the device idle
    // this sets back to max and waits for the device to cool off
    switch (IsArrayContains(cmdStr.substring(0, 3), opList))
    {
      case 0  : getPunchValue(cmdStr.substring(4));  cmdStr.remove(0); break;
      case 1  : setRelay(cmdStr.substring(4)); cmdStr.remove(0); break;
      case 2  : if (!testDevice(cmdStr.substring(4))) cmdStr.remove(0); break;
      case 3  : initCardSet(cmdStr.substring(4)); cmdStr.remove(0);break;
      case 4  : prntCardSet(cmdStr.substring(4)); cmdStr.remove(0); break;
      case 5  : pnchCardSet(cmdStr.substring(4)); cmdStr.remove(0); Keep_it_Idle = reset_idle_Count;  break;
      case 6  : resetFunc(); break;//Reset Device.
      case 7  : get_set_HID(cmdStr.substring(4)); cmdStr.remove(0); break;
      case 8  : realSensors(); cmdStr.remove(0); break;
      case 9  : get_set_PuchDirection(cmdStr.substring(4)); cmdStr.remove(0); break;
      case 10 : get_setEntryDistance(cmdStr.substring(4)); cmdStr.remove(0); break;
      case 14 : get_setPunchDepth(cmdStr.substring(4)); cmdStr.remove(0); break;

      case 11 : moveHead(cmdStr.charAt(4) == '1'); cmdStr.remove(0); break;
      case 12 : rackBack(); cmdStr.remove(0); break;
      case 13 : set_prntHeadDir(cmdStr.charAt(4) == '1'); cmdStr.remove(0); break;

      case 'X' : insertCardValue(cmdStr.substring(4)); cmdStr.remove(0); break;

      default : Serial.println(errCode[0]); squeak(1); cmdStr.remove(0); break;
    }
    //
    //    long lastmicros = micros();
    //    Serial.print("Time: ");
    //    Serial.println(lastmicros - firstMicros);
  }

}

void singlePinTest()
{
  String cmdStr;
  initRelays();
  lcd.clear();
  cmdStr = opList[2]; cmdStr.concat(" 8192");
  lcd.clear();
  lcd.write("Enter New Key");
  lcd.setCursor(0, 1);
  lcd.write("Key Test:");
  char newkey = '#';
  char oldkey = '#';
  while (!opcancelled)
  {

    cmdStr = opList[2];
    int tempi;
    for (tempi = 0; tempi < 25; tempi++)
    {
      newkey = FetchKeySelection();
      if (newkey != NO_KEY)
        break;
      delayMicroseconds(10000);
    }
    if (newkey != NO_KEY)
    {
      switch (newkey)
      {
        case '1': cmdStr.concat(" 1"); lcd.setCursor(9, 1); lcd.write("1  "); break;
        case '2': cmdStr.concat(" 2"); lcd.setCursor(9, 1); lcd.write("2  "); break;
        case '3': cmdStr.concat(" 4"); lcd.setCursor(9, 1); lcd.write("3  "); break;
        case 'A': cmdStr.concat(" 8"); lcd.setCursor(9, 1); lcd.write("4  "); break;
        case '4': cmdStr.concat(" 16"); lcd.setCursor(9, 1); lcd.write("5  "); break;
        case '5': cmdStr.concat(" 32"); lcd.setCursor(9, 1); lcd.write("6  "); break;
        case '6': cmdStr.concat(" 64"); lcd.setCursor(9, 1); lcd.write("7  "); break;
        case 'B': cmdStr.concat(" 128"); lcd.setCursor(9, 1); lcd.write("8  "); break;
        case '7': cmdStr.concat(" 256"); lcd.setCursor(9, 1); lcd.write("9  "); break;
        case '8': cmdStr.concat(" 512"); lcd.setCursor(9, 1); lcd.write("10 "); break;
        case '9': cmdStr.concat(" 1024"); lcd.setCursor(9, 1); lcd.write("11 "); break;
        case 'C': cmdStr.concat(" 2048"); lcd.setCursor(9, 1); lcd.write("12 "); break;
        case '*': cmdStr.concat(" 4096"); lcd.setCursor(9, 1); lcd.write("PEG"); break;
        case '#': cmdStr.concat(" 8191"); lcd.setCursor(9, 1); lcd.write("ALL"); break;
        case NO_KEY :  break;
        default : return;
      }
      oldkey = newkey;
    }
    else
      switch (oldkey)
      {
        case '1': cmdStr.concat(" 1"); lcd.setCursor(9, 1); lcd.write("1  "); break;
        case '2': cmdStr.concat(" 2"); lcd.setCursor(9, 1); lcd.write("2  "); break;
        case '3': cmdStr.concat(" 4"); lcd.setCursor(9, 1); lcd.write("3  "); break;
        case 'A': cmdStr.concat(" 8"); lcd.setCursor(9, 1); lcd.write("4  "); break;
        case '4': cmdStr.concat(" 16"); lcd.setCursor(9, 1); lcd.write("5  "); break;
        case '5': cmdStr.concat(" 32"); lcd.setCursor(9, 1); lcd.write("6  "); break;
        case '6': cmdStr.concat(" 64"); lcd.setCursor(9, 1); lcd.write("7  "); break;
        case 'B': cmdStr.concat(" 128"); lcd.setCursor(9, 1); lcd.write("8  "); break;
        case '7': cmdStr.concat(" 256"); lcd.setCursor(9, 1); lcd.write("9  "); break;
        case '8': cmdStr.concat(" 512"); lcd.setCursor(9, 1); lcd.write("10 "); break;
        case '9': cmdStr.concat(" 1024"); lcd.setCursor(9, 1); lcd.write("11 "); break;
        case 'C': cmdStr.concat(" 2048"); lcd.setCursor(9, 1); lcd.write("12 "); break;
        case '*': cmdStr.concat(" 4096"); lcd.setCursor(9, 1); lcd.write("PEG"); break;
        case '#': cmdStr.concat(" 8191"); lcd.setCursor(9, 1); lcd.write("ALL"); break;
        case NO_KEY :  break;
        default : return;
      }
    Serial.println(menuSelection[6]);
    Serial.println("Pins");
    getPunchValue(cmdStr.substring(4));
  }
}

void prntCardSet(String op)
{
  int i = 0;
  Serial.print(retText[1]);
  for (i = 1; i <= card_Max; i++)
  {
    Serial.print(" "); Serial.print(String(card_Set[i]));
  }

}

void initCardSet(String cardCount)
{

  if ((cardCount.toInt() > 0) && (cardCount.toInt() < 100 ))
  {
    Serial.println(retText[3]);
    card_Max = cardCount.toInt();

  }
  else
    Serial.println(errDescription[7]);
}

void realSensors()
{
  lcd.setCursor(0, 1);
  Serial.print("FBD: ");
  lcd.write("Fr-");
  int sensorValue = digitalRead(LPT_FSensor);
  lcd.print(sensorValue);
  Serial.print(sensorValue);
  Serial.print(",");
  lcd.write(" Bk-");
  sensorValue = digitalRead(LPT_BSensor);
  lcd.print(sensorValue);
  Serial.print(sensorValue);
  Serial.print(",");
  lcd.write(" Dn-");
  sensorValue = digitalRead(LPT_DSensor);
  lcd.print(sensorValue);
  Serial.println(sensorValue);
}


void rackBack()
{
  initRelays();
  while (digitalRead(LPT_BSensor))
  {
    relayState[rM] = true;
    driveRelay(); // The Rack is now free,,
    //  Serial.println("Rack is Free");
  }
  while (!digitalRead(LPT_BSensor))
  {
    //  Serial.println("Ready to Test Rack");
    relayState[rC] = true;
    relayState[rM] = true;
    relayState[rK] = true;
    relayState[rB] = false;
    driveRelay(); // Drive Motor to bring Back the Rack
    //  Serial.println("Drive Motor to bring Back the Rack");
  }

  //  long last_micros = micros();
  //
  relayState[rC] = true;
  relayState[rM] = false;
  relayState[rB] = true;

  driveRelay(); // Stop Everything
  delay(200);
  if (!digitalRead(LPT_BSensor))
  {
    relayState[rC] = true;
    relayState[rM] = true;
    relayState[rK] = true;
    relayState[rB] = false;
    driveRelay();
    relayState[rC] = true;
    relayState[rM] = false;
    relayState[rB] = true;
    while (!digitalRead(LPT_BSensor) & !opcancelled);
    driveRelay();
    delay(200);
  }
  initRelays();

  //  Serial.println("Stop Everything");
}


void idle_rackBack()
{
  idle_initRelays();
//  initRelays();
  while (digitalRead(LPT_BSensor))
  {
    relayState[rM] = true;
    driveRelay(); // The Rack is now free,,
    //  Serial.println("Rack is Free");
  }
  while (!digitalRead(LPT_BSensor))
  {
    //  Serial.println("Ready to Test Rack");
    relayState[rC] = true;
    relayState[rM] = true;
    relayState[rK] = true;
    relayState[rB] = false;
    driveRelay(); // Drive Motor to bring Back the Rack
    //  Serial.println("Drive Motor to bring Back the Rack");
  }

  //  long last_micros = micros();
  //
  relayState[rC] = true;
  //  relayState[rM] = false;
  relayState[rB] = true;

  driveRelay(); // Stop Everything
  delay(250);
  if (!digitalRead(LPT_BSensor))
  {
    relayState[rC] = true;
    relayState[rM] = true;
    relayState[rK] = true;
    relayState[rB] = false;
    driveRelay();
    relayState[rC] = true;
    //    relayState[rM] = false;
    relayState[rB] = true;
    while (!digitalRead(LPT_BSensor) & !opcancelled);
    driveRelay();
    delay(250);
  }
  idle_initRelays();
  //  Serial.println("Stop Everything");
}

void rackTest()
{
  if (!digitalRead(LPT_BSensor))
    rackBack(); // Assume Rack is in Reset Position
  initRelays();
  int count = rackTestSteps;
  relayState[rM] = true;

  driveRelay(); // Drive Motor to bring Back the Rack
  while (digitalRead(LPT_BSensor) & !opcancelled);
  while (count)
  {
    if (opcancelled | Serial.available() > 0)
      break;
    while (!opcancelled)
    {
      if (!digitalRead(LPT_DSensor))
      {
        break;
      }
    }
    while (!digitalRead(LPT_DSensor) & !opcancelled);
    count--;
    Serial.println(count);
  }
  if (opcancelled)
    return;
  rackBack();
}

bool getCard(int count)
{
  initRelays();  // Lets count Entry Distance
  relayState[rM] = true;
  driveRelay(); // Drive Motor to bring Back the Rack
  while (digitalRead(LPT_BSensor) & !opcancelled);
  while (count)
  {
    if (opcancelled)
      return false;

    while (!opcancelled)
    {
      if (!digitalRead(LPT_DSensor))
        break;
    }
    while (!digitalRead(LPT_DSensor) & !opcancelled);
    count--;
   // Serial.println("WAITING"); 
  }
  Serial.println("STN");

  if (!digitalRead(LPT_FSensor))
    return true;
  else
    return false;

}


void pnchCardSet(String op)
{
  lcd.setCursor(0, 1); lcd.write("Punch Initiated.");

  // if (cardReady == true)
  //  {
  cardReady = false;
  int i = 0;
  //rackBack();  // Reset rack
  if (!getCard(entryDistance)) // Start Card Insert
  {
    Serial.println(errDescription[5]);
    rackBack();
    return ;
  }
  //  Serial.print("INFO: CARD FOUND"); Serial.println("INFO: START PUNCH");
  cmdStr.remove(0);

  for (i = 1; i <= card_Max; i++)
  {
  lcd.setCursor(0, 1); lcd.write("Punching Now ");lcd.print(i);if(i<10)lcd.print(" ");
   
    while (Serial.available() > 0  & !opcancelled)
    {
      Serial.println(errCode[3]);
      keepAllUnderReset(true);
      rackBack();
      return;
    }

    if (opcancelled)
    {
      lcd.setCursor(0, 1);
      lcd.write(operation[0]);
      Serial.println(errCode[3]);
      rackBack();
      keepAllUnderReset(true);
      return;
    }
    setPunchValue(card_Set[i]);
    while (digitalRead(LPT_DSensor) & !opcancelled);
    if(i==Nprint_Count)
    {
        relayState[rP] = true;
    }
    drivePunchs(1);
    //    while (!digitalRead(LPT_DSensor) & !opcancelled);
    delayMicroseconds(punchReleaseDelay);
    Serial.print(retText[2]); Serial.println(String(i));
    drivePunchs(0);
    if(i!=Nprint_Count)
    {
        relayState[rP] = false;
    }
  }
  lcd.setCursor(0, 1); lcd.write("Punch Complete.!");
  // while (!digitalRead(LPT_FSensor) & !opcancelled);
  idle_rackBack();
  // rackBack();
  // }


}


void get_set_HID(String HIDkey)
{
  int i = HW_ID_eeAddress;
  if (HIDkey == "?")
  {
    String hidKey = "";
    Serial.print(retText[4]);
    for (int i = 0; i < 16; i++)
    {
      hidKey +=  char(EEPROM.read(i));
    }
    Serial.println(hidKey);
  }
  else
  {
    String hidKey = "";
    Serial.print(retText[4]);
    for (int i = 0; i < 16; i++)
      EEPROM.write(i, HIDkey.charAt(i));
    for (int i = 0; i < 16; i++)
    {
      hidKey +=  char(EEPROM.read(i));
    }
    Serial.println(hidKey);
  }

}

void get_setEntryDistance(String dist)
{
  if (dist == "?")
  {
    Serial.print(retText[5]);
    Serial.println(entryDistance);
  }
  else
  {
    entryDistance = dist.toInt();
    Serial.print(retText[5]);
    Serial.println(entryDistance);
  }

}

void get_setPunchDepth(String depth)
{
  if (depth == "?")
  {
    Serial.print(retText[6]);
    Serial.println(punchDepth);
  }
  else
  {
    punchDepth = depth.toInt();
    Serial.print(retText[6]);
    Serial.println(punchDepth);
  }

}


void get_set_PuchDirection(String PunchDirStr)
{
  int i = punch_Direction_eeAddress;
  if (PunchDirStr == "!")
  {
    punch_Direction_value = "";
    Serial.print(retText[6]);
    for (int i = 0; i < 14; i++)
      EEPROM.write(i, punch_Direction_default.charAt(i));
    for (int i = 0; i < 14; i++)
    {
      punch_Direction_value +=  char(EEPROM.read(i));
    }
    Serial.println(punch_Direction_value);
  }
  else if (PunchDirStr == "?")
  {
    punch_Direction_value = "";
    Serial.print(retText[6]);
    for (int i = 0; i < 14; i++)
    {
      punch_Direction_value +=  char(EEPROM.read(i));
    }
    Serial.println(punch_Direction_value);
  }
  else
  {
    punch_Direction_value = "";
    Serial.print(retText[6]);
    for (int i = 0; i < 14; i++)
      EEPROM.write(i, PunchDirStr.charAt(i));
    for (int i = 0; i < 14; i++)
    {
      punch_Direction_value +=  char(EEPROM.read(i));
    }
    Serial.println(punch_Direction_value);
  }

  setPunchDirection_Array();

}

void setPunchDirection_Array()
{
  int i;
  for (i = 0; i < 14; i++)
  {
    if ((punch_Direction_value.charAt(i) == '0' || punch_Direction_value.charAt(i) == '1' ) && punch_Direction_value.length() == 14 )
    {
      punchDirection[i] = (punch_Direction_value.charAt(i) == '0') ? false : true;
    }
    else
    {
      lcd.setCursor(0, 1);
      lcd.write(errDescription[9]);
      Serial.println(errCode[9]);
      get_set_PuchDirection(punch_Direction_default);
      return;
    }
  }
  lcd.setCursor(0, 1);
  lcd.write(infDescription[3]);
  Serial.print(infCode[3]);
  Serial.println(punch_Direction_value);

}


bool testDevice(String operand)
{
  // The Bit Parsing Starts Here <M/K/C/B/P><0/1>
  operand.trim();
  operand.toUpperCase();
  lcd.setCursor(0, 0);
  lcd.write(infDescription[4]);
  Serial.print(infCode[4]);
  Keep_it_Idle = 1000;
  switch (operand.charAt(0))
  {
    case 'M' :  Serial.println(menuSelection[1]); lcd.write(menuSelection[1]); relayState[0] = 1; relayState[2] = 1; relayState[1] = 0; relayState[3] = 0; relayState[4] = 0; driveRelay(); testMotor(); break;
    case 'K' :  Serial.println(menuSelection[2]);  lcd.write(menuSelection[2]); relayState[0] = 0; relayState[2] = 1; relayState[1] = !relayState[1]; relayState[3] = 0; relayState[4] = 0; break;
    case 'C' :  Serial.println(menuSelection[5]);   lcd.write(menuSelection[5]); relayState[2] = !relayState[2]; relayState[0] = 0; relayState[1] = 0; relayState[3] = 0; relayState[4] = 0; break;
    case 'B' :  Serial.println(menuSelection[4]);  lcd.write(menuSelection[4]); relayState[2] = 1; relayState[3] = !relayState[3]; relayState[0] = 0; relayState[1] = 0;  relayState[4] = 0; break;
    case 'P' :  Serial.println(menuSelection[10]); lcd.write(menuSelection[10]); relayState[0] = 0; relayState[2] = 0; relayState[1] = 0; relayState[3] = 0; relayState[4] = !relayState[4]; break;
    case 'R' :  Serial.println(menuSelection[3]);  lcd.write(menuSelection[3]); rackTest(); return true; break;
    case 'Q' :  Serial.println(menuSelection[8]);  lcd.write(menuSelection[8]); rackBack(); break;
    case 'S' :  Serial.println(menuSelection[9]);   lcd.write(menuSelection[9]); realSensors(); break;
    case 'Z' :  Serial.println(menuSelection[12]);   lcd.write(menuSelection[12]); squeak(100); break;
    case 'X' :  Serial.println(operation[2]); lcd.clear(); Serial.println(infDescription[4]); relayState[0] = 0; relayState[1] = 0; relayState[2] = 0; relayState[3] = 0; relayState[4] = 0;Keep_it_Idle = 100; break;
    default  :  Serial.println(menuSelection[6]);   lcd.write(menuSelection[6]); relayState[0] = 0; relayState[1] = 0; relayState[2] = 0; relayState[3] = 0; relayState[4] = 0; Serial.println("Pins"); getPunchValue(operand.substring(0, 4));  driveRelay(); return true;

  }
  driveRelay();
  delay(500);
  if (operand.charAt(0) == 'X')
    {
      return false;
      Keep_it_Idle = 1000;
    }
  return true;
}


void setRelay(String operand)
{
  // The Bit Parsing Starts Here <M/K/C/B/P><0/1>
  operand.trim();
  int i;
  operand.toUpperCase();
  if (operand.length() == 2)
    switch (operand.charAt(0))
    {
      case 'M' : relayState[0] = operand.charAt(1) == '0' ? false : true; break;
      case 'K' : relayState[2] = 1; relayState[3] = 0; relayState[1] = operand.charAt(1) == '0' ? false : true; break;
      case 'C' : relayState[2] = operand.charAt(1) == '0' ? false : true; break;
      case 'B' : relayState[2] = 1; relayState[3] = operand.charAt(1) == '0' ? false : true; break;
      case 'P' : relayState[4] = operand.charAt(1) == '0' ? false : true; break;
      default  : Serial.println(errCode[1]);
    }
  else if (operand.length() == 10)
    for (i = 0; i < 5; i++)
      switch (operand.charAt(i * 2))
      {
        case 'M' : relayState[0] = operand.charAt(i * 2 + 1) == '0' ? false : true; break;
        case 'K' : relayState[2] = 1; relayState[3] = 0; relayState[1] = operand.charAt(i * 2 + 1) == '0' ? false : true; break;
        case 'C' : relayState[2] = operand.charAt(i * 2 + 1) == '0' ? false : true; break;
        case 'B' : relayState[2] = 1; relayState[3] = operand.charAt(i * 2 + 1) == '0' ? false : true; break;
        case 'P' : relayState[4] = operand.charAt(i * 2 + 1) == '0' ? false : true; break;
        default  : Serial.println(errCode[1]);
      }

  driveRelay();

}

void testMotor()
{
  unsigned long oneMicros;
  while (digitalRead(LPT_DSensor) & !opcancelled);
  delayMicroseconds(50);
  if (!digitalRead(LPT_DSensor))
  {
    oneMicros = micros();
  }
  else
    return ;
  while (!digitalRead(LPT_DSensor) & !opcancelled);
  delayMicroseconds(50);
  if (digitalRead(LPT_DSensor));
  else
    return ;

  while (digitalRead(LPT_DSensor) & !opcancelled);
  delayMicroseconds(50);
  if (!digitalRead(LPT_DSensor));
  else
    return ;

  unsigned long twoMicros = micros();
  if (twoMicros > oneMicros)
  {
    String speedRPM = String(1000000 * 60 / (twoMicros - oneMicros), DEC);
    Serial.print("Motor Speed : ");
    Serial.print(speedRPM);
    Serial.println(" RPM ");
    lcd.setCursor(0, 1);
    lcd.write(" RPM ");
    lcd.print(speedRPM);
  }
  else
    return ;

}

void driveRelay()
{
  //  bool C_B, bool Coil, bool Motor , bool nprintin , bool CB_Enable
  //  driveRelay(0, 0, 0, 0, 0); // By Default Everything is OFF
  //  driveRelay(1, x, 0, 0, 0); // Coil
  //  driveRelay(1, 1, x, 0, 0); // Motor
  //  driveRelay(0, 1, 0, 0, x); // Clutch
  //  driveRelay(1, 1, 0, 0, x); // Brake
  //bool relayState[] = {false,false,false,false,false}; //<Motor/Klutch/Coil/Brake/Printing><0/1>

  int i;
  for (i = 0; i < 7; i++)
  {
    driveLatches(i, 0, 0, 0, 0, 0, 0, 0, 0);
  }

  if (relayState[3] == true)
    driveLatches(7, 1 , relayState[2], relayState[0], relayState[4], relayState[3], 1,1,1);
  else
    driveLatches(7, 0 , relayState[2], relayState[0], relayState[4], relayState[1], 1,1,1);

  for (i = 0; i < 7; i++)
  {
    driveLatches(i, 0, 0, 0, 0, 0, 0, 0, 0);
  }


}

String SequenceGenerator(int state)
{
  String newSequence;
  newSequence.reserve(120);
  int i = 0;
  for (i = 0; i < 14; i++)
  {
    newSequence += punchState[i] ? driveDirection[state][punchDirection[i]] : driveDirection[4][punchDirection[i]];
  }

  return newSequence;
}

void drivePunchs(bool Fwd_Rev)
{
  int i, j = 0;
  if (Fwd_Rev)
  {
    for (j = 0; j < punchDepth; j++)
      for (i = 0; i <= 3; i++)
      {
        driveLatchSet(SequenceGenerator(i));
      }
  }



  else
  {
    for (j = 0; j < punchDepth; j++)
      for (i = 3; i >= 0; i--)
      {
        driveLatchSet(SequenceGenerator(i));
      }

  }



}

void moveHead (bool upDown)
{
  initRelays();
  relayState[rM] = true;
  relayState[rC] = true;
  driveRelay(); // Drive Motor to bring Back the Rack
  while (!digitalRead(LPT_DSensor) & !opcancelled);
  initRelays();
}


void driveLatchSet(String dataSeq)
{

  int i = 6;
  driveLatches(i, dataSeq.charAt(i * 8) == '0', dataSeq.charAt(i * 8 + 1) == '0', dataSeq.charAt(i * 8 + 2) == '0', dataSeq.charAt(i * 8 + 3) == '0', dataSeq.charAt(i * 8 + 4) == '0', dataSeq.charAt(i * 8 + 5) == '0', dataSeq.charAt(i * 8 + 6) == '0', dataSeq.charAt(i * 8 + 7) == '0');
  delayMicroseconds(50);
  for (i = 0; i <= 5; i++)
    driveLatches(i, dataSeq.charAt(i * 8) == '0', dataSeq.charAt(i * 8 + 1) == '0', dataSeq.charAt(i * 8 + 2) == '0', dataSeq.charAt(i * 8 + 3) == '0', dataSeq.charAt(i * 8 + 4) == '0', dataSeq.charAt(i * 8 + 5) == '0', dataSeq.charAt(i * 8 + 6) == '0', dataSeq.charAt(i * 8 + 7) == '0');

}



int IsArrayContains(String searchValue, char* searchList[])
{
  searchValue.toUpperCase();
  if ((searchValue.charAt(0) == 'C') && (searchValue.substring(1).toInt() > 0 && searchValue.substring(1).toInt() <= card_Max))
  {
    card_Loc = searchValue.substring(1).toInt();
    return 'X';
  }
  else
  {
    for (int i = 0; i < opListSize ; i++)
      if (searchValue == searchList[i])
        return i;
  }
  return -1;
}

void insertCardValue(String operand)
{
  int colValue = -1;
  // The Bit Parsing Starts Here
  operand.trim();
  if (operand.toInt() > 0 && operand.toInt() <= 8192)
    colValue = operand.toInt();
  else
  {
    Serial.println(errCode[2]);
    lcd.setCursor(0, 1);
    lcd.write(errDescription[2]);
  }
  card_Set[card_Loc] = colValue;
  //  if (card_Loc == card_Max)
  //    cardReady = true;
  //  else
  //    cardReady = false;

  Serial.print(colValue); Serial.print(" > "); Serial.println(card_Loc);

}

void getPunchValue(String operand)
{
  int retValue = -1;

  // The Bit Parsing Starts Here
  operand.trim();
  if (operand.toInt() > 0 & operand.toInt() <= 8192)
    retValue = operand.toInt();
  else
  {
    Serial.println(errCode[2]);
    return;
  }
  // The Bit Parsing Ends Here

  Serial.println(retValue);

  setPunchValue(retValue);

  drivePunchs(1);
  delay(testpunchReleaseDelay);
  drivePunchs(0);
  delay(testpunchReleaseDelay);

}

void setPunchValue(int setValue)
{
  int i = 0;
  if (prnt_Updn_Rev)
    for (i = 0; i < 13; i++)
    {
      punchState[i] = bitRead(setValue, i);
    }
  else
    for (i = 0; i < 13; i++)
    {
      if (i < 12)
        punchState[i] = bitRead(setValue, 11 - i);
      else
        punchState[i] = bitRead(setValue, i);
    }
}

void set_prntHeadDir(bool rev_Fwd) // 0 is Fwd , 1 is Rev
{
  if (rev_Fwd)
  {
    prnt_Updn_Rev = true;
    Serial.println("PDRR");
  }
  else
  {
    prnt_Updn_Rev = false;
    Serial.println("PDRF");
  }

}

void clutchTest()
{
  initRelays();
  relayState[rC] = true;
  relayState[rK] = true;
  relayState[rM] = true;
  driveRelay();
}

void initRelays()
{
  relayState[rM] = false;
  relayState[rK] = false;
  relayState[rC] = false;
  relayState[rB] = false;
  relayState[rP] = false;

  driveRelay();
}

void idle_initRelays()
{
  //  relayState[0] = 1; relayState[2] = 1; relayState[1] = 0; relayState[3] = 0; relayState[4] = 0; driveRelay();
  relayState[rM] = true; // The Motor keeps spining
  relayState[rK] = false;
  relayState[rC] = true;
  relayState[rB] = false;
  relayState[rP] = false;
  driveRelay();
}



void initPins()
{
  pinMode(LPT_Address0, OUTPUT);
  pinMode(LPT_Address1, OUTPUT);
  pinMode(LPT_Address2, OUTPUT);

  pinMode(LPT_FSensor, INPUT);
  pinMode(LPT_BSensor, INPUT);
  pinMode(LPT_DSensor, INPUT);

  pinMode(cancel_Button, INPUT_PULLUP);
  pinMode(mode_Button, INPUT_PULLUP);
  pinMode(ok_Button, INPUT_PULLUP);

  pinMode(LPT_DATA0, OUTPUT);
  pinMode(LPT_DATA1, OUTPUT);
  pinMode(LPT_DATA2, OUTPUT);
  pinMode(LPT_DATA3, OUTPUT);
  pinMode(LPT_DATA4, OUTPUT);
  pinMode(LPT_DATA5, OUTPUT);
  pinMode(LPT_DATA6, OUTPUT);
  pinMode(LPT_DATA7, OUTPUT);

  pinMode(LPT_SysEnable, OUTPUT);
}


void driveLatches(int driveIC, bool Da0, bool Da1, bool Da2, bool Da3, bool Da4, bool Da5, bool Da6, bool Da7)
{
  digitalWrite(LPT_SysEnable, 1);
  delayMicroseconds(2);
  digitalWrite(LPT_Address0, bitRead(driveIC, 0));
  digitalWrite(LPT_Address1, bitRead(driveIC, 1));
  digitalWrite(LPT_Address2, bitRead(driveIC, 2));

  digitalWrite(LPT_DATA0, Da0);
  digitalWrite(LPT_DATA1, Da1);
  digitalWrite(LPT_DATA2, Da2);
  digitalWrite(LPT_DATA3, Da3);
  digitalWrite(LPT_DATA4, Da4);
  digitalWrite(LPT_DATA5, Da5);
  digitalWrite(LPT_DATA6, Da6);
  digitalWrite(LPT_DATA7, Da7);

  delayMicroseconds(10);
  digitalWrite(LPT_SysEnable, 0);
  delayMicroseconds(200);
  digitalWrite(LPT_SysEnable, 1);
}

void squeak(int err)
{
  digitalWrite(BUZZ_Pin, HIGH);
  delay(600 * err);
  digitalWrite(BUZZ_Pin, LOW);
  delay(5 * err);
}


