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

