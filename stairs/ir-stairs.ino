/*
Creative Embedded Systems
AKW Installation
Stairs

*/

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

int motionPin = 27;
int irPin1 = 33;
int irPin2 = 21;

int motionRead;
int irRead1;
int irRead2;

int motionMovement = 0;
int irMovement1 = 0;
int irMovement2 = 0;

// User stub
void sendMessage() ;

Task taskSendMessage( TASK_SECOND * 1 , TASK_FOREVER, &sendMessage );

void sendMessage() {
  String msg = "stair4:";
  msg += motionMovement;
  msg += " ";
  msg += "stair5:";
  msg += irMovement1;
  msg += " ";
  msg += "stair6:";
  msg += irMovement2;
  mesh.sendBroadcast( msg );
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

  pinMode(irPin, INPUT);
  pinMode(irPin2, INPUT);
}

void loop() {
  // it will run the user scheduler as well
  mesh.update();

  motionRead = digitalRead(motionPin);
  if (motionRead == HIGH) {
    motionMovement = 1;
  }
  else {
    motionMovement1= 0;
  }

  irRead1 = digitalRead(irPin1);
  if (irRead1 == HIGH) {
    irMovement1 = 1;
  }
  else {
    irMovement1 = 0;
  }

  irRead2 = digitalRead(irPin2);
  if (irRead2 == HIGH) {
    irMovement2 = 1;
  }
  else {
    irMovement2 = 0;
  }

  delay(100);
}