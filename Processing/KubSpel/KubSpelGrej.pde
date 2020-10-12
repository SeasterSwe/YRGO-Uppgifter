
ArrayList<Box> boxes = new ArrayList<Box>();
Ball ball = new Ball();
Player player = new Player();

void setup() 
{
  size(600, 600);
  background(10, 0, 6);
  float n = 20;
  rectMode(CENTER);
  float boxWidth = width/n;
  float boxHeight = height/2/n;
  float lerpVal = 1f/(n*n);
  float startAmt = 0;

  color startColor = color (255, 0, 0);
  color endColor = color (0, 0, 255);
  color boxColor;
  for (int i = 0; i < n + 1; ++i) {
    for (int t = 0; t < n + 1; ++t) {
      startAmt += lerpVal;
      boxColor = lerpColor(startColor, endColor, startAmt);
      boxes.add(new Box(t * boxWidth, i * boxHeight, boxWidth, boxHeight, boxColor)); 
    }
  }
  player.fixStuff();
  ball.fixStuff();
}

void draw() 
{
  background(10, 0, 6);
  player.drawPlayer();
  ball.move();

  for (int i = 0; i < boxes.size(); ++i) 
  {
    boxes.get(i).drawBox();
  }
}
void keyPressed()
{
  player.move();
}

private class Ball
{
  PVector dir = new PVector();
  PVector posBall = new PVector();
  float speed = 320;
  float r = 20;

  void move()
  {
    stroke(0,128,0);
    fill(0,128,0);
    drawBall();
    posBall.add(dir);
  }
  void bounce(String dirChange)
  {
    if (dirChange == "x") {
      dir.x *= -1;
    }
    else if(dirChange == "y"){
      dir.y*=-1;
    }    
  }
  void drawBall()
  {
    ellipse(posBall.x, posBall.y, 20, 20);
    if ((posBall.x > width) || (posBall.x < 0)) 
    {
      bounce("x");
      }
    if ((posBall.y > height) || (posBall.y < 0)) 
    {
        bounce("y");
    }  
  }
  void fixStuff()
  {
    posBall.x = width/2 - 30;
    posBall.y = height * 0.75;
    dir = new PVector();
    calcMove();
  }
  void calcMove()
  {
    dir = new PVector(random(-1,1), -1);
    dir.normalize();
    dir.mult(speed/100);
  }
}
private class Player
{
  PVector posPlayer = new PVector();
  float speed = 10;
  float len = 60;
  float h = 15;
  
  void fixStuff()
  {
    posPlayer.x = (width/2) - 30;
    posPlayer.y = height * 0.83;
  }
  void drawPlayer()
  {
    stroke(60,128,0);
    fill(60,128,0);
    rect(posPlayer.x, posPlayer.y, len, h);
    collCheck(30);
  }
  void collCheck(float dist)
  {
    if (PVector.dist(ball.posBall, posPlayer) < dist) 
    {
      ball.bounce("y");
    }
  }

  void move()
  {
    if (keyCode == RIGHT)
    {
      posPlayer.x += speed;
    }
    if (keyCode == LEFT)
    {
      posPlayer.x -= speed;
    }
  }
}
private class Box
{
  int health = 0;
  PVector pos = new PVector();
  float wid = 0;
  float hei = 0;
  color colo = 0;

  Box(float x, float y, float w,float h, color c)
  {
    pos.x = x;
    pos.y = y;
    wid = w;
    hei = h;
    colo = c;
  }

  void drawBox()
  {
    stroke(0);
    fill(colo);
    rect(pos.x, pos.y, wid, hei);
    collCheck(20);
  }
  void collCheck(float dist)
  {
    if (PVector.dist(ball.posBall, pos) < dist) 
    {
      ball.bounce("y");
      boxes.remove(this);
    }
  }
}