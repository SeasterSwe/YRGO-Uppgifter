
class Zombie extends Inhabitant{
	
	Human target = new Human();
   
	Zombie()
	{
		float redVal = random(60, 101);
		eyeColor = color(random(170, 210));
		habitantColor = color(redVal, (200 - redVal),0);
		inhabitantSpeed = 0.5f;
		super.multVel(inhabitantSpeed);
	}
	Zombie(float x, float y)
	{
		float redVal = random(60, 101);
		habitantColor = color(redVal, (200 - redVal),0);
		eyeColor = color(random(170, 210));
		inhabitantSpeed = 0.5f;
		pos.x = x;
		pos.y = y;
		super.multVel(inhabitantSpeed);
	}

	void walk()
	{
		super.walk();
		for (int i = 0; i < inhabitants.size(); ++i) {
			checkForContactWithHuman(this, inhabitants.get(i));
		}
		//borde sätta mina funktioner såhär istället å inte i varandra. Är enklare att se såhär.
		findClosestHuman();
		rotateToHuman();
	}

	void draw()
	{
		arms();
		super.draw();
	}

	void arms()
	{
		//funkar sisodär va
		stroke(habitantColor);
		strokeWeight(3);
		float x = vel.x;
		float y = vel.y;	
		float rad = atan2(y,x);

		pushMatrix();
        translate(pos.x, pos.y);
        rotate(rad);
        line (0, - habitantRadius / 2, 15, - habitantRadius / 2);
        line (0, + habitantRadius / 2, 15, + habitantRadius / 2);
        popMatrix();
	}

	void checkForContactWithHuman(Inhabitant one, Inhabitant two)
	{
		float maxDist = one.habitantRadius/2 + two.habitantRadius/2;
		if(two instanceof Zombie != true)
		{
			if(abs(one.pos.x - two.pos.x) > maxDist || abs(one.pos.y - two.pos.y) > maxDist)
				return;
			else if (dist(one.pos.x, one.pos.y, two.pos.x, two.pos.y) > maxDist) 
				return;		
			else
			{
				((Human)two).eaten();
				tombStones.add(new TombStone(pos.x, pos.y));
				dist = 1000;
				findClosestHuman();
			}
		}
	}

	float dist = 1000;
	void findClosestHuman()
	{
		for (int i = 0; i < inhabitants.size(); ++i) {
			if (inhabitants.get(i) instanceof Human == true) {
				
				float xd = inhabitants.get(i).pos.x - target.pos.x;
				float yd = inhabitants.get(i).pos.y - target.pos.y;
				
				if (sqrt(xd * xd + yd * yd) < dist) {
    				dist = sqrt(xd * xd + yd * yd);
    			 	target = (Human)inhabitants.get(i);	
				}	
			}		
		}
	}
	void rotateToHuman()
	{
		vel = PVector.sub(target.pos, pos);
		vel.normalize();
		vel.mult(inhabitantSpeed);
	}
}
