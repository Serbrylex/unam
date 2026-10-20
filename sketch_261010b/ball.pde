class Ball {
  PVector velocity;
  PVector position;
  float radius;
  float mass;

  Ball(PVector position, PVector velocity, float r) {
    this.velocity = velocity;
    this.position = position;
    radius = r;
    mass = PI * pow(r, 2);
  }
  
  void update() {
    position.add(velocity);
    
    if (position.x >= 1024) {
      velocity.x *= -1;
    }
    if (position.x <= 0) {
      velocity.x *= -1;
    }
    if (position.y >= 1024) {
      velocity.y *= -1;
    }
    if (position.y <= 0) {
      velocity.y *= -1;
    }
    
    circle(position.x, position.y, radius * 2);
  }
}
