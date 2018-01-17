class MouseLight 
{
  
  int x, y;
  int size;
  
  MouseLight() 
  {
    size = 150; 
  }
  
  void setSize(int value) 
  {
    size -= value * LIGHT_SIZE_INCREMENT;
    if (size < LIGHT_SIZE_MIN) size = LIGHT_SIZE_MIN;
    else if (size > LIGHT_SIZE_MAX) size = LIGHT_SIZE_MAX;
  }
  
  int getSize()
  {
    return size; 
  }
  
  void updatePosition(int _mouseX, int _mouseY)
  {
    this.x = _mouseX;
    this.y = _mouseY;
  }
  
  void display()
  {
    fill(100, 5);
    for (int i = 1; i < 11; i ++) 
    {
      ellipse(x, y, size * i / 10, size * i / 10);
    }
  }
}


void mouseWheel(MouseEvent event)
{
  mouseLight.setSize(event.getCount());
}