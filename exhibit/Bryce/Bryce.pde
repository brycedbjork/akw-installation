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
  fullScreen();
  oscP5 = new OscP5(this, 12001);
  sts[0] = new stair(255, 255, 255, 0, 0, width/4, height);
  sts[1] = new stair(255, 255, 255, width/4, 0, width/4, height);
  sts[2] = new stair(255, 255, 255, width/2, 0, width/4, height);
  elevs[0] = new elevator(255, 255, 255, width*3/4, 0, width/4, height/3);
  elevs[1] = new elevator(255, 255, 255, width*3/4, height*2/3, width/4, height/3);
}

void draw() {
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
  fill(map(micVal, 0, 400, 100, 255), map(micVal, 400, 1000, 100, 255), map(micVal, 1000, 1400, 100, 255));
  rect(width*3/4, height/3, width/4, height/3);
}

private class elevator {
  private int r;
  private int g;
  private int b;
  private float x;
  private float y;
  private float nw;
  private float nh;
  private boolean active;
  
  elevator(int nr, int ng, int nb, float nx, float ny, float nw, float nh) {
    this.r = nr;
    this.g = ng;
    this.b = nb;
    this.x = nx;
    this.y = ny;
    this.nw = nw;
    this.nh = nh;
    this.active = false;
  }
  
  void drawMe() {
    if (this.active) {
      if (this.r == 255) {
        this.active = false;
      } else {
        this.r += 5;
        this.b += 5;
        this.g += 5;
      }
    }
    fill(this.r, this.g, this.b);
    rect(this.x, this.y, this.nw, this.nh);
    stroke(0, 0, 0);
  }
  
  void colour(int nr, int ng, int nb) {
    this.r = nr;
    this.g = ng;
    this.b = nb;
  }
  
  void open() {
    this.colour(int(random(0, 255)), int(random(0, 255)), int(random(0, 255)));
    this.active = true;
  }
}

private class stair {
  private int r;
  private int g;
  private int b;
  private float x;
  private float y;
  private float nw;
  private float nh;
  private boolean active;
  
  stair(int nr, int ng, int nb, float nx, float ny, float nw, float nh) {
    this.r = nr;
    this.g = ng;
    this.b = nb;
    this.x = nx;
    this.y = ny;
    this.nw = nw;
    this.nh = nh;
    this.active = false;
  }
  
  void drawMe() {
    if (this.active) {
      if (this.r == 255) {
        this.active = false;
      } else {
        this.r += 5;
        this.g += 5;
        this.b += 5;
      }
    }
    fill(this.r, this.g, this.b);
    rect(this.x, this.y, this.nw, this.nh);
    stroke(0, 0, 0);
  }
  
  void colour(int nr, int ng, int nb) {
    this.r = nr;
    this.g = ng;
    this.b = nb;
  }
  
  void step() {
    this.colour(int(random(0, 255)), int(random(0, 255)), int(random(0, 255)));
    this.active = true;
  }
}
