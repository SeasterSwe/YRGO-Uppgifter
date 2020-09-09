
private PVector mousePos;
void setup()
{
  size(1000, 1000);
}

void draw()
{
    background(37, 0, 51);
    strokeWeight(2);
    
    mousePos = new PVector(mouseX,mouseY);
    PVector middlePos = new PVector(width/2,height/2);

	animation(middlePos);

    ParabolicCurve curve1 = new ParabolicCurve();
    PVector curve1Axis2 = new PVector(100,100);
    curve1.parabolicCurve(middlePos, curve1Axis2, 20);
    
    ParabolicCurve curve2 = new ParabolicCurve();
    PVector curve2Axis2 = new PVector(100,900);
    curve2.parabolicCurve(middlePos, curve2Axis2, 20);

     ParabolicCurve curve3 = new ParabolicCurve();
    PVector curve3Axis2 = new PVector(900,100);
    curve3.parabolicCurve(middlePos, curve3Axis2, 20);
    
    ParabolicCurve curve4 = new ParabolicCurve();
    PVector curve4Axis2 = new PVector(900,900);
    curve4.parabolicCurve(middlePos, curve4Axis2, 20);

   
}

void animation(PVector pos)
{
	float dist;
	PVector dir = new PVector();
	dir = PVector.sub(mousePos, pos);
	dist = PVector.dist(mousePos, pos);
	dir.normalize();
	dir.mult(dist/2);
	pos.add(dir);

	if ((pos.x > (width/2 - 20)) || (pos.x < (width/2 + 20))) 
	{
    	dir.x = dir.x * -1;
  	}
	if ((pos.y > (height/2 - 20)) || (pos.y < (height/2 + 20))) 
	{
   		dir.y = dir.y * -1;
 	}
}

private class ParabolicCurve
{
	private PVector axis1, axis2;
	private float numberOfLines;
	float sblX, sblY;
	void parabolicCurve(PVector axis1, PVector axis2, int numberOfLines)
	{
		this.axis1 = axis1;
		this.axis2 = axis2;
		this.numberOfLines = numberOfLines;
		sblX = (axis1.x - axis2.x)/numberOfLines;
		sblY = (axis1.y - axis2.y)/numberOfLines;

		drawCurve();
	}

	void drawCurve()
	{
		for (int i = 0; i < numberOfLines + 1; ++i) 
		{
			if(i%3 == 0 && i != 0)
			{
        		stroke(0, 0, 0, 256);
      		}
       		 else
        	{
        		stroke(240, 240, 240, 65);
       		}   
		line(axis1.x, axis1.y + (i * sblY), axis2.x + (i * sblX), axis2.y + (sblY * numberOfLines));
	}
	}
}
