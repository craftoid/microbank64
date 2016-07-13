
////////////////////////////////////////////////////
//                                                //
//     M I C R O C T R L                          //
//                                                //
////////////////////////////////////////////////////

// (c) bitcraftlab + SIGTHREAD 2016

// Sketch for controlling the microserfs and the 
// microbank

// - receives a six-bit messages via serial port
// - passes the message to the microbank and
//   the microserfs via OSC

import processing.serial.*;
import netP5.*;
import oscP5.*;

int bits = 0;
int dx, dy;

// serial communication
Serial port;
int baud = 9600;

// osc communication
OscP5 osc;
String host ="localhost";
NetAddress serf, bank;
int ctrlPort = 10000;
int serfPort = 10001;
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
  dx = width /6;
  dy = height/2;

  // connect to serial port
  String device = Serial.list()[0];
  port = new Serial(this, device, baud);

  // connect to OSC
  osc  = new OscP5(this, ctrlPort);
  serf = new NetAddress(host, serfPort);
  bank = new NetAddress(host, bankPort);
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


// get bits from the serial port
void serialEvent(Serial myPort) {
  bits = myPort.read();
  sendbits();
}


// use keyboard for toggling bits
void keyPressed() {
  if (key >= '1' && key <= '6') {
    int bit = key - '1';
    bits = (bits ^ (1<<bit)) & 63;
    sendbits();
  }
}


// send bits via OSC
void sendbits() {
  
  // create a new OSC message
  OscMessage  msg = new OscMessage("/bits");
  msg.add(bits);
  
  // send it to the bank and the serfs
  osc.send(msg, bank);
  osc.send(msg, serf);
  
}