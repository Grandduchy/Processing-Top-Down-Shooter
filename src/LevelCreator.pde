
public Player player = null;
public static float wallThickness = 5;
public static int score = 0;

public class LevelCreator {
  public Level level1 = new Level();
  public Level level2 = new Level();
  public Level level3 = new Level();
  public Level level0 = new Level();
  
  private float originX;
  private float originY;
  
  private int doorWidthConstant;
  
  public int currentLevel = 1;
  
  
  void setup() {
    if (player == null)
      player = new Player(0, 0, 10);
    originX = windowLength / 2;
    originY = windowHeight / 2;
    doorWidthConstant = Math.round(player.getWidth() *  2);
    switch(currentLevel) {
     case 0 :
       setupLevel0(); break;
     case 1 :
       setupLevel1(); break;
     case 2 :
       setupLevel2(); break;
     case 3 :
       setupLevel3(); break;
    }
  }
  
  public void setLevel(int i ) {
   this.currentLevel = i; 
  }
  
  public void setupLevel0() {
   Room emptyRoom = createRoom(originX / 2, originY / 2, 500, 500);
   level0.addRoom(emptyRoom);
    
   setPlayerStart(0,0);
    
  }
  
  public void setupLevel1() {
    Room startRoom = createRoom(originX - 70, originY + 250, 100, 100);
    startRoom.setupWalls((int)(wallThickness));
    startRoom.setupDoor(3, getDoorMid(startRoom.rect.getHeight()), doorWidthConstant);
    
    Room center = createRoom(originX - 170, originY - 50 - wallThickness, 300, 300);
    center.setupDoor(1, getDoorMid(center.rect.getWidth()), doorWidthConstant);
    center.setupDoor(0, getDoorMid(center.rect.getHeight()), doorWidthConstant);
    center.setupDoor(2, getDoorMid(center.rect.getHeight()), doorWidthConstant);
    
    
    Room side1 = createRoom(originX - 370 - wallThickness, originY - 50 - wallThickness, 200, 300);
    side1.setupDoor(2, getDoorMid(side1.rect.getHeight()), doorWidthConstant);
    
    Room side2 = createRoom(originX + 140 - wallThickness, originY - 50 - wallThickness, 200, 300);
    side2.setupDoor(0, getDoorMid(center.rect.getHeight()), doorWidthConstant);
    
    level1.addRoom(startRoom, center, side1, side2);
    
    setPlayerStart(startRoom.rect);
    
    center.setupEnemies(3, 0x3,side1, side2, startRoom);
    side1.setupEnemies(2, 0x2, center);
    side2.setupEnemies(2, 0x2, center);
    
    randomizeLevelGuns(level1, 1, 1);
    Gun p = pistol.clone();
    p.setInfinite();
    p.setRounds(12);
    p.setCapacity(12);
    p.setAmmo(p.getAmmo() - 100);
    player.setSecondaryGun(p);
  }
  
