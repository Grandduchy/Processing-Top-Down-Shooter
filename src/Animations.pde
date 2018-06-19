

PImage clearImg;
PImage youreDeadImg;
PImage bullet;
PImage enemyPistol;
PImage enemyRifle;
PImage playerPistol;
PImage playerRifle;
PImage playerShotgun;

PImage downM4;
PImage downShotgun;

class Animations {
  
  public int clearX = -100;
  
  public int deadOpacity = 0;
  
  public Pair<Integer, Boolean> colorR = new Pair<Integer, Boolean>(155, true);
  public Pair<Integer, Boolean> colorG = new Pair<Integer, Boolean>(155, false); 
  public Pair<Integer, Boolean> colorB = new Pair<Integer, Boolean>(255, true);
  
  public void setup() {
    clearImg = loadImage("clear.png");
    youreDeadImg = loadImage("youredead.png");
    bullet = loadImage("bullet.png");
    enemyPistol = loadImage("enemyPistol.png");
    enemyRifle = loadImage("enemyRifle.png");
    playerPistol = loadImage("playerPistol.png");
    playerRifle = loadImage("playerRifle.png");
    playerShotgun = loadImage("playerShotgun.png");
    downM4 = loadImage("M4A4.png");
    downShotgun = loadImage("mossberg.png");
  }
  
  
  public boolean runClear() {
  if (clearX >= windowLength / 2 - 400 && clearX <= windowLength / 2)
     clearX += 2;
    else
      clearX += 8;
    image(clearImg, clearX, windowHeight / 2);
    return clearX >= windowLength + 200 ? true : false;
  }
  
  public void resetClear() {
   clearX = - 100; 
  }

  public boolean runYoureDead() {
    int x = width / 2 - 300;
    int y = height / 2;
    pushMatrix();
    tint(255, deadOpacity);
    image(youreDeadImg, x, y);
    popMatrix();
    deadOpacity++;
    return deadOpacity > 250;
  }
  
  public void resetYoureDead() {
   deadOpacity = 0; 
  }
  
  public void resetCoolBackground() {
    
  }
  
  public void runCoolBackground() {
    incrementColor(colorR);
    incrementColor(colorG);
    incrementColor(colorB);
    color c = color(colorR.first.intValue(), colorG.first.intValue(), colorB.first.intValue());
    background(c);
  }
  
  private void incrementColor(Pair<Integer, Boolean> colorT) {
    final int speedConst = 1;
    int newColor = colorT.second ? colorT.first + speedConst : colorT.first - speedConst;
    int n = constrain(newColor, 0, 255);
    if (n == newColor) {
     colorT.first = newColor; 
    }
    else {
      colorT.second = !colorT.second;
    }
    
  }
  
  
}
