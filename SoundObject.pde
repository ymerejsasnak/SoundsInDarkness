class SoundObject
{
  
  int x, y;
  float distance;
  
  SoundObject()
  {
    x = (int) random(0, width - SOUND_SIZE);
    y = (int) random(0, height - SOUND_SIZE);
  }
  
  
  void calcDistance(int _mouseX, int _mouseY) {
    distance = dist(_mouseX, _mouseY, x, y);    
  }
  
  
  void display()
  {
    if (distance < mouseLight.getSize() / 2)
    {
      fill(map(mouseLight.getSize() / 2 - distance, 0, mouseLight.getSize() / 2, 0, 255));
      ellipse(x, y, SOUND_SIZE, SOUND_SIZE);
    }
  }
}