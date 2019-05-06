interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

abstract class Thing implements Displayable {
  float x, y;//Position of the Thing

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
}

class Rock extends Thing {
  Rock(float x, float y) {
    super(x, y);
  }

  void display() {
    /* Chris Choi */
    ellipse(x,y,50,50);
  }
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x, y);
  }
  void move() {
    /* Christy */
    x += random(0,10);
    y += random(0,10);
  }
}
import java.util.Random;
class Ball extends Thing implements Moveable {
  Ball(float x, float y) {

    super(x, y);
  }

  void display() {
    /* AMY */
    /* 
    a) A simple shape
    b)Several shapes put together to make something more complex. (may need some instance variables from here onward)
    c) An Image (use the menu sketch -> add file, so you don't have to worry about paths)
    d) Choose randomly: Simple, Complex, or Image  (you may need a new constructor for this)
    */
    ellipse(450, 300, 100, 100);
    
  }

  void move() {
    //Benjamin
    Random r = new Random();
    int next = Math.abs(r.nextInt())%4;
    if (next == 0) {
      x++;
    }
    else if (next == 1) {
      x--;
    }
    else if (next == 2) {
      y++;
    }
    else {
      y--;
    }
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(m);
    thingsToMove.add(m);
  }
}
void draw() {
  background(255);

  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
}