import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class WalkerMain extends PApplet {



//This file is only for testing your movement/behavior.
//The Walkers will compete in a different program!

ArrayList<WalkerInterface> walker = new ArrayList<WalkerInterface>();
ArrayList<PVector> walkerPos = new ArrayList<PVector>();

public void setup() {
  
  frameRate(300);

  for (int i = 0; i < 1; ++i) {
  	WalkerInterface w = new JakBul();
  	walker.add(w);	
  	PVector v = w.getStartPosition(width, height);
  	walkerPos.add(v);
  }

  background(10);
}

public void draw() {
  if(mousePressed){
    return;
  }
	for (int i = 0; i < walker.size(); ++i) {
    stroke(255,0,0);
		point(walkerPos.get(i).x,walkerPos.get(i).y);
  		walkerPos.get(i).add(walker.get(i).update());	
      PVector pos = walkerPos.get(i);
      if(pos.x > width || pos.x < 0 || pos.y < 0 || pos.y > height)
        println("died: ");
	}
}


class JakBul implements WalkerInterface {

  float areaWidth;
  float areaHeight;
  PVector currentPos;
  PVector target;
  int xLeangth;
  int yLeangth;
  float direction;
  float yDirecton;
  int wColor;
  float safeMargin = 20;
  float randomYLeangth;
  float randomXLeangth;
  public String getName()
  {
    return "Ginger Jakob"; //When asked, tell them our walkers name
  }

  public PVector getStartPosition(int playAreaWidth, int playAreaHeight)
  {
    //Select a starting position or use a random one.

    float safeMarginFix = 20f/1000f;
    safeMargin = playAreaWidth * safeMarginFix;
    
    areaWidth = playAreaWidth - safeMargin;
    areaHeight = playAreaHeight - safeMargin;

    float xFix = 1900f/playAreaWidth;
    float yFix = 1200f/playAreaHeight;

    this.randomYLeangth = 120f/yFix;
    this.randomXLeangth = 120f/xFix;

    PVector startPos = EdgeStart(playAreaWidth, playAreaHeight, safeMargin);
    float x = startPos.x;
    float y = startPos.y;
    
    direction = 1;
    yDirecton = 1;
    if(y > playAreaHeight/2)
      yDirecton = -1;
    if(x > playAreaWidth/2)
      direction = -1;

    currentPos = new PVector((int)x,(int)y);
    target = NewTarget();
    target.add(currentPos);

    //a PVector holds floats but make sure its whole numbers that are returned!
    return new PVector((int)x, (int)y);
  }

  public PVector update()
  {

    if(currentPos.dist(target) < 2)
    {
      target = NewTarget();
      target.add(currentPos);
    }

    if(currentPos.x <= target.x){
      
        currentPos.add(new PVector(1,0));
        if(target.x == currentPos.x){
            target.x = target.x - xLeangth;
            return YWalk();
        }

      return new PVector(1,0);
    }

      if(currentPos.x >= target.x){
        currentPos.add(new PVector(-1,0));
        if(target.x == currentPos.x){
          target.x = target.x + xLeangth;
          return YWalk();
        }
        return new PVector(-1,0);
    }

    else {
      return RandomDirection();
    }
  }

  public PVector NewTarget()
  {
    //lekrunt
    xLeangth = (int)random(1, randomXLeangth);
    yLeangth = (int)random(1, randomYLeangth);
    float dx = (xLeangth * direction) + currentPos.x;
    if(dx > areaWidth - safeMargin || dx < 0 + safeMargin)
    {
      direction *= -1;
    }
    return new PVector(xLeangth * (int)direction, yLeangth * (int)yDirecton);
  }

  boolean goDown = true;
  public PVector YWalk()
  {
    if(currentPos.y < areaHeight - safeMargin && yDirecton > 0){
      currentPos.add(new PVector(0,1));
      
      if(currentPos.y == areaHeight - safeMargin)
      {
        yDirecton *= -1;
        target.y = target.y += yLeangth * yDirecton;        
        target.x += xLeangth * direction;
      }

      return new PVector(0,1);
    }
    else if(currentPos.y > 0){
      currentPos.add(new PVector(0,-1));
      
      if(currentPos.y == 0 + safeMargin && yDirecton < 0)
      {
         yDirecton *= -1;
        target.y += yLeangth * yDirecton;        
        target.x += xLeangth * direction;
      }

      return new PVector(0,-1);
    }
    else {
      return RandomDirection();
    }
  }

  public PVector EdgeStart(float playAreaWidth, float playAreaHeight, float frame)
  {
    switch((int)random(0, 4)) {
    case 0:
      return new PVector(frame, random(frame, playAreaHeight - frame));
    case 1:
      return new PVector(playAreaWidth -frame, random(frame, playAreaHeight - frame));
    case 2:
      return new PVector(random(frame, playAreaWidth), frame);
    default:
      return new PVector(random(frame, playAreaWidth), playAreaHeight - frame);
    }
  }
  public PVector RandomDirection()
  {
    switch((int)random(0, 4)) {
    case 0:
      currentPos.add(new PVector(-1,0));
      return new PVector(-1, 0);
    case 1:
      currentPos.add(new PVector(1,0));
      return new PVector(1, 0);
    case 2:
      currentPos.add(new PVector(0,1));
      return new PVector(0, 1);
    default:
      currentPos.add(new PVector(0,-1));
      return new PVector(0, -1);
    }
  }
}


interface WalkerInterface {

  public String getName();

  public PVector getStartPosition(int playAreaWidth, int playAreaHeight);

  public PVector update();
}
  public void settings() {  size(400, 400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "WalkerMain" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
