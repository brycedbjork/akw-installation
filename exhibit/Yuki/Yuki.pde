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
microphone mic;

void setup() {
  fullScreen(P3D);
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
  elevs[0] = new elevator(255, 255, 255, height/5, height - (width / 5), 0, 0.2, PI, 0);
  elevs[1] = new elevator(255, 255, 255, width - (height / 5), height - (width / 5), 0, -0.2, 0, 0);
  mic = new microphone(255, 255, 255, width / 2, height / 8, 0, 0.2, 0, 0);
}

void draw() {
  background(0, 0, 0);
  fill(255, 0, 0);
  elevs[0].drawMe();
  elevs[1].drawMe();
  for (int i = 0; i < 6; i++) {
    sts[i].drawMe();
  }
  mic.drawMe();
}

void oscEvent(OscMessage theOscMessage) {
    String mes = "";
    for (int i = 0; i < 6; i++) {
      mes += theOscMessage.get(i).stringValue();
    }
    System.out.println(mes);
    if (mes.charAt(0) == '0') {
      mic.changeVal(Integer.parseInt(mes));
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

private class microphone {
  private int r;
  private int g;
  private int b;
  private int val;
  private float x;
  private float y;
  private float z;
  private float xd;
  private float yd;
  private float zd;
  
  microphone(int nr, int ng, int nb, float nx, float ny, float nz, float nxd, float nyd, float nzd) {
    this.r = nr;
    this.g = ng;
    this.b = nb;
    this.x = nx;
    this.y = ny;
    this.z = nz;
    this.xd = nxd;
    this.yd = nyd;
    this.zd = nzd;
    this.val = 900;
  }
  
  void drawMe() {
    pushMatrix();
    float nR = this.r;
    nR = 255 / 4095 * this.val;
    this.colour((int) nR, this.val % 255, val % 255);
    fill(this.r, this.g, this.b);
    translate(this.x, this.y, this.z);
    rotateY(this.yd);
    rotateX(this.xd);
    rotateZ(this.zd);
    stroke(0, 0, 0);
    int size = (int) (10 + sqrt(val));
    sphere(size);
    popMatrix();
    this.yd += 0.1;
  }
  
  void colour(int nr, int ng, int nb) {
    this.r = nr;
    this.g = ng;
    this.b = nb;
  }
  
  void changeVal(int nV) {
    this.val = nV;
  }
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
        this.r += 5;
        this.b += 5;
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
        this.r += 5;
        this.g += 5;
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


/*
void elev1(int r, int g, int b) {
  pushMatrix();
  fill(r, g, b);
  //rect(0, height - (width / 5), height/5, width/5);
  translate(height/5, height - (width / 5), 0);
  rotateY(PI);
  rotateX(0.2);
  stroke(0, 0, 0);
  box(height/5, width/5, 100);
  popMatrix();
}

void elev2(int r, int g, int b) {
  pushMatrix();
  fill(r, g, b);
  //rect(width - (height / 5), height - (width / 5), height/5, width/5);
  translate(width - (height / 5), height - (width / 5), 0);
  rotateX(-0.2);
  stroke(0, 0, 0);
  box(height/5, width/5, 100);
  popMatrix();
}

void stair1(int r, int g, int b) {
  //rect((width / 2) - (stepW * 0.5) + stepW, height - (stepH * 2), stepW, stepH);
  pushMatrix();
  fill(r, g, b);
  translate((width / 2), height - (stepH * 2), 0);
  stroke(0, 0, 0);
  box(stepW, 10, stepH);
  popMatrix();
}

void stair2(int r, int g, int b) {
  //rect((width / 2) - (stepW * 0.5), height - (stepH * 3), stepW, stepH);
  pushMatrix();
  fill(r, g, b);
  translate((width / 2), height - (stepH * 3), -50);
  stroke(0, 0, 0);
  box(stepW, 10, stepH);
  popMatrix();
}

void stair3(int r, int g, int b) {
  //rect((width / 2) - (stepW * 0.5) - stepW, height - (stepH * 4), stepW, stepH);
  pushMatrix();
  fill(r, g, b);
  translate((width / 2), height - (stepH * 4), -100);
  stroke(0, 0, 0);
  box(stepW, 10, stepH);
  popMatrix();
}

void stair4(int r, int g, int b) {
  //rect((width / 2) - (stepW * 0.5), height - (stepH * 3), stepW, stepH);
  pushMatrix();
  fill(r, g, b);
  translate((width / 2), height - (stepH * 5), -150);
  stroke(0, 0, 0);
  box(stepW, 10, stepH);
  popMatrix();
}

void stair5(int r, int g, int b) {
  pushMatrix();
  fill(r, g, b);
  translate((width / 2), height - (stepH * 6), -200);
  stroke(0, 0, 0);
  box(stepW, 10, stepH);
  popMatrix();
}

void stair6(int r, int g, int b) {
  pushMatrix();
  fill(r, g, b);
  translate((width / 2), height - (stepH * 7), -250);
  stroke(0, 0, 0);
  box(stepW, 10, stepH);
  popMatrix();
}
*/
