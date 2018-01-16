/*
  (sound toy)
  searching for sample loops in the dark





soundobjects:
change random walk to angular direction
constrain to screen
cleanup code

-randomwalk?, looping sound, volume goes up as light gets nearer   (also add filter and reverb to faraway sounds?)





*/




final int SOUND_SIZE = 20;

final int LIGHT_SIZE_MIN = 30;
final int LIGHT_SIZE_MAX = 300;
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
  
  audio.displaySoundObjects();
  mouseLight.display();
  
  
  // temp framerate display jic
  fill(200);
  textSize(20);
  text((int)frameRate, 10, 10);
}