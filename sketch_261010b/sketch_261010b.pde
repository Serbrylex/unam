BallsSystem bs;

void setup() {
  fullScreen(P3D);
  //size(1024, 720, P3D);
  orientation(LANDSCAPE);
  bs = new BallsSystem(200);
}

void draw() {
  background(0);
  bs.update();
  
  
  fill(255);
  textSize(16);
  text("Frame rate: " + int(frameRate), 10, 20);
}
