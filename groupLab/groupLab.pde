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
  float xMovement;
  float yMovement;
  int xDirection;
  int yDirection;
  
  LivingRock(float x, float y) {
    super(x, y);
    xMovement = random(0, 10);
    yMovement = random(0, 10);
    xDirection = 1;
    yDirection = 1;
  }
  void move() {
    /* Christy */
    if(x <= 0 || y <= 0 || x >= width || y >= height){
      xDirection *= -1;
      yDirection *= -1;
      xMovement = random(0, 10);
      yMovement = random(0, 10);
    }
    x += xMovement * xDirection;
    y += yMovement * yDirection;
  }
}
class Ball extends Thing implements Moveable {
  String mode;
  PImage ballPic;
  String colorRandom;
  
  Ball(float x, float y, String Mode, PImage BallPic, String ColorRandom) {
    super(x, y);
    mode = Mode;
    ballPic = BallPic;
    colorRandom = ColorRandom;
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
    //ellipse(450, 300, 100, 100);
    
    if(mode.equals("simple")){
      ellipse(x, y, 100, 100);
      fill(100);
    }
    else if(mode.equals("complex")){
      fill(80);
      ellipse(x, y, 100, 100);
      
    }
    else{
      image(ballPic, x, y, 100, 100);
    }
    
  }
  double theta = 0;
  double xspeed = 0;
  double yspeed = 0;
  void move() {
    //Benjamin
    if (x < 0 || x > 1000) {
      xspeed *= -1;
    }
    if (y < 0 || y > 800) {
      yspeed *= -1;
    }
    xspeed += random(-1.01,1);
    yspeed += random(-1.01,1);
    x += xspeed;
    y += yspeed;
    /*int next = (int)random(4);
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
    }*/
    /*x -= Math.cos(Math.toRadians(theta));
    y -= Math.sin(Math.toRadians(theta));
    theta = (theta+1)%360;*/
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);
  PImage img = loadImage("Rock.jpg");
  PImage imgball = loadImage("ball.png");
  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100), "image", imgball, "color");
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
