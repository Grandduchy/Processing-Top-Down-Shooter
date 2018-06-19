
Bullet pistolBullet, assultBullet, shotgunBullet;

Gun pistol, rifle, shotgun;




public void setupGuns() {
  pistolBullet = new Bullet(20, 15, 20, 34, bullet); // 15
  assultBullet = new Bullet(20, 15, 20, 50, bullet); // 20
  shotgunBullet = new Bullet(20, 15, 20, 100, bullet); // 50
  
  pistol = new Gun(pistolBullet.clone(), "Glock 17");
  rifle = new Gun(assultBullet.clone(), "M4A4");
  shotgun = new Gun(shotgunBullet.clone(), "Mossberg 500");
  
}

public class Gun  {
  
  private Bullet bullet;
  private int capacity = 30;
  private int ammo = 150;
  private int rounds = capacity;
  private String name;
  
  Gun(Bullet b, String name) {
   this.bullet = b; 
   this.name = name;
  }
  
  Gun(int w, int h, int speed, int damage) {
   bullet = new Bullet(w, h, speed, damage); 
  }
  
  Gun(int w, int h, int speed, int ammo, int capacity, int damage) {
   bullet = new Bullet(w, h, speed, damage); 
   this.ammo = ammo;
   this.capacity = capacity;
  }
  // Getters and Setters
  
  public Bullet getBullet() {
    rounds--;
   return bullet; 
  }
  
  public void setBullet(Bullet b) {
   this.bullet = b; 
  }
  
  public void setCapacity(int c) {
    this.capacity = c;  
  }
  
  public int getCapacity() {
   return capacity; 
  }
  
  public void setAmmo(int a) {
   this.ammo = a;
  }
  
  public int getAmmo() {
   return ammo; 
  }
  
  public void setRounds(int r) {
   this.rounds = r; 
  }
  
  public int getRounds() {
   return rounds; 
  }
  
  public void setName(String s) {
   this.name = s; 
  }
  
  public String getName() {
   return this.name; 
  }
  
  public void setInfinite() {
   this.capacity = Integer.MAX_VALUE;
   this.ammo = Integer.MAX_VALUE;
   this.rounds = Integer.MAX_VALUE;
  }
  
  public void reload() {
   ammo += rounds;
   rounds = 0;
   if (ammo <= 0) {
     ;
   }
   else if (ammo <= capacity) {
     rounds = ammo;
     ammo = 0;
   }
   else {
    rounds += capacity;
    ammo -= capacity;
   }
  }
  
  public boolean canFire() {
   return rounds >= 1; 
  }
  
  
  public Gun clone() {
    Gun g = new Gun(this.bullet.clone(), this.name);
    g.capacity = capacity;
    g.ammo = ammo;
    g.rounds = rounds;
    return g;
  }
  
}
