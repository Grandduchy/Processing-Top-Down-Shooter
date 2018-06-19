abstract class MovingRectangle extends Rectangle {
  protected float speed = 50; // speed is between 1 and 100 representation of percentage
  protected float rotation = 0;
  
  
  public abstract void move();
  
  
  public void draw() {
     drawRotRects(rotation, this);
  }
  
  public void rotateTo(int x, int y) {
    rotation = -atan2(this.x - x, this.y - y) - HALF_PI - QUARTER_PI;
  }
  
  public void contain() {
    this.x = constrain(this.x, 0, width);
    this.y = constrain(this.y, 0, height);
  }
  
  public void setRotation(float angle) {
   this.rotation = angle; 
  }
  
  public void setSpeed(float speed) {
   this.speed = speed;
  }
  
  public float getRotation() {
   return this.rotation; 
  }
  
  public float getSpeed() {
   return this.speed; 
  }
  
  protected float angleBetween(PVector a, PVector b) {
    return acos(a.dot(b) / (a.mag() * b.mag()));
  }
  
  
  protected float reduceAngle(float angle) {
    if (angle < 0)
      return reduceAngle(360 + angle);
    if (angle >= 0 && angle <= 90) {
       return angle; 
    }
    else
      return reduceAngle(angle - 90);
  }
  
  
}
