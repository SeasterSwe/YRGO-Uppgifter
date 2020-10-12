class TombStone
{
	PVector pos;
	color c;
	TombStone(float x, float y)
	{
		pos = new PVector(x,y);
		c = color(random(40,60)); //´kanske tarbort
	}
	void drawTombStone()
	{	
		pushMatrix();
		fill(color(c));
		stroke(c);
		translate(pos.x, pos.y);
		rectMode(CENTER);
		rect(0, 0, 4, -10); //grund
		rect(2, -6, 10, 2); // sida ->
		rect(-2, -6, 10, 2); // sida <-
		rect(0, -10, 6, 4, 18,18,18,18); //top
		stroke(0);
		strokeWeight(1.4);
		line(0,0,0,-9);
		line(2,-6, -2,-6);
		popMatrix();
	}
}
