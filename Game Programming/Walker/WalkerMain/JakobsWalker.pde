

class JakBul implements WalkerInterface {

  float areaWidth;
  float areaHeight;
  PVector currentPos;
  PVector target;
  int xLeangth;
  int yLeangth;
  float direction;
  float yDirecton;
  color wColor;
  float safeMargin = 20;
  float randomYLeangth;
  float randomXLeangth;
  String getName()
  {
    return "Ginger Jakob"; //When asked, tell them our walkers name
  }

  PVector getStartPosition(int playAreaWidth, int playAreaHeight)
  {
    //Select a starting position or use a random one.

    float safeMarginFix = 20f/1000f;
    safeMargin = playAreaWidth * safeMarginFix;
    
    areaWidth = playAreaWidth - safeMargin;
    areaHeight = playAreaHeight - safeMargin;

    float xFix = 1900f/playAreaWidth;
    float yFix = 1200f/playAreaHeight;

    this.randomYLeangth = 120f/yFix;
    this.randomXLeangth = 120f/xFix;

    PVector startPos = EdgeStart(playAreaWidth, playAreaHeight, safeMargin);
    float x = startPos.x;
    float y = startPos.y;
    
    direction = 1;
    yDirecton = 1;
    if(y > playAreaHeight/2)
      yDirecton = -1;
    if(x > playAreaWidth/2)
      direction = -1;

    currentPos = new PVector((int)x,(int)y);
    target = NewTarget();
    target.add(currentPos);

    //a PVector holds floats but make sure its whole numbers that are returned!
    return new PVector((int)x, (int)y);
  }

  PVector update()
  {

    if(currentPos.dist(target) < 2)
    {
      target = NewTarget();
      target.add(currentPos);
    }

    if(currentPos.x <= target.x){
      
        currentPos.add(new PVector(1,0));
        if(target.x == currentPos.x){
            target.x = target.x - xLeangth;
            return YWalk();
        }

      return new PVector(1,0);
    }

      if(currentPos.x >= target.x){
        currentPos.add(new PVector(-1,0));
        if(target.x == currentPos.x){
          target.x = target.x + xLeangth;
          return YWalk();
        }
        return new PVector(-1,0);
    }

    else {
      return RandomDirection();
    }
  }

  PVector NewTarget()
  {
    //lekrunt
    xLeangth = (int)random(1, randomXLeangth);
    yLeangth = (int)random(1, randomYLeangth);
    float dx = (xLeangth * direction) + currentPos.x;
    if(dx > areaWidth - safeMargin || dx < 0 + safeMargin)
    {
      direction *= -1;
    }
    return new PVector(xLeangth * (int)direction, yLeangth * (int)yDirecton);
  }

  boolean goDown = true;
  PVector YWalk()
  {
    if(currentPos.y < areaHeight - safeMargin && yDirecton > 0){
      currentPos.add(new PVector(0,1));
      
      if(currentPos.y == areaHeight - safeMargin)
      {
        yDirecton *= -1;
        target.y = target.y += yLeangth * yDirecton;        
        target.x += xLeangth * direction;
      }

      return new PVector(0,1);
    }
    else if(currentPos.y > 0){
      currentPos.add(new PVector(0,-1));
      
      if(currentPos.y == 0 + safeMargin && yDirecton < 0)
      {
         yDirecton *= -1;
        target.y += yLeangth * yDirecton;        
        target.x += xLeangth * direction;
      }

      return new PVector(0,-1);
    }
    else {
      return RandomDirection();
    }
  }

  PVector EdgeStart(float playAreaWidth, float playAreaHeight, float frame)
  {
    switch((int)random(0, 4)) {
    case 0:
      return new PVector(frame, random(frame, playAreaHeight - frame));
    case 1:
      return new PVector(playAreaWidth -frame, random(frame, playAreaHeight - frame));
    case 2:
      return new PVector(random(frame, playAreaWidth), frame);
    default:
      return new PVector(random(frame, playAreaWidth), playAreaHeight - frame);
    }
  }
  PVector RandomDirection()
  {
    switch((int)random(0, 4)) {
    case 0:
      currentPos.add(new PVector(-1,0));
      return new PVector(-1, 0);
    case 1:
      currentPos.add(new PVector(1,0));
      return new PVector(1, 0);
    case 2:
      currentPos.add(new PVector(0,1));
      return new PVector(0, 1);
    default:
      currentPos.add(new PVector(0,-1));
      return new PVector(0, -1);
    }
  }
}
