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
  boolean doneLoading;
  
  String lastChosenDirectory;
  
  
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
        
    doneLoading = false;
    selectFolder("choose a folder of samples", "getDirectory", sketchFile(""), this);
    ac.start();
  }
  
  
  public void getDirectory(File selection)
  {
    if (selection == null)
    {
      println("Window was closed or the user hit cancel.");
    } 
    else
    {
      lastChosenDirectory = selection.getAbsolutePath();
      loadAllSamples(selection.getAbsolutePath());
      setupSamplers();
      createSoundObjects(); //<>//
      doneLoading = true;
      
    }  
  }
    
    
  void loadAllSamples(String path)
  {
    java.io.File folder = new java.io.File(path);
    String[] filenames = folder.list();
    int fileIndex = 0;
    int totalFileSize = 0;
    while (totalFileSize < MAX_MEMORY && fileIndex < filenames.length) {
      try 
      {      
        samplers.add(new SamplePlayer(ac, new Sample(path + "/" + filenames[fileIndex])));
        totalFileSize += new File(path + "/" + filenames[fileIndex]).length();
       
      }
      catch (Exception e)
      {
        println(filenames[fileIndex] + " is not a valid audio file");
      
      }
      finally {
        fileIndex += 1; 
      }
      
      
      
    }
    println("loaded " + samplers.size() + " samples");
    println("with a total of " + totalFileSize + " bytes");

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
      ac.out.start();
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
    ac.out.pause(true);
    for (SamplePlayer sp: samplers)
    {
      sp.kill(); 
    }
    
      
    doneLoading = false;
    
    samplers.clear();
    gains.clear();
    gainGlides.clear();
    pans.clear();
    panGlides.clear();
    rateGlides.clear();
    
    soundObjects.clear();

    
    selectFolder("choose a folder of samples", "getDirectory", sketchFile(lastChosenDirectory), this);
  }
  
  
  void toggleMovement()
  {
    soundsMoving = !soundsMoving;

  }
  
  
  void updateSoundObjects(int _mouseX, int _mouseY)
  {
    if (doneLoading)
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
  }
  
  
  void playVisibleSounds()
  {
    if (doneLoading)
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
          samplers.get(index).pause(false);         
        }
        else
        {
          samplers.get(index).pause(true); 
        }
      }
      
    }
    
  }
  
  
  void displaySoundObjects()
  {
    if (doneLoading)
    {
      for (SoundObject so: soundObjects)
      {
        so.display(); 
      }
    }
  }
  
}