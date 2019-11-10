/*
Creative Embedded Systems
AKW Installation
Mic

*/
int led = 13;
int micPin = 33;
int switchPin = 21;
 
void setup()
{
  Serial.begin(9600);
  pinMode(switchPin, INPUT_PULLUP);
  pinMode(led, OUTPUT);
}

int switchState;
 
void loop()
{
    switchState = digitalRead(switchPin);
    
    if (switchState){

      digitalWrite(led, HIGH);
      long sum = 0;
      
      for(int i=0; i<1000; i++)
      {
          sum += analogRead(micPin);
      }
 
      sum = sum/1000;
   
      Serial.println(sum);
   
      delay(10);
    }
    else {
      digitalWrite(led, LOW);
    }
   
}
