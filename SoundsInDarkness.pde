/*
  (sound toy)
  searching for sample loops in the dark
*/

final int RADIUS_MIN = 20;
final int RADIUS_MAX = 150;
final int RADIUS_SCALING = 10;



import beads.*;
import java.io.File;


MouseLight mouseLight;
Audio audio;

void setup() {
  size(1000, 800); 
  background(0);
  ellipseMode(CENTER);

  mouseLight = new MouseLight();
  audio = new Audio();
}


void draw() {
  background(0); 
  mouseLight.updatePosition();
  mouseLight.display();
}