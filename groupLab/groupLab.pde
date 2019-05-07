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
  String mode;
  PImage image;
  Rock(float x, float y, String Mode, PImage Image) {
    super(x, y);
    mode = Mode;
    image = Image;
  }
  Rock(float x, float y) {
    super(x,y);
    mode = "simple";
  }

  void display() {
    /* Chris Choi */
    if (mode.equals("complex")) {
      fill(80);
      ellipse(x,y,50,40);
      noStroke();
      triangle(x-20,y+20,x+20,y+20,x,y-25);
      fill(255);
      stroke(0);
    }
    else if (mode.equals("simple")) {
      fill(80);
      ellipse(x,y,50,40);
      fill(255);
    }
    else {
      image(image, x,y,55,40);
    }
  }
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x, y);
  }
  void move() {
    /* Christy */
    x += random(-10,10);
    y += random(-10,10);
  }
}
import java.util.Random;
class Ball extends Thing implements Moveable {
  String mode;
  PImage ballPic;
  
  Ball(float x, float y, String Mode, PImage BallPic) {
    super(x, y);
    mode = Mode;
    ballPic = BallPic;
  }
  
  Ball(float x, float y){
    super(x, y);
    mode = "simple";
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
    if(mode.equals("simple")){
      ellipse(x, y, 100, 100);
      fill(100);
    }
    else if(mode.equals("complex")){
      
    }
    else{
      image(ballPic, x, y, 100, 100);
    }
    
  }
  double theta = 0;
  void move() {
    //Benjamin
    Random r = new Random();
    int next = Math.abs(r.nextInt())%4;
    if (next == 0) {
      if (x < 800) {
        x++;
      }
    }
    else if (next == 1) {
      if (x > 0) {
        x--;
      }
    }
    else if (next == 2) {
      if (y < 800) {
        y++;
      }
    }
    else {
      if (y > 0) {
        y--;
      }
    }
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);
  PImage img = loadImage("Rock.jpg");
  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100),"image",img);
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