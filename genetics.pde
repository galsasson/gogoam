
import themidibus.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

MidiBus myBus;
VerletPhysics2D physics;

Background[] back;

ArrayList<Creature> creatures;
Creature mouseCreature = null;

ArrayList<Player> players;

RawPortal rawPortal;

int beatCounter;
int colorFlipCounter;
int beatsPerColorFlip;

boolean systemReady = false;
PFont font;

//Dancer dancer;

ColorScheme colorScheme;

void setup()
{
  size(1280, 800);
  colorMode(HSB);
  smooth();
  frameRate(60);
  
  font = loadFont("ShareTech-Regular-16.vlw");
  
  myBus = new MidiBus(this, 0, 0);
  physics = new VerletPhysics2D();
  
  physics.setWorldBounds(new Rect(0,0,width,height));

  back = new Background[3];
  back[0] = new Background(1000, 1, 3);
  back[1] = new Background(10, 15, 18);
  back[2] = new Background(3, 30, 40);
  
  colorScheme = new ColorScheme();
  rawPortal = new RawPortal(new PVector(80, height-130));
  beatCounter = 0;
  
  // setup player on a circle outline
  players = new ArrayList<Player>();
  
  players.add(new Player(width-200, height-120, "Brass-Soft", -1));
  players.add(new Player(width-200, height-220, "Pad-Fat", -1));
  players.add(new Player(width-200, height-320, "Guitar-Balladeer", -1));
  players.add(new Player(width-200, height-420, "Guitar-Balladeer", 0));
  players.add(new Player(width-200, height-520, "Guitar-Kon", 2));
  players.add(new Player(width-200, height-620, "Guitar-Reg", 0));
  players.add(new Player(width-200, height-720, "Guitar-Reg-Fast", 1));
  
  creatures = new ArrayList<Creature>();
  for (int i=0; i<4; i++)
  {
    for (int j=0; j<4; j++)
    {
      Creature c = new Creature(150 + i*80, height/2-2*80 + j*80);
      c.initRandom();
      addCreature(c);
    }
  }
  
  /* Add the "GOGOAM" logo */
  String logo = "GOGOAM";
  for (int i=0; i<logo.length(); i++)
  {
    Creature c = new Creature(50+i*32, 50);
    c.initAsLetter(logo.charAt(i));
    addCreature(c);
  }

  systemReady = true;
}

void addCreature(Creature c)
{
    physics.addParticle(c);
    c.lock();
//    c.addBehavior(new AttractionBehavior(c, SIZE, -0.3));
//    physics.addBehavior(new AttractionBehavior(c, SIZE, -0.3));
    creatures.add(c);
}

void draw()
{
  int totalNotes = 0;

  background(colorScheme.getBackground());
  
  for (Background b : back)
  {
    b.update();
    b.draw();
  }
  
//  physics.update();
//  colorScheme.update();

  for (Creature c : creatures)
  {
    c.updateAnimation();
    c.draw();
  }
  
  for (Player p : players)
  {
    p.update();
    p.draw();
    totalNotes += p.getNumOfNotes();
  }
  
  rawPortal.draw();
  
  // update the force of the background
  back[0].setSpeed((float)totalNotes/600);
  back[1].setSpeed((float)totalNotes/300);
  back[2].setSpeed((float)totalNotes/200);
}

void mousePressed()
{
  for (Creature c : creatures)
  {
    if (c.pick(new Vec2D(mouseX, mouseY)))
    {
      mouseCreature = c;
      c.lock();     
      c.set(mouseX, mouseY);
      if (c.isRawType)
        c.setToCreature();
//      c.removeAllBehaviors();
      
      /* check if grabbed a creature from a player */
      for (Player p : players)
      {
        if (p.getCreature() == mouseCreature)
        {
          p.empty();
          mouseCreature.rotation = 0;
        }
      }
      
      return;
    }
  }
}

void mouseDragged()
{
  if (mouseCreature == null)
    return;
    
  mouseCreature.set(mouseX, mouseY);
}

void mouseReleased()
{
  if (mouseCreature == null)
    return;
    
  //mouseCreature.animateToOrig();
  //mouseCreature.unlock();
/*  
  // mate two creatures
  for (int i=0; i<creatures.size(); i++)
  {
    if (creatures.get(i) != mouseCreature && creatures.get(i).pick(new Vec2D(mouseX, mouseY)))
    {
      Creature newc = mouseCreature.mate(creatures.get(i));
      newc.set(creatures.get(i).add(0, 60));
      mouseCreature.subSelf(40, 0);
      creatures.get(i).addSelf(40, 0);
      addCreature(newc);
    }
  }
*/
  for (Player p : players)
  {
    if (p.pick(new PVector(mouseX, mouseY)))
    {
//      mouseCreature.lock();
      p.setCreature(mouseCreature);
    }
  }
  
  if (rawPortal.pick(new PVector(mouseX, mouseY)))
  {
    mouseCreature.set(rawPortal.pos.x, rawPortal.pos.y);
    mouseCreature.setToRaw();
  }
  
  mouseCreature = null;
}


void rawMidi(byte[] data) {
  if (!systemReady)
    return;
    
  /* start beat message */
  if (data[0] == (byte)0xfa) {
    for (Player p : players)
    {
      p.setBeat();
    }
    beatCounter = 0;
    colorFlipCounter = 0;
    beatsPerColorFlip = 24*2;
  }
  
   /* clock message */
  if (data[0] == (byte)0xf8) {
    beatCounter++;
    colorFlipCounter++;
    if (beatCounter==24*4) {
      beatCounter = 0;
    }
    
    /* tell players to emit sound */
    for (Player p : players)
    {
      p.beat();
    }

    /* beat animation */
    if (beatCounter == 24*4-20)
    {
      for (Creature c : creatures)
      {
        c.animateToBeat(0.3, 20);
      }
    }
    else if (beatCounter == 24*4-2)
    {
      for (Creature c : creatures)
      {
        c.animateFromBeat(0.3, 4);
      }
    }
    
    /* off beat animation */
    if (beatCounter == 24*2-10)
    {
      for (Creature c : creatures)
      {
        c.animateToBeat(0.2, 20);
      }
    }
    else if (beatCounter == 24*2-3)
    {
      for (Creature c : creatures)
      {
        c.animateFromBeat(0.2, 4);
      }
    }
    
  }
}

public void doTransitions()
{
  int activePlayers = 0;
  for (Player p : players)
  {
    if (p.getCreature() != null)
      activePlayers++;
  }
  
}

