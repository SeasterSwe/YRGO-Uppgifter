
//klasser
Player playerClass = new Player();
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<PlayerBullet> bullets = new ArrayList<PlayerBullet>();

int amountOfAsteroidsOut = 6;
 static int FPS = 60;
 
 //kan göras MYCKET bättre
void setup()
{
	size(512, 512);
	frameRate(FPS);
	playerClass.position.x = width/2;
	playerClass.position.y = height/2;
	
	for (int i = 0; i < amountOfAsteroidsOut; ++i)//spawnastroider
	{
		asteroids.add(new Asteroid());
		asteroids.get(i).setup();
	}
}
void draw()
{
	background(44,11,41);
	for (int i = 0; i <= asteroids.size() - 1; ++i)
	{
		asteroids.get(i).moveAsteroids();
	}
	
	for (int i = 0; i < bullets.size(); ++i) 
	{
		bullets.get(i).moveBullet();
	}
	if (keyPressed) 
	{
		playerClass.input();
	}
	shoot();
	playerClass.drawPlayer();
	frame++;
}

float frame = 0;
float secBeforeShoot = 0.2;
void shoot()
{
	if(mousePressed && frame > FPS * secBeforeShoot)
	{
		bullets.add(new PlayerBullet());
		int n = bullets.size();
		PVector javaCancer = new PVector();
		javaCancer.x = playerClass.position.x;
		javaCancer.y = playerClass.position.y;
		bullets.get(n - 1).position = javaCancer;
		bullets.get(n - 1).calcShootDir();
		frame = 0;
	}
}
/*
void victory()
{
	println("victory: "); //eller score
}
*/
private class PlayerBullet
{
	PVector position = new PVector();
	PVector direction = new PVector();
	float speed = 400;
	float radius = 20;

	void calcShootDir()
	{
		PVector temp = new PVector();
		PVector mouse = new PVector();
		
		mouse.x = mouseX;
		mouse.y = mouseY;

		temp = PVector.sub(mouse, position);
		temp.normalize();
		temp.mult(speed/100);
		direction = temp;
	}
	void moveBullet()
	{
		stroke(128, 124, 53);
		position.add(direction);
		ellipse(position.x, position.y, radius, radius);
	}

	void outOfBounds()
	{
		for (int i = 0; i < bullets.size(); ++i) 
		{
			PVector position = bullets.get(i).position;
			if ((position.x > width) || (position.x < 0)) 
			{
				removeBullet();
  			}
			if ((position.y > height) || (position.y < 0)) 
			{
    			removeBullet();
 			}
		}
	}
	void removeBullet()
	{
		bullets.remove(this);
	}
}

private class Player
{
	float speed = 4;
	PVector position = new PVector();
	PVector bullet = new PVector();
	PVector mousePos = new PVector();
	void input()
	{

	if (keyCode == UP) {
		position.y -= speed;
	}
	if (keyCode == DOWN) {
		position.y += speed;
	}
	if (keyCode == RIGHT) {
		position.x += speed;
	}
	if (keyCode == LEFT) {
		position.x -= speed;
	}	
	}

	void drawPlayer()
	{
		strokeWeight(2);
		stroke(226, 7, 203);
		noFill();
		ellipse(position.x, position.y, 40, 40);
		stroke(142,134,45);
		strokeWeight(3);
		PVector mouse = new PVector(mouseX, mouseY);
		line(position.x, position.y, mouse.x, mouse.y);
		strokeWeight(2);
	}
}

private class Asteroid 
{	
	PVector astroidPosition = new PVector(); 
	PVector astroidDirection = new PVector(); 

	float dist;
	float speed = 200;

	float astRadiusX;
	float astRadiusY;

	void setup()
	{
		astRadiusX = random(20, 30);
		astRadiusY = random(20, 30);
		calcAstroidMovement(true);	
	}

    float count = 0;
	void moveAsteroids()
	{
		stroke(100, 200, 0);
		noFill();		
		bounceAst();
 		astroidPosition.add(astroidDirection);
		ellipse(astroidPosition.x, astroidPosition.y, astRadiusX, astRadiusY);
		collisonCheck();
	}	
	
	void collisonCheck()
	{
		for (int i = 0; i < bullets.size(); ++i) 
		{
			if(PVector.dist(bullets.get(i).position, astroidPosition) < 35)
			{
				bullets.get(i).removeBullet();
				splitAstroid();
			}
		}
		if (PVector.dist(playerClass.position, astroidPosition) < 40) {
			println("gameover: ");
			//removelife?
			//destroyast?
		}
	}
	void bounceAst()
	{
		if ((astroidPosition.x > width + 100) || (astroidPosition.x < -100)) 
		{
			astroidDirection.x = astroidDirection.x * -1;
  		}
		if ((astroidPosition.y > height + 100) || (astroidPosition.y < -100)) 
		{
    		astroidDirection.y = astroidDirection.y * -1;
 		}
	}

	void calcAstroidMovement(boolean skipRandPos)
	{		
		if(skipRandPos == true)
		{
			float randN = random(0, 2);
			if (randN < 1) 
			{
				astroidPosition.add(new PVector(-100, random(0, height+100)));
			}
			else if (randN > 0)
			{
				astroidPosition.add(new PVector(width+100, random(0,height+100)));
			}	
		}	

			PVector temp = new PVector();
			temp = PVector.sub(getStartDest(), astroidPosition);
			temp.normalize();
			temp.mult(speed/100);
			astroidDirection.add(new PVector(temp.x,temp.y));	
	}

	boolean destroyAstroid()
	{
		if(astRadiusX <5 || astRadiusY <5)
		{
			asteroids.remove(this);
			return true;
		}
		return false;
	}

	void splitAstroid()
	{
		astRadiusX = astRadiusX/2;
		astRadiusY = astRadiusY/2;

		asteroids.add(new Asteroid());
		if(!destroyAstroid())
		{
			PVector javaCancer = new PVector();
			javaCancer.x = astroidPosition.x;
			javaCancer.y = astroidPosition.y;
			asteroids.get(asteroids.size() - 1).astroidPosition = javaCancer;
			asteroids.get(asteroids.size() - 1).calcAstroidMovement(false);

			asteroids.get(asteroids.size() - 1).astRadiusX = astRadiusX;
			asteroids.get(asteroids.size() - 1).astRadiusY = astRadiusY;
		}
	}

	private PVector getStartDest()
	{
		PVector vector = new PVector();
		float x = random(0, width);
		float y = random(0, height);
		vector.x = x;
		vector.y = y;
		return vector;
	}
}
