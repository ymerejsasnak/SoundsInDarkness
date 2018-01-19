/*
  (sound toy)
  searching for sample loops in the dark


way to limit # of files loaded (randomly from chosen dir) so as to avoid mem errors
other options for repeat files, # of files, etc

add realtime recording

adjustments and cleanup
*/




final int SOUND_SIZE = 20;

final int LIGHT_SIZE_MIN = 60;
final int LIGHT_SIZE_MAX = 500;
final int LIGHT_SIZE_INCREMENT = 10;




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
  
 
}