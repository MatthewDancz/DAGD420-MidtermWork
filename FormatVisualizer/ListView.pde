class ListView
{
  ArrayList<Button> Buttons = new ArrayList<Button>();
  PVector transpose = new PVector(0, 0);
  
  boolean selection1 = false, selection2 = false;

  ListView(PVector v)
  {
    transpose = v;
  }

  void Display(boolean mouseState)
  {
    for (Button b : Buttons)
    {
      b.update(mouseState, transpose.x);
    }
  }

  void AddButton(Button b)
  {
    Buttons.add(b);
  }

  void RemoveCurrentButton()
  {
    ArrayList<Button> ButtonsCopy = Buttons;
    for (Button b : Buttons)
    {
      if (b.getSelected() == true)
      {
        ButtonsCopy.remove(b.getMyIndex());
      }
    }

    Buttons = ButtonsCopy;
  }
  
  
  
  void checkButtonCollision()
  {
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
  }
}