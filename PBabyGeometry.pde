int cx, cy;
color[] colors = new color[4];
float ringSize=80;
String type = "RINGS";
boolean doSave = false;
int direction = 1;
boolean active=true;
boolean twitchy=false;
boolean isBW=true;

void randomizeColors() {
    // random colors
    for (int i=0;i<4;i++) {
      if (isBW) {
        float newGrey = random(256);
        colors[i] = color(newGrey, newGrey, newGrey);
       } else {
        colors[i] = color(random(256),random(256),random(256));
      }
    }
}

void blackAndWhiteColors() {
  isBW=true;
  colors[0]=#000000;
  colors[1]=#ffffFF;
  colors[2]=#000000;
  colors[3]=#ffffFF;
}

void centeredRect(float x,float y,float w,float h) {
  x = x - w/2;
  y = y - h/2;
  rect(x,y,w,h);
//  println("centeredRect");
}

void setup() {
  size(800,600);
  
  println("BWRings");
  println("use + and - to increase & decrease size of rings");
  println("use s to draw squares");
  println("use c to draw centered squares");
  println("use r to draw rings");
  println("use R to randomize colors");
  println("use b to toggle black & white");
  println("use x to save picture");
  println("use t to toggle twitchyness");
  
  cx=width/2;
  cy=height/2;
  
  blackAndWhiteColors();
}
void updateRingSize() {
  ringSize+=1.1*direction;
  if (ringSize < 3 || ringSize > 200) direction *= -1;
}

void draw() {
  if (!active) return;
  background(256);
  if (twitchy) randomizeColors();

  updateRingSize();
  boolean done = false;
  float size = height;
  int i=0;
  while (!done) {
    fill(colors[i%4]);
    stroke(colors[i++%4]);
    if (type.equals("RINGS")) {
      ellipse(cx,cy,size, size);
    } else if (type.equals("SQUARES")) {
      rect(0,0,size, size);
    } else if (type.equals("CENTERED_SQUARES")) {
      centeredRect(cx,cy,size, size);
    }    
    
    size-=ringSize;
    if (size < ringSize) done = true;
  }
  
  if (doSave) {
    saveFrame("BW-####.png");
    doSave=false;
  }
}

void keyPressed() {
//  println("keyPressed "+key);
  if (key==43) { // +
    ringSize = ringSize * 1.1;
  } else if (key==45) { // -
    ringSize = ringSize / 1.1;
  } else if (key==115) { //s
    type="SQUARES";
  } else if (key==116) { //t
    twitchy = ! twitchy;
  } else if (key==114) { //r
    type="RINGS";
  } else if (key==99) { //c
    type="CENTERED_SQUARES";    
  } else if (key==32) { // space
    active = ! active;
  } else if (key==98) { // b
    blackAndWhiteColors();
  } else if (key==82) { //R
    isBW=false;
    randomizeColors();
  } else if (key==120) { //x
    doSave=true;
  }
//println(ringSize);
}
