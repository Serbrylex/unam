CanonSystem cs;

void setup() {
  size(1024, 700, P2D);
  orientation(LANDSCAPE);
  cs = new CanonSystem();
}

void mousePressed() {
  cs.mousePressed();
}

void draw() {
  background(25);
  
  cs.update();
  cs.display();
  
  fill(255);
  textSize(16);
  text("Frame rate: " + int(frameRate), 10, 20);
}
