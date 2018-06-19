// ==========================================================
// Author : Joshua Challenger
// Date : Sunday March 11, 2018
// File Name : Rectangle.java
// Description : This class defines a rectangle type.
// ==========================================================
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.Vector;
import java.util.TreeSet;
import java.lang.RuntimeException;

enum drawType {
 NORMAL, // start from top left corner
 ORIGIN, // start from bottom left corner
 CARTESIAN  // start from the middle
}

void drawRectT(Rectangle rect, drawType type) {
  fill(rect.getFill(), rect.getOpacity());
  stroke(rect.getStroke(), rect.getOpacity());
  float xVal = rect.getX();
  float yVal = rect.getY();
  float rectHeight = rect.getHeight();
  
  if (type == drawType.CARTESIAN) 
    xVal = width / 2 + rect.getX();
  
  if (type == drawType.ORIGIN) 
  yVal = height - rect.getY() - rectHeight;
  else if (type == drawType.CARTESIAN) 
  yVal = height - rect.getY() - rectHeight - height / 2;
  if (rect.isImage())
    image(rect.getImage(), xVal, yVal, rect.getWidth(), rect.getHeight());
  else
    rect(xVal, yVal, rect.getWidth(), rect.getHeight()); 
}

// Function draws n amount of rectangles using origin coordinate system
void drawRects(Rectangle... rects) {
  for (Rectangle rect : rects) {
    drawRectT(rect, drawType.NORMAL);
  }
}

void drawRotRects(float angle, Rectangle... rects) {
  rectMode(CENTER);
  pushMatrix();
  for (Rectangle rect : rects) {
    pushMatrix();
    //translate(rect.getX() + rect.getWidth() / 2, rect.getY() - rect.getHeight());
   translate(rect.getX() + rect.getWidth() / 2, rect.getY() + rect.getHeight()  / 2);
   rotate(angle);
   if (rect.isImage())
     image(rect.getImage(), 0, 0, rect.getWidth(), rect.getHeight());
   else
     rect(0, 0, rect.getWidth(), rect.getHeight());
   
   popMatrix();
  }
  popMatrix();
  translate(0, 0);
  rectMode(CORNER);
  
}


public static class Rectangle {
  // Data fields
  protected float x;
  protected float y;
  protected float width;
  protected float height;
  protected color stroke = 0;
  protected color fill = 255;
  protected float opacity = 255;
  protected PImage img;
  
  
  Rectangle() {
    this(0,0,0,0);
  }
  
  Rectangle(Coordinate coord, float width, float height) {
    set(coord.x, coord.y, width, height);
  }
  
  Rectangle(float a, float b, float c, float d) {
    set(a,b,c,d);
  }
  
  
  public void set(float x, float y, float width, float height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }
  
  public void set(Coordinate coord, float width, float height) {
   set(coord.x, coord.y, width, height); 
  }
  
  public void set(Coordinate coord) {
    set(coord.x, coord.y);
  }
  
  public void set(float x, float y) {
   this.x = x;
   this.y = y;
  }
  
  public void setX(float x) {
    this.x = x;
  }
  
  public void setY(float y) {
   this.y = y; 
    
  }
  
  public void setImage(PImage img) {
    this.img = img;
  }
  
  public boolean isImage() {
   return this.img != null; 
  }
  
  public PImage getImage() {
   return this.img; 
  }
  
  public void setOpacity(float opacity) {
    this.opacity = map(opacity, 0, 100, 0, 255);
  }
  
  public float getOpacity() {
   return this.opacity; 
  }
  
  public void setColor(color stroke, color fill) {
   this.stroke = stroke;
   this.fill = fill;
  }
  
  public color getStroke() {
    return this.stroke;
  }
  
  public color getFill() {
    return this.fill;
  }
  
  @Override
  public String toString() {
    return "base: (" + x + ", " + y + ") w:" + width + " h:" + height;
  }
  
  public String toSimpleString() {
    return x + "," + y + "," + width + "," + height;
  }
  
  public float area() {
    return this.width * this.height;
  }
  
  public float perimeter() {
    if (height == 0 || width == 0) // its just a straight line
      return height + width;
    return height * 2 + width * 2;
  }
  
  // Getters
  public float getX() {
    return this.x;
  }
  
  public float getY() {
    return this.y;
  }
  
  public float getWidth() {
    return this.width;
  }
  
  public float getHeight() {
    return this.height;
  }
  
  public Rectangle clone() {
   Rectangle r = new Rectangle(x,y,this.width,this.height);
   r.stroke = stroke;
   r.fill = fill;
   r.opacity = opacity;
   return r;
  }
  
