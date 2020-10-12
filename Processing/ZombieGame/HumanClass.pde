
class Human extends Inhabitant{
	
	float turnRad;
	float panickRadius;
	Human()
	{
		float redVal = random(80,250);
		float blueVal = random(30, 90);
		color c = color(redVal, 0, blueVal);
		habitantColor = c;
		eyeColor = color(random(170, 210));
		
		inhabitantSpeed = 2;
		float r = random(-5, 6);
		habitantRadius += r;
		panickRadius = 90;
		turnRad = 40;
		super.multVel(inhabitantSpeed);
	}

	void walk()
	{
		super.walk();
		for (int i = 0; i < inhabitants.size(); ++i) {
			int hm = i;
			if(closeToZombie(panickRadius, this, inhabitants.get(i)))
			{
				panick(0.02f);
				dirChange(0.3f, 60);
			}
			else
			{
				dirChange(random(0.1f, 0.5f), 30);
			}
		}
	}

	float timeForNewMove = 0;
	void dirChange(float sectowait, float  minDeg)
	{	
		if (millis() > timeForNewMove) {
			//borde la ge ngt 90 åt båda håll samt till min deg så man ej får noll.
			float deg = random(random(-90, -minDeg+1), random(minDeg,91));
			float rad = radians(deg);
			vel = RotateRadians(vel, rad);
			timeForNewMove = millis() + (sectowait * 1000);	
		}
	}

	PVector RotateRadians(PVector v, float radians)
    {
        float ca = cos(radians);
        float sa = sin(radians);
        return new PVector(ca*v.x - sa*v.y, sa*v.x + ca*v.y);
    }

	void panick(float panickMag)
	{
		float f = sin(frameCount * 0.3f);
		
		if(abs(vel.y) > abs(vel.x))
		{
			if(vel.y > 0)
				pos.x = pos.x + (panickMag* f * habitantRadius);
			else if(vel.y < 0)
				pos.x = pos.x - (panickMag * f * habitantRadius);
		}
		else
		{
			if (vel.x < 0) 
				pos.y = pos.y + (panickMag * f * habitantRadius);
			
			else if(vel.x > 0)
				pos.y = pos.y - (panickMag * f * habitantRadius);
		}
	}

	void eaten()
	{
		inhabitants.add(new Zombie(pos.x, pos.y));
		inhabitants.remove(this);
	}

	boolean closeToZombie(float maxDist, Inhabitant one, Inhabitant two)
	{
		if(two instanceof Human != true)
		{
			if(abs(one.pos.x - two.pos.x) > maxDist || abs(one.pos.y - two.pos.y) > maxDist)
				return false;
			else if (dist(one.pos.x, one.pos.y, two.pos.x, two.pos.y) > maxDist) 
				return false;		
			else
			{
				return true;
			}
		}
		return false;
	}
}
class ControlableHuman extends Human
{
	ControlableHuman()
	{
		habitantColor = color(50,50,200);
	}
	void walk()
	{
		PVector mouse = new PVector(mouseX,mouseY);
		float dist;
		vel = PVector.sub(mouse, pos);
		dist = PVector.dist(mouse, pos);
		vel.normalize();
		vel.mult(inhabitantSpeed);
		pos.add(vel);
		//super.panick(0.08);
		type("You");
	}
	void type(String s)
	{
		textSize(20);
		textAlign(CENTER, CENTER);
		text(s, pos.x, pos.y - (habitantRadius * 2));
	}
}