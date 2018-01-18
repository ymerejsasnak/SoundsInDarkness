void mousePressed()
{
  // unload all + load new
  if (mouseButton == LEFT)
  {
    audio.clearAndLoadNew();
  }
}


void mouseWheel(MouseEvent event)
{
  mouseLight.setSize(event.getCount());
}