float r = 350;
int res = 399;
float n = 2, sum, nSum = 0;
boolean go = true;
boolean tutorial = true;
boolean pressed = false;

void setup() {
  size(displayWidth, displayHeight);
  r = (min(width, height)/2)*0.99;
  sum = TWO_PI/res;

  n = 0;//random(-1000, 1000);
}

void draw() {
  background(0);

  frameRate(60);

  if (nSum!=0) {
    stroke(255);
    fill(255);
    textAlign(LEFT, CENTER);
    textSize(40);
    text("Speed: x" + nf(nSum*10, 1, 2), 20, 40);

    float h1 = height*0.9;

    noStroke();
    fill(51);
    rect(width*0.1, h1, width*0.8, height*0.08, 50);

    stroke(255);
    fill(100);
    textAlign(CENTER);
    textSize(60);
    text("Stop", width/2, height*0.95);
  }

  translate(width/2, height/2);

  stroke(100, 255, 50, 75);

  noFill();

  beginShape();
  for (float i = 0; i<TWO_PI; i+=sum) {
    float x = cos(i)*r;
    float y = sin(i)*r;
    float x2 = cos(i*n)*r;
    float y2 = sin(i*n)*r;

    line(x, y, x2, y2);
    vertex(x, y);
  } 
  endShape(CLOSE);

  translate(-width/2, -height/2);

  if (tutorial) {
    noStroke();
    fill(255, 255, 255, 50);
    rect(0, 0, width, height);

    stroke(0);
    strokeWeight(10);
    line(width/2, 0, width/2, height);
    strokeWeight(1);

    stroke(255);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(40);
    text("Press here \n to decelerate", width*0.25, height/2);
    text("Press here \n to accelerate", width*0.75, height/2);
  }

  if (go) {
    n+=nSum;
  }
  if (pressed && frameCount%2==0) {
    nSum+=0.005*getSign();
  }
}

void mousePressed() {
  //go = !go;
  tutorial = false;

  if (onButton()) {
    nSum = 0;
    pressed = false;
  } else {
    pressed = true;
  }
}

boolean onButton() {
  float x1 = width*0.1;
  float x2 = width * 0.9;
  float h1 = height*0.9;
  float h2 = height * 0.95;

  return (mouseX<x2 && mouseX>x1 && mouseY<h2 && mouseY>h1);
}

void mouseReleased() {
  pressed = false;
}

void mouseClicked() {
  tutorial = false;

  nSum+=0.01*getSign();
}

int getSign() {
  if (mouseX<width/2) {
    return -1;
  } else {
    return 1;
  }
}