  public void setupLevel2() {
    Room startRoom = createRoom(originX - 120, originY - 350, 100, 100);
    startRoom.setupDoor(1, getDoorMid(startRoom.rect.getHeight()), doorWidthConstant);
    
    Room cooridor1 = createRoom(originX - 145, originY - 245, 150, 250);
    for (int i = 0; i <= 2; i+= 2)
      cooridor1.setupDoor(i, getDoorMid(cooridor1.rect.getHeight()), doorWidthConstant);
    for (int i = 1; i <= 3; i += 2)
      cooridor1.setupDoor(i, getDoorMid(cooridor1.rect.getWidth()), doorWidthConstant);
      
    Room cooridor2 = createRoom(originX - 145, originY, 150, 250);
    cooridor2.setupDoor(3, getDoorMid(cooridor2.rect.getWidth()), doorWidthConstant);
    cooridor2.setupDoor(2, getDoorMid(cooridor2.rect.getHeight()) * 3/ 2, doorWidthConstant);
    
    Room side1 = createRoom(originX - 350, originY - 220, 200, 200);
    side1.setupDoor(2, getDoorMid(side1.rect.getHeight()), doorWidthConstant);
    
    Room side2 = createRoom(originX + 10, originY - 220, 200, 200);
    side2.setupDoor(0, getDoorMid(side2.rect.getHeight()), doorWidthConstant);
    
    Room cooridor3 = createRoom(originX + 10, originY + 125, 150, 100);
    cooridor3.setupDoor(0, getDoorMid(cooridor3.rect.getHeight()), doorWidthConstant);
    cooridor3.setupDoor(2, getDoorMid(cooridor3.rect.getHeight()), doorWidthConstant);
    
    Room bigRoom = createRoom(originX + 165, originY + 50, 250, 250);
    bigRoom.setupDoor(0, getDoorMid(bigRoom.rect.getHeight()), doorWidthConstant);
    
    level2.addRoom(startRoom, cooridor1, cooridor2, side1, side2, cooridor3, bigRoom);
    
    setPlayerStart(startRoom.rect);
    
    randomizeLevelGuns(level2, 3, 3);
    
    cooridor1.setupEnemies(2, 0x20);
    cooridor2.setupEnemies(2, 0x20);
    cooridor3.setupEnemies(1, 0x10);
    side1.setupEnemies(3, 0x300);
    side2.setupEnemies(3, 0x300);
    bigRoom.setupEnemies(4, 0x220);
    
    // note remove these once transitions are done.
    Gun p = pistol.clone();
    p.setInfinite();
    p.setRounds(12);
    p.setCapacity(12);
    p.setAmmo(p.getAmmo() - 100);
    player.setSecondaryGun(p);
    
  }
  
