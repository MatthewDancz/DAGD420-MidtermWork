class Button {
  int w;
  int h;
  int x;
  int y;
  color normal = color(100);
  color hover = color(150);
  color click = color(250);
  boolean mouseOver;
  color activeColor;
  
  public boolean isTriggered = false; 

  Button(int h, int w, int x, int y, String text) {
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = x;
  }


  void Update() {
    UpdateHover();
    isTriggered = false;
    if (mouseOver && Keys.mouseDown) {
      activeColor = click;
      isTriggered = true;
    }
  }
  void Draw() {
    fill(activeColor);
    noStroke();
    rect(x, y, w, h);
  }

  void UpdateHover() {
    if (mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h) {
      mouseOver = true;
      activeColor = hover;
    } else {
      mouseOver = false;
      activeColor = normal;
    }
  }
  void ClickFunction(){
    
  }
  
}