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
    fill(100, 20);
    ellipse(x, y, size, size);
    ellipse(x, y, size / 3 * 2, size / 3 * 2);
    ellipse(x, y, size / 3, size / 3);
  }
}


void mouseWheel(MouseEvent event)
{
  mouseLight.setSize(event.getCount());
}