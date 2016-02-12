class TriangleState extends State {


  boolean keySpace = false;
  boolean keySpacePrev = false;
  float oppLength;
  String oppLengthStr;
  PVector oppTextPos = new PVector();
  float adjLength;
  String adjLengthStr;
  PVector adjTextPos = new PVector();
  float hypLength;
  String hypLengthStr;
  PVector hypTextPos = new PVector();
  PVector pointOnEdge = new PVector();
  PVector pointOnInsideEdge = new PVector();
  float angle;
  String angleText;

  float TmouseX;
  float TmouseY;





  void Update() {
    TmouseX = mouseX - width/2;
    TmouseY = mouseY - height/2;
    
    //get lenghts
    oppLength = dist(TmouseX, 0, TmouseX, TmouseY);
    hypLength = dist(0, 0, TmouseX, TmouseY);
    adjLength = dist(TmouseX, 0, 0, 0);
    
    //update text pos
    UpdateTextPos();

    //update string
    oppLengthStr = nf(oppLength, 0, 3);
    hypLengthStr = nf(hypLength, 0, 3);
    adjLengthStr = nf(adjLength, 0, 3);



    super.Update();
  }
  void Draw() {
    pushMatrix();
    translate(width/2, height/2);

    background(70);
    stroke(0);
    strokeWeight(1);
    line(0, -height/2, 0, height/2);
    line(-width/2, 0, width/2, 0);

    //draw triangle
    //grey sides
    stroke(150);
    strokeWeight(3);
    //opp
    line(TmouseX, 0, TmouseX, TmouseY);
    //adj
    line(TmouseX, 0, 0, 0);

    //yellow hypotenuse
    stroke(255, 255, 0);
    strokeWeight(5);
    line(0, 0, TmouseX, TmouseY);

    text(oppLengthStr, oppTextPos.x, oppTextPos.y);
    text(hypLengthStr, hypTextPos.x, hypTextPos.y);
    text(adjLengthStr, adjTextPos.x, adjTextPos.y);

    popMatrix();



    super.Draw();
  }
  void UpdateTextPos() {
    if (TmouseX < 0) {
      oppTextPos.x = TmouseX - 50;
      hypTextPos.x = TmouseX + (0 - TmouseX)/2 + 10;
      adjTextPos.x = 0 + (TmouseX - 0)/2;
      adjLength *= -1;
    } else {
      oppTextPos.x = TmouseX + 10; 
      hypTextPos.x = TmouseX - (TmouseX - 0)/2 - 50;
      adjTextPos.x = 0 - (0 - TmouseX)/2;
    }
    if (TmouseY < 0) {
      oppTextPos.y = TmouseY + oppLength/2;
      hypTextPos.y = TmouseY + (0 - TmouseY)/2 - 10;
      adjTextPos.y = 0 + 20;
    } else {
      oppTextPos.y = TmouseY - oppLength/2;
      hypTextPos.y = TmouseY - (TmouseY - 0)/2 + 10;
      adjTextPos.y = 0 - 20;
      oppLength *= -1;
    }
  }
}