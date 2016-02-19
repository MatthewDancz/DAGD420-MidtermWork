class StateManager{
 State state;
 
 
 StateManager(){
   state = new CircleState();
 }
 void Draw(){
  state.Update();
  state.Draw();
   
 }
  
}