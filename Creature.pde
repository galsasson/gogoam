int MAX_AGE = 16;
float SIZE = 50;

class Creature extends VerletParticle2D
{
//  public PVector pos;
  public float age;
  float rotation;
  
  Genome genome;
  ShapeMorpher morpher;
  
  boolean isRawType;
  
  boolean closeShape;
  boolean isLetter;
  
  public Creature(float x, float y)
  {
    super(x, y);
    age = MAX_AGE;
    rotation = 0;
    isRawType = false;
    closeShape = true;
    
    genome = new Genome();
    morpher = new ShapeMorpher();
  }
  
  public void initRandom()
  {
    genome.initRandom();
    closeShape = false;
    isLetter = false;
    
    morpher = new ShapeMorpher();
    morpher.initMorph(genome.shape, genome.shape, 0, 0, 1);
  }
  
  public void initAsLetter(char ch)
  {
    switch(ch)
    {
      case 'G':
        genome.initAsG();
        break;
      case 'O':
        genome.initAsO();
        break;
      case 'A':
        genome.initAsA();
        break;
      case 'M':
        genome.initAsM();
        break;
    }
    
    closeShape = false;
    isLetter = true;
    morpher.initMorph(genome.shape, genome.shape, 0, 0, 1);
  }
  
  public void setToRaw()
  {
    closeShape = true;
    isRawType = true;
    morpher.initMorph(genome.shape, morpher.circle, 0, 1, 20);
  }
  
  public void setToCreature()
  {
    initRandom();
    morpher.initMorph(morpher.circle, genome.shape, 0, 1, 20);
    isRawType = false;
  }

  public void updateAnimation()
  {
    morpher.update();
  }

  public void draw()
  {
    pushMatrix();
    translate(x, y);  
    g.rotate(rotation);

    // draw circle for visualization
//    drawCircle();
    
    noFill();
    if (isLetter) {
      stroke(colorScheme.getDark(), 100);
      strokeWeight(1);
    }
    else {
      stroke(colorScheme.getDark());
      strokeWeight(2);
    }
    beginShape();
    for (int i=0; i<(int)age; i++)
    {
      PVector shapePoint = morpher.getPoint(i);
      PVector p;
      if (isLetter) {
        p = shapePoint;
      } else {
        p = PVector.add(shapePoint, genome.distortion.get(i).get(frameCount%30));
      }
      vertex(p.x, p.y);
    }

    if (closeShape)
    {
      PVector shapePoint = morpher.getPoint(0);
      vertex(shapePoint.x + genome.distortion.get(0).get(frameCount%30).x,
                  shapePoint.y + genome.distortion.get(0).get(frameCount%30).y);
    }
    
    endShape();
    
    popMatrix();
  }
  
  private void drawCircle()
  {
    strokeWeight(1);
    stroke(160);
    
    float a = 0;
    while(a<PI*2)
    {
      line(0, 0, 50, 0);
      a += PI/8;
      g.rotate(PI/8);
    }
    println(a);
    
  }
  
  public PVector getPointPos(int index)
  {
      PVector shapePoint = morpher.getPoint(index);
      PVector p;
      if (isLetter) {
        p = shapePoint;
      } else {
        p = PVector.add(shapePoint, genome.distortion.get(index).get(frameCount%30));
      }
      return p;
  }
  
  public boolean pick(Vec2D p)
  {
    if (distanceTo(p) < SIZE-25) {
      return true;
    }
    
    return false;
  }
  
  public void animateToBeat(float amount, int frames)
  {
    if (isRawType)
      return;
    
    morpher.initMorph(genome.shape, morpher.circle, 0, amount, frames);
  }
  
  public void animateFromBeat(float fromAmount, int frames)
  {
    if (isRawType)
      return;
      
    morpher.initMorph(genome.shape, morpher.circle, fromAmount, 0, frames);
  }
  
  public void animateToMale(int frames)
  {
    if (isRawType)
      return;
      
    morpher.initMorph(genome.shape, morpher.male, 0, 1, frames);
  }
  
  public Creature mate(Creature c)
  {
    Creature newC = new Creature(x, y);
    newC.genome = genome.crossover(c.genome);
    newC.genome.mutate(0);

    return newC;
  }
  
  public Creature clone()
  {
    Creature c = new Creature(x, y);
    c.age = age;
    
    c.genome = genome.clone();
    
    return c;
  }
}

