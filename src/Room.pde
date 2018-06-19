
public void drawRooms(Room... rooms) {
    
  
  for (Room room : rooms) {
    strokeWeight(wallThickness);
    
    for (Iterator it = room.walls.values().iterator(); it.hasNext(); )
        for (Rectangle wall : (Vector<Rectangle>)it.next())
          drawRects(wall);
          
    strokeWeight(1);
    room.moveEnemies();
    for (Enemy e : room.enemies) {
      if (e.isAlert()) {
       e.setTarget(room.randToPlayerX(10), room.randToPlayerY(10)); // <------------------------------------------------------------------------------------------------------------
       Bullet b = e.fireAt((int)player.getX(), (int)player.getY());
       if (b != null)
         room.addBullet(e, b);
      }
      
      e.move();
      e.draw();
    }
    
    for (Pair<User, Bullet> b : room.bullets) {
     b.second.move();
     b.second.draw();
    }
    
  }
}

public class Room{
 
 public Rectangle rect = new Rectangle();
 public HashMap<Integer, Vector<Rectangle>> walls = new HashMap<Integer, Vector<Rectangle>>();
 public HashMap<Integer, Rectangle> doors = new HashMap<Integer, Rectangle>();
 public Vector<Pair<User, Bullet>> bullets = new Vector<Pair<User, Bullet>>();
 public Vector<Enemy> enemies = new Vector<Enemy>();
 
 
 public boolean explored = false;
 
 public Room(){}
 
 public Room(Rectangle r) {
   rect = r;
 }
 
 public boolean roomCleared() {
  for (Enemy e : enemies) {
   if (!e.isDead()) return false; 
  }
  return true;
 }
 
 public void moveEnemies() {
  for (Enemy e : enemies) {
   e.tick();
   e.moveRandomlyTo((int)(rect.getX() + rect.getWidth() - e.getWidth()), (int)(rect.getX() + e.getWidth()), (int)(rect.getY() + rect.getHeight() - e.getHeight()), (int)(rect.getY() + e.getHeight()));
  }
   
 }
 
 public void setupEnemies(int enemyCount, List<Rectangle> restraints) {
  
   if (restraints == null) restraints = new ArrayList<Rectangle>();
   for (int i = 0; i != enemyCount; i++) {
     enemies.add(new Enemy(getRandCord(restraints), enemyConstant, enemyConstant));
   }
 }
 
 public void setupEnemies(int enemyCount, long weaponTypes, List<Rectangle> restraints) {
   int pistols = (int)(weaponTypes & 0xF); 
   int shotguns = (int)(weaponTypes & 0xF0) >> 4;
   int carbines = (int)(weaponTypes & 0xF00) >> 8;
   int weaponSum = pistols + shotguns + carbines;
   if (enemyCount != weaponSum) throw new RuntimeException("no");
   
   for (int i = 0; i != pistols; i++) {
     if (restraints == null) restraints = new ArrayList<Rectangle>();
     Enemy e = new Enemy(getRandCord(restraints), enemyConstant, enemyConstant);
     e.setImage(enemyPistol);
     Gun p = pistol.clone();
     p.setInfinite();
     e.setGun(p);
     enemies.add(e);
   }
   
   for (int i = 0; i != shotguns; i++) {
    if (restraints == null) restraints = new ArrayList<Rectangle>();
     Enemy e = new Enemy(getRandCord(restraints), enemyConstant, enemyConstant);
     e.setImage(enemyRifle);
     Gun shotty = shotgun.clone();
     shotty.setInfinite();
     e.setGun(shotty);
     enemies.add(e);
   }
   
   for (int i = 0; i != carbines; i++) {
     if (restraints == null) restraints = new ArrayList<Rectangle>();
     Enemy e = new Enemy(getRandCord(restraints), enemyConstant, enemyConstant);
     e.setImage(enemyRifle);
     Gun carbine = rifle.clone();
     carbine.setInfinite();
     e.setGun(carbine);
     enemies.add(e);
   }
   
 }
 
 public void setupEnemies(int enemyCount, long weaponTypes, Rectangle... restraints) {
  Vector<Rectangle> rects = new Vector<Rectangle>();
  rects.addAll(Arrays.asList(restraints));
  setupEnemies(enemyCount, weaponTypes, rects);
 }
 
 public void setupEnemies(int enemyCount, long weaponTypes, Room... restraints) {
  Vector<Rectangle> rects = new Vector<Rectangle>();
  for (Room r : restraints) 
    rects.add(r.rect);
  setupEnemies(enemyCount, weaponTypes, rects);
 }
 
