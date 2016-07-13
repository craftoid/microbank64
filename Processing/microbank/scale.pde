
// scale a pixel image without interpolation
PImage scalePixels(PImage img, int factor) {
  
  int w1 = img.width;
  int h1 = img.height;
  int w2 = w1 * factor;
  int h2 = h1 * factor;
  
  PImage img2 = createImage(w2, h2, RGB);
  for(int y = 0; y < h2; y++) {
    for(int x = 0; x < w2; x++) {
      img2.set(x, y, img.get(x/factor, y/factor));
    }
  }
  
  return img2;
  
}