BallsSystem bs;

void setup() {
  size(1024, 1024, P3D);
  orientation(LANDSCAPE);
  bs = new BallsSystem(20, 1024);
}

void draw() {
  background(0);
  bs.update();
  
  
  fill(255);
  textSize(16);
  text("Frame rate: " + int(frameRate), 10, 20);
}
