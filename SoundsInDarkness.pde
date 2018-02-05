/*
  (sound toy)
  searching for sample loops in the dark

-some glitchiness when loading (actually reloading) lots of samples? (gc issue? can't do anything about it??)

max memory not quite right (can go over amount by up to 1 file's size)

doppler effect not quite right when going away? (ie rate down)

add realtime recording

adjustments and cleanup
*/


final int MAX_MEMORY = 50000000; //50 mb roughly

final int SOUND_SIZE = 20;

final int LIGHT_SIZE_MIN = 50;
final int LIGHT_SIZE_MAX = 700;
final int LIGHT_SIZE_INCREMENT = 10;



import beads.*;
import java.io.File;


MouseLight mouseLight;
Audio audio;

void setup()
{
  size(1000, 800); 
  background(0);
  ellipseMode(CENTER);
  noStroke();

  mouseLight = new MouseLight();
  audio = new Audio();
}


void draw() 
{
  background(0); 
 
  mouseLight.updatePosition(mouseX, mouseY);
  audio.updateSoundObjects(mouseX, mouseY);
  
  audio.playVisibleSounds();
  
  audio.displaySoundObjects();
  mouseLight.display();
  
 // println(Runtime.getRuntime().totalMemory());
 
}