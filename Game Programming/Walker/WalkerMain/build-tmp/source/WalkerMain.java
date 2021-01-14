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

WalkerInterface walker;
PVector walkerPos;

public void setup() {
  

  //Create a walker from the class Example it has the type of WalkerInterface
  walker = new JakobsWalker();

  walkerPos = walker.getStartPosition(width, height);
}

public void draw() {
  point(walkerPos.x, walkerPos.y);
  walkerPos.add(walker.update());
}


class JakobsWalker implements WalkerInterface {

  public String getName()
  {
    return "Jakob"; //When asked, tell them our walkers name
  }

  public PVector getStartPosition(int playAreaWidth, int playAreaHeight)
  {
    //Select a starting position or use a random one.
    float x = (int) random(0, playAreaWidth);
    float y = (int) random(0, playAreaHeight);

    //a PVector holds floats but make sure its whole numbers that are returned!
    return new PVector(x, y);
  }

  public PVector update()
  {
    //add your own walk behavior for your walker here.
    //Make sure to only use the outputs listed below.

    switch((int)random(0, 4)) {
    case 0:
      return new PVector(-1, 0);
    case 1:
      return new PVector(1, 0);
    case 2:
      return new PVector(0, 1);
    default:
      return new PVector(0, -1);
    }
  }
}


interface WalkerInterface {
  //returns the name of the walker, should be your name!
  public String getName();

  //returns the start position for the walker
  public PVector getStartPosition(int playAreaWidth, int playAreaHeight);

  //updates the walker position
  //the walker is only allowed to take one step, left/right or up/down
  //If the walker moves diagonally or too long, it will be killed.
  public PVector update();
}
  public void settings() {  size(640, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "WalkerMain" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
