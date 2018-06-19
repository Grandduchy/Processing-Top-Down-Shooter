//https://www.processing.org/discourse/beta/num_1139256015.html
public static int playerConstant = 35;

public class Player extends User {
  
  private HashMap<Character, Boolean> keys = new HashMap<Character, Boolean>();
  
  private Gun secondaryGun = null;
  private Gun equipGun = null;
  
  public boolean mouseHeld = false;
  int nextAuto = 0;
  
  Player(float x1, float y1, float speed1) {
    this.x = x1;
    this.y = y1;
    this.width = playerConstant;
    this.height = playerConstant;
    this.setColor(0, 255);
    this.speed = speed1;
    
    keys.put('w', false);
    keys.put('d', false);
    keys.put('s', false);
    keys.put('a', false);
  }
  
  
  @Override
  public Bullet fireAt(int x, int y) {
    Gun clone = this.gun;
    this.gun = equipGun;
    Bullet b = super.fireAt(x, y);
    this.gun = clone;
    return b;
  }
  
  public boolean primaryEquiped() {
    return equipGun == this.gun;
  }
  
  public void swapToPrimary() {
   if (hasPrimary()) {
    equipGun = this.gun; 
   }
  }
  
  public void resetMovement() {
   keys.replace('w', false);
   keys.replace('d', false);
   keys.replace('s', false);
   keys.replace('a', false);
  }
  
  public void swapToSecondary() {
   if (this.secondaryGun != null)
     equipGun = secondaryGun;
  }
  
  public void setSecondaryGun(Gun g) {
    this.secondaryGun = g;
    equipGun = g;
  }
  
  public Gun getSecondaryGun() {
   return secondaryGun; 
  }
  
  public Gun getEquipGun() {
   return equipGun;
  }
  
  public boolean hasPrimary() {
   return this.gun != null; 
  }
  
  public boolean hasSecondary() {
   return this.secondaryGun != null; 
  }
  
  @Override
  public void setGun(Gun g) {
    this.gun = g;
    equipGun = this.gun;
  }
  
  @Override
   public void move() {
      
     moveX();
     moveY();
     
  }
/*
*If d or a is pressed the player will be
*moving on the x-axis(left or right)
*/
  public void moveX() {
   if (keys.get('d'))
       this.x += speed;
    if (keys.get('a'))
       this.x -= speed;
  }
/*
*If w or s is pressed the player will be
*moving on the y-axis(up or down)
*/ 
  public void moveY() {
    if (keys.get('w'))
       this.y -= speed;
     if (keys.get('s'))
       this.y += speed;
  }
  
  
  public void loadKey(char keyT) {
    keys.replace(keyT, true);
  }
  
  public void removeKey(char keyT) {
    keys.replace(keyT, false);
  }
  
  @Override
  public void reloadGun() {
    Gun clonedGun = this.gun;
    this.gun = equipGun;
    super.reloadGun();
    gun = clonedGun;
  }
  
  // Note this is not a full clone.
  @Override
  public Player clone() {
   Player p = new Player(this.x, this.y, this.speed); 
   return p;
  }
  
  public void automateFire() {
    try {
      if (equipGun.name == rifle.name && nextAuto <= 0) {
         ctr.playerFire();
         nextAuto = 10;
      }
      if (equipGun.name == shotgun.name && nextAuto <= 0) {
       ctr.playerFire();
       nextAuto = 50;
      }
    } catch(Exception e) {
     return;
    }
  }
  
  public void tick() {
    --nextAuto;
  }
  
}
  
