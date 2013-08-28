class Polygon {

  protected int n;
  protected int rotation;
  protected float cx;
  protected float cy;
  protected float w;
  protected float h;
  protected float startAngle;

  public Polygon(int _sides, int _x, int _y, int _rotation) {
    n = _sides;
    startAngle = -PI / 2;
    w = 100;
    h = 100;
    cx = _x;
    cy = _y;
    rotation = _rotation;
  }

  void draw(int _rotation) {
    rotation = _rotation;
    draw();  
  }
  
  void draw()
  {
    float angle = TWO_PI/ n;
    /* The "radius" is one half the total width and height */
    w = w / 2.0;
    h = h / 2.0;

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
  }
}

