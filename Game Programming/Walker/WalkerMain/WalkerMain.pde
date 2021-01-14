

//This file is only for testing your movement/behavior.
//The Walkers will compete in a different program!

ArrayList<WalkerInterface> walker = new ArrayList<WalkerInterface>();
ArrayList<PVector> walkerPos = new ArrayList<PVector>();

void setup() {
  size(640, 480);
  frameRate(240);

  for (int i = 0; i < 2; ++i) {
  	WalkerInterface w = new JakobsWalker();
  	walker.add(w);	
  	color c = color(random(50, 255), random(0, 100), random(20, 160));
  	PVector v = w.getStartPosition(width, height, c);
  	walkerPos.add(v);
  }

  background(10);
}

void draw() {
	for (int i = 0; i < walker.size(); ++i) {
		point(walkerPos.get(i).x,walkerPos.get(i).y);
  		walkerPos.get(i).add(walker.get(i).update());	
	}
}
