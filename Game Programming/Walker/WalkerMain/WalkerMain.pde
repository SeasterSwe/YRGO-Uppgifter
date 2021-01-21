

//This file is only for testing your movement/behavior.
//The Walkers will compete in a different program!

ArrayList<WalkerInterface> walker = new ArrayList<WalkerInterface>();
ArrayList<PVector> walkerPos = new ArrayList<PVector>();

void setup() {
  size(400, 400);
  frameRate(300);

  for (int i = 0; i < 1; ++i) {
  	WalkerInterface w = new JakBul();
  	walker.add(w);	
  	PVector v = w.getStartPosition(width, height);
  	walkerPos.add(v);
  }

  background(10);
}

void draw() {
  if(mousePressed){
    return;
  }
	for (int i = 0; i < walker.size(); ++i) {
    stroke(255,0,0);
		point(walkerPos.get(i).x,walkerPos.get(i).y);
  		walkerPos.get(i).add(walker.get(i).update());	
      PVector pos = walkerPos.get(i);
      if(pos.x > width || pos.x < 0 || pos.y < 0 || pos.y > height)
        println("died: ");
	}
}
