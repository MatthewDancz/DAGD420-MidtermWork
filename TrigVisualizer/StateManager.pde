class StateManager{
 State state;
 
 
 StateManager(){
   state = new TriangleState();
 }
 void Draw(){
  state.Update();
  state.Draw();
   
 }
  
}