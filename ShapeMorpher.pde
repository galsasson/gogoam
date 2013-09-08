
class ShapeMorpher
{
  public ArrayList<PVector> circle;
  public ArrayList<PVector> point;
  public ArrayList<PVector> male;
  
  Animator anim;
  ArrayList<PVector> fromShape;
  ArrayList<PVector> toShape;
  
  public ShapeMorpher()
  {
    initCircle();
    initPoint();
    initMale();
    
    anim = new Animator();
    fromShape = null;
    toShape = null;
  }
  
  public void initMorph(ArrayList<PVector> s1, ArrayList<PVector> s2, float start, float end, int frames)
  {
    this.fromShape = s1;
    this.toShape = s2;
    anim.init(start, end, frames);
    anim.play();
  }
  
  public PVector getPoint(int index)
  {
    PVector diff = PVector.sub(toShape.get(index), fromShape.get(index));
    return PVector.add(fromShape.get(index), PVector.mult(diff, anim.getNextFrame()));
  }
  
  public void update()
  {
    anim.update();
  }
  
    private void initCircle()
  {    
    circle = new ArrayList<PVector>();
    
    PVector origin = new PVector(0, SIZE/2);
    
    float angInc = ((PI*2) / MAX_AGE);
    for (int i=0; i<MAX_AGE; i++)
    {
      origin.rotate(angInc);
      circle.add(origin.get());
    }
  }
  
  private void initPoint()
  {
    point = new ArrayList<PVector>();
    
    for (int i=0; i<MAX_AGE; i++)
      point.add(new PVector(0, 0));
  }
  
  private void initMale()
  {
    male = new ArrayList<PVector>();
    
    male.add(new PVector(-15,-15));
    male.add(new PVector(-5,-15));
    male.add(new PVector(5,-15));
    male.add(new PVector(15,-15));
    male.add(new PVector(15,-5));
    male.add(new PVector(15,5));
    male.add(new PVector(15,15));
    male.add(new PVector(0,15));
    male.add(new PVector(-15,15));
    male.add(new PVector(-15,5));
    male.add(new PVector(-5,5));
    male.add(new PVector(5,5));
    male.add(new PVector(5,-5));
    male.add(new PVector(-5,-5));
    male.add(new PVector(-15,-5));
    male.add(new PVector(-15,-15));
  }
}
