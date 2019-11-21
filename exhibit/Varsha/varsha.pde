import oscP5.*;
import netP5.*;

OscP5 oscP5;

float stepW;
float stepH;
float stepD;
float elevW;
float elevH;
elevator elevs[] = new elevator[2];
stair sts[] = new stair[6];

void setup() {
  fullScreen(P3D);
  background(0);
  smooth();
  oscP5 = new OscP5(this, 12001);
  stepW = width / 4;
  stepH = height / 8;
  stepD = 10;
  elevW = height / 5;
  elevH = width / 5;
  sts[0] = new stair(255, 255, 255, (width / 2), height - (stepH * 2), 0, 0, 0, 0);
  sts[1] = new stair(255, 255, 255, (width / 2), height - (stepH * 3), -50, 0, 0, 0);
  sts[2] = new stair(255, 255, 255, (width / 2), height - (stepH * 4), -100, 0, 0, 0);
  sts[3] = new stair(255, 255, 255, (width / 2), height - (stepH * 5), -150, 0, 0, 0);
  sts[4] = new stair(255, 255, 255, (width / 2), height - (stepH * 6), -200, 0, 0, 0);
  sts[5] = new stair(255, 255, 255, (width / 2), height - (stepH * 7), -250, 0, 0, 0);
  lights();
  elevs[0] = new elevator();
  elevs[1] = new elevator();
}

void draw() {
  background(0, 0, 0);
  fill(255, 0, 0);
  elevs[0].drawMe();
  elevs[1].drawMe();
  for (int i = 0; i < 6; i++) {
    sts[i].drawMe();
  }
}

void oscEvent(OscMessage theOscMessage) {
    String mes = "";
    for (int i = 0; i < 6; i++) {
      mes += theOscMessage.get(i).stringValue();
    }
    System.out.println(mes);
    if (mes.charAt(0) == '0') {
      mic(Integer.parseInt(mes));
    } else if (mes.charAt(5) == '1') {
      char num = mes.charAt(3);
      if (mes.charAt(0) == 'e') {
        if (num == '1') {
          elevs[0].open();
        } else if (num == '2') {
          elevs[1].open();
        } else {
          System.out.println("Bad Message: " + mes);
        }
      } else if (mes.charAt(0) == 's') {
        if (num == '1') {
          sts[0].step();
        } else if (num == '2') {
          sts[1].step();
        } else if (num == '3') {
          sts[2].step();
        } else if (num == '4') {
          sts[3].step();
        } else if (num == '5') {
          sts[4].step();
        } else if (num == '6') {
          sts[5].step();
        } else {
          System.out.println("Bad Message: " + mes);
        }
      } else {
        System.out.println("Bad Message: " + mes);
      }
    }
}

void mic(int val) {
}

private class elevator {
  private boolean active;
  private float r;
  private float g;
  private float b;
  private int x;
  private int y;
  private float pointilize;
  
  elevator() {
    this.r = random(256);
    this.g = random(256);
    this.b = random(256);
    this.x = int(random(1500));
    this.y = int(random(1500));
    this.pointilize = random(100);
    this.active = false;
  }
  
  void drawMe() {
    if (this.active) {
      if (this.r == 255) {
        this.active = false;
      } else {
        this.r += 5;
        this.b += 5;
      }
    }
  int loc = x + y*100;
  
  float r = random(256);
  float g = random(256);
  float b = random(256);
  noStroke();
  
  fill(r,g,b,100);
  ellipse(x, y,pointillize,pointillize);
 }
 
 void colour(int nr, int ng, int nb) {
    this.r = nr;
    this.g = ng;
    this.b = nb;
  }
  
  void open() {
    this.colour(0, 255, 0);
    this.active = true;
  }
}

private class stair {
  private int r;
  private int g;
  private int b;
  private float x;
  private float y;
  private float z;
  private float xd;
  private float yd;
  private float zd;
  private boolean active;
  
  stair(int nr, int ng, int nb, float nx, float ny, float nz, float nxd, float nyd, float nzd) {
    this.r = nr;
    this.g = ng;
    this.b = nb;
    this.x = nx;
    this.y = ny;
    this.z = nz;
    this.xd = nxd;
    this.yd = nyd;
    this.zd = nzd;
    this.active = false;
  }
  
  void drawMe() {
    if (this.active) {
      if (this.r == 255) {
        this.active = false;
      } else {
        this.r += 5;
        this.g += 5;
      }
    }
  }
  
  void colour(int nr, int ng, int nb) {
    this.r = nr;
    this.g = ng;
    this.b = nb;
  }
  
  void step() {
    this.colour(0, 0, 255);
    this.active = true;
  }
}
