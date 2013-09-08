
class RawPortal
{
  PVector pos;
  float height;
  
  public RawPortal(PVector p)
  {
    pos = p;
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    stroke(colorScheme.getDark());
    strokeWeight(2);
    noFill();
    
    arc(0, 0, 100, 100, -PI/2-1, -PI/2+1);
    arc(0, 0, 100, 100, PI/2-1, PI/2+1);
    
    fill(colorScheme.getDark());
    text("recycle", -20, 3);
    
    popMatrix();
  }
  
  public boolean pick(PVector p)
  {
    if (PVector.sub(p, pos).mag() < 50)
     return true;
    
    return false; 
  }
}
