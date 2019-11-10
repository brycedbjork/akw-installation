/*
Creative Embedded Systems
AKW Installation
Elevator

*/
//Defining the pins and variables
const int trigPin = 12;
const int echoPin = 13;
 
long duration;
long distance;
 
void setup() {
  //Initiate serial monitor
  Serial.begin (9600);
 
  //Specifies the pins behavior
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
}
 
void loop() {
  //Sending a LOW pulse to clear the trigPin
  //and sets the trigger to a HIGH pulse for 10 microseconds
  digitalWrite(trigPin, LOW);
  delayMicroseconds(5);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
 
  //Reads the echoPin and the time it
  //took for the HIGH pulse to return
  duration = pulseIn(echoPin, HIGH);
 
  //Calculating the distance in in
  distance = (duration/2) / 74;
 
  //Checking to see if the discance is less than 400
  //to avoid getting alerts when object is out of range.
  if (distance < 400){
    Serial.print("distance: ");
    Serial.println(distance);
  }
 
  delay(200);
}
