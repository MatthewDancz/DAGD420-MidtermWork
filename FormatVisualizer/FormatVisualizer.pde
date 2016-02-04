PVector origin = new PVector(0, 0);
float half = 2;
float sizeY = 1000;
float sizeX = 1500;
float midPointY = sizeY / half;
float midPointX = sizeX / half;
float toolBoxWidth = 200;
float propertyBoxWidth = -300;
float hierarchyBoxWidth = -300;

void setup()
{
  size(1500, 1000);
}

void draw()
{
  
  
  //World Space
  
  background(100);
  pushMatrix();
  translate(midPointX, midPointY);
  
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
  popMatrix();
  
  text("Canvas Area", sizeX / half - 70, sizeY / half + 5);
}