import oscP5.*;
import netP5.*;

OscP5 oscP5;

float stepW;
float stepH;
float stepD;
float elevW;
float elevH;
float micVal = 0;
elevator elevs[] = new elevator[2];
stair sts[] = new stair[6];

void setup() {
  fullScreen(P3D);
  oscP5 = new OscP5(this, 12001);
  stepW = width / 4;
  stepH = height / 4;
  stepD = 200;
  elevW = height / 5;
  elevH = width / 5;
  sts[0] = new stair(255, 255, 255, (width /2), height - (stepH * 1), 0, 50, 0, 0);
  sts[1] = new stair(255, 255, 255, (width / 2), height - (stepH * 2), -50, 50, 0, 0);
  sts[2] = new stair(255, 255, 255, (width / 2), height - (stepH * 3), -100, 59, 0, 0);
  lights();
  elevs[0] = new elevator(255, 255, 255, height/5, height - (width / 5), 0, 0.2, PI, 0);
  elevs[1] = new elevator(255, 255, 255, width - (height / 5), height - (width / 5), 0, -0.2, 0, 0);
}

void draw() {
  background(map(micVal, 0, 400, 100, 255), map(micVal, 400, 1000, 100, 255), map(micVal, 1000, 1400, 100, 255));
  fill(255, 0, 0);
  elevs[0].drawMe();
  elevs[1].drawMe();
  for (int i = 0; i < 3; i++) {
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
        } else {
          System.out.println("Bad Message: " + mes);
        }
      } else {
        System.out.println("Bad Message: " + mes);
      }
    }
}

void mic(int val) {
  micVal = val;
}

private class elevator {
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
  
  elevator(int nr, int ng, int nb, float nx, float ny, float nz, float nxd, float nyd, float nzd) {
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
        this.r += 50;
        this.b += 50;
      }
    }
    pushMatrix();
    fill(this.r, this.g, this.b);
    translate(this.x, this.y, this.z);
    rotateY(this.yd);
    rotateX(this.xd);
    rotateZ(this.zd);
    stroke(0, 0, 0);
    box(elevW, elevH, 100);
    popMatrix();
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
        this.r += 50;
        this.g += 50;
      }
    }
    pushMatrix();
    fill(this.r, this.g, this.b);
    translate(this.x, this.y, this.z);
    rotateY(this.yd);
    rotateX(this.xd);
    rotateZ(this.zd);
    stroke(0, 0, 0);
    box(stepW, stepD, stepH);
    popMatrix();
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
