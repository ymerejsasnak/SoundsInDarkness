public class Audio 
{
  
  AudioContext ac;
  ArrayList<SamplePlayer> samplers;
  ArrayList<Gain> gains;
  //gain glides too?
  ArrayList<SoundObject> soundObjects;
  
  
  Audio()
  {
    ac = new AudioContext();
    samplers = new ArrayList<SamplePlayer>();
    gains = new ArrayList<Gain>();
    soundObjects = new ArrayList<SoundObject>();
    ac.start();
    
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
      setupSamplers();
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
  
  
  void setupSamplers() 
  {
    for (int index = 0; index < samplers.size(); index++)
    {
      gains.add(new Gain(ac, 2, 1));
      samplers.get(index).pause(true);
      samplers.get(index).setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
      gains.get(index).addInput(samplers.get(index));
      ac.out.addInput(gains.get(index));
    }
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
      so.updatePosition();
      so.calcDistance(_mouseX, _mouseY);
    }
  }
  
  
  void playVisibleSounds()
  {
    for (int index = 0; index < soundObjects.size(); index++)
    {
      if (soundObjects.get(index).getVisible())
      {
        gains.get(index).setGain(soundObjects.get(index).getGain());
        samplers.get(index).pause(false); 
      }
      else
      {
        samplers.get(index).pause(true); 
      }
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