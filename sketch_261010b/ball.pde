class Ball {
  PVector velocity;
  PVector position;
  float radius;
  float mass;

  Ball(PVector position, PVector velocity, float r) {
    this.velocity = velocity;
    this.position = position;
    radius = r;
    mass = (4.0f / 3.0f) * PI * pow(r, 3);
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
    if (position.z >= 1024) {
      velocity.z *= -1;
    }
    if (position.z <= 0) {
      velocity.z *= -1;
    }
  }
  
  void draw() {
    
    pushMatrix();
    translate(position.x, position.y, position.z);
    noStroke();
    fill(220);
    sphere(radius);
    popMatrix();
  }
}
