class Hexagon {
  
   protected PApplet parent;
   protected PGraphics buffer;
   protected float a;
   protected float b;
   protected float c;
   private int startX;
   private int startY;
   
  public Hexagon(Object p, int newStartX, int newStartY, int sideLength){
      if (p instanceof PGraphics)
        buffer = (PGraphics) p;
      
      if (p instanceof PApplet)
        parent = (PApplet) p;
      
      setStartX(newStartX);
      setStartY(newStartY);
      c = sideLength;
      a = c/2;
      b = parent.sin(parent.radians(60))*c;
    }

  public void drawTranslatedHex(int n){

    parent.pushMatrix();
    parent.translate(getStartX(), getStartY());
    //draw hex shape
    drawHex(n);
    parent.popMatrix();
  }
  
  public void drawHex(int n){
    //draw hex shape
    parent.beginShape();
      switch(n) {
        case 0:
          parent.vertex(0,b);
          parent.vertex(a,0);
          parent.vertex(a+c,0);
          parent.vertex(2*c,b);
          parent.vertex(a+c,2*b);
          parent.vertex(a+c,2*b);
          parent.vertex(a,2*b);
          parent.vertex(0,b);
          break;
        case 1:
          parent.vertex(a+c,0);
          parent.vertex(2*c,b);
          parent.vertex(a+c,2*b);
          parent.vertex(a+c,2*b);
          parent.vertex(a,2*b);
          parent.vertex(0,b);
          break;
        case 2:
          parent.vertex(0,b);
          parent.vertex(a,0);
          parent.vertex(a+c,2*b);
          parent.vertex(a+c,2*b);
          parent.vertex(a,2*b);
          parent.vertex(0,b);
          break;
        case 3:
          parent.vertex(0,b);
          parent.vertex(a,0);
          parent.vertex(a+c,0);
          parent.vertex(2*c,b);
          parent.vertex(a,2*b);
          parent.vertex(0,b);
          break;
        default:
          parent.vertex(0,b);
          parent.vertex(a,0);
          parent.vertex(a+c,0);
          parent.vertex(2*c,b);
          parent.vertex(a,2*b);
          parent.vertex(0,b);
          break;

      }
    parent.endShape();
  }

  public void setStartX(int startX) {
    this.startX = startX;
  }

  public int getStartX() {
    return startX;
  }

  public void setStartY(int startY) {
    this.startY = startY;
  }

  public int getStartY() {
    return startY;
  }
}
