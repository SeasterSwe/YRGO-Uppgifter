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

public class TrigometryMain extends PApplet {

int frame = 0;
float multiplier = 0.002f;
int numberOfPoints = 100;
float safeMargin;
float pointSize;
float distX;
float halfHeight;

float sinSpeed = 0.04f;
float sinStr = 50;

public void setup()
{
	
	strokeWeight(20);
	safeMargin = pointSize;
	distX = (width - safeMargin)/numberOfPoints;
	halfHeight = height * 0.5f;

	noiseSeed(0);
	frameRate(60);
}

public void draw()
{
	background(0);

	strokeWeight(5);
	stroke(255,100,0);

	//DrawCircle();
	//DrawSpiral();
	
}

public void DrawSpiral()
{
	int n = 100;
	float r = 40;
	float middleX = width * 0.5f;

	for (int i = 0; i <= n; ++i) {
		float angleDist = radians(i);
		float x = middleX + (r - i) * sin(angleDist * 100);
		float y = halfHeight + (r - i) * cos(angleDist * 100);

		strokeWeight(1);
		stroke(255,255,255);

		line(middleX, halfHeight, x, y);

		strokeWeight(10);
		stroke(255,100,0);
		
		point(x, y);
	}
	frame++;
}

public void DrawLines()
{
	for (int i = 0; i <= numberOfPoints; ++i) {
		point(safeMargin + (distX * i), halfHeight + 
			sin((frame + i) * sinSpeed) * sinStr);//halfHeight + noise(i) * random(0, sinStr * 2)) + sin((frame + i) * sinSpeed) * sinStr);
	}

	for (int i = 0; i <= numberOfPoints; ++i) {
		point(safeMargin + (distX * i), halfHeight - 
		cos((frame - i) * sinSpeed) * sinStr);//- kan bli +
	}		
	frame++;
}

public void DrawCircle()
{
  int n = 20;
  float r = 80;
  float middleX = width * 0.5f;
  float angleDist = 360/n;
  for (int i = 0; i <= n; ++i) {
    float x = middleX + r * sin(-angleDist * PI/180 * i + frame * sinSpeed);
    float y = halfHeight + r * cos(-angleDist * PI/180 * i + frame * sinSpeed);

  		 strokeWeight(1);
		stroke(255,255,255);

		line(middleX, halfHeight, x, y);

		strokeWeight(10);
		stroke(255,100,0);
		
		point(x, y);
  }
  frame++;
}
  public void settings() { 	size(640, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TrigometryMain" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
