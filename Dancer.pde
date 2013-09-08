class Dancer
{
  PVector pos;
  
  PVector pelvis;
  float bodyAngle;
  float bodyLength;
  
  float armLength;
  float arm1Angle;
  float arm2Angle;
  
  float headt;
  float arm1t;
  float arm2t;
  
  public Dancer(float x, float y)
  {
    pos = new PVector(x, y);
    
    bodyAngle = -PI/2;
    bodyLength = 25;
    pelvis = new PVector(0, -25);
    armLength = 25;
    arm1Angle = 0;
    arm2Angle = 0;
    
    headt = 0;
    arm1t = 0.3;
    arm2t = 0;
  }
  
  public void update()
  {
    headt += 0.05;
    arm1t += 0.05;
    arm2t += 0.05;
  }
  
  public void draw()
  {
    fill(colorScheme.getDark());
    
    pushMatrix();
    translate(pos.x, pos.y);
    
    line(-3, 0, pelvis.x, pelvis.y);
    line(3, 0, pelvis.x, pelvis.y);
    
    translate(pelvis.x, pelvis.y);
    rotate(bodyAngle + sin(headt)*0.3);
    line(0, 0, bodyLength, 0);
    
    translate(bodyLength, 0);
    ellipse(0, 0, 5, 5);
    
    translate(-5, 0);
    
    pushMatrix();
    rotate(arm1Angle + sin(headt+PI)*1);
    line(0, 0, armLength, 0);
    popMatrix();
    pushMatrix();
    rotate(arm2Angle + sin(headt+PI+0.3)*1);
    line(0, 0, armLength, 0);
    popMatrix();
    
    
    
    popMatrix();
  }
}
