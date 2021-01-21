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

public class GameOfLife extends PApplet {



GameManager gameManager = new GameManager();
ImageLoader imageLoader;
public void setup() 
{
	
	gameManager.spawn();
	imageLoader = new ImageLoader();
}

public void draw() 
{
	background(10);
	gameManager.draw();
}


Object [][] objects;
boolean[][] newObjState;
int n = 50;
long startTime;
float spawnTime = 2000;
class GameManager
{
	public void spawn()
	{
		objects = new Object[n][n];
		newObjState = new boolean[n][n];

		float w = (float)width/n;
		float h = (float)height/n;

		for (int y = 0; y < n; ++y) {
			for (int x = 0; x < n; ++x) {
				boolean bool = false;	

				//if((int)random(0,6) < 1)
				//	bool = true;
				objects[y][x] = new Object(w * x, y * h, bool);
			}		
		}
		//gliderCannon();

		startTime = millis() + (long)spawnTime;
	}

	public void draw()
	{
		//målar och kollar
		for (int y = 0; y < n; ++y) {
			for (int x = 0; x < n; ++x) {
				check(y,x);
				objects[y][x].draw();
			}
		}		

		//ändrar alivebool till nästa frame
		if(millis() > startTime) {
			startTime = millis() + (long)spawnTime;
			for (int y = 0; y < n; ++y) {
				for (int x = 0; x < n; ++x) {
					objects[y][x].isAlive = newObjState[y][x];
				}
			}
		}
	}

	public void check(int y, int x)
	{
		int sum = 0;
		int xVal;
		int yVal;

		for (int i = -1; i < 2; ++i) 
		{
			yVal = y + i;			
			if(yVal < 0)
				yVal = n-1;
			else if (yVal > n - 1)
				yVal = 0;

			for (int j = -1; j < 2; ++j) 
			{
				xVal = x + j;			
				if(xVal < 0)
					xVal = n-1;
				else if (xVal > n - 1)
					xVal = 0;

				if(objects[yVal][xVal].isAlive)
				{
					sum += 1;
				}
			}
		}

		if(objects[y][x].isAlive)
			sum -=1;


		if(objects[y][x].isAlive && (sum < 2 || sum > 3))
			newObjState[y][x] = false;
		else if(!objects[y][x].isAlive && sum == 3)
			newObjState[y][x] = true;
		else
			newObjState[y][x] = objects[y][x].isAlive;
	}

	float time2 = 0;
	public void spawnBunchOfGliders()
	{
		if(millis() > time2) {
			time2 = millis() + 700;
			for (int i = 0; i < 6; ++i) {
				spawnGilder(i * 10,0);
			}
		}
	}

	public void spawnGilder(int xpos, int ypos)
	{
		objects[ypos + 1][xpos].isAlive = true;
		objects[ypos + 2][xpos + 1].isAlive = true;
		
		for (int i = 0; i < 3; ++i) {
			objects[ypos + i][xpos +2].isAlive = true;
		}
	}
	public void gliderCannon()
	{
		//ez
		objects[5][1].isAlive = true;
		objects[5][2].isAlive = true;
		objects[6][1].isAlive = true;
		objects[6][2].isAlive = true;

		objects[5][11].isAlive = true;
		objects[6][11].isAlive = true;
		objects[7][11].isAlive = true;
		
		objects[8][12].isAlive = true;
		objects[4][12].isAlive = true;

		objects[3][13].isAlive = true;
		objects[9][13].isAlive = true;
		objects[3][14].isAlive = true;
		objects[9][14].isAlive = true;

		objects[6][15].isAlive = true;
		objects[4][16].isAlive = true;
		objects[8][16].isAlive = true;
		
		objects[5][17].isAlive = true;
		objects[6][17].isAlive = true;
		objects[7][17].isAlive = true;
		objects[6][18].isAlive = true;

		objects[5][21].isAlive = true;
		objects[4][21].isAlive = true;
		objects[3][21].isAlive = true;
		objects[5][22].isAlive = true;
		objects[4][22].isAlive = true;
		objects[3][22].isAlive = true;

		objects[6][23].isAlive = true;
		objects[2][23].isAlive = true;

		objects[6][25].isAlive = true;
		objects[7][25].isAlive = true;

		objects[2][25].isAlive = true;
		objects[1][25].isAlive = true;

		objects[4][35].isAlive = true;
		objects[5][35].isAlive = true;
		objects[4][36].isAlive = true;
		objects[5][36].isAlive = true;
	}
}


class ImageLoader
{
	PImage img;
	PImage destination;
	int dab = 0;
	ImageLoader()
	{
		img = loadImage("GliderCannon.png");
		destination = createImage(img.width, img.height, RGB);
		draw();
	}
	public void draw()
	{
		img.loadPixels();
		destination.loadPixels();
		boolean b = true;
		for (int x = 0; x < img.width; x++) {
			for (int y = 0; y < img.height; y++) {
				int loc = x + y * img.width;
				
				if (brightness(img.pixels[loc]) > 180) {
					b = true;		
					destination.pixels[loc] = color(255);					
				}
				else if(b && x % 8 == 0) {
					b = false;
					destination.pixels[loc] = color(0);
					objects[y/16][x/16].isAlive = true;
					//610 x 178
				} 
				else {
					destination.pixels[loc] = color(255);
				}
			}
		}
		destination.updatePixels();
		image(destination, 0,0);
	}
}

class Object
{
	private float sizeW;
	private float sizeH;
	private PVector pos;
	private int c;

	public boolean isAlive;

	Object(float x, float y, boolean alive)
	{
		//fixa sizeW ngn stanns
		sizeW = (float)width/n;
		sizeH = (float)height/n;
		pos = new PVector(x,y);
		isAlive = alive;
	}

	public void draw()
	{
		strokeWeight(1);
		if(isAlive)
		{
			c = 0xffAD4515;//#13BD6E //#346962
			fill(c);
			stroke(0xff732E0E); //#2A544F
		}
		else 
		{
			c = 0xff121211;//#70003E //#AFDEAF
			fill(c);
			stroke(0xff000000); //#9BC49B
		}
		rect(pos.x, pos.y, sizeW, sizeH);
	}
}
  public void settings() { 	size(800,800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "GameOfLife" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
