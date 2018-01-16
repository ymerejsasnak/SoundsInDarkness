public class Audio 
{
  
  AudioContext ac;
  ArrayList<SamplePlayer> samplers;
  
  
  Audio()
  {
    ac = new AudioContext();
    samplers = new ArrayList<SamplePlayer>();
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
    }  
  }
    
    
  void loadAllSamples(String path)
  {
    java.io.File folder = new java.io.File(path);
    String[] filenames = folder.list();
    for (int i = 0; i < filenames.length; i++) {
      try 
      {      
        samplers.add(new SamplePlayer(ac, new Sample(path + "/" + filenames[i])));//SampleManager.sample(filenames[i]));
      }
      catch (Exception e)
      {
        println(filenames[i] + " is not a valid audio file");
      }
    }
    println("loaded " + samplers.size() + " samples");
  }
  
}