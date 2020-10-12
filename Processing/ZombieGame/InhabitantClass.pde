
class Inhabitant
{
	color habitantColor;
	color eyeColor;
	float habitantRadius = 15;
	float inhabitantSpeed = 4;

	PVector vel;
	PVector pos;

	Inhabitant()
	{
		ellipseMode(CENTER);
		habitantColor = color(random(80, 255));
		eyeColor = color(random(60, 200));
		pos = new PVector();
		vel = new PVector();
		pos = setStartPos();
		vel = newVel();
	}

	void draw()
	{
		screenWarp();
		walk();
		fill(habitantColor);
		stroke(habitantColor);
		ellipse(pos.x, pos.y, habitantRadius, habitantRadius);
		eyes();
	}

	void eyes()
	{
		float rad = atan2(vel.y,vel.x);
		pushMatrix();
        translate(pos.x, pos.y);
        rotate(rad);
        stroke(eyeColor);
        fill(eyeColor);
        circle(habitantRadius/4,-habitantRadius/4, habitantRadius/8); 
        circle(habitantRadius/4,habitantRadius/4, habitantRadius/8);
        popMatrix();
	}

	void walk()
	{
		pos.x += vel.x;
		pos.y += vel.y;
	}

	void screenWarp()
	{
		if(pos.x < 0)
			pos.x = width;
		if(pos.x > width)
			pos.x = 0;

		if(pos.y < 0)
			pos.y = height;
		if(pos.y > height)
			pos.y = 0;	
	}

	PVector setStartPos()
	{
		PVector temp = new PVector();
		temp.x = random(0, width);
    	temp.y = random(0, height);
		/*
		float randN = random(0, 2);
		if (randN < 1) 
		{
			temp = new PVector(0, random(-habitantRadius, height+habitantRadius));
		}
		else if (randN > 0)
		{
			temp = new PVector(width + habitantRadius, random(-habitantRadius, height+habitantRadius));
		}	
		*/
		return temp;
	}

	PVector newVel()
	{
		PVector temp = new PVector();
		temp.x = random(11) - 5;
		temp.y = random(11) - 5;
		temp.normalize();
		return temp;
	}

	//blevskumt i newVel
	void multVel(float s) 
	{
		vel.mult(s);
	}
}