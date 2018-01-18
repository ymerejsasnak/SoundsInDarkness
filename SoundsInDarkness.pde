/*
  (sound toy)
  searching for sample loops in the dark

ideas:
change rate to go up if approaching and down if going away
adjustments and cleanup
*/




final int SOUND_SIZE = 20;

final int LIGHT_SIZE_MIN = 60;
final int LIGHT_SIZE_MAX = 500;
final int LIGHT_SIZE_INCREMENT = 10;

final float PERLIN_SCALE = .005;



import beads.*;
import java.io.File;


MouseLight mouseLight;
Audio audio;

void setup() {
  size(1000, 800); 
  background(0);
  ellipseMode(CENTER);
  noStroke();

  mouseLight = new MouseLight();
  audio = new Audio();
}


void draw() {
  background(0); 
 
  mouseLight.updatePosition(mouseX, mouseY);
  audio.updateSoundObjects(mouseX, mouseY);
  
  audio.playVisibleSounds();
  
  audio.displaySoundObjects();
  mouseLight.display();
  
  
  // temp framerate display jic
  fill(200);
  textSize(20);
  text((int)frameRate, 10, 10);
}