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
  void removeVector(int index) { Vectors.remove(index); }
  
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
        fill(0, 255, 0);
        text(v.getVectorName(), v.getMagnitude()/half * cos(v.getThetaAngle()), v.getMagnitude()/half * sin(v.getThetaAngle()));
        fill(0);
        v.setIsDrawn();
      }
    }
  }
  
  int getSize() { return Vectors.size(); }
}