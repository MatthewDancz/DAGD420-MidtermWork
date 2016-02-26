
StateManager stateManager;
int mouseWheelValue;

void setup(){
  size(1100,900);
  background(100);
  stateManager = new StateManager();
}
void draw(){
  stateManager.Draw();
  
  
  mouseWheelValue = 0;
  Keys.update();
  
}

void mouseWheel(MouseEvent event) {
  mouseWheelValue = event.getCount();
} 