

Object [][] objects;
boolean[][] newObjState;
int n = 50;
long startTime;
float spawnTime = 2000;
class GameManager
{
	void spawn()
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

	void draw()
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

	void check(int y, int x)
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
	void spawnBunchOfGliders()
	{
		if(millis() > time2) {
			time2 = millis() + 700;
			for (int i = 0; i < 6; ++i) {
				spawnGilder(i * 10,0);
			}
		}
	}

	void spawnGilder(int xpos, int ypos)
	{
		objects[ypos + 1][xpos].isAlive = true;
		objects[ypos + 2][xpos + 1].isAlive = true;
		
		for (int i = 0; i < 3; ++i) {
			objects[ypos + i][xpos +2].isAlive = true;
		}
	}
	void gliderCannon()
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