 public void setupEnemies(int enemyCount, long weaponTypes) {
  setupEnemies(enemyCount, weaponTypes, new ArrayList<Rectangle>()); 
 }
 
 
 public void setupEnemies(int enemyCount) {
  setupEnemies(enemyCount, new ArrayList<Rectangle>()); 
 }
 
 public void pushPlayerIntoRoom() {
   int constt = 50;
   float x = constrain(player.getX(), rect.getX() + constt, rect.getX() +rect.getWidth() - constt);
   float y = constrain(player.getY(), rect.getY() + constt, rect.getY() + rect.getHeight() - constt);
   player.set(x, y);
 }
 
 
 public void removeDeadEnemies() {
  Vector<Enemy> deadEnemies = new Vector<Enemy>();
  
  for (Enemy e : enemies) {
   if (e.isDead())
     deadEnemies.add(e);
  }
  
  for (Enemy e : deadEnemies) {
    score += 150;
   enemies.remove(e); 
  }
   
 }
 public void removeDeadBullets() {
   Vector<Pair<User, Bullet>> ba = new Vector<Pair<User,Bullet>>();
   for (Pair<User, Bullet> b : bullets) {
    if (!rect.contains(b.second))
      ba.add(b);
   }
   
   for (Pair<User, Bullet> b : ba) {
    bullets.remove(b); 
   }
   
 }
 
 public void addBullet(User firedBy, Bullet b) {
  bullets.add(new Pair<User, Bullet>(firedBy, b)); 
 }
 
 
 private Coordinate getRandCord(List<Rectangle> restraints) {
  Coordinate cord = null;
  outer:
  while(true) {
    int x = randInt((int)rect.getX(), (int)(rect.getX() + rect.getWidth()));
    int y = randInt((int)rect.getY(), (int)(rect.getY() + rect.getHeight()));
    Enemy e = new Enemy(x, y, enemyConstant, enemyConstant);
    for (Rectangle r : restraints) {
     if (!Rectangle.intercept(r, e).isEmpty()) continue outer; 
    }
    cord = new Coordinate(x, y);
    break;
  }
  
  return cord;
 }
 
 
 
 public boolean isCleared() {
  for (Enemy e : enemies) {
   if (!e.isDead()) return false; 
  }
   return true;
 }
 
 public void setupWalls(int wallThickness) {
   if (rect != null) {
    List<Wall> w = Arrays.asList(getWalls(rect, wallThickness));
    int i = 0;
    for (Iterator<Wall> it = w.iterator(); it.hasNext(); i++) {
      Vector<Rectangle> n = new Vector<Rectangle>();
      n.add(it.next());
      walls.put(new Integer(i), n);
    }
    
   }
 }
 
 public void setupDoor(int wallNum, int doorDepth, int doorWidth) {
   try {
     if (walls.get(wallNum).size() != 1 || doors.get(wallNum) != null) throw new RuntimeException("Can only have one door per wall."); 
     Rectangle w = walls.get(wallNum).get(0);
     Pair<Integer, Integer> p = new Pair<Integer, Integer>(doorDepth, doorWidth);
     Pair<List<Wall>, Rectangle> newWalls = getWalls(w, wallNum, p, (int)(wallNum == 0 || wallNum == 2 ? w.getWidth() : w.getHeight()) );
     walls.get(wallNum).clear();
     for (Wall wall : newWalls.first) {
      walls.get(wallNum).add(wall); 
     }
     Rectangle r = doors.get(wallNum);
     r = newWalls.second;
   } catch(Exception e) {
    e.printStackTrace(); 
     
   } //<>// //<>//
 }
 
 public int randToPlayerX(int radius) {
   
   Rectangle r = new Rectangle(player.getX() - radius, player.getY() + radius, player.getWidth() + radius * 2, player.getHeight() + radius * 2);
   return randInt((int)r.getX(), (int)(r.getX() + r.getWidth()));
 }
 
 public int randToPlayerY(int radius) {
   Rectangle r = new Rectangle(player.getX() - radius, player.getY() + radius, player.getWidth() + radius * 2, player.getHeight() + radius * 2);
   return randInt((int)r.getY(), (int)(r.getY() + r.getHeight()));
 }
 
 public void clearWalls() {
   walls = new HashMap<Integer, Vector<Rectangle>>();
 }
 
 public void clearDoors() {
   doors = new HashMap<Integer, Rectangle>();
 }
 
 public void setRect(Rectangle r) {
   rect = r;
 }
 
 public boolean explored() {
  return this.explored; 
 }
 
}
