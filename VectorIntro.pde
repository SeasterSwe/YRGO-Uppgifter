
private PVector ballV = new PVector();
private float speed;
private PVector dir = new PVector();
private float dist;
void setup() {

	size(640, 640);
	smooth();
	ballV.x = width/2;
	ballV.y = height/2;
	speed = 60;
}

void draw() {
	background(256);
	PVector mouse = new PVector(mouseX,mouseY);
	PVector mouseArrow = new PVector(20,20);
	stroke(53, 74,55); 
	fill(53, 74,55);
	ellipse(ballV.x, ballV.y, 40, 40);	

	if (mousePressed)
	{
		if (mouseButton == RIGHT)
		{
			ballV = mouse;
		}
		else if (mouseButton == LEFT)
		{	
			stroke(100, 200, 0);
			line(ballV.x, ballV.y, mouseX, mouseY);

			dir = PVector.sub(mouse, ballV);
			dist = PVector.dist(mouse, ballV);
			dir.normalize();
			dir.mult(dist/speed);

			/*
			PVector dir2 = new PVector();
			dir2 = PVector.sub(mouse, mouseArrow);
			dir2.normalize();
			mouseArrow.add(dir2);
			float test = mouseArrow.mag();

			line(mouseX, mouseY, mouseX + test, mouseY + test);
			line(mouseX, mouseY, mouseX - test, mouseY + test);
			*/
		}
	}	
	else 
	{
		bounceCheck();
		ballV.add(dir);
	}
}
void bounceCheck()
{
	if ((ballV.x > width - 20) || (ballV.x < 20)) 
	{
    dir.x = dir.x * -1;
  	}
	if ((ballV.y > height - 20) || (ballV.y < 20)) 
	{
    dir.y = dir.y * -1;
 	}
}
