
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
float holder = 0;
float[] lastLine = new float[4];

boolean isTextChanged = false;

//Variables used for creating and drawing a Vector.
float xStart = 0, yStart = 0, mouseXEnd, mouseYEnd;

boolean isMouseClicked = false, isMouseClickedPreviously = false, onButton = false, isVectorAdded = true;
boolean isAddVector = false, isAddVectorPreviously = false, isSubtractVector = false, isDrawVector = true;

ArrayList<Button> Buttons = new ArrayList<Button>();
ArrayList<Button> toolBoxButtons = new ArrayList<Button>();
Button addVector, subtractVector, drawVector;

Vector previousVector, firstVector, secondVector;

int count = 0;

void setup()
{
  size(1500, 1000);
  background(100);
  line(midPointX, -402, midPointX, 1402);
  line(-402, midPointY, 1402, midPointY);
  
  drawVector = new Button(new PVector(0, 0), toolBoxWidth, 20);
  drawVector.setText("Draw Vectors");
  toolBoxButtons.add(drawVector);
  
  addVector = new Button(new PVector(0, 0), toolBoxWidth, 20);
  addVector.setText("Add Vectors");
  toolBoxButtons.add(addVector);
  
  subtractVector = new Button(new PVector(0, 0), toolBoxWidth, 20);
  subtractVector.setText("Subtract Vectors");
  toolBoxButtons.add(subtractVector);
  
  updateWindow();
}

void draw()
{
  //World Space

  
  pushMatrix();
  translate(midPointX, midPointY);
  if (isMouseClicked && !isMouseClickedPreviously)
  {
    holder = A.size() + 1;
    A.addVector(new Vector("V" + holder, xStart, yStart, mouseXEnd, mouseYEnd));
    isTextChanged = true;
  }
  if (isAddVector == true && isVectorAdded == false && firstVector != null && secondVector != null)
  {
    holder = A.size() + 1;
    lastLine[0] = 0;
    lastLine[1] = 0;
    lastLine[2] = firstVector.getComponentX() + secondVector.getComponentX();
    lastLine[3] = firstVector.getComponentY() + secondVector.getComponentY();
    A.addVector(new Vector("V" + holder, xStart, yStart, firstVector.getComponentX() + secondVector.getComponentX(), firstVector.getComponentY() + secondVector.getComponentY()));
    isVectorAdded = true;
  }
  if (isSubtractVector == true && isVectorAdded == false && firstVector != null && secondVector != null)
  {
    holder = A.size() + 1;
    lastLine[0] = firstVector.getComponentX();
    lastLine[1] = firstVector.getComponentY();
    lastLine[2] = secondVector.getComponentX();
    lastLine[3] = secondVector.getComponentY();
    A.addVector(new Vector("V" + holder, xStart, yStart, firstVector.getComponentX() - secondVector.getComponentX(), firstVector.getComponentY() - secondVector.getComponentY()));
    isVectorAdded = true;
  }
  
  strokeWeight(0);
  stroke(0, 255, 0);
  line(lastLine[0], lastLine[1], lastLine[2], lastLine[3]);
  strokeWeight(3);
  stroke(0);
  
  A.display();
  isMouseClickedPreviously = isMouseClicked;
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
  //rect(origin.x, origin.y, toolBoxWidth, 1000);
  fill(0);
  stroke(0);
  int j = 0;
  for (Button b : toolBoxButtons)
  {
    b.setPosition(new PVector(toolBoxWidth/2 + (j * toolBoxWidth), origin.y + 10));
    b.update(isMouseClicked, 0);
    j++;
  }
  
  translate(1500, 0);
  fill(255);
  /*Button heirarchyButton = new Button(new PVector(hierarchyBoxWidth/2, origin.y + 5), hierarchyBoxWidth, 20);
  heirarchyButton.setText("View Heirarchy");
  heirarchyButton.update(isMouseClicked);*/
  fill(0);
  stroke(0);
  int i = 1;
  for(Vector v : A.Vectors)
  {
    Button b = new Button(new PVector(hierarchyBoxWidth/2, origin.y + 20 * i - 10), hierarchyBoxWidth, 20);
    b.setText("Vector " + i);
    b.update(isMouseClicked, v, 1500);
    Buttons.add(b);
    i++;
  }
  
  translate(0, 1000);
  fill(255);
  rect(origin.x, origin.y, propertyBoxWidth, -150);
  fill(0);
  stroke(0);
  if (previousVector != null)
  {
    text("Vector " + previousVector.getVectorName(), propertyBoxWidth + 10, -130);
    text("X Component: " + previousVector.getComponentX(), propertyBoxWidth + 10, -110);
    text("Y Component: " + previousVector.getComponentY(), propertyBoxWidth + 150, -110);
    text("Magnitude: " + previousVector.getMagnitude(), propertyBoxWidth + 10, -90);
    text("Theta: " + previousVector.getThetaAngle(), propertyBoxWidth + 150, -90);
  }
  drawMatrixNumbers(A);
  popMatrix();
}

void mousePressed()
{
  if (mouseButton == LEFT)
  {
    if (drawVector.isColliding() == true)
    {
      isDrawVector = true;
      isAddVector = false;
      isSubtractVector = false;
    }
    
    if (addVector.isColliding() == true)
    {
      isDrawVector = false;
      isAddVector = true;
      isSubtractVector = false;
    }
    
    if (subtractVector.isColliding() == true)
    {
      isDrawVector = false;
      isAddVector = false;
      isSubtractVector = true;
    }
  }
  
  for (Button b : Buttons)
  {
    if (mouseButton == LEFT && b.isColliding())
    {
      previousVector = b.whenClicked();
      onButton = true;
      if (isAddVector == true || isSubtractVector == true)
      {
        firstVector = b.whenClicked();
      }
    }
    if (mouseButton == RIGHT && b.isColliding())
    {
      if (isAddVector == true || isSubtractVector == true)
      {
        secondVector = b.whenClicked();
        isVectorAdded = false;
      }
    }
  }
  
  for (Button b : toolBoxButtons)
  {
    if (mouseButton == LEFT && b.isColliding())
    {
      onButton = true;
    }
  }
  
  if (mouseButton == LEFT && onButton == false && isDrawVector == true)
  {
    isMouseClicked = true;
    mouseXEnd = mouseX - midPointX;
    mouseYEnd = mouseY - midPointY;
  }
}

