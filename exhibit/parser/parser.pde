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
    if (mes.charAt(0) == '0') {
      mic(Integer.parseInt(mes));
    } else if (mes.charAt(5) == '1') {
      char num = mes.charAt(3);
      if (mes.charAt(0) == 'e') {
        if (num == '1') {
          elev1();
        } else if (num == '2') {
          elev2();
        } else {
          System.out.println("Bad Message: " + mes);
        }
      } else if (mes.charAt(0) == 's') {
        if (num == '1') {
          stair1();
        } else if (num == '2') {
          stair2();
        } else if (num == '3') {
          stair3();
        } else if (num == '4') {
          stair4();
        } else if (num == '5') {
          stair5();
        } else if (num == '6') {
          stair6();
        } else {
          System.out.println("Bad Message: " + mes);
        }
      } else {
        System.out.println("Bad Message: " + mes);
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

void mic(int val) {
}
