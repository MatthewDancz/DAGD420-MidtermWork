
StateManager stateManager;
int mouseWheelValue;

void setup(){
  size(900,900);
  background(100);
  stateManager = new StateManager();
}
void draw(){
  stateManager.Draw();
  
  
  mouseWheelValue = 0;
  
}

  void mouseWheel(MouseEvent event) {
    mouseWheelValue = event.getCount();
  } 