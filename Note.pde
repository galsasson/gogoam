class Note extends Thread
{
  int noteVal;
  int volume;
  int channel;
  int timeMs;
  
  public Note(int val, int vol, int chan, int t)
  {
    noteVal = val;
    volume = vol;
    channel = chan;
    timeMs = t;
  }
  
  public void run()
  {
    try
    {
      Thread.sleep((int)random(5));
      playNote();
    
      Thread.sleep(timeMs);
    
      stopNote();
    }
    catch (Exception e){
    }

  }
  
  private void play()
  {
    start();
  }
  
  private void playNote()
  {
    myBus.sendNoteOn(channel, noteVal, volume);
  }
  
  public void stopNote()
  {
    myBus.sendNoteOff(channel, noteVal, volume);
  }
  
  
  
}

