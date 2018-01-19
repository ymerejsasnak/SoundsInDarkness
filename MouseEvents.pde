void mousePressed()
{
  // unload all + load new
  if (mouseButton == LEFT)
  {
    audio.clearAndLoadNew();
  }
  else if (mouseButton == RIGHT)
  {
    audio.toggleMovement(); 
  }
}


void mouseWheel(MouseEvent event)
{
  mouseLight.setSize(event.getCount());
}