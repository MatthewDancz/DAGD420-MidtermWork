
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
boolean isAddVector = false, isAddVectorPreviously = false, isSubtractVector = false, isDrawVector = true, isDeleteVector = false, isSelectVector = false;
boolean isHelpTextDrawn = false, isUpdateHelpText = true;

ListView ListView1 = new ListView(new PVector(propertyBoxWidth/half, 10), hierarchyBoxWidth);

ArrayList<Button> Buttons = new ArrayList<Button>();
ArrayList<Button> toolBoxButtons = new ArrayList<Button>();
Button addVector, subtractVector, drawVector, deleteVector, selectVector;

Vector previousVector, firstVector, secondVector;

int counts = 0;

color b1 = #1B94B5;
color g1 = #4D7782;
color b2 = #105669;
color b3 = #3A9AB5;
color b4 = #082C36;
color y1 = #FF9410;
color b2o50 = color(16, 86, 105, 120);
color b2o25 = color(16, 86, 105, 60);

String direction = "Click to draw Vectors.";

void setup()
{
  size(1500, 1000);
  background(b4);
  stroke(b2);
  line(midPointX, -10000, midPointX, 10000);
  line(-10000, midPointY, 10000, midPointY);

  drawVector = new Button(new PVector(0, 0), toolBoxWidth, 20);
  drawVector.setText("Draw Vectors");
  toolBoxButtons.add(drawVector);

  addVector = new Button(new PVector(0, 0), toolBoxWidth, 20);
  addVector.setText("Add Vectors");
  toolBoxButtons.add(addVector);

  subtractVector = new Button(new PVector(0, 0), toolBoxWidth, 20);
  subtractVector.setText("Subtract Vectors");
  toolBoxButtons.add(subtractVector);

  deleteVector = new Button(new PVector(0, 0), toolBoxWidth, 20);
  deleteVector.setText("Delete Vector");
  toolBoxButtons.add(deleteVector);

  selectVector = new Button(new PVector(0, 0), toolBoxWidth, 20);
  selectVector.setText("Select Vector");
  toolBoxButtons.add(selectVector);

  updateWindow();
}

void draw()
{
  //World Space
  pushMatrix();
  translate(midPointX, midPointY);
  
  if (isDeleteVector == true)
  {
    ListView1.RemoveCurrentButton();
  }
  
  if (isMouseClicked && !isMouseClickedPreviously)
  {
    holder = A.getSize() + 1;
    ListView1.AddButton(new Vector("V" + holder, xStart, yStart, mouseXEnd, mouseYEnd));
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

  strokeWeight(0);
  stroke(0, 255, 0);
  line(lastLine[0], lastLine[1], lastLine[2], lastLine[3]);
  strokeWeight(3);
  stroke(0);

  //A.display();
  isMouseClickedPreviously = isMouseClicked;
  popMatrix();

  //Screen Space
  if (isTextChanged)
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
    b.update(isMouseClicked);
    j++;
  }
  if (isHelpTextDrawn == false || isUpdateHelpText == true)
  {
    fill(b4);
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
  if (isDeleteVector == false)
  {
    //A.display();
    ListView1.Display(isMouseClicked);
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
      isDeleteVector = false;
      isSelectVector = false;
      direction = "Click to draw Vectors.";
      isUpdateHelpText = true;
    }

    if (addVector.isColliding() == true)
    {
      isDrawVector = false;
      isAddVector = true;
      isSubtractVector = false;
      isDeleteVector = false;
      isSelectVector = false;
      direction = "Select vectors by left and right clicking.";
      isUpdateHelpText = true;
    }

    if (subtractVector.isColliding() == true)
    {
      isDrawVector = false;
      isAddVector = false;
      isSubtractVector = true;
      isDeleteVector = false;
      isSelectVector = false;
      direction = "Select vectors by left and right clicking.";
      isUpdateHelpText = true;
    }

    if (deleteVector.isColliding() == true)
    {
      isDrawVector = false;
      isAddVector = false;
      isSubtractVector = false;
      isDeleteVector = true;
      isSelectVector = false;
      direction = "Select a vector to delete.";
      isUpdateHelpText = true;
    }

    if (selectVector.isColliding() == true)
    {
      isDrawVector = false;
      isAddVector = false;
      isSubtractVector = false;
      isDeleteVector = false;
      isSelectVector = true;
      direction = "Select a vector in the world space.";
      isUpdateHelpText = true;
    }
  }

  ListView1.checkButtonCollision();

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