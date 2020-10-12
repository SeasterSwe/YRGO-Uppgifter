

class ImageLoader
{
	PImage img;
	PImage destination;
	int dab = 0;
	ImageLoader()
	{
		img = loadImage("GliderCannon.png");
		destination = createImage(img.width, img.height, RGB);
		draw();
	}
	void draw()
	{
		img.loadPixels();
		destination.loadPixels();
		boolean b = true;
		for (int x = 0; x < img.width; x++) {
			for (int y = 0; y < img.height; y++) {
				int loc = x + y * img.width;
				
				if (brightness(img.pixels[loc]) > 180) {
					b = true;		
					destination.pixels[loc] = color(255);					
				}
				else if(b && x % 8 == 0) {
					b = false;
					destination.pixels[loc] = color(0);
					objects[y/16][x/16].isAlive = true;
					//610 x 178
				} 
				else {
					destination.pixels[loc] = color(255);
				}
			}
		}
		destination.updatePixels();
		image(destination, 0,0);
	}
}