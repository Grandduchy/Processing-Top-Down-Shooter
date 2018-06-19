

class Bullet extends MovingRectangle {
 protected float targetX;
 protected float targetY;
 protected boolean stop = false;
 protected PVector directionVector;
 protected float damage;
 
/*
*Overloading Constructor
*/
 public Bullet(float w, float h, float speed, float damage) {
   this.width = w;
   this.height = h;
   this.speed = speed;
   this.damage = damage;
 }
 
 public Bullet(float w, float h, float speed, float damage, PImage img) {
  this(w, h, speed, damage);
  this.setImage(img);
 }
 
 public Bullet(Coordinate cord,int w, int h, int targetX, int targetY, int speed, int damage) {
   this.x = cord.x;
   this.y = cord.y;
   this.width = w;
   this.height = h;
   this.targetX = targetX;
   this.targetY = targetY;
   this.speed = speed;
   this.damage = damage;
 }
 
 public void setStopping(boolean stop) {
   this.stop = stop;
 }
 
 public boolean getStop() {
  return this.stop; 
 }
 
 public void targetTo(Coordinate c) {
   targetTo(c.x, c.y);
 }
 
 public void targetTo(float x, float y) {
  targetX = x;
  targetY = y;
 }
 
 public void setDirectionVector(PVector dv) {
  this.directionVector = dv.copy(); 
 }
 
 public PVector getDirectionVector() {
  return directionVector; 
 }
 
 public float getDamage() {
  return damage; 
 }
 
 
 @Override
 public void move() {
   
   if (directionVector == null) {
     directionVector = new PVector();
     directionVector.set(targetX - this.x, targetY - this.y);
     directionVector.normalize();
     directionVector = directionVector.mult(map(speed, 1, 100, 1, 50 ));
     
   }
   
   
   if (stop) {
     if ((int)targetX != x || (int)targetY != y) {
        x += (targetX - x) * map(speed, 1, 100, 0.005, 0.1);
        y += (targetY - y) * map(speed, 1, 100, 0.005, 0.1);
     }
   }
   else {
     this.x += directionVector.x;
     this.y += directionVector.y;
   }
 }
 
 
 @Override
 public Bullet clone() {
   Bullet b = new Bullet(this.width, this.height, this.speed, this.damage);
   b.x = this.x;
   b.y = this.y;
   b.targetX = this.targetX;
   b.targetY = this.targetY;
   b.damage = this.damage;
   b.img = this.img;
   return b;
 }
  
  
}
