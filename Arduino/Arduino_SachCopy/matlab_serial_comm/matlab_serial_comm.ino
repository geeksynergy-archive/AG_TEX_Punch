 int ledPin=13;
    int matlabData;
    int analogInPin = A0;
    int sensorValue = 0;        // value read from the pot
    int outputValue = 0; 
     
    void setup()
    {
    pinMode(ledPin,OUTPUT);
    Serial.begin(9600);
    }
     
    void loop()
    {
       
    if(Serial.available()>0) // if there is data to read
    {
    matlabData=Serial.read(); // read data
    sensorValue = analogRead(analogInPin);
    outputValue = map(sensorValue, 0, 1023, 0, 255);
 
 // Send the value to the Serial Monitor
    Serial.print("Output Value=");
    Serial.println(outputValue);
    if(matlabData==1)
    {
    digitalWrite(ledPin,HIGH); // turn light on
    Serial.write(outputValue); 
    }
    else if(matlabData==2)
    {digitalWrite(ledPin,LOW); // turn light off
    }delay(10);
    }
    }
