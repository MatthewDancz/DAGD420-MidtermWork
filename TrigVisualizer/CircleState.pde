class CircleState extends State {

  PVector pointOnEdge = new PVector();
  PVector pointOnInsideEdge = new PVector();
  float angle;
  String angleText;
  float TmouseX;
  float TmouseY;
  float oppLength;
  String oppLengthStr;
  PVector oppTextPos = new PVector();
  float adjLength;
  String adjLengthStr;
  PVector adjTextPos = new PVector();
  float hypLength;
  String hypLengthStr;
  PVector hypTextPos = new PVector();

  color b1 = #1B94B5;
  color g1 = #4D7782;
  color b2 = #105669;
  color b3 = #3A9AB5;
  color b4 = #082C36;
  color y1 = #FF9410;
  color b2o50 = color(16, 86, 105, 120);
  color b2o25 = color(16, 86, 105, 60);

  String adjAngle;
  String oppAngle;
  String angleTextDeg;
  CircleState() {
    println("THI");
    name = "circle";
  }

  void Update() {

    if (mouseX > 300) {
      TmouseX = mouseX - width/2 - 150;
      TmouseY = mouseY - height/2;
    }



    //find point on circle
    //find angle between origin and mouse
    angle = atan2(TmouseY - 0, TmouseX - 0);
    float angleDeg = angle * 180/PI;


    //find point based on angle from origin with length of circle radius
    pointOnEdge.y = sin(angle) * 200;
    pointOnEdge.x = cos(angle) * 200;
    //pointOnEdge.add((float)250,(float)250);

    //find point based on angle from origin with length of inner circle radius for angle text pos
    pointOnInsideEdge.y = sin(angle/2) * 50;
    pointOnInsideEdge.x = cos(angle/2) * 50;





    //update text
    oppLength = dist(pointOnEdge.x, 0, pointOnEdge.x, pointOnEdge.y);
    oppLength = map(oppLength, 0, 200, 0, 1);
    hypLength = dist(0, 0, pointOnEdge.x, pointOnEdge.y);
    hypLength = map(hypLength, 0, 200, 0, 1);
    adjLength = dist(pointOnEdge.x, 0, 0, 0);
    adjLength = map(adjLength, 0, 200, 0, 1);

    angleText = nf(angle, 0, 3) + " radians";
    angleTextDeg = nf(angleDeg, 0, 1) + " degrees";

    //update text position based on quadrent
    UpdateTextPos();


    oppLengthStr = nf(oppLength, 0, 3);
    hypLengthStr = nf(hypLength, 0, 3);
    adjLengthStr = nf(adjLength, 0, 3);
  }
  void Draw() {


    pushMatrix();
    translate(width/2 + 150, height/2);

    background(b4);
    stroke(b2);
    strokeWeight(3);
    line(0, -height/2, 0, height/2);
    line(-width/2, 0, width/2, 0);

    strokeWeight(1);
    for (int i = -width/2; i < width/2; i += 10) {
      stroke(b2o25);
      if (i % 50 == 0) stroke(b2o50);
      line(i, -height/2, i, height/2);
    }
    for (int i = -height/2; i < height/2; i += 10) {
      stroke(b2o25);
      if (i % 50 == 0) stroke(b2o50);
      line(-width/2, i, width/2, i);
    }

    stroke(b2);
    fill(b3);
    strokeWeight(3);

    //draw circle
    noFill();
    ellipse(0, 0, 400, 400);



    //draw triangle
    //grey sides
    stroke(b1);
    strokeWeight(3);
    //opp
    line(pointOnEdge.x, 0, pointOnEdge.x, pointOnEdge.y);
    //adj
    line(pointOnEdge.x, 0, 0, 0);

    //draw arc
    arc(0, 0, 60, 60, angle, 0);
    arc(0, 0, 60, 60, 0, angle);

    //yellow hypotenuse
    stroke(y1);
    strokeWeight(5);
    line(0, 0, pointOnEdge.x, pointOnEdge.y);

    fill(255);



    //draw text
    //do radian text
    text(angleText, pointOnInsideEdge.x, pointOnInsideEdge.y);

    text(oppLengthStr, oppTextPos.x, oppTextPos.y);
    text(hypLengthStr, hypTextPos.x, hypTextPos.y);
    text(adjLengthStr, adjTextPos.x, adjTextPos.y);

    popMatrix();

    noStroke();
    fill(g1);
    rect(0, 0, 300, height);
    fill(255);

    text("Hypotenuse Length     =  " + hypLengthStr, 10, 15);
    text("Adjacent Side Length  =  " + adjLengthStr, 10, 30);
    text("Opposite Side Length  =  " + oppLengthStr, 10, 45);

    text("Hypotenuse Angle      =  " + angleText, 10, 75);
    text("Hypotenuse Angle      =  " + angleTextDeg, 10, 90);
    //text("Opposite Side Length = " + oppLengthStr, 10,10);


    super.Draw();
  }

  void UpdateTextPos() {
    if (pointOnEdge.x < 0) {
      oppTextPos.x = pointOnEdge.x - 50;
      hypTextPos.x = pointOnEdge.x + (0 - pointOnEdge.x)/2 + 10;
      adjTextPos.x = 0 + (pointOnEdge.x - 0)/2;
      adjLength *= -1;
    } else {
      oppTextPos.x = pointOnEdge.x + 10; 
      hypTextPos.x = pointOnEdge.x - (pointOnEdge.x - 0)/2 - 50;
      adjTextPos.x = 0 - (0 - pointOnEdge.x)/2;
    }
    if (TmouseY < 0) {
      oppTextPos.y = pointOnEdge.y + (oppLength * 100)/2;
      hypTextPos.y = pointOnEdge.y + (0 - pointOnEdge.y)/2 - 10;
      adjTextPos.y = 0 + 20 ;
    } else {
      oppTextPos.y = pointOnEdge.y - (oppLength * 100)/2;
      hypTextPos.y = pointOnEdge.y - (pointOnEdge.y - 0)/2 + 10 ;
      adjTextPos.y = 0 - 20;
      oppLength *= -1;
    }
  }
}