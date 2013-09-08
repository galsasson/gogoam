
class Animator
{
  boolean playing;
  
  float start;
  float offset;
  float end;
  
  float inc;
  float x;
  
  int frames;
  
  
  float noiseTime = 0;
  
  public Animator()
  {
    init(0, 0, 1);
    
    noiseTime = random(100000);
  }
  
  public Animator(float s, float e, int c)
  {
    init(s, e, c);
    
    noiseTime = random(100000);
  }
  
  public void init(float s, float e, int f)
  {
    playing = false;
    
    start = s;
    end = e;
    frames = f;
    
    x = 0;
    offset = 0;
    inc = (float)1/frames;
  }
  
  public void initEaseIn(int f)
  {
    frames = f;
  }
  
  public void play()
  {
    playing = true;
  }
  
  public void stop()
  {
    playing = false;
  }
  
  public float getNextFrame()
  {
    // Real code:
    return start+offset;
  }
  
  public float getNoise()
  {
    // noise
    noiseTime += random(0, 0.005);
    float n = noise(noiseTime);
    n = (n<0) ? 0 : n;
    
    return n;    
  }
  
  public void update()
  {
    if (!playing)
      return;
      
    frames--;
    
    x += inc;
    
    // linear interpolation
    offset = (end-start)*x;

    if (frames==0)
      playing = false;
  }
}
