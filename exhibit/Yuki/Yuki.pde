import oscP5.*;
import netP5.*;

OscP5 oscP5;

float stepW;
float stepH;
float x;

void setup() {
  fullScreen(P3D);
  oscP5 = new OscP5(this, 12001);
  stepW = width / 4;
  stepH = height / 8;
  lights();
  x = 0;
}

void draw() {
  background(0, 0, 0);
  fill(255, 0, 0);
  elev1(255, 255, 255);
  elev2(255, 255, 255);
  stair1(255, 255, 255);
  stair2(255, 255, 255);
  stair3(255, 255, 255);
  stair4(255, 255, 255);
  stair5(255, 255, 255);
  stair6(255, 255, 255);
  /*
  pushMatrix();
  translate(width / 2 - 50, height*0.35, 0);
  //rotateX(x);
  rotateY(x);
  //rotateZ(x);
  x += 0.2;
  noFill();
  stroke(255);
  sphere(100);
  popMatrix();
  */
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
          elev1(0, 255, 0);
        } else if (num == '2') {
          elev2(0, 255, 0);
        } else {
          System.out.println("Bad Message: " + mes);
        }
      } else if (mes.charAt(0) == 's') {
        if (num == '1') {
          stair1(0, 0, 255);
        } else if (num == '2') {
          stair2(0, 0, 255);
        } else if (num == '3') {
          stair3(0, 0, 255);
        } else if (num == '4') {
          stair4(0, 0, 255);
        } else if (num == '5') {
          stair5(0, 0, 255);
        } else if (num == '6') {
          stair6(0, 0, 255);
        } else {
          System.out.println("Bad Message: " + mes);
        }
      } else {
        System.out.println("Bad Message: " + mes);
      }
    }
}

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

void mic(int val) {
}