  public void setupLevel3() {
    Room startRoom = createRoom(originX, originY + 190, 100, 100);
    startRoom.setupDoor(0, getDoorMid(startRoom.rect.getHeight()), doorWidthConstant);
    startRoom.setupDoor(3, getDoorMid(startRoom.rect.getWidth()) + 5, doorWidthConstant);
    
    Room nextRoom = createRoom(originX - 305, originY + 90, 300, 300);
    nextRoom.setupDoor(2, getDoorMid(nextRoom.rect.getHeight()), doorWidthConstant);
    nextRoom.setupDoor(3, getDoorMid(nextRoom.rect.getWidth()), doorWidthConstant);
    
    Room inside1 = createRoom(nextRoom.rect.getX(), nextRoom.rect.getY(), 100, 100);
    inside1.setupDoor(2, getDoorMid(inside1.rect.getHeight()), doorWidthConstant);
    inside1.setupEnemies(1, 0x10);
    
    Room inside2 = createRoom(nextRoom.rect.getX(), nextRoom.rect.getY() + inside1.rect.getHeight() + wallThickness, 100, 100);
    inside2.setupDoor(2, getDoorMid(inside1.rect.getHeight()), doorWidthConstant);
    inside2.setupEnemies(1, 0x10);
    
    Room inside3 = createRoom(nextRoom.rect.getX(), nextRoom.rect.getY() + inside1.rect.getHeight() * 2 + wallThickness * 2, 100, 90);
    inside3.setupDoor(2, getDoorMid(inside1.rect.getHeight()), doorWidthConstant);
    inside3.setupEnemies(1, 0x10);
    
    Room interRoom = createRoom(nextRoom.rect.getX() + inside1.rect.getWidth(), nextRoom.rect.getY(), nextRoom.rect.getWidth() - inside1.rect.getWidth(), nextRoom.rect.getHeight(), false);
    interRoom.setupEnemies(2, 0x110);
    
    
    level3.addRoom(startRoom, nextRoom, inside1, inside2, inside3, interRoom); // first two rooms
    
    Room cooridor1 = createRoom(originX + 25, originY + 90, doorWidthConstant, 100);
    cooridor1.setupDoor(1, getDoorMid(cooridor1.rect.getWidth()), doorWidthConstant);
    cooridor1.setupDoor(2, getDoorMid(cooridor1.rect.getHeight()), doorWidthConstant);
    
    Room cooridor2 = createRoom(originX + 80, originY + 90, 300, 100);
    cooridor2.setupDoor(0, getDoorMid(cooridor2.rect.getHeight()), doorWidthConstant);
    cooridor2.setupDoor(1, getDoorMid(cooridor2.rect.getWidth()) * 5/ 4 - 36, doorWidthConstant);
    cooridor2.setupDoor(3, getDoorMid(cooridor2.rect.getWidth()) * 5/ 4 - 36, doorWidthConstant);
    cooridor2.setupEnemies(1, 0x100);
    
    Room smallMain = createRoom(originX + 150, originY + 195, 300, 190);
    smallMain.setupDoor(3, getDoorMid(smallMain.rect.getWidth() / 2), doorWidthConstant);
    smallMain.setupEnemies(4, 0x220);
    
    
    Room main = createRoom(originX - 405, originY - 265, 350, 350);
    main.setupDoor(1, getDoorMid(main.rect.getWidth()) * 3 / 2, doorWidthConstant);
    main.setupDoor(2, getDoorMid(main.rect.getHeight()) / 2 + 15, doorWidthConstant);
    main.setupEnemies(6, 0x330);
    
    Room sideMain = createRoom(originX + 100, originY - 265, 250, 250);
    sideMain.setupDoor(0, getDoorMid(sideMain.rect.getHeight()) - 10, doorWidthConstant);
    sideMain.setupDoor(1, getDoorMid(sideMain.rect.getWidth()), doorWidthConstant);
    sideMain.setupEnemies(4, 0x220);
    
    Room cooridor3 = createRoom(originX - 50, originY - 200, 145, 100);
    cooridor3.setupDoor(0, getDoorMid(cooridor3.rect.getHeight()), doorWidthConstant);
    cooridor3.setupDoor(2, getDoorMid(cooridor3.rect.getHeight()), doorWidthConstant);
    cooridor3.setupEnemies(1, 0x10);
    
    Room cooridor4 = createRoom(originX + 175, originY - 10, 100, 95);
    cooridor4.setupDoor(1, getDoorMid(cooridor4.rect.getWidth()), doorWidthConstant);
    cooridor4.setupDoor(3, getDoorMid(cooridor4.rect.getWidth()), doorWidthConstant);
    cooridor4.setupEnemies(1, 0x10);
    
    level3.addRoom(main, cooridor1, cooridor2, smallMain, sideMain, cooridor3, cooridor4);
    
    setPlayerStart(startRoom);
    
    randomizeLevelGuns(level3, 4, 4);
    
    
    Gun p = pistol.clone();
    p.setInfinite();
    p.setRounds(12);
    p.setCapacity(12);
    p.setAmmo(p.getAmmo() - 100);
    player.setSecondaryGun(p);
  }
  
  public void playerFire() {
    Level lvl = getLevel(currentLevel);
    
    Bullet bullet = player.fireAt(mouseX, mouseY);
    if (bullet != null) {
      lvl.addBullet(bullet, player);
    }
    
  }
  
  public void fireSecondary() {
   if (player.primaryEquiped()) throw new RuntimeException("Primary is equipped");
   playerFire();
  }
  
  public void alertEnemies() {
    // Find room player is in
    Room room = null;
    for (Room r : getLevel(currentLevel).rooms) {
      if (!Rectangle.intercept(r.rect, player).isEmpty())
        room = r;
    }
    
    if (room != null) {
      for (Enemy e : room.enemies) {
       e.toggleAlert(); 
      }
    }
    
  }
  
  public void drawLevel() {
    Level level = getLevel(currentLevel);
    drawLevels(level);
    
    // a second overlapping draw to look nicer
    for (Room r : level.rooms) {
      for (Iterator it = r.walls.values().iterator(); it.hasNext();) {
        for (Rectangle wall : (Vector<Rectangle>)it.next())
          drawRects(wall);
      }
    }
    player.draw();
  }
  
