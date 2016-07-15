
Room selectedRoom;

// staff rooms
Room office = new Office();
Room revision = new Revision();
Room counter = new Counter();
Room consulting = new Consulting();
Room elevator = new ElevatorRoom();
Room vault = new Vault();

// other rooms
Room kitchen = new Kitchen();
Room bathroom = new Bathroom();
Room attic = new Attic();
Room waitinghall = new Waitinghall();

Room elevator2 = new ElevatorRoom2();
Room elevator3 = new ElevatorRoom3();
Room elevator4 = new ElevatorRoom4();

Room staircase1 = new Staircase1();
Room staircase2 = new Staircase2();
Room balcony = new Balcony();

// rooms and sprites
Room[] staffRoom = {
  office, 
  revision, 
  consulting, 
  counter, 
  vault, 
  elevator
};

Room[] publicRoom = {
  elevator2, 
  kitchen, 
  bathroom, 
  attic, 
  waitinghall, 
  elevator3, 
  elevator4, 
  staircase1, 
  staircase2,
  balcony
};


abstract class Room {

  String name = "room";
  int[] outline = {};

  void setOutline(int ... coords) {
    outline = coords;
  }

  void show() {

    pushStyle();
    noFill();

    // select outline color
    if (this == selectedRoom) {
      stroke(255, 0, 0, 200);
      fill(255, 100, 100, 100);
      strokeWeight(10);
    } else {
      stroke(100, 150);
      strokeWeight(8);
    }

    drawOutline();
    popStyle();
  }

  void drawOutline() {
    beginShape();
    for (int i = 0; i < outline.length; i+=2) {
      vertex(outline[i], outline[i+1]);
    }
    endShape(CLOSE);
  }
}


class Office extends Room {

  {
    name = "Büro";
    setOutline( 
      492, 194, 
      1048, 194, 
      1048, 363, 
      320, 363
      );
  }
}

class Revision extends Room {

  {
    name = "Revision";
    setOutline(
      311, 383, 
      1048, 383, 
      1048, 579, 
      311, 579
      );
  }
}

class Consulting extends Room {

  {
    name = "Beratung";
    setOutline(
      311, 599, 
      1048, 599, 
      1048, 795, 
      310, 795
      );
  }
}

class Counter extends Room {

  {
    name = "Schalter";
    setOutline(
      389, 815, 
      574, 815, 
      574, 1131, 
      389, 1131
      );
  }
}

class ElevatorRoom extends Room {

  {
    name = "Fahrstuhl Keller";
    setOutline(
      1331, 1151, 
      1680, 1151, 
      1680, 1386, 
      1331, 1386
      );
  }
}

class ElevatorRoom2 extends Room {

  {
    name = "Fahrstuhl EG";
    setOutline(
      1331, 815, 
      1680, 815, 
      1680, 1130, 
      1331, 1130
      );
  }
}

class ElevatorRoom3 extends Room {
  {
    name = "Fahrstuhl 2. OG";
    setOutline(
      1068, 383, 
      1313, 383, 
      1313, 579, 
      1068, 579
      );
  }
}

class ElevatorRoom4 extends Room {
  {
    name = "Fahrstuhl 3. OG";
    setOutline(
      1068, 194, 
      1440, 194, 
      1309, 363, 
      1068, 363
      );
  }
}

class Staircase1 extends Room {
  {
    name = "Treppenhaus EG";
    setOutline(
      1068, 815, 
      1310, 815, 
      1310, 1131, 
      1068, 1131
      );
  }
}

class Staircase2 extends Room {
  {
    name = "Treppenhaus 1. OG";
    setOutline(
      1068, 599, 
      1312, 599, 
      1312, 795, 
      1068, 795
      );
  }
}

class Kitchen extends Room {

  {
    name = "Küche";
    setOutline(
      1331, 383, 
      1680, 383, 
      1680, 579, 
      1331, 579
      );
  }
}

class Bathroom extends Room {

  {
    name = "Bad";
    setOutline(
      1331, 599, 
      1680, 599, 
      1680, 795, 
      1331, 795
      );
  }
}

class Attic extends Room {

  {
    name = "Dachboden";
    setOutline(
      1505, 145, 
      1673, 363, 
      1340, 363
      );
  }
}

class Vault extends Room {

  {
    name = "Tresor";
    setOutline(
      384, 1151, 
      1310, 1151, 
      1310, 1388, 
      384, 1388
      );
  }
}

class Waitinghall extends Room {
  {
    name = "Waiting Room";
    setOutline(
      593, 815, 
      1047, 815, 
      1047, 1131, 
      593, 1131
      );
  }
}

class Balcony extends Room {
  {
    name = "Balkon";
    setOutline(
      1697, 540, 
      1768, 540, 
      1768, 579, 
      1698, 579
      );
  }
}