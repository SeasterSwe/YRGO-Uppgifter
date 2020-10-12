
int amountOfStartHumans = 99;
ArrayList<Inhabitant> inhabitants = new ArrayList<Inhabitant>();
ArrayList<TombStone> tombStones = new ArrayList<TombStone>();

boolean calcTimeOnce = true;
float startTime;
float textTime;
long currentTime;
float time;
float deltaTime;

void setup() {
	size(512, 512);
	frameRate(60);

	currentTime = millis();
    deltaTime = (currentTime - time) * 0.001f;
	spawn();

	time = currentTime;
}

void draw() {
	clearBackground();
	drawTombstones();
	moveHabitants();

	if(!humansAlive())
	{
		gameOverText();
		if(keyPressed == true)
		{
			inhabitants.clear();
			tombStones.clear();
			spawn();
			calcTimeOnce = true;
		}
	}
}

//giveTrail
void clearBackground()
{
	rectMode(CORNER);
	fill(0, 0, 0, 40);
	rect(-10, -10, width+10, height+10);
}

void gameOverText()
{
	if (calcTimeOnce) {
		textTime = millis() - startTime;
		calcTimeOnce = false;
	}
	fill(17, 158, 50);
	textSize(40);
	textAlign(CENTER, CENTER);
	text("GAME OVER", width/2, height/2);
	text("Took " +String.format("%.1f", textTime/1000) + " seconds", width/2, height/2  + 40);
}

void spawn()
{
	startTime = millis();
	for (int i = 0; i < amountOfStartHumans; ++i) {
		inhabitants.add(new Human());
	}
	inhabitants.add(new Zombie(random(0,width), random(0, height)));
	inhabitants.add(new ControlableHuman());
}

void moveHabitants()
{
	for (int i = 0; i < inhabitants.size(); ++i)
		inhabitants.get(i).draw();
}

void drawTombstones()
{
	for (int i = 0; i < tombStones.size(); ++i) {
		tombStones.get(i).drawTombStone();
	}
}

boolean humansAlive() {
	for (int i = 0; i < inhabitants.size(); ++i) {
		if (inhabitants.get(i) instanceof Human) {
			return true;
		}
	}
	return false;
}
