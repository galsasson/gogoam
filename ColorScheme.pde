
class ColorScheme
{
  Animator animH;
  Animator animS;
  Animator animB;
  
  public ColorScheme()
  {
    animH = new Animator(0, 0, 1);
    animS = new Animator(0, 0, 1);
    animB = new Animator(220, 220, 1);
  }
  
  public color getDark()
  {
    return color(35);
  }
  
  public color getLight()
  {
    return color(220);
  }
  
  public color getBackground()
  {
    return color(animH.getNextFrame(), animS.getNextFrame(), animB.getNextFrame());
  }
  
  public color getNoteColor(float pitch)
  {
    return color(map(pitch, 0, 1, 0, 360), 200, 200);
  }
  
  public color getLaserColor()
  {
    return color(0, 190, 150);
  }
  
  public void startFlip(color target, int frames)
  {
    animH.init(animH.getNextFrame(), hue(target), frames);
    animS.init(animS.getNextFrame(), saturation(target), frames);
    animB.init(animB.getNextFrame(), brightness(target), frames);
    animH.play();
    animS.play();
    animB.play();
  }
  
  public void update()
  {
    animH.update();
    animS.update();
    animB.update();
  }
}
