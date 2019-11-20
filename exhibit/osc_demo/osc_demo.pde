import oscP5.*;
import netP5.*;

OscP5 oscP5;
int x, y;

void setup() {
  size(400, 400);
  oscP5 = new OscP5(this, 12001);
}

void draw() {
  background(255);
  rect(x, y, 100, 100);
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.addrPattern().equals("/test")) {
    print(theOscMessage.get(0).stringValue());
    print(theOscMessage.get(1).stringValue());
    print(theOscMessage.get(2).stringValue());
    print(theOscMessage.get(3).stringValue());
    print(theOscMessage.get(4).stringValue());
    print(theOscMessage.get(5).stringValue());
    println();
  }
}
