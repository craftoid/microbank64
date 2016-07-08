
////////////////////////////////////////////////////
//                                                //
//     M I C R O B A N K    6 4                   //
//                                                //
////////////////////////////////////////////////////

// (c) bitcraftlab + SIGTHREAD 2016

// Sketch for displaying the microbank
// - receives a six-bit messages via OSC from microctrl

import oscP5.*;

int bits = 0;
int dx, dy;

// osc communication
OscP5 osc;
int bankPort = 10002;

// light bulbs
color[] palette = {   
  color(255, 255, 255), 
  color(255, 0, 0), 
  color(0, 255, 0), 
  color(0, 0, 255), 
  color(255, 255, 0), 
  color(200, 200, 200)
};


void setup() 
{
  size(600, 100);
  dx = width / 6;
  dy = height/ 2;

  // connect to OSC
  osc  = new OscP5(this, bankPort);
  osc.plug(this, "receive",  "/bits");
}


// draw the light bulbs
void draw() {
  background(0);
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
}