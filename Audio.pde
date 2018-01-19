public class Audio 
{
  
  AudioContext ac;
  ArrayList<SamplePlayer> samplers;
  ArrayList<Gain> gains;
  ArrayList<Glide> gainGlides;
  ArrayList<Panner> pans;
  ArrayList<Glide> panGlides;
  ArrayList<Glide> rateGlides;
  
  ArrayList<SoundObject> soundObjects;
  
  boolean soundsMoving;
  
  
  Audio()
  {
    ac = new AudioContext();
    
    samplers = new ArrayList<SamplePlayer>();
    gains = new ArrayList<Gain>();
    gainGlides = new ArrayList<Glide>();
    pans = new ArrayList<Panner>();
    panGlides = new ArrayList<Glide>();
    rateGlides = new ArrayList<Glide>();
    
    soundObjects = new ArrayList<SoundObject>();
    soundsMoving = true;
    
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
      
      SamplePlayer thisSampler = samplers.get(index);
      thisSampler.pause(true);
      thisSampler.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
      thisSampler.setInterpolationType(SamplePlayer.InterpolationType.CUBIC);

      gainGlides.add(new Glide(ac, 0, 25));
      gains.add(new Gain(ac, 2, gainGlides.get(index)));
      
      panGlides.add(new Glide(ac, 0, 25));
      pans.add(new Panner(ac, panGlides.get(index)));
      
      rateGlides.add(new Glide(ac, 1, 25));
      
           
      
      gains.get(index).addInput(thisSampler);
      pans.get(index).addInput(gains.get(index));
      
      ac.out.addInput(pans.get(index));
    }
  }
  
  void createSoundObjects()
  {
    for (int i = 0; i < samplers.size(); i++) 
    {
      soundObjects.add(new SoundObject(i));
    }
  }
  
  
  void clearAndLoadNew()
  {
    //ac.out.pause(true);
    for (SamplePlayer sp: samplers)
    {
      sp.kill(); 
    }
    
    samplers.clear();
    gains.clear();
    gainGlides.clear();
    pans.clear();
    panGlides.clear();
    rateGlides.clear();
    
    soundObjects.clear();
    
    selectFolder("choose a folder of samples", "getDirectory", sketchFile(""), this);
  }
  
  
  void toggleMovement()
  {
    soundsMoving = !soundsMoving;

  }
  
  
  void updateSoundObjects(int _mouseX, int _mouseY)
  {
    for (SoundObject so: soundObjects)
    {
      if (soundsMoving)
      {
        so.updatePosition();
      }
      so.calcDistance(_mouseX, _mouseY);
      
    }
  }
  
  
  void playVisibleSounds()
  {
    for (int index = 0; index < soundObjects.size(); index++)
    {
      SoundObject thisObject = soundObjects.get(index);
      samplers.get(index).setRate(rateGlides.get(index));
        
      if (thisObject.getVisible())
      {
        gainGlides.get(index).setValue(thisObject.getGain());
        panGlides.get(index).setValue(thisObject.getPan());
        rateGlides.get(index).setValue(thisObject.getRate());
        println(thisObject.getRate());
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