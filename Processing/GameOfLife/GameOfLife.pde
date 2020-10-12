

GameManager gameManager = new GameManager();
ImageLoader imageLoader;
void setup() 
{
	size(800,800);
	gameManager.spawn();
	imageLoader = new ImageLoader();
}

void draw() 
{
	background(10);
	gameManager.draw();
}