
class NoteRing
{
  PVector pos;
  float size;
  float alpha;
  
  int frames;
  int counter;
  
  public NoteRing(PVector p, float s, int f)
  {
    pos = p;
    size = s;
    frames = f;
    counter = frames;
    
    alpha = 255;
  }
  
  public boolean update()
  {
    size += 3;
    if (alpha>0) {
      alpha-=255/frames;
      counter--;
      return true;
    }
    else             // we are dead
      return false;
  }
  
    
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    strokeWeight(2);
    stroke(0, 0, 0, alpha);
    ellipse(0, 0, size, size);
    
    popMatrix();
  }
  
}
