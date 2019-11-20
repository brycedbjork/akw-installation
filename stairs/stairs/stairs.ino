/*
Creative Embedded Systems
AKW Installation
Stairs

*/

//************************************************************
// this is a simple example that uses the painlessMesh library
//
// 1. sends a silly message to every node on the mesh at a random time between 1 and 5 seconds
// 2. prints anything it receives to Serial.print
//
//
//************************************************************
#include <painlessMesh.h>

#define MESH_PREFIX "Atrium AKW"
#define MESH_PASSWORD "lets go!"
#define MESH_PORT 5555

// Prototypes
void sendMessage(); 
void receivedCallback(uint32_t from, String & msg);
void newConnectionCallback(uint32_t nodeId);
void changedConnectionCallback(); 
void nodeTimeAdjustedCallback(int32_t offset); 
void delayReceivedCallback(uint32_t from, int32_t delay);

Scheduler     userScheduler; // to control your personal task
painlessMesh  mesh;


int pirPin = 2;
int pirStat = 0;

int pirPin2 = 4;
int pirStat2 = 0;

const int pingPin = 15;
long duration, inches, cm;
int prevInches;
int ultrasonicMovement = 0;
int motionMovement1 = 0;
int motionMovement2 = 0;

// User stub
void sendMessage() ; // Prototype so PlatformIO doesn't complain

Task taskSendMessage( TASK_SECOND * 1 , TASK_FOREVER, &sendMessage );

void sendMessage() {
  if (ultrasonicMovement == 1) {
    mesh.sendBroadcast( "st_1 1" );
  } else {
    mesh.sendBroadcast( "st_1 0 );
  }
  if (motionMovement1 == 1) {
    mesh.sendBroadcast( "st_2 1" );
  } else {
    mesh.sendBroadcast( "st_2 0" );
  }
  if (motionMovement2 == 1) {
    mesh.sendBroadcast( "st_3 1" );
  } else {
    mesh.sendBroadcast( "st_3 0);
  }
  String msg = "stair1:";
  msg += ultrasonicMovement;
  msg += " ";
  msg += "stair2:";
  msg += motionMovement1;
  msg += " ";
  msg += "stair3:";
  msg += motionMovement2;
  //mesh.sendBroadcast( msg );
  Serial.print(msg);
  taskSendMessage.setInterval( TASK_SECOND * 1 );
}

// Needed for painless library
void receivedCallback( uint32_t from, String &msg ) {
  Serial.printf("startHere: Received from %u msg=%s\n", from, msg.c_str());
}

void newConnectionCallback(uint32_t nodeId) {
    Serial.printf("--> startHere: New Connection, nodeId = %u\n", nodeId);
}

void changedConnectionCallback() {
  Serial.printf("Changed connections\n");
}

void nodeTimeAdjustedCallback(int32_t offset) {
    Serial.printf("Adjusted time %u. Offset = %d\n", mesh.getNodeTime(),offset);
}

void setup() {
  Serial.begin(115200);

//mesh.setDebugMsgTypes( ERROR | MESH_STATUS | CONNECTION | SYNC | COMMUNICATION | GENERAL | MSG_TYPES | REMOTE ); // all types on
  mesh.setDebugMsgTypes( ERROR | STARTUP );  // set before init() so that you can see startup messages

  mesh.init( MESH_PREFIX, MESH_PASSWORD, &userScheduler, MESH_PORT );
  mesh.onReceive(&receivedCallback);
  mesh.onNewConnection(&newConnectionCallback);
  mesh.onChangedConnections(&changedConnectionCallback);
  mesh.onNodeTimeAdjusted(&nodeTimeAdjustedCallback);

  userScheduler.addTask( taskSendMessage );
  taskSendMessage.enable();

  pinMode(pirPin, INPUT);

  pinMode(pirPin2, INPUT);
}

void loop() {
  // it will run the user scheduler as well
  mesh.update();

  pirStat = digitalRead(pirPin);
  if (pirStat == HIGH) {
    motionMovement1 = 1;
  }
  else {
    motionMovement1 = 0;
  }

  pirStat2 = digitalRead(pirPin2);
  if (pirStat2 == HIGH) {
    motionMovement2 = 1;
  }
  else {
    motionMovement2 = 0;
  }
  
  pinMode(pingPin, OUTPUT);
  digitalWrite(pingPin, LOW);
  delayMicroseconds(2);
  digitalWrite(pingPin, HIGH);
  delayMicroseconds(5);
  digitalWrite(pingPin, LOW);

  pinMode(pingPin, INPUT);
  duration = pulseIn(pingPin, HIGH);
  
  prevInches = inches;
  
  inches = microsecondsToInches(duration);
  cm = microsecondsToCentimeters(duration);
  
  if (prevInches > inches){
    ultrasonicMovement = 1;
  }
  else{
    ultrasonicMovement = 0;
  }

  delay(100);
}

long microsecondsToInches(long microseconds){
  return microseconds / 74 / 2;
}

long microsecondsToCentimeters(long microseconds){
  return microseconds / 29 / 2;
}
