enum Direction {
  NONE, UP, DOWN, LEFT, RIGHT 
}


class SoundObject
{
  
  int x, y;
  float distance;
  Direction direction;
  boolean visible;
  
  SoundObject()
  {
    x = (int) random(0, width - SOUND_SIZE);
    y = (int) random(0, height - SOUND_SIZE);
    direction = Direction.values()[(int) random(Direction.values().length)];
    visible = false;
  }
  
  
  void calcDistance(int _mouseX, int _mouseY) {
    distance = dist(_mouseX, _mouseY, x, y);    
    visible = distance < mouseLight.getSize() / 2;
  }
  
  boolean getVisible()
  {
    return visible;
  }
  
  void walk()
  {
    
    float chance = random(100);
    if (chance > 75) 
    {
      direction = Direction.values()[(int) random(Direction.values().length)];
    }
    
    switch(direction)
    {
      case RIGHT: 
        x++;
        break;
      case LEFT: 
        x--;
        break;
      case DOWN: 
        y++;
        break;
      case UP: 
        y--;
        break;
      case NONE:
        break;
    }
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