
class NoteSymbol
{
  PVector pos;
  PVector speed;
  color col;
  
  float alpha;
  float minSpeed;
  
  public NoteSymbol(float x, float y, float a, color c)
  {
    pos = new PVector(x, y);
    speed = new PVector(-7, 0);
    alpha = a;
    col = c;
    
    minSpeed = -3; 
  }
  
  public void setDirection(float x, float y)
  {
    PVector direction = new PVector(x, y);
    direction.normalize();
    direction.mult(7);
    speed = direction;
  }
  
  public boolean update()
  {
    pos.add(speed);
    
    if (speed.x < minSpeed)
      speed.mult(0.98);
      
    alpha-=0.8;
    
    if (alpha<0)
      return false;
      
    return true;
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    noStroke();
    fill(col, alpha);
    ellipse(0, 0, 10, 10);
    
    popMatrix();
  }
  
}
