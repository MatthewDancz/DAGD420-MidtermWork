
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
boolean isAddVector = false, isAddVectorPreviously = false, isSubtractVector = false, isDrawVector = true, isDeleteButton = false;
boolean isHelpTextDrawn = false, isUpdateHelpText = true;

ArrayList<Button> Buttons = new ArrayList<Button>();
ArrayList<Button> toolBoxButtons = new ArrayList<Button>();
Button addVector, subtractVector, drawVector, deleteButton;

Vector previousVector, firstVector, secondVector;

int counts = 0;

String direction = "Click to draw Vectors.";

void setup()
{
  size(1500, 1000);
  background(100);
  line(midPointX, -10000, midPointX, 10000);
  line(-10000, midPointY, 10000, midPointY);
  
  drawVector = new Button(new PVector(0, 0), toolBoxWidth, 20, 0);
  drawVector.setText("Draw Vectors");
  toolBoxButtons.add(drawVector);
  
  addVector = new Button(new PVector(0, 0), toolBoxWidth, 20, 1);
  addVector.setText("Add Vectors");
  toolBoxButtons.add(addVector);
  
  subtractVector = new Button(new PVector(0, 0), toolBoxWidth, 20, 2);
  subtractVector.setText("Subtract Vectors");
  toolBoxButtons.add(subtractVector);
  
  deleteButton = new Button(new PVector(0, 0), toolBoxWidth, 20, 3);
  deleteButton.setText("Delete Vector");
  toolBoxButtons.add(deleteButton);
  
  updateWindow();
}

void draw()
{
  //World Space
  pushMatrix();
  translate(midPointX, midPointY);
  if (isMouseClicked && !isMouseClickedPreviously)
  {
    holder = A.getSize() + 1;
    A.addVector(new Vector("V" + holder, xStart, yStart, mouseXEnd, mouseYEnd));
    isTextChanged = true;
  }
  if (isAddVector == true && isVectorAdded == false && firstVector != null && secondVector != null)
  {
    holder = A.getSize() + 1;
    lastLine[0] = 0;
    lastLine[1] = 0;
    lastLine[2] = firstVector.getComponentX() + secondVector.getComponentX();
    lastLine[3] = firstVector.getComponentY() + secondVector.getComponentY();
    A.addVector(new Vector("V" + holder, xStart, yStart, firstVector.getComponentX() + secondVector.getComponentX(), firstVector.getComponentY() + secondVector.getComponentY()));
    isVectorAdded = true;
  }
  if (isSubtractVector == true && isVectorAdded == false && firstVector != null && secondVector != null)
  {
    holder = A.getSize() + 1;
    lastLine[0] = firstVector.getComponentX();
    lastLine[1] = firstVector.getComponentY();
    lastLine[2] = secondVector.getComponentX();
    lastLine[3] = secondVector.getComponentY();
    A.addVector(new Vector("V" + holder, xStart, yStart, firstVector.getComponentX() - secondVector.getComponentX(), firstVector.getComponentY() - secondVector.getComponentY()));
    isVectorAdded = true;
  }
  
  for (int i = 0; i < A.getSize(); i++)
  {
    if (isDeleteButton == true)
    {
      //A.removeVector();
    }
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
  if (isHelpTextDrawn == false || isUpdateHelpText == true)
  {
    fill(100);
    noStroke();
    rect(origin.x, origin.y + 23, toolBoxWidth + 20, 20);
    fill(0);
    stroke(0);
    text(direction, origin.x + 3, origin.y + 40);
    isHelpTextDrawn = true;
    isUpdateHelpText = false;
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
    Button b = new Button(new PVector(hierarchyBoxWidth/2, origin.y + 20 * i - 10), hierarchyBoxWidth, 20, i);
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
      isDeleteButton = false;
      direction = "Click to draw Vectors.";
      isUpdateHelpText = true;
    }
    
    if (addVector.isColliding() == true)
    {
      isDrawVector = false;
      isAddVector = true;
      isSubtractVector = false;
      isDeleteButton = false;
      direction = "Select vectors by left and right clicking.";
      isUpdateHelpText = true;
    }
    
    if (subtractVector.isColliding() == true)
    {
      isDrawVector = false;
      isAddVector = false;
      isSubtractVector = true;
      isDeleteButton = false;
      direction = "Select vectors by left and right clicking.";
      isUpdateHelpText = true;
    }
    
    if (deleteButton.isColliding() == true)
    {
      isDrawVector = false;
      isAddVector = false;
      isSubtractVector = false;
      isDeleteButton = true;
      direction = "Select a vector to delete.";
      isUpdateHelpText = true;
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