class Ball {
  PVector initialPosition;
  PVector initialVelocity;
  
  PVector velocity;
  PVector position;
  PVector gravity = new PVector(0, -9.81f);

  float radio;
  float time = 0;
  float floor = 0;
  float timpacto = 0;

  Ball(PVector position, PVector velocity, float radio, float floor) {
    this.initialPosition = position.copy();
    this.initialVelocity = velocity.copy();
    
    this.velocity = velocity.copy();
    this.position = position.copy();
    
    this.radio = radio;
    this.floor = floor;
    
    float g = -gravity.y;
    timpacto = (
      initialVelocity.y
      + sqrt(initialVelocity.y * initialVelocity.y + 2 * initialPosition.y * g)
    ) / g;
  }
  
  void update(float dt) {
    if (time <= timpacto) {
      time += dt;
    }
    
    position.set(
      initialPosition.x + initialVelocity.x * time,
      initialPosition.y + initialVelocity.y * time 
      + 0.5f * gravity.y * time * time
    );
    
    velocity.set(
      initialVelocity.x,
      initialVelocity.y + gravity.y * time
    );
  }
  
  void display(float originX, float originY, float pixelsPerMeter) {
    float pX =  originX + position.x * pixelsPerMeter;
    float pY = originY - position.y * pixelsPerMeter;
    float diameter = 2 * radio * pixelsPerMeter;
    
    circle(pX, pY, diameter);
  }
}
