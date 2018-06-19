public static class Coordinate implements Comparable<Coordinate> {
  public float x;
  public float y;
  
  Coordinate(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  // Function creates a semi-unique hashcode for an object
  // Needed for LinkedHashSet to work.
  @Override
  public int hashCode() {
    final int prime = 31;
    float result = 1;
    result = prime * result + x;
    result = prime * result + y;
    return (int)result;
  }
  
  
  // Function determines if an object is equal to this.
  // Needed for LinkedHashSet to sort
  @Override
  public boolean equals(Object obj) {
    // check the memory locations
    if (this == obj)
      return true;
    if (obj == null)
      return false;
    // Check if the class properties are the same
    if (getClass() != obj.getClass())
      return false;
    // Check the data fields
    Coordinate other = (Coordinate) obj;
    if (x != other.x)
      return false;
    if (y != other.y)
      return false;
    return true;
  }

  public boolean equals(Coordinate e) {
    return this.x == e.x && this.y == e.y;
  }
  
  @Override
  public String toString() {
    return "(" + x + ", " + y + ")";
  }
  
  // Function determines the distance of two coordinates
  public static double linearDistance(Coordinate obj, Coordinate other) {
    return Math.sqrt(Math.pow(obj.x - other.x, 2) + Math.pow(obj.y - other.y, 2));
  }
  
  // Function determines if two coordinates create a straight line
  public static boolean isStraight(Coordinate obj, Coordinate other) {
    if (obj.x == other.x && obj.y != other.y)
      return true;
    else if (obj.y == other.y && obj.x != other.x)
      return true;
    else
      return false;
  }
  
  // Distance from origin
  public double originDistance() {
    return Math.sqrt(Math.pow(x,2) + Math.pow(y, 2));
  }
  
  // Function is used to compare the relative distance of a coordinate.
  @Override
  public int compareTo(Coordinate o) {
    return (int)(this.originDistance() - o.originDistance());
  }
}
