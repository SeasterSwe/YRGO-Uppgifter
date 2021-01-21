int frame = 0;
float multiplier = 0.002;
int numberOfPoints = 100;
float safeMargin;
float pointSize;
float distX;
float halfHeight;

float sinSpeed = 0.04;
float sinStr = 120;

void setup()
{
	size(1080, 480);
	strokeWeight(20);
	safeMargin = pointSize + 40;
	distX = (width - safeMargin)/numberOfPoints;
	halfHeight = height * 0.5f;

	noiseSeed(0);
	frameRate(60);
}

void draw()
{
	background(15);

	strokeWeight(5);
	stroke(255,100,0);

	//DrawSpiral();
	DrawLinesTest();
	frame++;
}

void DrawCircleCool (float xPos, float yPos, float speed)
{
	for (int z = 1; z <= 2; ++z) {
		int n = 20;
		float r = 100 - (30 * z) + sin((frame) * sinSpeed) * 20;
 	 	float angleDist = 360/n;
 		
 		for (int i = 0; i <= n; ++i) {
   	 		float x = xPos + r * sin(-angleDist * PI/180 * i + frame * speed);
  	 		float y = yPos + r * cos(-angleDist * PI/180 * i + frame * speed);

  	 		if(z % 2 == 0 && i % 2 == 0)
  	 		{
  	 			strokeWeight(0.2f);
				stroke(200,200,200);
				line(xPos, yPos, x, y);
  	 		}
			strokeWeight(10);
			float cR = 100 + sin((frame) * sinSpeed) * 90;
			float cG = 0;
			float cB = 200 + sin((frame) * sinSpeed) * 90;
			color c = color(cR, cG, cB);
			stroke(c);
		
			point(x, y);
 		}
		
	}  	
}

float oklart = 0;
float oklart2 = numberOfPoints;
float dir = 1;
void DrawLinesTest()
{
	for (int i = 0; i <= numberOfPoints; ++i) {
		float x = safeMargin + (distX * i);
		float ySin =  halfHeight + sin((frame + i) * sinSpeed + frame * sinSpeed/2) * sinStr;
		float yCos = halfHeight - cos((frame - i) * sinSpeed) * sinStr;

		strokeWeight(0.2f);
		stroke(200,200,200);

		line(x, ySin, x, yCos);

		strokeWeight(5);
		float cR = 100 + sin((frame +i) * sinSpeed ) * 90;
		float cG = 0;
		float cB = 200 + sin((frame +i) * sinSpeed) * 90;
		color c = color(cR, cG, cB);

		stroke(c);
		
		point(x, ySin);//halfHeight + noise(i) * random(0, sinStr * 2)) + sin((frame + i) * sinSpeed) * sinStr);
		
		point(x, yCos);//- kan bli +

	}		

	oklart = oklart + 0.5f * dir;
	oklart2 = oklart2 + 0.5f * -dir;
	if(oklart >= numberOfPoints || oklart <= 0)
		dir = dir * -1;

	DrawCircleCool(safeMargin + (distX * oklart), halfHeight + 
		sin((frame + oklart) * sinSpeed + frame * sinSpeed/2) * sinStr, sinSpeed * -dir);

	DrawCircleCool(safeMargin + (distX * oklart2), halfHeight - 
		cos((frame - oklart2) * sinSpeed) * sinStr, -sinSpeed * -dir);
	

}

