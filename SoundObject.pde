class SoundObject
{
  
  float x, y;
  float distance;
  float angle;
  boolean visible;

  float angleRange;
  
  SoundObject()
  {
    x = random(SOUND_SIZE, width - SOUND_SIZE);
    y = random(SOUND_SIZE, height - SOUND_SIZE);
    visible = false;
    angle = 0;
    angleRange = random(QUARTER_PI, HALF_PI);
  }
  
  
  void calcDistance(int _mouseX, int _mouseY) {
    distance = dist(_mouseX, _mouseY, x, y);    
    visible = distance < mouseLight.getSize() / 2;
  }
  
  boolean getVisible()
  {
    return visible;
  }
  
  float getGain()
  {
    return map(distance, 0, mouseLight.getSize() / 2, 1.0, 0.0);
  }
  
  
  void chooseDirection()
  {
    angle += randomGaussian() * angleRange;
  }
  
  
  void walk()
  {
    chooseDirection();
    x += cos(angle);
    y += sin(angle);
    keepOnScreen();
  }
  
  void keepOnScreen()
  {
    //getting stuck
    if (x < SOUND_SIZE) x = SOUND_SIZE;
    else if (x > width - SOUND_SIZE) x = width - SOUND_SIZE;
    else if (y < SOUND_SIZE) y = SOUND_SIZE;
    else if (y > height - SOUND_SIZE) y = height - SOUND_SIZE;
    else return;
    
    angle = -angle;
  }
  
  void display()
  {
    if (visible)
    {
      fill(map(mouseLight.getSize() / 2 - distance, 0, mouseLight.getSize() / 2, 0, 255));
      ellipse(x, y, SOUND_SIZE, SOUND_SIZE);
    }
  }
}