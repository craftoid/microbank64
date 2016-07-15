
// staff
Sprite director, secretary, accountant, bankteller, guard, liftboy;

Sprite[] sprite;

void setupSprites() {

  director = new Director();
  secretary = new Secretary();
  accountant = new Accountant();
  bankteller = new BankTeller();
  guard = new Guard();
  liftboy = new Liftboy();

  sprite = new Sprite[] {
    director, 
    secretary, 
    accountant, 
    bankteller, 
    guard, 
    liftboy
  };

  // initial position  
  director.moveto(610, 364);
  secretary.moveto(1450, 580);
  bankteller.moveto(430, 1132);
  accountant.moveto(612, 796);
  guard.moveto(804, 1386);
  liftboy.moveto(1528, 1386);
}

class Director extends Sprite {
  {
    gridCrop(12, 0);
  }
}

class Secretary extends Sprite {
  {
    gridCrop(6, 0);
  }
}

class Accountant extends Sprite {
  {
    gridCrop(9, 0);
  }
}

class Guard extends Sprite {
  {
    gridCrop(15, 0);
  }
}

class BankTeller extends Sprite {
  {
    gridCrop(6, 0);
  }
}

class Liftboy extends Sprite {
  {
    gridCrop(3, 0);
  }
}


class Sprite {

  PImage img;
  int x, y, w, h;


  void show() {
    image(img, x, y - h);
  }

  void moveto(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void crop(int x, int y, int w, int h) {
    img = spriteSheet.get(x, y, w, h);
    this.w = w;
    this.h = h;
  }

  void gridCrop(int x, int y) {
    int cellx = 72;
    int celly = 100;
    crop(72 * x, 0, 46, 150);
  }
}