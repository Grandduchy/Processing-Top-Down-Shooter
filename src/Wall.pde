import java.util.Arrays;

public Wall[] getWalls(Rectangle r, int wallThickness) {
 Wall[] walls = new Wall[4];
 walls[0] = new Wall(r.getX(), r.getY(), wallThickness, r.getHeight());
 walls[1] = new Wall(r.getX(), r.getY() + r.getHeight() , r.getWidth(), wallThickness);
 walls[2] = new Wall(r.getX() + r.getWidth(), r.getY(), wallThickness, r.getHeight() + wallThickness);
 walls[3] = new Wall(r.getX(), r.getY(), r.getWidth(), wallThickness);
 return walls;
}
// first -> how far in
// second -> length of door
public Pair<List<Wall>, Rectangle> getWalls(Rectangle r, int wallNum, Pair<Integer, Integer> doorParams, int wallThickness) {
  List<Wall> walls = new Vector<Wall>();
  walls.addAll(Arrays.asList(getWalls(r, wallThickness)));
  Wall main = walls.get(wallNum);
  walls.clear();
  switch(wallNum) { 
   case 0 : {
     Wall first = new Wall(r.getX(), r.getY(), wallThickness, doorParams.first);
     Rectangle door = new Rectangle(r.getX(), r.getY() + doorParams.first, wallThickness, doorParams.second);
     Wall second = new Wall(r.getX(), r.getY()+ doorParams.first + doorParams.second, wallThickness, r.getHeight() - first.getHeight() - door.getHeight());
     walls.remove(main);
     walls.add(first);
     walls.add(second);
     Pair<List<Wall>, Rectangle> pair = new Pair<List<Wall>, Rectangle>();
     pair.first = walls; 
     pair.second = door;
     return pair;
   }
   case 1 : {
    Wall first = new Wall(r.getX(), r.getY() + r.getHeight() - wallThickness, doorParams.first, wallThickness);
    Rectangle door = new Rectangle(r.getX() + doorParams.first, r.getY() + r.getHeight(), doorParams.second, wallThickness);
    Wall second = new Wall(r.getX() + doorParams.first + doorParams.second, r.getY() + r.getHeight() - wallThickness, r.getWidth() - first.getWidth() - door.getWidth() + wallThickness, wallThickness);
    walls.remove(main);
    walls.add(first);
    walls.add(second);
    Pair<List<Wall>, Rectangle> pair = new Pair<List<Wall>, Rectangle>();
    pair.first = walls; 
    pair.second = door;
    return pair;
   }
   case 2 : {
    Wall first = new Wall(r.getX() + r.getWidth() - wallThickness, r.getY(), wallThickness, doorParams.first);
    Rectangle door = new Rectangle(r.getX() + r.getWidth() - wallThickness, r.getY() + doorParams.first, wallThickness, doorParams.second);
    Wall second = new Wall(r.getX() + r.getWidth() - wallThickness, r.getY() + doorParams.first + doorParams.second, wallThickness, r.getHeight() - doorParams.first - doorParams.second);
    walls.remove(main);
    walls.add(first);
    walls.add(second);
    Pair<List<Wall>, Rectangle> pair = new Pair<List<Wall>, Rectangle>();
    pair.first = walls; 
    pair.second = door;
    return pair;
   }
   case 3 : {
    Wall first = new Wall(r.getX(), r.getY(), doorParams.first, wallThickness);
    Rectangle door = new Wall(r.getX() + doorParams.first, r.getY(), doorParams.second, wallThickness);
    Wall second = new Wall(r.getX() + doorParams.first + doorParams.second, r.getY(), r.getWidth() - first.getWidth() - door.getWidth(), wallThickness);
    walls.remove(main);
    walls.add(first);
    walls.add(second);
    Pair<List<Wall>, Rectangle> pair = new Pair<List<Wall>, Rectangle>();
    pair.first = walls; 
    pair.second = door;
    return pair;
     
   }
   default :
     throw new RuntimeException("Wallnum paramter is out of scope.");
    
  
  }
}


class Wall extends Rectangle {
  
  Wall(float x, float y, float width, float height) {
   super(x,y,width,height); 
  }
 
  public boolean intersectsUser(User p) {
    return Rectangle.intercept(p, this).isEmpty();
  }
  
  
}
