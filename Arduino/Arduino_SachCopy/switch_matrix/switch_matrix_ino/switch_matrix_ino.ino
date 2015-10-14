    int c1=2;
    int c2=3;
    int c3=4;
    int c4=5;
    int r1=9;
    int r2=8;
    int r3=7;
    int r4=6;
    int a1=0;
    int a2=0;
    int a3=0;
    int a4=0;
    int rowValue=0;
     
    void setup()
    {
      pinMode(c4,INPUT);
      pinMode(c1,INPUT);
      pinMode(c2,INPUT);
      pinMode(c3,INPUT);
      pinMode(r4,OUTPUT);
      pinMode(r1,OUTPUT);
      pinMode(r2,OUTPUT);
      pinMode(r3,OUTPUT);
    
      Serial.begin(9600);
    }
     
    void loop()
    {
      //if(Serial.available()>0) // if there is data to read
      for(int i=1;i<=4;i++)
      {
       if(i==1)
       {
       rowValue=1110;
       }
       if(i==2)
       {
       rowValue=1101;
       }
       if(i==3)
       {
       rowValue=1011;
       }
       if(i==4)
       {
       rowValue=0111;
       }//Serial.read(); // read data
        /*if(rowValue==1110)
        digitalWrite(r0,HIGH); // turn light on
        digitalWrite(r1,HIGH); // turn light on
        digitalWrite(r2,HIGH); // turn light on
        digitalWrite(r3,HIGH); // turn light on
        
        else if(matlabData==2)
        digitalWrite(ledPin,LOW); // turn light off*/
        
        switch (rowValue) {
      case 1110:    
          digitalWrite(r1,HIGH); // turn light on
          a1=digitalRead(c1);
          a2=digitalRead(c2);
          a3=digitalRead(c3);
          a4=digitalRead(c4);
          digitalWrite(r2,LOW); // turn light on
          
          digitalWrite(r3,LOW); // turn light on
          
          digitalWrite(r4,LOW); // turn light on
          
          
          if(a4==1)
           {
             Serial.println("3");
           }
          if(a3==1)
           {
             Serial.println("2");
           }
           if(a2==1)
           {
             Serial.println("1");
           }
           if(a1==1)
           {
             Serial.println("0");
           }
        break;
        case 1101:    
          digitalWrite(r1,LOW); // turn light on
          
          digitalWrite(r2,HIGH); // turn light on
          a1=digitalRead(c1);
          a2=digitalRead(c2);
          a3=digitalRead(c3);
          a4=digitalRead(c4); 
          digitalWrite(r3,LOW); // turn light on
          
          digitalWrite(r4,LOW); // turn light on
                   
          
          
          if(a4==1)
           {
             Serial.println("7");
           }
          if(a3==1)
           {
             Serial.println("6");
           }
           if(a2==1)
           {
             Serial.println("5");
           }
           if(a1==1)
           {
             Serial.println("4");
           }
        break;
         case 1011:    
          digitalWrite(r1,LOW); // turn light on
          digitalWrite(r2,LOW); // turn light on
          digitalWrite(r3,HIGH); // turn light on
          a1=digitalRead(c1);
          a2=digitalRead(c2);
          a3=digitalRead(c3);
          a4=digitalRead(c4);
          digitalWrite(r4,LOW); // turn light on
          
           if(a4==1)
           {
             Serial.println("11");
           }
          if(a3==1)
           {
             Serial.println("10");
           }
           if(a2==1)
           {
             Serial.println("9");
           }
           if(a1==0)
           {
             Serial.println("8");
           }
        break;
         case 0111:    
          digitalWrite(r1,LOW); // turn light on
           
          digitalWrite(r2,LOW); // turn light on
          
          digitalWrite(r3,LOW); // turn light on
          
          digitalWrite(r4,HIGH); // turn light off
          a1=digitalRead(c1);
          a2=digitalRead(c2);
          a3=digitalRead(c3);
          a4=digitalRead(c4);
          
          
          
            if(a4==1)
           {
             Serial.println("15");
           }
          if(a3==1)
           {
             Serial.println("14");
           }
           if(a2==1)
           {
             Serial.println("13");
           }
           if(a1==1)
           {
             Serial.println("12");
           }
        break;
         default:
           Serial.println("Key not pressed");                      
       
                            
      }
  } 

}
      
