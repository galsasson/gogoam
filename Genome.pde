

class Genome
{
  public ArrayList<PVector> shape;
  public ArrayList<ArrayList<PVector>> distortion;
  public int[] volume;
  
  public Genome()
  {
    shape = new ArrayList<PVector>();
    distortion = new ArrayList<ArrayList<PVector>>();
    volume = new int[360];
    initVolume();
  }
  
  public void initRandom()
  {
    float distortionLevel = random(3, 7);
    float spikynessLevel = random(0);
    initShape(spikynessLevel);
    initDistortion(distortionLevel);
  }
  
  public void initAsG()
  {
    /* init G shape */
    for (int i=0; i<4; i++)
      shape.add(new PVector(12-i*5, -20));
    for (int i=0; i<4; i++)
      shape.add(new PVector(-12, -20+i*5));
    for (int i=0; i<4; i++)
      shape.add(new PVector(-12+i*5, 20));
    for (int i=0; i<2; i++)
      shape.add(new PVector(12, 20-i*5));
    shape.add(new PVector(12, 5));
    shape.add(new PVector(0, 5));
    
    initDistortion(random(2, 4));
  }
  
  public void initAsO()
  {
    for (int i=0; i<4; i++)
      shape.add(new PVector(12-i*5, -20));
    for (int i=0; i<4; i++)
      shape.add(new PVector(-12, -20+i*5));
    for (int i=0; i<4; i++)
      shape.add(new PVector(-12+i*5, 20));
    for (int i=0; i<3; i++)
      shape.add(new PVector(12, 20-i*5));    
    shape.add(new PVector(12, -20));
    
    initDistortion(random(2, 4));
  }
  
  public void initAsA()
  {
    for (int i=0; i<2; i++)
      shape.add(new PVector(-12, 20-i*5));
    for (int i=0; i<2; i++)
      shape.add(new PVector(-12+i*5, -20));
    for (int i=0; i<2; i++)
      shape.add(new PVector(12, -20+i*5));
    for (int i=0; i<3; i++)
      shape.add(new PVector(12-i*5, 5));
    for (int i=0; i<3; i++)
      shape.add(new PVector(-12+i*5, 5));
    for (int i=0; i<3; i++)
      shape.add(new PVector(12, 5+i*5));  
    shape.add(new PVector(12, 20));
    
    initDistortion(random(2, 4));
  }
  
  public void initAsM()
  {
    for (int i=0; i<4; i++)
      shape.add(new PVector(-12, 20-i*5));
    for (int i=0; i<3; i++)
      shape.add(new PVector(-12+i*3, -20+i*4));
    for (int i=0; i<4; i++)
      shape.add(new PVector(0+i*3, -5-i*4));
    for (int i=0; i<4; i++)
      shape.add(new PVector(12, -20+i*5));
    shape.add(new PVector(12, 20));
    
    initDistortion(random(2, 4));
  }

  public Genome clone()
  {
    Genome g = new Genome();
    g.shape = new ArrayList<PVector>();
    
    for (PVector p : shape)
    {
      g.shape.add(p.get());
    }
    
    g.distortion = new ArrayList<ArrayList<PVector>>();
    for (ArrayList<PVector> arr : distortion)
    {
      ArrayList<PVector> vertexDistortion = new ArrayList<PVector>();
      
      for (PVector p : arr)
      {
        vertexDistortion.add(p.get());
      }
      
      g.distortion.add(vertexDistortion);
    }

    return g;
  }
  
  public Genome crossover(Genome c2)
  {
    Genome newGen = new Genome();
    
    /* crossover creature shape */
    int switchOn = int(random(shape.size()/4, shape.size()*3/4));
    for (int i=0; i<shape.size(); i++)
    {
      if (i<switchOn)
        newGen.shape.add(shape.get(i).get());
      else
        newGen.shape.add(c2.shape.get(i).get());
    }
    
    /* crossover distortion */
    for (int v=0; v<distortion.size(); v++)
    {
      ArrayList<PVector> vm1 = distortion.get(v);
      ArrayList<PVector> vm2 = c2.distortion.get(v);      
      ArrayList<PVector> newVertexMotion = new ArrayList<PVector>();
      
      switchOn = int(random(vm1.size()));
      for (int i=0; i<vm1.size(); i++)
      {
        if (i<switchOn)
          newVertexMotion.add(vm1.get(i).get());
        else
          newVertexMotion.add(vm2.get(i).get());
      }
      
      newGen.distortion.add(newVertexMotion);
    }
    
    return newGen;
  }
  
