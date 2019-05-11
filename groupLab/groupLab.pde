interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

interface Collideable {
  boolean isTouching(Thing other);
}

abstract class Thing implements Displayable {
  float x, y;//Position of the Thing

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
}

class Rock extends Thing implements Collideable {
  String mode;
  PImage[] images;
  int type;
  Rock(float x, float y, String Mode, PImage[] Images) {
    super(x, y);
    mode = Mode;
    images = new PImage[Images.length];
    for (int i = 0; i < Images.length;i++) {
      images[i] = Images[i];
    }
    type = (int)random(0,2);
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
      image(images[type], x,y,100,100);
    }
  }
  
  boolean isTouching(Thing other){
    double xmid;
    double ymid;
    if (mode.equals("simple") || mode.equals("complex")) {
      xmid = x + 25;
      ymid = y + 20;
    }
    else {
      xmid = x + 50;
      ymid = y + 50;
    }
    if (Math.sqrt(Math.pow((double)(other.x-xmid),2.0) + Math.pow((double)(other.y-ymid),2.0)) < 80) {
      return true; 
    }
    return false;
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
  LivingRock(float x, float y, String Mode, PImage[] Images) {
    super(x, y,Mode,Images);
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
  double xspeed;
  double yspeed;
  
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
    xspeed = 0;
    yspeed = 0;
  }
  
  Ball(float x, float y){
    super(x, y);
    mode = "simple";
    xspeed = 0;
    yspeed = 0;
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
ArrayList<Collideable> ListofCollideables;

void setup() {
  size(1000, 800);
  PImage[] rocks = new PImage[] {loadImage("rock.png"), loadImage("stone.png")};
  PImage imgball = loadImage("ball.png");
  
  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  ListofCollideables = new ArrayList<Collideable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100), "simple", imgball, "random");
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100),"image",rocks);
    thingsToDisplay.add(r);
    ListofCollideables.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100), "image",rocks);
    thingsToDisplay.add(m);
    thingsToMove.add(m);
    ListofCollideables.add(m);
  }
  for (Moveable thing : thingsToMove) {
    for (Collideable c : ListofCollideables) {
      if (c.isTouching((Thing)thing)) {
        if (thing instanceof Ball) {
          ((Ball)thing).x = 50+random(width-100); 
          ((Ball)thing).y = 50+random(height-100);     
        }
      }
    }
  }
}
void draw() {
  background(255);

  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
    for (Collideable c : ListofCollideables) {
      if (c.isTouching((Thing)thing)) {
        if (thing instanceof Ball) {
          ((Ball)thing).xspeed *= -1; 
          ((Ball)thing).yspeed *= -1;     
        }
      }
    }
  }
}
