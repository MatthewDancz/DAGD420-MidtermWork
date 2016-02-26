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

String adjAngle;
String oppAngle;
  CircleState(){
    println("THI");
   name = "circle"; 
  }
  
  void Update(){
    TmouseX = mouseX - width/2;
    TmouseY = mouseY - height/2;
    
     
    
    //find point on circle
    //find angle between origin and mouse
    angle = atan2(TmouseY - 0, TmouseX - 0);
    
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
    
    //update text position based on quadrent
    UpdateTextPos();
  
  
  oppLengthStr = nf(oppLength, 0, 3);
  hypLengthStr = nf(hypLength, 0, 3);
  adjLengthStr = nf(adjLength, 0, 3);
  
  }
  void Draw(){
    
    
    pushMatrix();
    translate(width/2, height/2);
    
    background(70);
    stroke(0);
    strokeWeight(1);
    line(0, -height/2, 0, height/2);
    line(-width/2, 0, width/2, 0);

    fill(240);
    
    
    //draw circle
    noFill();
    ellipse(0,0,400,400);
    
    //do radian text
    text(angleText, pointOnInsideEdge.x, pointOnInsideEdge.y);
    
    //draw triangle
    //grey sides
    stroke(150);
    strokeWeight(3);
    //opp
    line(pointOnEdge.x, 0, pointOnEdge.x, pointOnEdge.y);
    //adj
    line(pointOnEdge.x, 0, 0, 0);
    
    //draw arc
    arc(0, 0, 60, 60, angle, 0);
    arc(0, 0, 60, 60, 0, angle);
    
    //yellow hypotenuse
    stroke(255,255,0);
    strokeWeight(5);
    line(0, 0, pointOnEdge.x, pointOnEdge.y);
    
    //draw text
  text(oppLengthStr, oppTextPos.x, oppTextPos.y);
  text(hypLengthStr, hypTextPos.x, hypTextPos.y);
  text(adjLengthStr, adjTextPos.x, adjTextPos.y);
    
    popMatrix();
  text("Hypotenuse Length     =  " + hypLengthStr, 10,15);
  text("Adjacent Side Length  =  " + adjLengthStr, 10,30);
  text("Opposite Side Length  =  " + oppLengthStr, 10,45);
  
  text("Hypotenuse Angle      =  " + angleText, 10,75);
  //text("Opposite Side Length = " + oppLengthStr, 10,10);
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