  // In an intersection returns the outmost lines of the rectangle, which is the difference
  // of the intercepted rectangle from the two rectangles 
  // Inside a rectangle, function returns the outer rectangle
  // In no interception returns both perimeters combined.
  public static float totalPerimeter(Rectangle obj, Rectangle other) {
    Rectangle leftRect = obj.x <= other.x ? obj : other;
    Rectangle rightRect = leftRect == obj ? other : obj;
    Rectangle interceptedRect = Rectangle.intercept(obj, other);
    if (rightRect.contains(leftRect))
      return rightRect.perimeter();
    else if (interceptedRect.isEmpty())
      return rightRect.perimeter() + leftRect.perimeter();
    // note to verify with teacher.
    else if (interceptedRect.area() == 0 && (interceptedRect.height != 0 || interceptedRect.width != 0))
      return rightRect.perimeter() + leftRect.perimeter() - interceptedRect.perimeter() * 2;
    else
      return rightRect.perimeter() + leftRect.perimeter() - interceptedRect.perimeter();
    
  }
  
  // determines if other is inside the object, returns false if they are the same.
  public boolean contains(Rectangle other) {
    // Check if each point is contained in this object.
    Coordinate[] coords = other.coordinates();
    for (Coordinate cord : coords) {
      if (!this.pointContained(cord)) return false;
    }
    
    // Special case, if the rectangle is the same, then it should return false.
    boolean isAllSame = this.x == other.x && this.y == other.y
        && this.width == other.width && this.height == other.height;
    
    return !isAllSame;
  }
  
  // returns if all fields are 0
  public boolean isEmpty() {
    return this.x == this.width && this.x == this.y && this.x == this.height && this.x == 0;
  }
  
  // In an intercept there will be only two points where one rectangle's point(s)
  // are contained in the other - Except in the special case!.
  //           |-----|                   |---------|     * - Most important points
  //         |-|--*  |              |----|--*      |
  //         | |  |  |              |    |  |      |     
  //         | *--|--|              |----|--*      |
  //         |----|                      |---------|
  // From those two points, they are the highest and lowest XY values the rectangle can be.
  // The rectangle can be formed by comparing the XY's and their coordinate differences.
  // X point is found by comparing which of the x points two is smaller.
  // Y point is found by comparing which of the y points two is larger.
  // Width is found by the x difference of the points.
  // Height is found by the y difference of the points.
  // For special case, the other points are found by determining if points on the rightmost
  // rectangle are in both rectangles.
  public static Rectangle intercept(Rectangle obj, Rectangle other) {
    // Considering only the leftmost and rightmost triangle simplifies narrows down the scenarios
    Rectangle leftRect = obj.x <= other.x ? obj : other;
    Rectangle rightRect = leftRect == obj ? other : obj;
    Coordinate[] leftCords = leftRect.coordinates();
    Coordinate[] rightCords = rightRect.coordinates();
    Coordinate first = null, second = null;
    
    boolean isSpecialCase = false;
    int i = 0;
    // Find the coordinate(s) in the leftmost rectangle that is inside the rightmost.
    for (Coordinate cord : leftCords) {
      boolean isContained = rightRect.pointContained(cord);
      if (isContained) {
        if (first == null)
          first = cord;
        else {
          // The special case only happens if one rectangle has two coordinates inside the other
          // The second rectangle won't have any coordinate in the other.
          // Therefore second will not get overwritten in the next loop.
          second = cord;
          isSpecialCase = true;
        }
        ++i;
      }
    }
    
    if (i == 4) 
      // the rectangle is completely contained in the other, each point is inside the other.
      return leftRect;
    
    int j = 0;
    for (Coordinate cord : rightCords) {
      boolean isContained = leftRect.pointContained(cord);
      if (isContained) {
        
        if (j == 1) {
          isSpecialCase = true;
        }
          
        if (first == null) first = cord;
        else second = cord;
        
        ++j;
      }
    }
    if (j == 4)
      return rightRect;
    
    Rectangle rect = new Rectangle(0,0,0,0);
    
    boolean goesThrough = (first == null || second == null);
    if (goesThrough) {
      // Get all possible coordinates, the coordinate are possibilities
      Vector<Coordinate> coordinates = new Vector<Coordinate>(16);
      
      coordinates.add(new Coordinate(rightRect.x, leftRect.y));
      coordinates.add(new Coordinate(rightRect.x, leftRect.y + leftRect.height));
      coordinates.add(new Coordinate(rightRect.x + rightRect.width, leftRect.y));
      coordinates.add(new Coordinate(rightRect.x + rightRect.width, leftRect.y + leftRect.height));
      
      coordinates.add(new Coordinate(rightRect.x, leftRect.y + leftRect.height));
      coordinates.add(new Coordinate(rightRect.x + rightRect.width, leftRect.y + leftRect.height));
      coordinates.add(new Coordinate(rightRect.x, leftRect.y));
      coordinates.add(new Coordinate(rightRect.x + rightRect.width, leftRect.y));
      
      for (Coordinate c : rightCords)
       coordinates.add(c); 
      for (Coordinate c : leftCords)
        coordinates.add(c);
      
      rect = getSpecialRect(coordinates, leftRect, rightRect); 
    }
    else if (!isSpecialCase)
      rect = getRect(first,second);
    else {
      
      // Get all possible coordinates, the coordinate are possibilities,
      // Two of the possible four coordinates may not be in the formed rectangle.
      Vector<Coordinate> coordinates = new Vector<Coordinate>();
      coordinates.add(first); coordinates.add(second);
      // The points make a horizontal line.
      if (first.x == second.x) {
        coordinates.add(new Coordinate(rightRect.x, first.y));
        coordinates.add(new Coordinate(rightRect.x, second.y));
        
        coordinates.add(new Coordinate(leftRect.x + leftRect.width, first.y));
        coordinates.add(new Coordinate(leftRect.x + leftRect.width, second.y));
        
      }
      else { // Points make a vertical line where first.y == second.y
        coordinates.add(new Coordinate(first.x, leftRect.y + leftRect.height));
        coordinates.add(new Coordinate(second.x, leftRect.y + leftRect.height));
        
        coordinates.add(new Coordinate(first.x, leftRect.y));
        coordinates.add(new Coordinate(second.x, leftRect.y));
        
      }
      
      rect = getSpecialRect(coordinates, leftRect, rightRect);
    }
      
    return rect;
    
  }
  
