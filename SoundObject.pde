class SoundObject
{
  int index;
  
  float x, y;
  float distance;
  float lastDistance;
  float angle;
  float speed;
  
  boolean visible;

  color myColor;
  
  SoundObject(int index)
  {
    this.index = index;
    x = random(SOUND_SIZE, width - SOUND_SIZE);
    y = random(SOUND_SIZE, height - SOUND_SIZE);
    visible = false;
    angle = 0;
    speed = random(2, 10);
    myColor = color(random(100, 255), random(100, 255), random(100, 255));
  }
  
  
  void calcDistance(int _mouseX, int _mouseY) {
    lastDistance = distance;
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
  
  float getPan()
  {
    if (x < mouseLight.x)
    { 
      return map(distance, 0, LIGHT_SIZE_MAX / 2, 0, -1);
    }
    else if (x > mouseLight.x)
    {
      return map(distance, 0, LIGHT_SIZE_MAX / 2, 0, 1);
    }
    else
    {
      return 0; 
    }
  }
  
  float getRate()
  {
    if (lastDistance > distance)
    { 
      
      return map(lastDistance - distance, 0, LIGHT_SIZE_MAX / 2, 1, 10);
    }
    else if (lastDistance < distance)
    {
      return map(distance - lastDistance, LIGHT_SIZE_MAX / 2, 0, .1, 1);
    }
    else
    {
      return 1; 
    }
  }
  
  void chooseDirection()
  {
    angle += randomGaussian() * random(QUARTER_PI / 4, QUARTER_PI / 2);;
  }
  
  
  void updatePosition()
  {
    if (random(100) > 50)     chooseDirection();
    x += cos(angle) * speed;
    y += sin(angle) * speed;
    keepOnScreen();
  }
  
  void keepOnScreen()
  {
    
    if (x < SOUND_SIZE / 2) x = SOUND_SIZE / 2;
    else if (x > width - SOUND_SIZE / 2) x = width - SOUND_SIZE / 2;
    else if (y < SOUND_SIZE / 2) y = SOUND_SIZE / 2;
    else if (y > height - SOUND_SIZE / 2) y = height - SOUND_SIZE / 2;
    else return;
    
    angle = angle + PI;
  }
  
  
  void display()
  {
    if (visible)
    {
      float myAlpha = map(mouseLight.getSize() / 2 - distance, 0, mouseLight.getSize() / 2, 0, 255);
      fill(myColor, myAlpha);
      ellipse(x, y, SOUND_SIZE, SOUND_SIZE);
    }
  }
}