    public Genome crossover2(Genome c2)
  {
    Genome newGen = new Genome();
    
    /* crossover creature shape */
    int switchOn = int(random(SIZE/4, shape.size()*3/4));
    for (int i=0; i<shape.size(); i++)
    {
      if (random(1)<0.5/*switchOn*/)
        newGen.shape.add(shape.get(i).get());
      else
        newGen.shape.add(c2.shape.get(i).get());
    }
    
    /* crossover distortion */
    for (int v=0; v<distortion.size(); v++)
    {
      ArrayList<PVector> vm1 = distortion.get(v);
      ArrayList<PVector> vm2 = c2.distortion.get(v);      
      ArrayList<PVector> newVertexMotion = new ArrayList<PVector>();
      
      switchOn = int(random(vm1.size()));
      for (int i=0; i<vm1.size(); i++)
      {
        if (i<switchOn)
          newVertexMotion.add(vm1.get(i).get());
        else
          newVertexMotion.add(vm2.get(i).get());
      }
      
      newGen.distortion.add(newVertexMotion);
    }
    
    return newGen;
  }

  
  public void mutate(float m)
  {
    for (int i=0; i<shape.size(); i++)
    {
      if (random(1) < m)
      {
        /* mutate */
        if (i%2==0)
          shape.get(i).x = random(-SIZE/2, SIZE/2);
        else
          shape.get(i).y = random(-SIZE/2, SIZE/2);
      }
    }
  }
  
  private void initShape(float spikynessLevel)
  {
    shape = new ArrayList<PVector>();

    float x = random(-SIZE/2, SIZE/2);
    float y = random(-SIZE/2, SIZE/2);
    shape.add(new PVector(x, y));

    for (int i=1; i<MAX_AGE; i++) {
      if (i%2 == 0) {
        x = random(-SIZE/2, SIZE/2);
        if (random(1) < spikynessLevel)
          y = random(-SIZE/2, SIZE/2);
      }
      else {
        y = random(-SIZE/2, SIZE/2);
        if (random(1) < spikynessLevel)
          x = random(-SIZE/2, SIZE/2);
      }

      shape.add(new PVector(x, y));
    }
  }

  private void initDistortion(float distortionLevel)
  {
    distortion = new ArrayList<ArrayList<PVector>>();
    float tTime = random(10000);
    float tX = random(10000);
    float tY = random(10000);

    for (int i=0; i<MAX_AGE; i++)
    {
      ArrayList<PVector> vertexDistortion = new ArrayList<PVector>();
      
      // for every vertex, calculate movement
      for (int t=0; t<27; t++)
      {
        vertexDistortion.add(new PVector((noise(tX)-0.5)*distortionLevel, (noise(tY)-0.5)*distortionLevel));
        tX += 0.1;
        tY += 0.1;
      }
      
      /* make ease into the first */
      PVector diff = PVector.sub(vertexDistortion.get(0), vertexDistortion.get(26));
      diff.div(4);
      
      vertexDistortion.add(PVector.add(vertexDistortion.get(26), diff));
      vertexDistortion.add(PVector.add(vertexDistortion.get(27), diff));
      vertexDistortion.add(PVector.add(vertexDistortion.get(28), diff));
      
      distortion.add(vertexDistortion);
    }
  }
  
  private void initVolume()
  {
    for (int i=0; i<volume.length; i++)
    {
      volume[i] = (int)random(128);
    }
  }
  
  public int getVolume(float ang)
  {
    int angle = (int)degrees(ang);
    int vol = volume[angle%360];
    if (vol > 30)
      return vol;
    else
      return 0;
  }
  

}
