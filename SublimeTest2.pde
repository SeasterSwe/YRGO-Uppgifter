//float[][] letters = {{100,200,100,10,100,200,75,190,55,170,75,190}};
void setup()
{
	size(640, 480);	
}

void draw()
{
	//varje {} är en bokstav. 4 siffror behövs för en linje. 
	float[][] letters = {{100,200,100,10,100,200,75,190,55,170,75,190},
	{150,200,200,10,250,200,200,10,178,100,222,100}, 
	{300,200,300,10,355,10,300,100,350,200,300,100}, 
	{350+150,196,349+150,10,399+150,48,350+150,8,399+150,
		47,349+150,98,396+150,133,351+150,199,394+150,134,350+150,101}};

	background(64, 41, 50);
	strokeWeight(2.7);

	for (int o = 0; o < 3; o++) 
	{
		float x = random(0, 15); //Får den att hoppa lite i x (borde heta ngt annat)
		float y = random(0, 15); //^^ men y			
		for (int i = 0; i < letters.length; i++) 
		{ 
  			stroke(random(255), random(255), random(255)); //färg för bokstav
  			for (int j = 0; j < letters[i].length; j+=4)
  			{
  			//sätter linjer för en bokstav
  			line(letters[i][j] + x, letters[i][j+1] + y, letters[i][j+2] + x,letters[i][j+3] + y);
  			} 	
    	}
   	    noFill();
  		ellipse(418 + x, 106 + y, 112 + x, 198 +y);  //Ett O
	}
}
