

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
  float angle;
  String angleText;

  float TmouseX;
  float TmouseY;

  PVector selectedPoint;
  float scale = 4;


  TriangleState() {
    println("THI");
    name = "tri";
  }


  void Update() {


    if (mouseWheelValue > 0) scale--;
    if (mouseWheelValue < 0) scale++;
    if (scale >=5) scale = 5;
    if (scale <= 1) scale = 1;



    TmouseX = mouseX - width/2;
    TmouseY = mouseY - height/2;

    selectedPoint = new PVector(TmouseX, TmouseY);
    selectedPoint.div(scale);
    selectedPoint = new PVector(floor(selectedPoint.x), floor(selectedPoint.y));

    //get lenghts
    oppLength = dist(selectedPoint.x, 0, selectedPoint.x, selectedPoint.y);
    hypLength = dist(0, 0, selectedPoint.x, selectedPoint.y);
    adjLength = dist(selectedPoint.x, 0, 0, 0);

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
    scale(scale);

    background(70);
    stroke(0);
    strokeWeight(2 / scale);
    line(0, -height/2, 0, height/2);
    line(-width/2, 0, width/2, 0);

    strokeWeight(1 / scale);
    for (int i = -width/2; i < width/2; i += 10) {
      line(i, -height/2, i, height/2);
    }
    for (int i = -height/2; i < height/2; i += 10) {
      line(-width/2, i, width/2, i);
    }

    //draw triangle
    //grey sides
    stroke(150);
    strokeWeight(3 / scale);
    //opp
    line(selectedPoint.x, 0, selectedPoint.x, selectedPoint.y);
    //adj
    line(selectedPoint.x, 0, 0, 0);

    //yellow hypotenuse
    stroke(255, 255, 0);
    strokeWeight(5 / scale);
    line(0, 0, selectedPoint.x, selectedPoint.y);

    textSize(16 / scale);

    text(oppLengthStr, oppTextPos.x, oppTextPos.y);
    text(hypLengthStr, hypTextPos.x, hypTextPos.y);
    text(adjLengthStr, adjTextPos.x, adjTextPos.y);

    popMatrix();

    textSize(16);
    text("Hypotenuse Length     =  " + hypLengthStr, 10, 15);
    text("Adjacent Side Length  =  " + adjLengthStr, 10, 30);
    text("Opposite Side Length  =  " + oppLengthStr, 10, 45);

    // text("Hypotenuse Angle      =  " + angleText, 10,75);

    super.Draw();
  }
  void UpdateTextPos() {
    if (selectedPoint.x < 0) {
      oppTextPos.x = -adjLength - (80 / scale);
      hypTextPos.x = -adjLength/2 + 50/scale;
      adjTextPos.x = 0 + (selectedPoint.x - 0)/2;
      adjLength *= -1;
    } else {
      oppTextPos.x = selectedPoint.x + (10 / scale); 
      hypTextPos.x = adjLength/2 - 100/scale;
      adjTextPos.x = 0 - (0 - selectedPoint.x)/2;
    }
    if (TmouseY < 0) {
      oppTextPos.y = selectedPoint.y + oppLength/2;
      hypTextPos.y = selectedPoint.y + (0 - selectedPoint.y)/2 - (10 / scale);
      adjTextPos.y = 0 + (20 / scale);
    } else {
      oppTextPos.y = selectedPoint.y - oppLength/2;
      hypTextPos.y = oppLength/2;// / scale + (20 + 10 * scale);
      adjTextPos.y = 0 - (20 / scale);
      oppLength *= -1;
    }
  }
}