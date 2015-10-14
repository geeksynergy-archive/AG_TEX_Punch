#include <Keypad.h>
const byte ROWS = 4; 
const byte COLS = 4; 
char keys[ROWS][COLS] = {
  {'d','h','l','p'},
  {'c','g','k','o'},
  {'b','f','j','n'},
  {'a','e','i','m'}
};
byte rowPins[ROWS] = {6,7,8,9}; //connect to row pinouts 
byte colPins[COLS] = {2,3,4,5}; //connect to column pinouts

Keypad keypad = Keypad( makeKeymap(keys), rowPins, colPins, ROWS, COLS );

void setup(){
  Serial.begin(9600);
}

void loop(){
  char key = keypad.getKey();

  if (key != NO_KEY){
    Serial.println(key);
  }
}

