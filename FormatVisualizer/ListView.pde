class ListView
{
  ArrayList<ListViewButton> Buttons = new ArrayList<ListViewButton>();
  PVector position = new PVector(0, 0);
  float frameWidth, buttonHeight = 20;
  
  boolean selection1 = false, selection2 = false;

  ListView(PVector v, float w)
  {
    position = v;
    frameWidth = w;
  }

  void Display(boolean mouseState)
  {
    int i = 0;
    for (ListViewButton b : Buttons)
    {
      b.update(mouseState);
      b.setPosition(new PVector(b.getPositionX(), b.getPositionY() + 20 * i));
      i++;
    }
    DrawVectors();
  }
  
  void DrawVectors()
  {
    for(ListViewButton v : Buttons)
    {
      if (!v.getHeldVector().getDrawnState())
      {
        float m = 5;
        PVector straight = new PVector(2 * m * cos(v.getHeldVector().getThetaAngle()), 2 * m * sin(v.getHeldVector().getThetaAngle()));
        PVector normal1 = new PVector(-m * sin(v.getHeldVector().getThetaAngle()), m * cos(v.getHeldVector().getThetaAngle()));
        PVector normal2 = new PVector(m * sin(v.getHeldVector().getThetaAngle()), -m * cos(v.getHeldVector().getThetaAngle()));
        pushMatrix();
        translate(-width/2, height/2);
        strokeWeight(3);
        line(v.getHeldVector().getOriginX(), v.getHeldVector().getOriginY(), v.getHeldVector().getComponentX(), v.getHeldVector().getComponentY());
        fill(0, 255, 0);
        text(v.getHeldVector().getVectorName(), v.getHeldVector().getMagnitude()/half * cos(v.getHeldVector().getThetaAngle()), v.getHeldVector().getMagnitude()/half * sin(v.getHeldVector().getThetaAngle()));
        fill(0);
        
        translate((v.getHeldVector().getMagnitude() - 2 * m) * cos(v.getHeldVector().getThetaAngle()), (v.getHeldVector().getMagnitude() - 2 * m) * sin(v.getHeldVector().getThetaAngle()));
        beginShape();
        vertex(straight.x, straight.y);
        vertex(normal1.x, normal1.y);
        vertex(normal2.x, normal2.y);
        endShape(CLOSE);
        popMatrix();

        v.getHeldVector().setIsDrawn();
      }
    }
  }

  void AddButton(Vector v)
  {
    ListViewButton b = new ListViewButton(position, frameWidth, buttonHeight, Buttons.size() - 1, v);
    b.setText("Vetor " + b.getIndex() + 1);
    Buttons.add(b);
  }

  void RemoveCurrentButton()
  {
    ArrayList<ListViewButton> ButtonsCopy = Buttons;
    for (ListViewButton b : Buttons)
    {
      if (b.getSelected() == true)
      {
        ButtonsCopy.remove(b.getIndex());
      }
    }

    Buttons = ButtonsCopy;
  }
  
  int ListViewSize() { return Buttons.size(); }
  
  void checkButtonCollision()
  {
    for (ListViewButton b : Buttons)
    {
      if (mouseButton == LEFT && b.isColliding())
      {
        previousVector = b.getHeldVector();
        onButton = true;
        if (isAddVector == true || isSubtractVector == true)
        {
          firstVector = b.getHeldVector();
        }
      }
      if (mouseButton == RIGHT && b.isColliding())
      {
        if (isAddVector == true || isSubtractVector == true)
        {
          secondVector = b.getHeldVector();
          isVectorAdded = false;
        }
      }
    }
  }
}

class ListViewButton extends Button
{
  Vector heldVector = null;
  int index = 0;
  
  ListViewButton(PVector pos, float w, float h, int i, Vector v)
  {
    super(pos, w, h);
    heldVector = v;
    index = i;  
  }
  
  int getIndex() { return index; }
  Vector getHeldVector() { return heldVector; }
}