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
    String mes = "";
    for (int i = 0; i < 6; i++) {
	mes += theOscMessage.get(i).stringValue();
    }
    if (mes[0] == 'e') {
	if (mes[3] == '1') {
	} else if (mes[3] == '2') {
        }
  }
}

void elev1() {
}

void elev2() {
}

void stair1() {
}

void stair2() {
}

void stair3() {
}

void stair4() {
}

void stair5() {
}

void stair6() {
}
