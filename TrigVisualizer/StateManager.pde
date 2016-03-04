class StateManager {
  State state;
  State nextState;
  boolean shouldSwitchState = false;


  StateManager() {
    state = new CircleState();
  }
  void Draw() {
    state.Update();
    state.Draw();

    if (Keys.onDown(Keys.SPACE)) {

      if (state.name == "tri") {
        SwitchState("CircleState");
      }
      if (state.name == "circle") {
        SwitchState("TriangleState");
      }
    }

    if (shouldSwitchState) {
      state = nextState; 
      shouldSwitchState = false;
    }
  }

  public void SwitchState(String stateToSwitchTo) {
    println(stateToSwitchTo);
    shouldSwitchState = true;
    switch(stateToSwitchTo) {
    case "CircleState": 
      nextState = new CircleState();
      println("D");
      break;
    case "TriangleState": 
      nextState = new TriangleState();
      println("D");
      break;
    }
  }
}