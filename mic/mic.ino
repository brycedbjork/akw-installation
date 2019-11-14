/*
Creative Embedded Systems
AKW Installation
Mic

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

#define   MESH_PREFIX       "Atrium AKW"
#define   MESH_PASSWORD   "lets go!"
#define   MESH_PORT       5555

// mic stuff
int led = 13;
int micPin = 33;
int switchPin = 21;
int sum;

// Prototypes
void sendMessage(); 
void receivedCallback(uint32_t from, String & msg);
void newConnectionCallback(uint32_t nodeId);
void changedConnectionCallback(); 
void nodeTimeAdjustedCallback(int32_t offset); 
void delayReceivedCallback(uint32_t from, int32_t delay);

Scheduler     userScheduler; // to control your personal task
painlessMesh  mesh;

// User stub
void sendMessage() ; // Prototype so PlatformIO doesn't complain

Task taskSendMessage( TASK_SECOND * 1 , TASK_FOREVER, &sendMessage );

void sendMessage() {
  String msg;
  msg = "microphone:";

  // pad the message
  if (sum < 10) {
    msg += "000";
    msg += sum;
  }
  // pad the message
  else if (sum < 100) {
    msg += "00";
    msg += sum;
  }
  // pad the message
  else if (sum < 1000) {
    msg += "0";
    msg += sum;
  }
  // pad the message
  else {
    msg += sum;
  }
  
  //msg += mesh.getNodeId();
  mesh.sendBroadcast( msg );
  taskSendMessage.setInterval( TASK_SECOND * 1 );
  Serial.println(msg);
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

  pinMode(switchPin, INPUT_PULLUP);
  pinMode(led, OUTPUT);

//mesh.setDebugMsgTypes( ERROR | MESH_STATUS | CONNECTION | SYNC | COMMUNICATION | GENERAL | MSG_TYPES | REMOTE ); // all types on
  mesh.setDebugMsgTypes( ERROR | STARTUP );  // set before init() so that you can see startup messages

  mesh.init( MESH_PREFIX, MESH_PASSWORD, &userScheduler, MESH_PORT );
  mesh.onReceive(&receivedCallback);
  mesh.onNewConnection(&newConnectionCallback);
  mesh.onChangedConnections(&changedConnectionCallback);
  mesh.onNodeTimeAdjusted(&nodeTimeAdjustedCallback);

  userScheduler.addTask( taskSendMessage );
  taskSendMessage.enable();
}

int switchState;

void loop() {

    switchState = digitalRead(switchPin);
    sum = 0;
    //if (true){

      digitalWrite(led, HIGH);
      long pre_sum = 0;
      
      for(int i=0; i<1000; i++)
      {
          pre_sum += analogRead(micPin);
      }
 
      sum = pre_sum/1000;

      //Serial.println(sum);
   
      delay(10);
    //}
//    else {
//      digitalWrite(led, LOW);
//    }
  
  // it will run the user scheduler as well
  mesh.update();
}
