public static int enemyConstant = 35;

// TODO associate fireFrequency and nextFire into gun instead of enemy.

public class Enemy extends User {
  private int moveFrequency = 300;
  private int fireFrequency = 150;
  private int nextFire = 0;
  private int nextMove = 0;
  private int radius = 100;
  private float targetX = Float.MAX_VALUE;
  private float targetY = Float.MAX_VALUE;
  private boolean isAlerted = false;
  
  Enemy(float x, float y, float w, float h) {
   this(x, y, w, h, null);
  }
  
  Enemy(Coordinate c, float w, float h) {
   this(c.x, c.y, w, h, null); 
  }
  
  Enemy(float x, float y, float w, float h, PImage img) {
    moveFrequency = randInt(300, 800);
    nextMove = randInt(0, moveFrequency);
    nextFire = randInt(0, fireFrequency);
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
    this.speed = 25;
    setColor(getRandColor(), getRandColor());
    this.setImage(img);
  }
  
  @Override
  public Bullet fireAt(int x, int y) {
    if (nextFire <= 0) {
      nextFire = fireFrequency;
      return super.fireAt(x, y); 
    }
    return null;
  }
  
  public void moveRandomlyTo(int maxX, int minX, int maxY, int minY) {
    if (nextMove <= 0) {
      targetX = rand(maxX, minX);
      targetY = rand(maxY, minY);
      nextMove = moveFrequency;
    }
  }
/*
*When player enters a room the enemies
*start thier attacks
*/
  public void toggleAlert() {
   isAlerted = true; 
  }
/*
*Checking if the enemy are alert or not
*(if alert returns true and if not return false)
*/  
  public boolean isAlert() {
   return isAlerted;
  }
  
  public void setFireFrequency(int f) {
   this.fireFrequency = f; 
  }
  
  public Coordinate getTarget() {
   return new Coordinate((int)targetX, (int)targetY); 
  }
  
  public void setTarget(float x, float y) {
    this.targetX = x;
    this.targetY = y;
  }
  
  public int getFrequency() {
   return moveFrequency; 
  }
  
  public int getRadius() {
   return radius;
  }
  
  public void setRadius(int r) {
   this.radius = r; 
  }
  
  
  public int getTick() {
   return nextMove; 
  }
  
  public void tick() {
   tick(1); 
  }
  
  public void tick(int rate) {
   nextMove -= rate;
   nextFire -= rate;
  }
  
  
  public void moveTo(int x, int y) {
    targetX = x;
    targetY = y;
  }
  
  @Override 
  public void draw() {
    tick();
    super.draw();
  }
  
  @Override
  //Making them move around in the room
  public void move() {
    
    if (((int)targetX != x || (int)targetY != y) && (targetX != Float.MAX_VALUE && targetY != Float.MAX_VALUE)) {
      x += (targetX - x) * map(speed, 1, 100, 0.005, 0.1);
      y += (targetY - y) * map(speed, 1, 100, 0.005, 0.1);
      if (isAlerted)
        this.rotateTo((int)player.x, (int)player.y);
      else
        this.rotateTo((int)targetX, (int)targetY);
    }
  }
  
  
  // Function comes from https://stackoverflow.com/questions/21089959/detecting-collision-of-rectangle-with-circle
  public boolean interceptsRadius(Rectangle r) {
    float circleX = this.x + this.width / 2;
    float circleY = this.y + this.height / 2;
    
    float distX = Math.abs(circleX - r.x + r.width / 2);
    float distY = Math.abs(circleY - r.y + r.height / 2);
    
    if (distX > (r.width / 2 + radius)) return false;
    if (distY > (r.height / 2 + radius)) return false;
    
    if (distX <= r.width / 2) return true;
    if (distY <= r.height / 2) return true;
    
    float dx = distX - r.width / 2;
    float dy = distY - r.height / 2;
    
    return dx*dx + dy*dy <= (radius*radius);
  }
  
  private int rand(int max, int min) {
    return (int)(Math.random() * ((max - min) + 1)) + min;
  }
  
}