  // Get the rectangle from two coordinates, where the coordinates
  // are either the same in X or Y value or they have a x and y difference
  private static Rectangle getRect(Coordinate first, Coordinate second) {
    if (first == null || second == null ) // it doesn't intercept
      return new Rectangle(0, 0, 0, 0);
    float farLeftX = first.x <= second.x ? first.x : second.x;
    float lowestY = first.y <= second.y ? first.y : second.y;
    Coordinate base = new Coordinate(farLeftX, lowestY);
    return new Rectangle(base, Math.abs(first.x - second.x), Math.abs(first.y - second.y));
  }
  // Check each coordinate to determine if they are in both
  // Then find the lowest and highest XY values.
  private static Rectangle getSpecialRect(List<Coordinate> coordinates, Rectangle rect1, Rectangle rect2) {
    Set<Coordinate> cords = new TreeSet<Coordinate>();
    // Get the four points that make the rectangle.
    for (int i = 0; i < coordinates.size(); i++) {
      Coordinate cord = coordinates.get(i);
      if (rect1.pointContained(cord) && rect2.pointContained(cord)) // if they're in both triangles
        cords.add(cord);
    }
    
    // Get the lowest XY and highest XY
    Coordinate[] lowestCords = new Coordinate[2];
    int i = 0;
    for (Iterator<Coordinate> it = cords.iterator(); it.hasNext(); i++) {
      Coordinate c = it.next();
      if (i == 0)
        lowestCords[0] = c;
      else if (i == cords.size() - 1)
        lowestCords[1] = c;
    }
    // From the lowest and highest, the problem is the same as the original.
    return getRect(lowestCords[0], lowestCords[1]);
  }
  
  // Returns the coordinate locations of the rectangle where :
  // E1 -> bottom-left  E2 -> top-left  E3 -> top-right  E4 -> bottom-right  
  public Coordinate[] coordinates() {
    Coordinate[] coords = new Coordinate[4];
    coords[0] = new Coordinate(this.x, this.y);
    coords[1] = new Coordinate(this.x, this.y + this.height);
    coords[2] = new Coordinate(this.x + this.width, this.y + this.height);
    coords[3] = new Coordinate(this.x + this.width, this.y);
    return coords;
  }
  
  // Determines if point x,y is inside/on the rectangle.
  public boolean pointContained(float x, float y) {
    boolean containedX = this.x <= x && this.x + this.width >= x;
    boolean containedY = this.y <= y && this.y + this.height >= y;
    return containedX && containedY;
  }
  
  // Overloaded for Coordinate type
  public boolean pointContained(Coordinate cord) {
    return pointContained(cord.x, cord.y);
  }
  
}
