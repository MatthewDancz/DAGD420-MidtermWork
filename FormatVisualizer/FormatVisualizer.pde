PVector origin = new PVector(0, 0);
float half = 2;
float sizeY = 1000;
float sizeX = 1500;
float midPointY = sizeY / half;
float midPointX = sizeX / half;
float toolBoxWidth = 200;
float propertyBoxWidth = -300;
float hierarchyBoxWidth = -300;

//Variables used for creating and drawing a Vector.
float mouseXStart, mouseYStart, mouseXEnd, mouseYEnd;

void setup()
{
  size(1500, 1000);
  background(100);
}

void draw()
{
  
  
  //World Space
  
  pushMatrix();
  translate(midPointX, midPointY);
  Matrix A = new Matrix(1, 0, 0, 0, 1, 0, 0, 0, 1);
  
  if (mousePressed)
  {
    mouseXStart = mouseX;
    mouseYStart = mouseY;
  }
  if (mouseXEnd != 0)
  {
    Vector newVector = new Vector(mouseXStart, mouseYStart, mouseXEnd, mouseYEnd);
    A.addVector(newVector);
    mouseXEnd = 0;
  }
  
  A.display();
  popMatrix();
  
  //Screen Space
  
  pushMatrix();
  fill(255);
  rect(origin.x, origin.y, toolBoxWidth, 1000);
  fill(0);
  stroke(0);
  text("Tool # 1", toolBoxWidth / half - 20, origin.y + 20);
  
  translate(1500, 0);
  fill(255);
  rect(origin.x, origin.y, hierarchyBoxWidth, midPointY);
  fill(0);
  stroke(0);
  text("Hierarchy component # 1", hierarchyBoxWidth + 10, origin.y + 20);
  
  translate(0, 1000);
  fill(255);
  rect(origin.x, origin.y, propertyBoxWidth, -midPointY);
  fill(0);
  stroke(0);
  text("Property # 1", propertyBoxWidth + 10, -midPointY + 20);
  translate(-1500, -1000);
  popMatrix();
  
  text("Canvas Area", sizeX / half - 70, sizeY / half + 5);
}

void mouseReleased()
{
  mouseXEnd = mouseX;
  mouseYEnd = mouseY;
}

class Matrix
{
  float a, b, c, d, e, f, g, h, i;
  ArrayList<Vector> Vectors = new ArrayList<Vector>();
  
  Matrix(
    float inputValueA,
    float inputValueB,
    float inputValueC,
    float inputValueD,
    float inputValueE,
    float inputValueF,
    float inputValueG,
    float inputValueH,
    float inputValueI)
  {
    a = inputValueA;
    b = inputValueB;
    c = inputValueC;
    d = inputValueD;
    e = inputValueE;
    f = inputValueF;
    g = inputValueG;
    h = inputValueH;
    i = inputValueI;
  }
  
  void addVector(Vector worldVector)
  {
    Vectors.add(worldVector);
  }
  
  void translate()
  {
    
    display();
  }
  
  void scale()
  {
    
    display();
  }
  
  void rotate()
  {
    
    display();
  }
  
  void display()
  {
    for(Vector v : Vectors)
    {
      line(v.getOriginX(), v.getOriginY(), v.getComponentX(), v.getComponentY());
    }
  }
}

class Vector
{
  private float originX, originY, componentX, componentY, magnitude, thetaAngle;
  
  Vector (float originx, float originy, float x, float y)
  {
    originX = originx;
    originY = originy;
    componentX = x;
    componentY = y;
    magnitude = sqrt(componentX*componentX + componentY * componentX);
    thetaAngle = atan2(componentY, componentX);
  }
  
  float getOriginX() { return originX; }
  float getOriginY() { return originY; }
  float getComponentX() { return componentX; }
  float getComponentY() { return componentY; }
  float getMagnitude() { return magnitude; }
  float getThetaAngle() { return thetaAngle; }
}