  public void keyInterpret(char key) {
    if (key == 'r') {
      player.reloadGun();
    }
    if (key == 'e') {
      swapFloorGuns();
    }
    if (key == '1') {
      player.swapToPrimary();
    }
    if (key == '2') {
      player.swapToSecondary();
    }
  }
  
  public void tick() {
    Level level = getLevel(currentLevel);
    level.tick();
    player.tick();
    alertEnemies();
    damageEnemies();
    if (player.mouseHeld)
      player.automateFire();
      
    damagePlayer();
    checkIfDead();
    checkIfClear();
    
    changePlayerImage();
    
    if (stage == 5) { // reset everything
      player = new Player(0, 0, 10);
      level1 = new Level();
      level2 = new Level();
      level3 = new Level();
      currentLevel = 1;
      setupLevel1();
      animate.resetClear();
      animate.resetYoureDead();
    }
    
  }
  
  public void changePlayerImage() {
    Gun g = player.getEquipGun();
   if (g.getName() == pistol.getName())
     player.setImage(playerPistol);
   if (g.getName() == rifle.getName())
     player.setImage(playerRifle);
   if (g.getName() == shotgun.getName())
     player.setImage(playerShotgun);
    
  }
  
  private void checkIfDead() {
    if (player.isDead()) {
     player.resetMovement();
     boolean isDone = animate.runYoureDead();
     if (isDone) { // GOTO SCOREBOARD
       screen.setScoreScreen(true, "You died.");
       stage = 5;
       animate.resetYoureDead();
     }
    }
  }
  
  private void checkIfClear() {
    Level level = getLevel(currentLevel);
    boolean clear = true;
    for (Room r : level.rooms) {
      if (!r.roomCleared()) clear = false;
    }
    if (!clear) return;
    
    boolean isDone = animate.runClear();
    if (isDone) { // GOTO NEXT LEVEL ORRRRR SCOREBOARD REMEMBER TO RESET
      swapToNextLevel();
      if (currentLevel == 4) {// done, go to scoreboard 
        screen.setScoreScreen(true, "Levels Cleared!");
        stage = 5;
      }
      animate.resetClear();
    }
  }
  
  private void damagePlayer() {
    Level level = getLevel(currentLevel);
    ArrayList<Pair<User,Bullet>> used = new ArrayList<Pair<User, Bullet>>();
    for (Room room : level.rooms) {
     for (Pair<User, Bullet> bullet : room.bullets) {
      if (!Rectangle.intercept(bullet.second, player).isEmpty() && bullet.first != player) {
        player.damageBy((int)bullet.second.getDamage() / 4);
        used.add(bullet);
      }
     }
    }
    
    for (Pair<User, Bullet> usedBullet : used) {
     for (Room room :level.rooms) {
      room.bullets.remove(usedBullet); 
     }
    }
    
    if (player.getHealth() < 0) {
     player.setHealth(0); 
    }
  }
  
  public void overlay() {
    fill(0);
    Gun primary = player.getGun();
    if (primary != null) {
      text("Player Health : " + player.getHealth(), 70, 20); 
      text("Primary : " + primary.name,  70, 50);
      text("Ammo : " + primary.rounds + "/" + primary.ammo, 70, 70);
    }
    Gun secondary = player.getSecondaryGun();
    
    text("Equipped : " + player.getEquipGun().name, 200, 20);
    text("Health : " + player.getHealth(), 450, 50);
    text("Score : " + score, 550, 50);
    
    text("Secondary : " + secondary.name, 250, 50);
    text("Ammo : " + secondary.rounds + "/∞", 250, 70);
  }
  
