import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;
BeatListener bl;

ArrayList<Hexagon> shapes;
int numberCols = 8;
int numberShapes = 8;
int size = 50;
int x, y, h, s, b = 0;

void setup()
{
  background(51);
  
  size(1000, 900, P3D);  
  textAlign(CENTER);

  shapes = new ArrayList<Hexagon>();
 
  noStroke();
  colorMode(HSB);
  for (int i = 1; i <= numberCols; i++) {
    for (int j = 1; j <= numberShapes; j++) {
      x = i * (size * 2);
      y = j * (size + 37);
      Hexagon hex = new Hexagon(this, x, y, size);
      shapes.add(hex);      
    }
  }
  
  minim = new Minim(this);
  
  song = minim.loadFile("ADEN_-_MOVE.mp3", 1024);
  song.play();
  // a beat detection object that is FREQ_ENERGY mode that 
  // expects buffers the length of song's buffer size
  // and samples captured at songs's sample rate
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  // set the sensitivity to 300 milliseconds
  // After a beat has been detected, the algorithm will wait for 300 milliseconds 
  // before allowing another beat to be reported. You can use this to dampen the 
  // algorithm if it is giving too many false-positives. The default value is 10, 
  // which is essentially no damping. If you try to set the sensitivity to a negative value, 
  // an error will be reported and it will be set to 10 instead. 
  beat.setSensitivity(30);  
  // make a new beat listener, so that we won't miss any buffers for the analysis
  bl = new BeatListener(beat, song);  
  
}

void draw()
{  
  int j = 0;
  int foo = 0;
  
  for (int i = 0; i < shapes.size(); i++) {
    h = i * 3;
    s = 80 + i;
    b = 200 + i;
//    println("h: "+h+" s: "+s+" b: "+b);
    fill(h, s, b);

    if ( beat.isKick() ) {
      println("Kick!");
      foo = 1;
    }
    if ( beat.isSnare() ) foo = 2;
    if ( beat.isHat() ) foo = 3;

    println("foo: "+foo);
  
    shapes.get(i).drawTranslatedHex(j);
    
    if (j == 3) {
      j = 0;
    } else {
      j++;
    }   
  }
 
  
  
  //  Hexagon kickHex = new Hexagon(this, width/4 - 55, height/2, 10);
  //  Hexagon snareHex = new Hexagon(this, width/2 - 55, height/2,10);
  //  Hexagon hatHex = new Hexagon(this, 3*width/4 - 55, height/2, 10);
  //
  //  kickHex.drawTranslatedHex(0);
  //  snareHex.drawTranslatedHex(0);
  //  hatHex.drawTranslatedHex(0);
}

