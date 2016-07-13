
int offsetX = 0;
int offsetY = 0;
int poffsetX = 0;
int poffsetY = 0;
float zoom;

// add some mouse dragging support for development
void mouseDragged() {
  if (zoom == 1) {
    offsetX += mouseX - pmouseX;
    offsetY += mouseY - pmouseY; 
    offsetX = (int) constrain(offsetX, width - bankImage.width * zoom, 0);
    offsetY = (int) constrain(offsetY, height - bankImage.height * zoom, 0);
  }
}

// print the screen cordinates of the clicked position
void mousePressed() {
  if(mouseButton == RIGHT) {
    int screenX = -offsetX + int(mouseX / zoom);
    int screenY = -offsetY + int(mouseY / zoom);
    print( ", " + screenX + ", " + screenY );
  }
}


// add some keyboard interaction for development
void keyPressed() {
  switch(key) {
    
  case '+':
    if(zoom != 1.0) {
      zoom = 1.0;
      offsetX = poffsetX;
      offsetY = poffsetY;
    }
    break;
    
  case '-':
    if(zoom != 0.5) {
      zoom  = 0.5;
      poffsetX = offsetX;
      poffsetY = offsetY;
      offsetX = 0;
      offsetY = 0;
    }
    break;
    
  case 'd':
    debug = !debug;
    break;
    
  }
  
  if(key >= '1' && key <= '6') {
    int i = key - '1';
    selectedRoom = staffRoom[i];
  }
  
}