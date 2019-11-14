import oscP5.*;
import netP5.*;

OscP5 oscP5;

void setup() {
  size(720, 480);

  oscP5 = new OscP5(this, 5555);   // listening
}

void oscEvent(OscMessage theOscMessage) {
  print("received an osc message.");
  println(theOscMessage.addrPattern());
}