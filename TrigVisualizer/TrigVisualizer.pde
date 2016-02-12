
State state;

void setup(){
  size(900,900);
  background(100);
  state = new TriangleState();
}
void draw(){
  state.Update();
  state.Draw();
  
}