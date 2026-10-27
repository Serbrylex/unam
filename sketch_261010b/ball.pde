class Ball {
  float tono;
  
  PVector velocity;
  PVector position;
  
  PVector angularVelocity;
  PVector angles; // angulo inicial que va a ir afectando a la esfera
  
  float radius;
  float mass;
  
  // auxiliares para no procesar extra
  float inertia;
  
  PMatrix3D orientation = new PMatrix3D();
  
  // deformacion
  float squash = 0;
  

  Ball(
    PVector position, PVector velocity,
    float radius, 
    PVector angles, PVector angularVelocity,
    float tono
  ) {
    this.tono = tono;
    
    this.velocity = velocity;
    this.position = position;
    
    this.angularVelocity = angularVelocity;
    this.angles = angles;
    
    this.radius = radius;
    
    mass = (4.0f / 3.0f) * PI * pow(radius, 3);
    inertia = (2.0f / 5.0f) * mass * pow(radius, 2);
    
    orientation.rotateX(angles.x);
    orientation.rotateY(angles.y);
    orientation.rotateZ(angles.z);
  }
  
  void update() {
    squash *= 0.85f;
    
    position.add(velocity);
    
    if (position.x >= width - radius) {
      velocity.x *= -1;
    }
    if (position.x <= radius) {
      velocity.x *= -1;
    }
    if (position.y >= height - radius) {
      velocity.y *= -1;
    }
    if (position.y <= radius) {
      velocity.y *= -1;
    }
    if (position.z >= height - radius) {
      velocity.z *= -1;
    }
    if (position.z <= radius) {
      velocity.z *= -1;
    }
    
    // Actualmente tus velocidades están expresadas por fotograma.
    float dt = 1.0f;

    float angularSpeed = angularVelocity.mag();

    if (angularSpeed > 0) {
      PVector axis = PVector.div(angularVelocity, angularSpeed);

      PMatrix3D rotationStep = new PMatrix3D();
      rotationStep.rotate(
        angularSpeed * dt,
        axis.x,
        axis.y,
        axis.z
      );

      // angularVelocity está expresada en coordenadas globales.
      orientation.preApply(rotationStep);
    }
  }
  
  void draw() {
     float sy = 1.0f - squash;
     float sxz = 1.0f / sqrt(sy);
    
    lights();
    pushMatrix(); // Guarda el estado original del espacio
    
      translate(position.x, position.y, position.z);
      scale(sxz, sy, sxz);
      applyMatrix(orientation);
     
      stroke(255);
      noFill();
      sphere(radius);
      
      colorMode(HSB, 255);
      stroke(tono, 255, 255);
      line(0, 0, 0, radius * 1.2f, 0, 0);
      
    popMatrix();
  }
}
