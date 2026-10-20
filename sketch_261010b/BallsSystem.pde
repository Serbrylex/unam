class BallsSystem {
  ArrayList<Ball> balls;
  int dimentions;
  int velocity = 10;
  
  BallsSystem(int n, int dim) {
    balls = new ArrayList<Ball>();
    dimentions = dim;
    
    for (int i = 0; i < n; i++) {
      Ball b = new Ball(
        new PVector(random(1, dimentions - 1), random(1, dimentions - 1)),
        new PVector(random(-1 * velocity, velocity), random(-1 * velocity, velocity)),
        random(10, 50) // radius
      );
      balls.add(b);
    }
  }
  
  boolean collides(Ball a, Ball b) {
    // Gestionar cuando se superponen
    PVector u = PVector.sub(a.position, b.position);
    float d = u.dot(u);
    
    return d <= pow(a.radius + b.radius, 2);
  }
  
  PVector CalculateNewVelocity(Ball a, Ball b) {
    PVector result = a.velocity.copy();
    
    PVector deltaPosition = PVector.sub(a.position, b.position);
    float distanceSquared = PVector.dot(deltaPosition, deltaPosition);
    
    if (distanceSquared == 0) {
      return result;
    }
    
    PVector deltaVelocity = PVector.sub(a.velocity, b.velocity);
    
    float massFactor = (2.0f * b.mass) / (a.mass + b.mass);
    float numerador = PVector.dot(deltaVelocity, deltaPosition);
    //posicion puede ser igual y el producto punto dar cero
    deltaPosition.mult(numerador/distanceSquared);
    deltaPosition.mult(massFactor);
    result.sub(deltaPosition);
    
    return result;
  }
  
  void CalculateNewVelocities(Ball a, Ball b) {
    PVector deltaPosition = PVector.sub(a.position, b.position);
    PVector deltaVelocity = PVector.sub(a.velocity, b.velocity);
    
    if (deltaVelocity.dot(deltaPosition) >= 0) {
      return;
    }
    
    PVector v1res = CalculateNewVelocity(a, b);
    PVector v2res = CalculateNewVelocity(b, a);
    
    a.velocity = v1res;
    b.velocity = v2res;
  }
  
  void update() {
    for (Ball b : balls) {
      b.update();
    }
    
    for (int i = 0; i < balls.size(); i++) {
      Ball a = balls.get(i);
        for (int j = i + 1; j < balls.size(); j++) {
        Ball b = balls.get(j);
        
        if (collides(a, b)) {
          CalculateNewVelocities(a, b);
        }
      }
    }
  }
}
