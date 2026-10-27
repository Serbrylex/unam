class BallsSystem {
  ArrayList<Ball> balls;
  int v_lim = 2;
  float e = 1; // restitucion, que tanto rebota el contacto, usa la normal
  float mu = 0.02f; // coeficiente de friccion, tangencial
  
  BallsSystem(int n) {
    balls = new ArrayList<Ball>();
    
    for (int i = 0; i < n; i++) {
      float angleX = random(0, 2);
      float angleY = random(0, 2);
      float angleZ = random(0, 2);
      
      float tono = map(i, 0, n, 0, 255);
      float radius = random(10, 50); // radius 
      
      Ball b = new Ball(
        new PVector(
          random(radius, width - radius),
          random(radius, height - radius),
          random(radius, height - radius)
        ),
        new PVector(
          random(1, v_lim),
          random(1, v_lim),
          random(1, v_lim)
        ),
        radius,
        new PVector(radians(angleX), radians(angleY), radians(angleZ)),
        new PVector(
          random(0.01, 0.05),
          random(0.01, 0.05),
          random(0.01, 0.05)
        ),
        tono
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
  
  PVector getRelativeVelocityOnContact(Ball a, Ball b, PVector normal) {
    // left
    PVector newB = b.angularVelocity.copy();
    newB.mult(b.radius);
    newB = newB.cross(normal);
    PVector leftFactor = PVector.sub(b.velocity, newB);
    
    // right
    PVector newA = a.angularVelocity.copy();
    newA.mult(a.radius);
    newA = newA.cross(normal);
    PVector rightFactor = PVector.add(a.velocity, newA);
    
    return PVector.sub(leftFactor, rightFactor);
  }
  
  void updateImpulses(Ball a, Ball b) {
    PVector normal = PVector.sub(b.position, a.position);
    float distanceSquared = normal.magSq();
    
    if (distanceSquared < 1e-12f) {
      return;
    }
    
    normal.normalize();
    
    PVector u = getRelativeVelocityOnContact(a, b, normal);
    float un = PVector.dot(u, normal);
    PVector ut = PVector.sub(
      u, PVector.mult(normal, un)
    );
    
    if (un >= 0) {
      return; // ganamos
    }
    
    float invMassA = 1.0f / a.mass;
    float invMassB = 1.0f / b.mass;
    
    // Calculamos los impulsos jn y Jt
    float jn = -((1.0f + e) * un) / (invMassA + invMassB);
    
    PVector Jt = ut.copy();
    Jt.mult(-1.0f);
    Jt.div(
      invMassA + invMassB
      + (pow(a.radius, 2) / a.inertia)
      + (pow(b.radius, 2) /  b.inertia)
    );
    
    float maxFrictionImpuse = mu * jn;
    float jtMagnitude = Jt.mag();
    
    if (jtMagnitude > maxFrictionImpuse) {
      Jt.mult(maxFrictionImpuse/jtMagnitude);
    }
    
    PVector J = PVector.add(PVector.mult(normal, jn), Jt);
    
    a.velocity.sub(PVector.div(J, a.mass));
    b.velocity.add(PVector.div(J, b.mass));
    
    // Nuevas velocidades angulares
    PVector nxJt = normal.cross(Jt);
    
    PVector diffagvtyA = PVector.mult(nxJt, a.radius/a.inertia);
    PVector agvtyA = PVector.sub(a.angularVelocity, diffagvtyA);
    
    PVector diffagvtyB = PVector.mult(nxJt, b.radius/b.inertia);
    PVector agvtyB = PVector.sub(b.angularVelocity, diffagvtyB);
    
    a.angularVelocity = agvtyA;
    b.angularVelocity = agvtyB;
    
  }
  
  // legacy
  PVector CalculateNewVelocity(Ball a, Ball b) {
    PVector result = a.velocity.copy();
    
    PVector deltaPosition = PVector.sub(a.position, b.position);
    float distanceSquared = PVector.dot(deltaPosition, deltaPosition);
    
    if (distanceSquared == 0) {
      return result;
    }
    
    PVector deltaVelocity = PVector.sub(a.velocity, b.velocity);
    
    float massFactor = ((1.0f + e) * b.mass) / (a.mass + b.mass);
    float numerador = PVector.dot(deltaVelocity, deltaPosition);
    //posicion puede ser igual y el producto punto dar cero
    deltaPosition.mult(numerador/distanceSquared);
    deltaPosition.mult(massFactor);
    result.sub(deltaPosition);
    
    return result;
  }
  
  // legacy
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
          a.squash = 0.15f;
          b.squash = 0.15f;
          updateImpulses(a, b);
        }
      }
    }
    
    for (Ball b : balls) {
      b.draw();
    }
  }
}
