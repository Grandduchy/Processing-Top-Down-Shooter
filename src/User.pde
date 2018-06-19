
public abstract class User extends MovingRectangle {
  //Initializing health to 100
	protected int health = 100;
	protected Gun gun = null;
	
  public Bullet fireAt(int x, int y) {
   
    if (gun == null) throw new RuntimeException("Gun of user type is null");
    
    if (gun.canFire()) {
      Bullet b = gun.getBullet().clone();
      b.set(this.x, this.y);
      b.targetTo(x, y);
      b.rotateTo(x, y);
      return b;
    } else {
     return null; 
    }
  }
  
  public void setGun(Gun g) {
    this.gun = g;
  }
  
//Overwriting health  
  
  public Gun getGun() {
   return gun; 
  }
  
  public void setHealth(int health) {
   this.health = health; 
  }

  public int getHealth() {
   return this.health; 
  }
  
  public void damageBy(int x) {
   this.health -= x; 
  }
  
  public void reloadGun() {
   if (gun != null)
     gun.reload();
  }
  
  public boolean isDead() { return health <= 0; }
	

}
