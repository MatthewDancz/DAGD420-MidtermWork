
Matrix A = new Matrix(1, 0, 0, 0, 1, 0, 0, 0, 1);

PVector origin = new PVector(0, 0);

float half = 2;
float sizeY = 1000;
float sizeX = 1500;
float midPointY = sizeY / half;
float midPointX = sizeX / half;
float toolBoxWidth = 200;
float propertyBoxWidth = -300;
float hierarchyBoxWidth = -300;

boolean isTextChanged = false;

//Variables used for creating and drawing a Vector.
float mouseXStart, mouseYStart, mouseXEnd, mouseYEnd;

boolean isMouseClicked = false, isMouseClickedPreviously = false;

int count;

Vector previousVector;

void setup()
{
  size(1500, 1000);
  background(100);
  line(width/half - 50, -402, width/half - 50, 1402);
  line(-402, midPointY, 1402, midPointY);
  updateWindow();
}

void draw()
{
  
  
  //World Space
  if (isMouseClicked && !isMouseClickedPreviously)
  {
    count++;
    if (count >= 2)
    {
      A.addVector(new Vector(mouseXStart, mouseYStart, mouseXEnd, mouseYEnd));
      previousVector = A.Vectors.get(A.Vectors.size() - 1);
      count = 0;
      isTextChanged = true;
    }
  }
 
  isMouseClickedPreviously = isMouseClicked;
  
  A.display();  
  
  pushMatrix();
  translate(midPointX, midPointY);
 
  popMatrix();
  
  //Screen Space
  if(isTextChanged)
  {
    updateWindow();
  }

}

void updateWindow()
{
  pushMatrix();
  fill(255);
  strokeWeight(2);
  rect(origin.x, origin.y, toolBoxWidth, 1000);
  fill(0);
  stroke(0);
  text("Tool # 1", toolBoxWidth / half - 20, origin.y + 20);
  
  translate(1500, 0);
  fill(255);
  rect(origin.x, origin.y, hierarchyBoxWidth, midPointY);
  fill(0);
  stroke(0);
  int i = 1;
  for(Vector v : A.Vectors)
  {
    text("Hierarchy component " + i, hierarchyBoxWidth + 10, origin.y + 20 * i);
    i++;
  }
  println(A.Vectors);
  
  translate(0, 1000);
  fill(255);
  rect(origin.x, origin.y, propertyBoxWidth, -midPointY);
  fill(0);
  stroke(0);
  text("Property # 1", propertyBoxWidth + 10, -midPointY + 20);
  popMatrix();
}

void mousePressed()
{
  if (mouseButton == LEFT)
  {
    isMouseClicked = true;
    mouseXStart = mouseX;
    mouseYStart = mouseY;
  }
}

void mouseReleased()
{
  if (mouseButton == LEFT)
  {
    isMouseClicked = false;
    mouseXEnd = mouseX;
    mouseYEnd = mouseY;
  }
}

class Matrix
{
  float a, b, c, d, e, f, g, h, i;
  public ArrayList<Vector> Vectors = new ArrayList<Vector>();
  
  Matrix(
    float inputValueA, float inputValueB, float inputValueC,
    float inputValueD, float inputValueE, float inputValueF,
    float inputValueG, float inputValueH, float inputValueI)
  {
    a = inputValueA; b = inputValueB; c = inputValueC;
    d = inputValueD; e = inputValueE; f = inputValueF;
    g = inputValueG; h = inputValueH; i = inputValueI;
  }
  
  void addVector(Vector worldVector) { Vectors.add(worldVector); }
  
  void translate(float x, float y, Vector v)
  {
    c = x;
    f = y;
    
    display();
  }
  
  void scale(float x, float y, Vector v)
  {
    a = x;
    e = y;
    
    display();
  }
  
  void rotate(float angle, Vector v)
  {
    a = cos(angle);
    b = sin(angle);
    d = -b;
    e = a;
    
    display();
  }
  
  void becomeIdentityMatrix()
  {
    a = 1; b = 0; c = 0;
    d = 0; e = 1; f = 0;
    g = 0; h = 0; i = 1;
  }
  
  void display()
  {
    for(Vector v : Vectors)
    {
      if (!v.getDrawnState())
      {
        strokeWeight(3);
        line(v.getOriginX(), v.getOriginY(), v.getComponentX(), v.getComponentY());
        v.setIsDrawn();
      }
    }
  }
}

class Vector
{
  private float originX, originY, componentX, componentY, magnitude, thetaAngle;
  private boolean isDrawn = false;
  
  Vector (float originx, float originy, float x, float y)
  {
    originX = originx;
    originY = originy;
    componentX = x;
    componentY = y;
    magnitude = sqrt(componentX*componentX + componentY * componentX);
    thetaAngle = atan2(componentY, componentX);
  }
  
  boolean getDrawnState() { return isDrawn; }
  float getOriginX() { return originX; }
  float getOriginY() { return originY; }
  float getComponentX() { return componentX; }
  float getComponentY() { return componentY; }
  float getMagnitude() { return magnitude; }
  float getThetaAngle() { return thetaAngle; }
  void setIsDrawn() { isDrawn = !isDrawn; }
}