
class Object
{
	private float sizeW;
	private float sizeH;
	private PVector pos;
	private color c;

	public boolean isAlive;

	Object(float x, float y, boolean alive)
	{
		//fixa sizeW ngn stanns
		sizeW = (float)width/n;
		sizeH = (float)height/n;
		pos = new PVector(x,y);
		isAlive = alive;
	}

	void draw()
	{
		strokeWeight(1);
		if(isAlive)
		{
			c = #AD4515;//#13BD6E //#346962
			fill(c);
			stroke(#732E0E); //#2A544F
		}
		else 
		{
			c = #121211;//#70003E //#AFDEAF
			fill(c);
			stroke(#000000); //#9BC49B
		}
		rect(pos.x, pos.y, sizeW, sizeH);
	}
}