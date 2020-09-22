PVector input()
{
	input.x = 0;
	input.y = 0;
	if (moveLeft) {
    	input.x -= 1;
  	}
  	if (moveRight) {
   		input.x += 1;
  	}
  	if (moveUp) {
  		input.y -= 1;
  	}
  	if (moveDown) {
  		input.y +=1;
  	}
  	return input.normalize();
}
void keyPressed()
{
	if(keyCode == LEFT || key == 'a')
		moveLeft = true;
	if (keyCode == RIGHT || key == 'd')
		moveRight = true;
	if (keyCode == UP || key == 'w')
		moveUp = true;
	if (keyCode == DOWN || key == 's')
		moveDown = true;
}
void keyReleased()
{
	if(keyCode == LEFT || key == 'a')
		moveLeft = false;
	if(keyCode == RIGHT || key == 'd')
		moveRight = false;
	if (keyCode == UP || key == 'w')
		moveUp = false;
	if (keyCode == DOWN || key == 's')
		moveDown = false;
}