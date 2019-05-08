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
      image(image, x,y,100,100);
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
  LivingRock(float x, float y, String Mode, PImage Image) {
    super(x, y,Mode,Image);
    xMovement = random(0, 10);
    yMovement = random(0, 10);
    xDirection = 1;
    yDirection = 1;
  }
  
  void display() {
    super.display();
    fill(255);
    ellipse(x+40,y+40,20,20);
    ellipse(x+70,y+40,20,20);
    fill(0);
    ellipse(x+40,y+40,10,10);
    ellipse(x+70,y+40,10,10);
    fill(255);
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
  int ballColor1;
  int ballColor2;
  int ballColor3;
  boolean moveType;
  
  Ball(float x, float y, String Mode, PImage BallPic, String ColorRandom) {
    super(x, y);
    ballPic = BallPic;
    mode = Mode;
    if(ColorRandom.equals("random")){
      ballColor1 = int(random(0,255));
      ballColor2 = int(random(0,255));
      ballColor3 = int(random(0,255));
    } else{
      ballColor1 = 255;
      ballColor2 = 0;
      ballColor3 = 0;
    }
    moveType = false;
    if (random(10) >= 5) {
      moveType = true;
    }
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
    else{
      image(ballPic, x, y, 100, 100);
    }
    fill(ballColor1, ballColor2, ballColor3);
  }
  double xspeed = 0;
  double yspeed = 0;
  void move() {
    if (moveType) {
      otherMove();
      return;
    }
    //Benjamin
    if (x < 0) {
      x = 0;
      xspeed *= random(-1,-0.75);
    }
    if (x > 1000) {
      x = 1000;
      xspeed *= random(-1,-0.75);
    }
    if (y < 0) {
      y = 0;
      yspeed *= random(-1,-0.75);
    }
    if (y > 800) {
      y = 800;
      yspeed *= random(-1,-0.75);
    }
    xspeed += random(-1,1);
    yspeed += random(-1,1);
    x += xspeed;
    y += yspeed;
  }
  
  double theta = 0;
  void otherMove() {
    x -= Math.cos(Math.toRadians(theta));
    y -= Math.sin(Math.toRadians(theta));
    theta = (theta+1)%360;
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);
  PImage img = loadImage("rock.png");
  PImage imgball = loadImage("ball.png");
  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100), "simple", imgball, "random");
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100),"image",img);
    thingsToDisplay.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100), "image",img);
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