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