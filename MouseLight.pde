class MouseLight 
{
  
  int x, y;
  int radius;
  
  MouseLight() 
  {
    radius = 60; 
  }
  
  void setRadius(int value) 
  {
    radius -= value * RADIUS_SCALING;
    if (radius < RADIUS_MIN) radius = RADIUS_MIN;
    else if (radius > RADIUS_MAX) radius = RADIUS_MAX;
  }
  
  void updatePosition()
  {
    this.x = mouseX;
    this.y = mouseY;
  }
  
  void display()
  {
    fill(200, 20);
    ellipse(x, y, radius * 2, radius * 2);
  }
}


void mouseWheel(MouseEvent event)
{
  mouseLight.setRadius(event.getCount());
}