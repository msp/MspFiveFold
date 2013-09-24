import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;

Polygon[] polys = new Polygon[300];

final int numSides = 5;
int h, s, b = 0;
float a = 0;

void setup()
{
  try {
    size(600, 600);
    smooth();
    noStroke();
    fill(255);
  
    textFont(createFont("Helvetica", 16));
    textAlign(CENTER);
  
    for(int i=0; i<polys.length; i++) {
      float x = width/2 + cos(i/2.0) * i;
      float y = height/2 + sin(i/2.0) * i;
      polys[i] = new Polygon(numSides, x, y, (int)x, 0.05 + (i/2000.0) );
      // stop animation
      //polys[i] = new Polygon(numSides, x, y, (int)x, 0 );
    }
      
    setupMinim();

  } catch (Exception e) {
    e.printStackTrace();
    println("Error running setup!"); 
  }
  
}

void draw()
{ 
  background(51);
  noStroke();
  colorMode(HSB);

  for(int i=0; i<polys.length; i++) {
    h = i/2;
    s = 80 + i;
    b = 200 + i;
        
    a = map(80, 20, 80, 60, 255);
    fill(h, s, b, a);

    polys[i].draw();
  }
}

void setupMinim() {
  
  try {    
    minim = new Minim(this);
  
    song = minim.loadFile("prelude_pre.mp3", 1024);
    song.play();
    // a beat detection object that is FREQ_ENERGY mode that 
    // expects buffers the length of song's buffer size
    // and samples captured at songs's sample rate
    // beat = new BeatDetect(song.bufferSize(), song.sampleRate());
    // set the sensitivity to 300 milliseconds
    // After a beat has been detected, the algorithm will wait for 300 milliseconds 
    // before allowing another beat to be reported. You can use this to dampen the 
    // algorithm if it is giving too many false-positives. The default value is 10, 
    // which is essentially no damping. If you try to set the sensitivity to a negative value, 
    // an error will be reported and it will be set to 10 instead. 
    // beat.setSensitivity(50);  
    // kickSize = snareSize = hatSize = 16;
    // make a new beat listener, so that we won't miss any buffers for the analysis
    // bl = new BeatListener(beat, song);
  } catch (Exception e) {
    e.printStackTrace();
    println("Error setting up Minim!"); 
  }
}
class BeatListener implements AudioListener
{
  private BeatDetect beat;
  private AudioPlayer source;
  
  BeatListener(BeatDetect beat, AudioPlayer source)
  {
    this.source = source;
    this.source.addListener(this);
    this.beat = beat;
  }
  
  void samples(float[] samps)
  {
    beat.detect(source.mix);
  }
  
  void samples(float[] sampsL, float[] sampsR)
  {
    beat.detect(source.mix);
  }
}
class Polygon {

  protected int n;
  protected int rotation;
  protected float cx;
  protected float cy;
  protected float w;
  protected float h;
  protected float time, speed;
  protected float startAngle;

  public Polygon(int _sides, float _x, float _y, int _rotation, float _speed) {
    n = _sides;
    startAngle = -PI / 2;
    w = 100;
    h = 100;
    cx = _x;
    cy = _y;
    rotation = _rotation;
    speed = _speed;
    time = 0;
  }

  void draw(int _rotation) {
    rotation = _rotation;
    draw();  
  }
  
  void draw()
  {
    float angle = TWO_PI/ n;
    float sz = map(sin(time), -1, 1, 5, 15);
    w = sz;
    h = sz;

    pushMatrix();
    translate(cx, cy);    
    rotate(radians(rotation));   

    beginShape();
    for (int i = 0; i < n; i++)
    {
      vertex(w * cos(startAngle + angle * i), 
      h * sin(startAngle + angle * i));
    }
    endShape(CLOSE);
    
    popMatrix();
    
    time = time + speed;
  }
}


