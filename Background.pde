import java.util.Random;
import java.util.Collections;
import java.util.Comparator;

class Background
{
  ArrayList<Circle> circles;
  PVector pos;
  float speed;
  float maxSpeed;
  Random rand;
  
  public Background(int num, float minSize, float maxSize)
  {
    rand = new Random();
    speed = 0;
    pos = new PVector(0, 0);
    circles = new ArrayList<Circle>();
    
    float mean = minSize + (maxSize - minSize)/2;
    for (int i=0; i<num; i++)
    {
      circles.add(new Circle(width+random(width), random(height), (float)rand.nextGaussian() * (maxSize - minSize) + mean));
    }
    maxSpeed = 2;
  }
  
  public void setSpeed(float s)
  {
    speed = s;
    
    if (speed > maxSpeed)
      speed = maxSpeed;
  }
  
  public void update()
  {
    pos.x -= speed;
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);

    for (Circle c : circles)
    {
      c.draw();
      if (pos.x + c.pos.x < 0) {
        c.pos.x += width+c.size;
        c.pos.y = random(height);
      }
        
    }
        
    popMatrix();
  }
}
