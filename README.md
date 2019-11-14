## Distributed Networks: Task 1 Documentation

## Members

Bryce Bjork,
Felicia Chang,
Justin Cong,
Yuki de Pourbaix,
Varsha Raghavan

## Input Sensors and Devices

5 ESP32s,
4 Motion Sensors,
3 Ultrasonics,
1 IR Sensor,
1 Microphone,
1 Switch,
1 LED

## Input Network Setup

Our installation is built around the staircase located between floors 2 and 3 in AKW. Two ESP32s with a combination of ultrasonic, motion, and IR sensors will be mounted on the side of the staircase, and each sensor will be associated with a specific step (six steps in total). Two ESP32s with one ultrasonic sensor each will be mounted at the top of the elevator entryways in floor 2. Finally the last ESP32 attached to a microphone, switch, and LED will be mounted on the wall near the staircase.
The intent with these input locations is to capture the general activity that takes place on AKW floor 2. Specifically, the elevator sensors will capture how often each elevator is used, the stair sensors will capture whether that specific stair has been stepped on or not, and the microphone wall mount will provide the user with an option to flip a switch and record the surrounding noise level/ speak into it.  

## Data Network Setup

In order to communicate all input values from the sensors in a centralized way, we have implemented a mesh network via painless mesh. Each ESP32 is associated with a specific node that are all hosted on the same port. When sensor values are received, a message is sent through this port that communicates the specific input value and the node it originated from. A Raspberry Pi will be listening on the same port for these messages, and as it receives them it will determine the appropriate output.


