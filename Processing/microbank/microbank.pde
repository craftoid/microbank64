
////////////////////////////////////////////////////
//                                                //
//     M I C R O B A N K    6 4                   //
//                                                //
////////////////////////////////////////////////////

// (c) bitcraftlab + SIGTHREAD 2016

// Sketch for displaying the microbank
// - receives a six-bit messages via OSC from microctrl
// - displays the dollhouse on a QXGA screen (2048 x 1536)

import oscP5.*;

boolean debug = false;

int bits = 0;
int dx, dy;

// osc communication
OscP5 osc;
int bankPort = 10002;


// light bulb colors
color[] palette = {   
  color(255, 255, 255), 
  color(255, 0, 0), 
  color(0, 255, 0), 
  color(0, 0, 255), 
  color(255, 255, 0), 
  color(200, 200, 200)
};

// dollhouse image
PImage bankImage;


// sprites
Sprite[] sprite = {};

void setup() 
{

  fullScreen(2); zoom = 1.0;
  // size(2048, 1536); zoom = 1.0;       // HIRES
  // size(1024, 768); zoom = 0.5;     // LORES (development only)

  // connect to OSC
  osc  = new OscP5(this, bankPort);
  osc.plug(this, "receive", "/bits");

  // load sprites and images
  bankImage = loadImage("microbank.gif");
  bankImage = scalePixels(bankImage, 3);

}


void draw() {

  background(255);

  showBank();
  showRooms();
  showSprites();

  if (debug) {
    showLamps();
  }
  
}

void showBank() {

  translate(offsetX, offsetY);
  scale(zoom);
  image(bankImage, 0, 0);
  
}

void showRooms() {
  
  // show staff rooms
  for(int i = 0; i < staffRoom.length; i++) {
    staffRoom[i].show();
  }
  
  // show public rooms
    for(int i = 0; i < publicRoom.length; i++) {
    publicRoom[i].show();
  }
  
}

void showSprites() {
  for(int i = 0; i < sprite.length; i++) {
    sprite[i].show();
  }
}


void adjustOffset() {
}

void showLamps() {

  dx = width / 6;
  dy = height/ 2;

  int b = bits;
  for (int i = 0; i < 6; i++) {
    fill(b % 2 == 1 ? palette[i] : 50);
    ellipse(dx/2 + i*dx, dy, dx/2, dx/2);
    b /= 2;
  }
}

// OSC receiver
void receive(int b) {
 
  bits = b;
  selectBits(bits);
}

void selectBits(int b) {

  bits = b;
  
  int hi = (bits & 56) >> 3;
  println("Hi Bits " + hi);

  if (hi == 0) {
    selectNowhere();
  }

  // select a room corresponding to the bit code
  if (hi >= 1 && hi <= 6) {
    selectRoom(hi-1);
  }

  // incoming message for all the staff!
  if (hi == 7) {
    if (bits == 63) {
      // if all bits are set we got a bankrobbery
      selectAlarm();
    } else {
      // otherwise eveyone go home to their own room
      selectEverywhere();
    }
  }
  
}

void selectRoom(int i) {
  selectedRoom = staffRoom[i];
}

void selectNowhere() {
  selectedRoom = null;
}

void selectEverywhere() {
  selectedRoom = null;
}

void selectAlarm() {
  selectedRoom = null;
}