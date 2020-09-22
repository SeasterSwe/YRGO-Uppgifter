boolean moveLeft;
boolean moveRight;
boolean moveUp;
boolean moveDown;

float time;
float deltaTime;
float amountOfStartBalls = 10;
PVector input = new PVector();

ArrayList<Ball> balls = new ArrayList<Ball>();
Player player;

static float FPS = 60;
boolean playerIsAlive = true;

void setup()
{
	frameRate(FPS);
	size(512, 512);
	player = new Player(width/2, height/2);
	for (int i = 0; i < amountOfStartBalls; ++i) {
		balls.add(new Ball());	
	}
}

float snarkDELUXE = 0;
float snark = 3;
void draw()
{
	background(40);
	long currentTime = millis();
    deltaTime = (currentTime - time) * 0.001f;
   
    snarkDELUXE += deltaTime;
   
    for (int i = 0; i < balls.size(); ++i) {
    	balls.get(i).draw();
    }
    if(playerIsAlive)
    	player.draw();
    else
    	player.gameOverText();

    if (snarkDELUXE > snark && balls.size() < 101) {
    	snark += 3;
    	balls.add(new Ball());
    }

    time = currentTime;
}

class Player
{
	PVector pos;
	PVector acc = new PVector();
	PVector vel = new PVector();
	PVector input = new PVector();
	PVector move = new PVector();
	float maxSpeed = 60;
	float accSpeed = 20;
	float rad = 20;

	Player(float x, float y)
	{
		pos = new PVector(x,y);
	}
	void draw()
	{
		long currentTime = millis();
	   	deltaTime = (currentTime - time) * 0.001f;

	    accellerate();
	  	stopAccellerate();
	  	screenJump();
	  	
	  	move = new PVector(vel.x,vel.y);
	  	move.mult(accSpeed * deltaTime);

	  	pos.add(move);
	  	stroke(color(255, 0, 40));
	  	ellipse(pos.x, pos.y, rad, rad);
 		time = currentTime;
	}

	void accellerate()
	{
		acc = input();
		acc.mult(accSpeed * deltaTime);
		vel.add(acc);
		vel.limit(maxSpeed);
	}
	void stopAccellerate()
	{
		if (acc.mag() == 0)
		{
			acc.x -= vel.x * 0.03;
			acc.y -= vel.y * 0.03;
			vel.add(acc);
		}	
	}

	void screenJump()
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
	void gameOverText()
	{
		textSize(32);
		textAlign(CENTER, CENTER);
		text("GAME OVER", width/2, height/2);
	}

}
class Ball
{
	PVector pos;
	PVector vel;

	float rad;
	float speed;
	color collor;
	Ball()
	{
		ellipseMode(CENTER);
		speed = 3;
		rad = 10;
		collor = color(random(80, 255));

		pos = new PVector();
		pos = startPos();

		newDir();
	}
	PVector startPos()
	{
		float randN = random(0, 2);
		PVector temp = new PVector();
		if (randN < 1) 
		{
			temp = new PVector(-rad, random(-rad, height+rad));
		}
		else if (randN > 0)
		{
			temp = new PVector(width + rad, random(-rad, height+rad));
		}	
		return temp;
	}
	void update()
	{
		pos.x += vel.x;
		pos.y += vel.y;
	}
	void draw()
	{
		update();
		screenBounce();
		noFill();
		stroke(collor);
		checkForPlayerColl(player.pos.x, player.pos.y, player.rad);
		ellipse(pos.x, pos.y, rad, rad);
	}
	void screenBounce()
	{
		if(pos.x < -rad || pos.x > width + rad)
			vel.x = -vel.x;

		if(pos.y < -rad || pos.y > height + rad)
			vel.y = -vel.y;
	}
	void checkForPlayerColl(float px, float py, float pr)
	{
		int maxDist = int(rad + player.rad);
		if (abs(px - pos.x) > maxDist || abs(py - pos.y) > maxDist) 
		{
			return;
		}
		else if (PVector.dist(player.pos, pos) > maxDist) {
			return;
		}
		else {
			playerIsAlive = false;
			balls.remove(this); //ezgameOverText
			//newDir();
			return;
		}
	}
	void newDir()
	{
		vel = new PVector();
		vel.x = random(11) - 5;
		vel.y = random(11) - 5;
		vel.normalize();
		vel.mult(speed);
	}
}