class CanonSystem {
  Ball b;
  float speed = 0;
  float angle = 0;
  float time = 0;
  boolean shoot = false;
  PVector origin = new PVector(0, 700);
  
  CanonSystem() {
    PVector velocity = new PVector(0, 0);
    PVector position = new PVector(50, 50);
    b = new Ball(
      position,
      velocity,
      10,
      650
    );
  }
  
  void resetBall() {
    float angleRadian = radians(angle);
    PVector velocity = new PVector(
      speed * cos(angleRadian),
      speed * sin(angleRadian)
    );
    PVector position = new PVector(50, 50);
    b = new Ball(
      position,
      velocity,
      10,
      50
    );
  }
  
  void drawVector() {
    stroke(255);
    line(50, 650, mouseX, mouseY);
  }
  
  void drawFlor() {
    stroke(204, 102, 0);
    line(0, 650, width, 650);
  }
  
  void mousePressed() {
    float CO = abs(mouseY - 650);
    float CA = abs(mouseX - 50);
    float angleRadian = atan2(CO, CA);
    
    float distance = sqrt(CO * CO + CA * CA);
    speed = constrain(distance * 0.3, 0, 100);
    
    angle = degrees(angleRadian);
    resetBall();
    shoot = true;
  }
  
  void update() {
    if (shoot) {
      time += 0.001f;
      b.update(time);
    }
    drawVector();
  }
  
  void display() {
    drawFlor();
    b.display(0, 700, 1);
  }
}
