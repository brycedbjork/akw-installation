import oscP5.*;
import netP5.*;
import processing.sound.*;

SoundFile choir_a;
SoundFile choir_b;
SoundFile choir_c;
SoundFile choir_d;
SoundFile choir_e;
SoundFile choir_g;
SoundFile cymbal;
SoundFile drum;
OscP5 oscP5;
int x, y;

void setup() {
  fullScreen();
  fill(234);
  rect(0, 0, width, height);
  oscP5 = new OscP5(this, 12001);
  
  // sound files to play
  choir_a = new SoundFile(this, "choir_a.wav");
  choir_b = new SoundFile(this, "choir_b.wav");
  choir_c = new SoundFile(this, "choir_c.wav");
  choir_d = new SoundFile(this, "choir_d.wav");
  choir_e = new SoundFile(this, "choir_e.wav");
  choir_g = new SoundFile(this, "choir_g.wav");
  cymbal = new SoundFile(this, "cymbal.wav");
  drum = new SoundFile(this, "drum.wav");
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
  cymbal.play();
}

void elev2() {
  drum.play();
}

void stair1() {
  choir_g.play();
}

void stair2() {
   choir_a.play();
}

void stair3() {
   choir_b.play();
}

void stair4() {
   choir_c.play();
}

void stair5() {
   choir_d.play();
}

void stair6() {
   choir_e.play();
}

void mic(int val) {
}
