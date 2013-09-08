
class Circle
{
  PVector pos;
  float size;
  color c;
  
  public Circle(float x, float y, float s)
  {
    pos = new PVector(x, y);
    size = s;
    c = color(random(170, 220));
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    fill(c);
    noStroke();
    ellipse(0, 0, size, size);
    
    popMatrix();
  }
}