  private void swapFloorGuns() {
    Level level = getLevel(currentLevel);
    Pair<PVector, Pair<Rectangle, Gun>> lowestGun = null;
    for (Pair<Rectangle, Gun> gun : level.droppedGuns) { 
      PVector vec = new PVector();
      vec.set(gun.first.getX() - player.getX(), gun.first.getY() - player.getY());
      if (lowestGun == null) {
          lowestGun = new Pair<PVector, Pair<Rectangle, Gun>>(vec, gun);
      }
      else {
         if (lowestGun.first.mag() > vec.mag()) {
           lowestGun = new Pair<PVector, Pair<Rectangle, Gun>>(vec, gun);
         }
      }
    }
    
    // do the actual swapping
    if (lowestGun != null && lowestGun.first.mag() <= 40) { 
      level.droppedGuns.remove(lowestGun.second);
      Gun playerGun = player.getGun();
      // if player has gun drop it otherwise dont
      if (playerGun != null) {
        level.droppedGuns.add(new Pair<Rectangle, Gun>(lowestGun.second.first, playerGun));
      }
      player.setGun(lowestGun.second.second);
    }
    
  }
  
   //<>//
  private Level getLevel(int l) {
   switch(l) {
    case 0 : return level0;
    case 1 : return level1;
    case 2 : return level2;
    case 3 : return level3;
    default: throw new RuntimeException("Level number is out of scope.");
   }
  }
  
  private int getDoorMid(double sideLength) {
    return (int)(sideLength / 2 - doorWidthConstant / 2);
  }
  
  private Room createRoom(float x, float y, float width, float height, boolean setWalls) {
   Room room = new Room();
   Rectangle rect = new Rectangle(x, y, width, height);
   room.setRect(rect);
   if (setWalls)
     room.setupWalls((int)wallThickness);
   return room;
  }
  
  private Room createRoom(float x, float y, float width, float height) {
   return createRoom(x, y, width, height, true); 
  }
  
  public void movePlayer() {
    Player tempPlayer = player.clone();
    player.rotateTo(mouseX, mouseY);
    short i = 0;
    player.moveY();
    if (!doesIntercept(player))
      i |= 0xF;
    player.y = tempPlayer.y;
    player.moveX();
    if (!doesIntercept(player))
      i |= 0xF0;
    player.x = tempPlayer.x;
    
    switch(i) {
     case 0xFF : 
       player.move();
       break;
     case 0xF0 : 
       player.moveX();
       break;
    case 0xF : 
      player.moveY();
      break;
    }
  }
  
  private void swapToNextLevel() {
   if (currentLevel == 4) return;
   player.setHealth(100);
   currentLevel++;
   this.setup();
   
  }
  
  private boolean doesIntercept(Player p) {
    Level l = getLevel(currentLevel);
    for (Room r : l.rooms)
     for (Iterator it = r.walls.values().iterator(); it.hasNext();)
      for (Rectangle wall : (Vector<Rectangle>)it.next()) 
       if (!Rectangle.intercept(wall, p).isEmpty())
         return true;
    return false;
  }
  
  private void setPlayerStart(Rectangle r) {
    player.set(r.getX() + r.getWidth() / 2 - player.getWidth() / 2, r.getY() + player.getHeight() / 2);
  }
  
  private void setPlayerStart(Room r) {
   setPlayerStart(r.rect); 
  }
  
  private void setPlayerStart(int x, int y) {
   player.set(x, y); 
  }
  
  public void mouseMoved() {
   player.rotateTo(mouseX, mouseY);
  }
  
  public void damageEnemies() {
   Level lvl = getLevel(currentLevel);
   
   Vector<Pair<User, Bullet>> usedBullets = new Vector<Pair<User, Bullet>>();
   
    for (Room room : lvl.rooms) {
     
      for (Pair<User, Bullet> bullet : room.bullets) {
         
        for (Room enemyRoom : lvl.rooms) {
           for (Enemy e : enemyRoom.enemies) {
            if (!Rectangle.intercept(bullet.second, e).isEmpty() && bullet.first == player) {
               usedBullets.add(bullet);
               e.damageBy((int)bullet.second.getDamage());
            }
           }
        }
        
      }
      
    }
    
    for (Pair<User, Bullet> used : usedBullets) {
      for (Room room : lvl.rooms) {
        room.bullets.remove(used);
      }
    }
    
    
  }
  
  
}
