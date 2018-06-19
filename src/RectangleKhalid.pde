/*********Did not use this rectangle class************/

/**
 * ----------------
 * Khalid Ozal
 * Rectangle Class
 * ISU-4U
 * March 3/20/2018
 * ----------------
 */
public static class RectangleK {
  private int left; // left is x-coords
  private int bottom; // bottom is y-coords
  private int width;
  private int height;
  private int area;
  private int perimeter;

  /**
   * Initializing left, bottom, width, height to 0
   */
  public RectangleK() {
    left = 0;
    bottom = 0;
    width = 0;
    height = 0;
  }

  /**
   * Overloading Constructor
   * 
   * @param left
   * @param bottom
   * @param width
   * @param height
   */
  public RectangleK(int left, int bottom, int width, int height) {
    set(left, bottom, width, height);
  }

  /**
   * To check for a negative number and if it is negative assign it to zero
   * 
   * @param left
   * @param bottom
   * @param width
   * @param height
   */
  public void set(int left, int bottom, int width, int height) {
    if (width < 0) {
      width = 0;
    }
    if (height < 0) {
      height = 0;
    }
    this.left = left;
    this.bottom = bottom;
    this.width = width;
    this.height = height;

  }

  /**
   * Finding the area of rectangle
   * 
   * @return
   */
  public int area() {

    area = this.width * this.height;
    return area;
  }

  /**
   * Finding the perimeter of rectangle
   * 
   * @return
   */
  public int perimeter() {

    if (height == 0) {
      perimeter = width;
    } else {
      perimeter = 2 * (this.width + this.height);
    }
    return perimeter;
  }

  /**
   * Finding if rectangle intersect. If they don't overlap return an object
   * rectangle with everything as zero
   * 
   * @param r1
   * @param r2
   * @return
   */
  public static RectangleK intersection(RectangleK r1, RectangleK r2) {
    RectangleK recLeft, recRight, recBottom, recTop;
    int xc, yc, w, h;
    // Finding the left most point.
    if (r1.left < r2.left) {
      recLeft = r1;
      recRight = r2;
    } else {
      recLeft = r2;
      recRight = r1;
    }
    // Finding the bottom most point.
    if (r1.bottom < r2.bottom) {
      recTop = r1;
      recBottom = r2;
    } else {
      recBottom = r2;
      recTop = r1;
    }
    // Checking the overlap Width
    if (recLeft.left + recLeft.width < recRight.left) {
      // no overlap
      return new RectangleK(0, 0, 0, 0);
    } // else if (recLeft.left + recLeft.width > recRight.left + recRight.width) {
      // complete overlap
      // w = recRight.width;
    else {
      // Partly Overlap
      w = recLeft.left + recLeft.width - recRight.left;
    }
    // Checking the overlap for height
    if (recTop.bottom + recTop.height < recBottom.bottom) {
      // no overlap
      return new RectangleK(0, 0, 0, 0);
    } else if (recTop.bottom + recTop.height > recBottom.bottom + recBottom.height) {
      // complete overlap
      h = recBottom.height;
    } else {
      // Partly Overlap
      h = recTop.bottom + recTop.height - recBottom.bottom;
    }
    xc = recRight.left;
    yc = recBottom.bottom;

    return new RectangleK(xc, yc, w, h);
  }

  /**
   * Finding total parameters of two rectangle.
   * 
   * @param r1
   * @param r2
   * @return
   */
  public static int totalPerimeter(RectangleK r1, RectangleK r2) {
    if (intersection(r1, r2).equals(new Rectangle(0, 0, 0, 0))) {
      return 2 * r1.width + 2 * r1.height + 2 * r2.width + 2 * r2.height;
    }
    RectangleK rInt = intersection(r1, r2);
    return 2 * r1.width + 2 * r1.height + 2 * r2.width + 2 * r2.height - 2 * rInt.width - 2 * rInt.height;

  }

  /**
   * Checking for containment of Rectangle and returning true if it is contained.
   * 
   * @param other
   * @return
   */
  public boolean contains(RectangleK other) {
    RectangleK recLeft;
    RectangleK recRight;
    RectangleK recTop;
    RectangleK recBottom;
    if (left < other.left) {
      recLeft = this;
      recRight = other;
    } else {
      recLeft = other;
      recRight = this;
    }
    if (bottom < other.bottom) {
      recTop = this;
      recBottom = other;
    } else {
      recTop = this;
      recBottom = other;
    }

    // IF THEY FULL OVERLAP(special case)
    if (this.left == other.left && this.bottom == other.bottom && this.width == other.width
        && this.height == other.height) {
      return false;
    }
    if (recLeft.left + recLeft.width >= recRight.left + recRight.width
        && recBottom.bottom + recBottom.height >= recTop.bottom + recTop.height);
    return true;
  }
  

  /**
   * Overwriting toString.
   */
  public String toString() {
    return "base:(" + left + "," + bottom + ")" + " w:" + width + " h:" + height;
  }
}
