const int VERT = A0; // analog J1
const int HORIZ = A1; // analog J1
const int VERT1 = A2; // analog J2
const int HORIZ1 = A3; // analog J2

void setup()
{
  
  Serial.begin(9600); // set up serial port for output
}

void loop() 
{
  int ver, hor,ver1, hor1;
  
  // read all values from the joystick
  
  ver = analogRead(VERT); // will be 0-1023
  hor = analogRead(HORIZ);
  ver1 = analogRead(VERT1); 
  hor1 = analogRead(HORIZ1);
  
  //For Joystick1................................................
  if(ver>700)
  {
    
    Serial.println('q');
  }
  if(ver<300)
  {
    
    Serial.println('r');
  }
  if(hor>700)
  {
    
    Serial.println('s');
  }
  if(hor<300)
  {
    
    Serial.println('t');
  }

  //For Joystick2.............................................. 
  if(ver1>700)
  {
    
    Serial.println('u');
  }
  if(ver1<300)
  {
    
    Serial.println('v');
  }
  if(hor1>700)
  {
    
    Serial.println('w');
  }
  if(hor1<300)
  {
    
    Serial.println('x');
  }
 
}  
