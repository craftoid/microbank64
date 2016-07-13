
Room selectedRoom;

// staff rooms
Room office = new Office();
Room revision = new Revision();
Room counter = new Counter();
Room consulting = new Consulting();
Room elevator = new ElevatorRoom();
Room vault = new Vault();

// other rooms
Room elevator2 = new ElevatorRoom2();
Room kitchen = new Kitchen();
Room bathroom = new Bathroom();
Room attic = new Attic();
Room waitinghall = new Waitinghall();

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
  waitinghall 
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
    if(this == selectedRoom) {
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
  }

  Office() {    
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
  }

  Revision() {
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
  }

  Consulting() {
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
  }

  Counter() {
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
  }

  ElevatorRoom() {
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
  }

  ElevatorRoom2() {
    setOutline(
      1331, 815, 
      1680, 815, 
      1680, 1130, 
      1331, 1130
      );
  }
}


class Kitchen extends Room {

  {
    name = "Küche";
  }

  Kitchen() {
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
  }

  Bathroom() {
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
  }

  Attic() {
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
  }

  Vault() {
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
  }

  Waitinghall() {
    setOutline(
      593, 815, 
      1047, 815, 
      1047, 1131, 
      593, 1131
      );
  }
}

class ElevatorRoom3 extends Room {
  {
    name = "Fahrstuhl 2. OG";
  }
}

class ElevatorRoom4 extends Room {
  {
    name = "Fahrstuhl 3. OG";
  }
}

class Staircase1 extends Room {
  {
    name = "Treppenhaus EG";
  }
}

class Staircase2 extends Room {
  {
    name = "Treppenhaus 1. OG";
  }
}

class Balcony extends Room {
  {
    name = "Balkon";
  }
}