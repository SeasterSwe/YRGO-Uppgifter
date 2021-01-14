


void DrawLines()
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

void DrawCircle()
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

void DrawSpiral()
{
  	float middleX = width * 0.5f; //Center of circle on x axis //Center of circle on 
  	int n = 200;
  	float r = 20;
	for (int i = 0; i <= n; ++i) {
		float angle = radians(i);
		strokeWeight(1);
		stroke(255,255,255);

		float radius = r + i;
   	 	float x = middleX + cos(angle*10 + (frame * 0.04f)) * radius;  
    	float y = halfHeight + sin(angle*10+(frame * 0.04f)) * radius;

//		line(middleX, halfHeight, x, y);

		strokeWeight(10);
		stroke(255,100,0);
		
		point(x, y);
	}
	frame++;
}