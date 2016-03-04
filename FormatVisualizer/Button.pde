class Button
{
  ArrayList<PVector> mPoints = new ArrayList<PVector>();
  ArrayList<PVector> tPoints = new ArrayList<PVector>();
  
  PMatrix2D matrix = new PMatrix2D();
  
  public PVector position = new PVector();
  
  float bbEdgeL = 0, bbEdgeR = 0, bbEdgeT = 0, bbEdgeB = 0;
  float scale = 1;
  
  boolean colliding = false, doneChecking = false, isSelected = false;
  
  String buttonText = null;
  
  Button(PVector pos, float w, float h) 
  { 
    position = pos;
    addPoint(w/2, h/2);
    addPoint(w/2, -h/2);
    addPoint(-w/2, -h/2);
    addPoint(-w/2, h/2);
  }
  
  void addPoint(float x, float y)
  {
    mPoints.add(new PVector(x, y));
    tPoints.add(new PVector());
  }
  
  void update(boolean isMousePressed)
  {
    doneChecking = false;
    colliding = false;
    
    matrix.reset();
    matrix.translate(position.x, position.y);
    matrix.scale(scale);
    
    bbEdgeL = Float.MAX_VALUE;
    bbEdgeT = Float.MAX_VALUE;
    bbEdgeR = Float.MIN_VALUE;
    bbEdgeB = Float.MIN_VALUE;
    
    for (int i = 0; i < mPoints.size(); i++)
    {
      matrix.mult(mPoints.get(i), tPoints.get(i));
      PVector p = tPoints.get(i);
      if (p.x > bbEdgeR) bbEdgeR = p.x;
      if (p.x < bbEdgeL) bbEdgeL = p.x;
      if (p.y > bbEdgeB) bbEdgeB = p.y;
      if (p.y < bbEdgeT) bbEdgeT = p.y;
    }
    
    colliding = checkCollisionWithPoint(new PVector(mouseX, mouseY));
    
    if (isMousePressed && colliding)
    {
      isSelected = true;
      fill(255);
      clickDrag();
    }
    
    draw();
  }
  
  void clickDrag()
  {
    if (mousePressed == true);
    {
      position.x = mouseX;
      position.y = mouseY;
    }
  }
  
  void draw()
  {
    fill(255);
    if (colliding) fill(255, 0, 0);
    noStroke();
    beginShape();
    for (PVector p : tPoints) vertex(p.x, p.y);
    endShape();
    
    stroke(0);
    rect(bbEdgeL, bbEdgeT, bbEdgeR - bbEdgeL, bbEdgeB - bbEdgeT);
    fill(0);
    if (buttonText != null)
    {
      text(buttonText, bbEdgeL + 10, bbEdgeT + 15);
    }
  }
  
  boolean checkCollisionWithPoint(PVector pt)
  {
    if (pt.x > bbEdgeR || pt.x < bbEdgeL || pt.y > bbEdgeB || pt.y < bbEdgeT) return false;
    // in bounding box, now check in polygon:

    return true;
  } 
  
  void setText(String text) { buttonText = text; }
  void setPosition(PVector v) { position = v; }
  public boolean getSelected() { return isSelected; }
  public boolean isColliding() { return colliding; }
  public float getPositionX() { return position.x; }
  public float getPositionY() { return position.y; }
}

class MinMax
{
  float min = 0, max = 0;
}