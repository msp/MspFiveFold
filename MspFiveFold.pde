import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;
BeatListener bl;

ArrayList<Polygon> shapes;
final int numSides = 5;
final int numberCols = 8;
final int numberShapes = 8;
final int size = 50;
int x, y, h, s, b = 0;
int angle = 0;
int defaultRadius = 60;
int defaultRotation = 0;
int kickRotation, snareRotation, hatRotation = defaultRotation;
float kickRadius, snareRadius, hatRadius = defaultRadius;
float kickSize, snareSize, hatSize;  
float a = 0;
boolean debug = false;
boolean spin = true;

void setup()
{
  //frameRate(10);
  size(900, 950, P2D);  
  textFont(createFont("Helvetica", 16));
  textAlign(CENTER);

  setupMinim();
}

void draw()
{ 
  background(51);
  noStroke();
  colorMode(HSB);

  shapes = new ArrayList<Polygon>();
  initShapes();

  if (beat.isKick()) { 
    kickRadius = 80;
    kickRotation += 45;
    kickSize = 32;
    snareRotation = hatRotation = defaultRotation;
  } 
  
  if (beat.isSnare()) {
    snareRadius = 80;
    snareRotation += 45;
    snareSize = 32;
    kickRotation = hatRotation = defaultRotation;
  } 
  
  if (beat.isHat()) {
    hatRadius = 80;
    hatRotation += 45;
    hatSize = 32;
    kickRotation = snareRotation = defaultRotation;
  }

  if (debug) drawDebug();

  for (int i = 0; i < shapes.size(); i++) {    
    h = i * 3;
    s = 80 + i;
    b = 200 + i;

    if (i < 16) {
      a = map(kickRadius, 20, 80, 60, 255);
      fill(h, s, b, a);

      if (!spin) kickRotation = 0; 
      shapes.get(i).draw(kickRotation);
    } 
    else if (i >= 24 && i < 40) {
      a = map(snareRadius, 20, 80, 60, 255);
      fill(h, s, b, a);

      if (!spin) snareRotation = 0;
      shapes.get(i).draw(snareRotation);
    } 
    else if (i >= 48 && i < 64) {
      a = map(hatRadius, 20, 80, 60, 255);
      fill(h, s, b, a);

      if (!spin) hatRotation = 0;
      shapes.get(i).draw(hatRotation);
    } 
    else {
      fill(h, s, b);
      shapes.get(i).draw();
    }
  }

  tween();
}

void setupMinim() {
  minim = new Minim(this);

  song = minim.loadFile("marcus_kellis_theme.mp3", 1024);
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
  beat.setSensitivity(50);  
  kickSize = snareSize = hatSize = 16;
  // make a new beat listener, so that we won't miss any buffers for the analysis
  bl = new BeatListener(beat, song);
}

void initShapes() {  
  for (int i = 1; i <= numberCols; i++) {
    for (int j = 1; j <= numberShapes; j++) {
      x = i * (size * 2);
      y = j * (size + 55);

      angle = j % 2 == 0 ? 180 : 0;
      shapes.add(new Polygon(numSides, x, y, angle));
    }
  }
}

void tween() {
  kickRadius *= 0.95;
  snareRadius *= 0.95;
  hatRadius *= 0.95;
  kickRotation *= 0.95;
  snareRotation *= 0.95;
  hatRotation *= 0.95;

  if ( kickRadius < defaultRadius ) kickRadius = defaultRadius;
  if ( snareRadius < defaultRadius ) snareRadius = defaultRadius;
  if ( hatRadius < defaultRadius ) hatRadius = defaultRadius;
  if ( kickRotation < defaultRotation ) kickRotation = defaultRotation;
  if ( snareRotation < defaultRotation ) snareRotation = defaultRotation;
  if ( hatRotation < defaultRotation ) hatRotation = defaultRotation;
}

void drawDebug() {
  textSize(kickSize);
  text("KICK", width/4, height/2);
  textSize(snareSize);
  text("SNARE", width/2, height/2);
  textSize(hatSize);
  text("HAT", 3*width/4, height/2);
  kickSize = constrain(kickSize * 0.95, 16, 32);
  snareSize = constrain(snareSize * 0.95, 16, 32);
  hatSize = constrain(hatSize * 0.95, 16, 32);
}

