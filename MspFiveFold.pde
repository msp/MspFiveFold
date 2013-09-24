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
