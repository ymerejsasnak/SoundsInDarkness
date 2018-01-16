public class Audio 
{
  
  AudioContext ac;
  ArrayList<SamplePlayer> samplers;
  ArrayList<SoundObject> soundObjects;
  
  
  Audio()
  {
    ac = new AudioContext();
    samplers = new ArrayList<SamplePlayer>();
    soundObjects = new ArrayList<SoundObject>();
    
    selectFolder("choose a folder of samples", "getDirectory", sketchFile(""), this);
  }
  
  
  public void getDirectory(File selection)
  {
    if (selection == null)
    {
      println("Window was closed or the user hit cancel.");
    } 
    else
    {
      loadAllSamples(selection.getAbsolutePath());
      createSoundObjects();
    }  
  }
    
    
  void loadAllSamples(String path)
  {
    java.io.File folder = new java.io.File(path);
    String[] filenames = folder.list();
    for (int i = 0; i < filenames.length; i++) {
      try 
      {      
        samplers.add(new SamplePlayer(ac, SampleManager.sample(path + "/" + filenames[i])));
      }
      catch (Exception e)
      {
        println(filenames[i] + " is not a valid audio file");
      }
    }
    println("loaded " + samplers.size() + " samples");
  }
  
  
  void createSoundObjects()
  {
    for (int i = 0; i < samplers.size(); i++) 
    {
      soundObjects.add(new SoundObject());
    }
  }
  
  
  void updateSoundObjects(int _mouseX, int _mouseY)
  {
    for (SoundObject so: soundObjects)
    {
      so.calcDistance(_mouseX, _mouseY);
    }
  }
  
  
  void displaySoundObjects()
  {
    for (SoundObject so: soundObjects)
    {
      so.display(); 
    }
  }
  
}