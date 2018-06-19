

public void drawLevels(Level... levels) {
  for (Level level : levels) {
   for (Room r : level.rooms) {
    drawRooms(r); 
   }
   for (Pair<Rectangle, Gun> p : level.droppedGuns) {
     if (p.second.getName() == rifle.getName())
       p.first.setImage(downM4);
     if (p.second.getName() == shotgun.getName())
       p.first.setImage(downShotgun);
    drawRects(p.first); 
   }
   
   level.removeDeadBullets();
  }
}

public void randomizeLevelGuns(Level lvl, int rifleCount, int shotCount) {
      int gunWidth = 40;
      int gunHeight = 20;
  for (int i = 0; i != rifleCount; i++) {
      Pair<Rectangle, Gun> gunPair = new Pair<Rectangle, Gun>();
      Room r = lvl.rooms.get(randInt(0, lvl.rooms.size() - 1));
      int randX = randInt((int)r.rect.getX() + gunWidth, (int)(r.rect.getX() + r.rect.getWidth() - gunWidth));
      int randY = randInt((int)r.rect.getY() + gunHeight, (int)(r.rect.getY() + r.rect.getHeight() - gunHeight));
      Rectangle rect = new Rectangle(randX, randY, gunWidth, gunHeight);
      rect.setImage(downM4);
      gunPair.first = rect;
      gunPair.second = rifle.clone();
      lvl.droppedGuns.add(gunPair);
    }
    
    for (int i = 0; i != shotCount; i++) {
      Pair<Rectangle, Gun> gunPair = new Pair<Rectangle, Gun>();
      Room r = lvl.rooms.get(randInt(0, lvl.rooms.size() - 1));
      int randX = randInt((int)r.rect.getX(), (int)(r.rect.getX() + r.rect.getWidth()));
      int randY = randInt((int)r.rect.getY(), (int)(r.rect.getY() + r.rect.getHeight()));
      Rectangle rect = new Rectangle(randX, randY, gunWidth, gunHeight);
      rect.setImage(downShotgun);
      gunPair.first = rect;
      gunPair.second = shotgun.clone();
      gunPair.second.setCapacity(8);
      gunPair.second.setRounds(8);
      lvl.droppedGuns.add(gunPair);
    }
      
}





public static class Level {
  public Vector<Room> rooms = new Vector<Room>();
  public Vector<Pair<Rectangle, Gun>> droppedGuns = new Vector<Pair<Rectangle, Gun>>();
  
  Level() {
   rooms = new Vector<Room>(); 
  }
  
  
  public void runDead() {
    
  }
  
  public void addBullet(Bullet b, Player p) {
    Room room = null;
    for (Room r : rooms) {
      if (!Rectangle.intercept(p, r.rect).isEmpty())
        room = r;
    }
    if (room != null) {
      room.addBullet(p, b); 
    }
  }
  
  public void removeDeadBullets() {
   for (Room r : rooms) {
    r.removeDeadBullets(); 
   }
  }
    
  public void addRoom(Room... rooms) {
    for (Room r : rooms) {
     this.rooms.add(r); 
    }
  }
  
  public void tick() {
   for (Room r : rooms) {
     r.removeDeadEnemies();
   }
  }
  
}