void mouseReleased()
{
  for (Button b : Buttons)
  {
    b.colliding = false;
  }
  
  for (Button b : toolBoxButtons)
  {
    b.colliding = false;
  }
  
  if (mouseButton == LEFT)
  {
    isMouseClicked = false;
    onButton = false;
  }
}

void drawMatrixNumbers(Matrix matrix)
{
  text("World Matrix", propertyBoxWidth + 10, -110 + 40); 
  for (int i = 0; i < 3; i++)
  {
    for (int j = 0; j < 3; j++)
    {
      text(matrix.propertyArray[i][j], propertyBoxWidth + 10 + j * 50, -50 + 20 * i);
    }
  }
}

class Matrix
{
  float[] floatArray0 = new float[3];
  float[] floatArray1 = new float[3];
  float[] floatArray2 = new float[3];
  public float[][] propertyArray = new float[3][3];
  public ArrayList<Vector> Vectors = new ArrayList<Vector>();
  
  Matrix(
    float inputValueA, float inputValueB, float inputValueC,
    float inputValueD, float inputValueE, float inputValueF,
    float inputValueG, float inputValueH, float inputValueI)
  {
    floatArray0[0] = inputValueA;
    floatArray0[1] = inputValueB;
    floatArray0[2] = inputValueC;
    propertyArray[0] = floatArray0;
    floatArray1[0] = inputValueD;
    floatArray1[1] = inputValueE;
    floatArray1[2] = inputValueF;
    propertyArray[1] = floatArray1;
    floatArray2[0] = inputValueG;
    floatArray2[1] = inputValueH;
    floatArray2[2] = inputValueI;
    propertyArray[2] = floatArray2;
  }
  
  void addVector(Vector worldVector) { Vectors.add(worldVector); }
  
  void myTranslate(float x, float y, Vector v)
  {
    propertyArray[0][2] = x;
    propertyArray[1][2] = y;
    
    display();
  }
  
  void myScale(float x, float y, Vector v)
  {
    propertyArray[0][0] = x;
    propertyArray[1][1] = y;
    
    display();
  }
  
  void myRotate(float angle, Vector v)
  {
    propertyArray[0][0] = cos(angle);
    propertyArray[0][1] = sin(angle);
    propertyArray[1][0] = -propertyArray[0][1];
    propertyArray[1][1] = propertyArray[0][0];
    
    display();
  }
  
  void becomeIdentityMatrix()
  {
    propertyArray[0][0] = 1; propertyArray[0][1] = 0; propertyArray[0][2] = 0;
    propertyArray[1][0] = 0; propertyArray[1][1] = 1; propertyArray[1][2] = 0;
    propertyArray[2][0] = 0; propertyArray[2][1] = 0; propertyArray[2][2] = 1;
  }
  
  void display()
  {
    for(Vector v : Vectors)
    {
      if (!v.getDrawnState())
      {
        float m = 5;
        PVector straight = new PVector(2 * m * cos(v.getThetaAngle()), 2 * m * sin(v.getThetaAngle()));
        PVector normal1 = new PVector(-m * sin(v.getThetaAngle()), m * cos(v.getThetaAngle()));
        PVector normal2 = new PVector(m * sin(v.getThetaAngle()), -m * cos(v.getThetaAngle()));
        pushMatrix();
        translate((v.getMagnitude() - 2 * m) * cos(v.getThetaAngle()), (v.getMagnitude() - 2 * m) * sin(v.getThetaAngle()));
        beginShape();
        vertex(straight.x, straight.y);
        vertex(normal1.x, normal1.y);
        vertex(normal2.x, normal2.y);
        endShape(CLOSE);
        popMatrix();
        strokeWeight(3);
        line(v.getOriginX(), v.getOriginY(), v.getComponentX(), v.getComponentY());
        text(v.getVectorName(), v.getMagnitude()/half * cos(v.getThetaAngle()), v.getMagnitude()/half * sin(v.getThetaAngle()));
        v.setIsDrawn();
      }
    }
  }
  
  float size()
  {
    return Vectors.size();
  }
}

class Vector
{
  private String name;
  private float originX, originY, componentX, componentY, magnitude, thetaAngle;
  private boolean isDrawn = false;
  
  Vector (String vectorName, float originx, float originy, float x, float y)
  {
    name = vectorName;
    originX = originx;
    originY = originy;
    componentX = x;
    componentY = y;
    magnitude = sqrt(componentX * componentX + componentY * componentY);
    thetaAngle = atan2(componentY, componentX);
  }
  
  Vector getUnitNormal()
  {
    return new Vector(name, originX, originY, cos(thetaAngle), sin(thetaAngle));
  }
  
  boolean getDrawnState() { return isDrawn; }
  float getOriginX() { return originX; }
  float getOriginY() { return originY; }
  float getComponentX() { return componentX; }
  float getComponentY() { return componentY; }
  float getMagnitude() { return magnitude; }
  float getThetaAngle() { return thetaAngle; }
  String getVectorName() { return name; }
  void setIsDrawn() { isDrawn = !isDrawn; }
}