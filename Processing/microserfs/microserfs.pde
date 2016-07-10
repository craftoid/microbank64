
////////////////////////////////////////////////////
//                                                //
//     M I C R O S E R F S                        //
//                                                //
////////////////////////////////////////////////////

// (c) bitcraftlab + SIGTHREAD 2016

// Sketch for displaying the staff of the microbank
// - receives a six-bit messages via OSC from microctrl
// - displays on a 1280 x 800 screen

// to check the functionality:

// press 'd' to toggle debugging mode (show the lamps)
// press '0' .. '7' for setting the value of the lower bits
// press 'b' for bankrobbery (all bits set)

import oscP5.*;

boolean debug;
int bits = 0;

// osc communication
OscP5 osc;
int bankPort = 10001;

// light bulbs
color[] palette = {   
  color(255, 255, 255), 
  color(255, 0, 0), 
  color(0, 255, 0), 
  color(0, 0, 255), 
  color(255, 255, 0), 
  color(200, 200, 200)
};

// names
String[] name = {
  "director", 
  "secretary", 
  "accountant", 
  "bankteller", 
  "liftboy", 
  "guard"
};

String[] state = {
  "normal", 
  "happy", 
  "shocked", 
};

// portraits
PImage[][] sprite = new PImage[name.length][state.length];

// portrait dimensions
int w = 426;
int h = 400;

// which sprites to display
int[] select = new int[sprite.length];

void setup() 
{

  size(1280, 800);

  // load all the portraits
  for (int i = 0; i < name.length; i++) {
    for (int j = 0; j < state.length; j++) {

      // load the image
      String filename = name[i] + "-" + state[j] + ".gif";
      println("Loading " + filename + " ...");
      PImage img = loadImage(filename);

      // crop the image in case it's oversized
      img = img.get((img.width - w)/2, (img.height - h)/2, w, h);

      // add the image to our array of sprites
      sprite[i][j] = img;
    }
  }

  // connect to OSC
  osc  = new OscP5(this, bankPort);
  osc.plug(this, "receive", "/bits");
}


void draw() {

  background(255);
  
  showPortraits();

  if (debug) {
    showLamps();
  }

}

void showPortraits() {

  int cols = 3;
  int bw1 = 5;
  int bw2 = 8;
  int bw3 = 12;

  for (int i = 0; i < sprite.length; i++) {

    // calculate position
    float x = (i % cols) * w + bw1 / 2 - 1;
    float y = (i / cols) * h + bw1 / 2 - 1;

    // draw the sprite
    imageMode(CENTER);
    image(sprite[i][select[i]], x + w/2, y + h/2);

    pushStyle();

    noFill();

    // draw a black border around everything
    stroke(0);
    strokeWeight(bw1);
    rect(x, y, w  - 1, h - 1);

    // inner border color based on state
    switch(select[i]) {

    case 0:

      // light gray inner border
      stroke(200);
      strokeWeight(bw1);
      rect(x + bw1, y + bw1, w - 2 * bw1 - 1, h - 2 * bw1 - 1);
      break;

    case 1:

      // fat pulsating inner border (gray to black)
      float f1 = 0.5 + 0.5 * sin(frameCount / 10.0);
      color c1 = lerpColor(color(100), color(200), f1);
      stroke(c1);
      strokeWeight(bw3);
      rect(x + bw2, y + bw2, w - 2 * bw2 - 1, h - 2 * bw2 - 1);
      break;

    case 2:

      // fat pulsating inner border (red to black)
      float f2 = 0.5 + 0.5 * sin(frameCount / 10.0);
      color c2 = lerpColor(color(100, 0, 0), color(200, 100, 100), f2);
      stroke(c2);
      strokeWeight(bw3);
      rect(x + bw2, y + bw2, w - 2 * bw2 - 1, h - 2 * bw2 - 1);
      break;
    }

    popStyle();
  }
}


// OSC receiver
void receive(int b) {

  bits = b;
  selectBits(bits);
}


void selectBits(int b) {

  bits = b;
  
  int lo = bits & 7;

  if (lo == 0) {
    selectNobody();
  }

  // select a sprite corresponding to the bit code
  if (lo >= 1 && lo <= 6) {
    selectSprite(lo-1);
  }

  // incoming message for all the staff!
  if (lo == 7) {
    if (bits == 63) {
      // if all bits are set we got a bankrobbery
      selectAlarm();
    } else {
      // otherwise just a regular meeting
      selectEverybody();
    }
  }
  
}


// display lamps in debug mode
void showLamps() {

  int b = bits;

  int dx = width / 6;
  int dy = height/ 2;
  int bw = 6;

  pushStyle();
 
  noStroke();
  fill(0, 150);
  rect(0, height/2 - dx/2 , width, dx);
  
  for (int i = 0; i < 6; i++) {
    
    noFill();
    
    // black outline
    stroke(0);
    strokeWeight(bw);
    ellipse(dx/2 + i*dx, dy, dx/2 + bw, dx/2 + bw);   
    
    // colored ellipse with white outline
    fill(b % 2 == 1 ? palette[i] : 50);
    stroke(255);
    ellipse(dx/2 + i*dx, dy, dx/2, dx/2);
    
    b /= 2;
    
  }
  
  popStyle();
  
}

void selectSprite(int num) {

  // select a single sprite
  for (int i = 0; i < sprite.length; i++) {
    if (i == num) {
      select[i] = 1;
    } else {
      select[i] = 0;
    }
  }

}

void selectNobody() {
  selectAll(0);
}

void selectEverybody() {
  selectAll(1);
}

void selectAlarm() {
  selectAll(2);
}

void selectAll(int state) {
  for (int i = 0; i < sprite.length; i++) {
    select[i] = state;
  }
}

// keyboard interaction for debugging ...
void keyPressed() {

  switch(key) {
  case 'd':  // toggle debug mode 
    debug = !debug;
    break;
  case 'b':  // bank robbery
    selectBits(63);
    break;
  }

  // use the numeric keys to select a person manually
  if (key >= '0' && key <= '7') {
    int i = key - '0';
    selectBits(i);
  }
  
}