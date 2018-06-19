//declaring variables  //<>//
private int windowLength;
private int windowHeight;
//Initializing stage to 0(Showing the main menu)
int stage = 0;
//PFont startGame;
PFont highScore;
File file = new File("highscore.cfg");
LevelCreator ctr = new LevelCreator();
Animations animate = new Animations();
Screen screen = new Screen();
boolean inMenu = true;
PImage background;
PImage scores;
PImage gameOver;
PImage instruction;


public void setup() {
  size(1000, 800);
  animate.setup();
  setupGuns();
  windowLength = width;
  windowHeight = height;
  background(255);
  ctr.setLevel(1);
  ctr.setup();
  background = loadImage("missedCall.png");
  background.resize(width, height);
  scores = loadImage("scores.png");
  scores.resize(width, height);
  gameOver = loadImage("letsGetThisOverWith.png");
  gameOver.resize(width, height);
  instruction = loadImage("reborn.png");
  instruction.resize(width, height);
}


public void draw() {
  runMenu();
}


/*Everytime mouse is pressed the player
 * will shoot a bullet
 */
public void mousePressed() {
  try {
    ctr.fireSecondary();
  } 
  catch(Exception e) {
  }
  player.mouseHeld = true;
}
/*Everytime mouse is moved the player
 * will look that way
 */
public void mouseMoved() {
  ctr.mouseMoved();
}

public void mouseReleased() {
  player.mouseHeld = false;
}

public void keyPressed() {
  /*
* Control the main menu
   */
  menuPress();
  player.loadKey(key);
  ctr.keyInterpret(key);
  screen.keyInterpret(key);
}

public void keyReleased() {
  player.removeKey(key);
}

public color getRandColor() {
  return color(random(0, 255), random(0, 255), random(0, 255));
}


public int randInt(int min, int max) {
  return min + (int)(Math.random() * ((max - min) + 1));
}


//Each key is binded to a stage
public void menuPress() {
  if (!inMenu) return;

  if ((int)key == 10) {
    stage =  0;
  }
  //0 is binded to stage 0
  if (key == '0') { 
    stage = 0;
  }
  //1 is binded to stage 1
  else if (key == '1') { 
    stage = 1;
  }
  //2 is binded to stage 2
  else if (key == '2') { 
    stage = 2;
  } 
  //3 is binded to stage 3
  else if (key == '3') { 
    stage = 3;
  }
  //4 is binded to stage 4
  else if (key == '4') { 
    stage = 4;
  }
}


//binding stages to parts of the main menu
public void runMenu() {
  //Displaying main menu
  inMenu = true;
  if (stage == 0) {
    background(background);
    textSize(14);
    //Show options
    //Pressing 1 would start the game
    String thiss = "THIS SCREEN (PRESS 0 OR ENTER)";
    text(thiss, 80, 20);
    String startGame = "START GAME (PRESS 1)";
    text(startGame, 80, 50);
    //Pressing 2 will display the highscore
    String highScore = "HIGH SCORE (PRESS 2)";
    text(highScore, 80, 80);
    //Pressing 3 will display the instruction
    String instruction = "INSTRUCTION (PRESS 3)";
    text(instruction, 80, 110);
    //Pressing 4 will quit the game
    String quit = "QUIT (PRESS 4)";
    text(quit, 80, 140);
  }
  //Starts the game
  if (stage == 1) {
    inMenu = false;
    animate.runCoolBackground();
    ctr.tick();
    ctr.drawLevel();
    ctr.movePlayer();
    ctr.overlay();
  }
  //Display High Score
  if (stage == 2) {
    background(scores);

    String[] letters = loadStrings("highscore.cfg");
    String[] highscore = new String[letters.length];
    String[] names  = new String[letters.length];
    int[] scores  = new int[letters.length];
    //get length of text file

    //sorting try 1

    for (int i = 0; i<letters.length; i++) {
      highscore = letters[i].split(",");
      names[i] = highscore[0];
      try {
        scores[i] = Integer.parseInt(highscore[1]);
      } 
      catch(Exception e) {
        scores[i] = Integer.MIN_VALUE;
      }
    }

    int n = scores.length;
    int temp = 0;
    String nameTemp = null;
    for (int i = 0; i < n; i++) {
      for (int j = 1; j < (n - i); j++) {

        if (scores[j - 1] < scores[j]) {
          temp = scores[j - 1];
          nameTemp = names[j - 1];
          scores[j - 1] = scores[j];
          names[j - 1] = names[j];
          scores[j] = temp;
          names[j] = nameTemp;
        }
      }
    }

    String[][] arr = new String[letters.length][letters.length];
    for (int i = 0; i != scores.length; i++) {
      arr[i] = new String[]{ names[i], String.valueOf(scores[i]) };
    }

    pushMatrix();
    textAlign(CENTER);
    textSize(24);
    for (int i = 0; i != letters.length && i <= 10; i++) {
      String s = arr[i][0] + " : " + arr[i][1];
      text(s, width / 2, 50 + 30 * i);
    }
    popMatrix();
    textSize(12);
  }
  //Displays Instruction
  if (stage == 3) {
    background(instruction);
    String instruction = "=======INSTRUCTION=======";
    text(instruction, 50, 20);
    String moveUp = "MOVE UP      W";
    text(moveUp, 50, 50);
    String moveDown = "MOVE DOWN      S";
    text(moveDown, 50, 80);
    String moveLeft = "MOVE LEFT      A";
    text(moveLeft, 50, 110);
    String moveRight = "MOVE RIGHT      D";
    text(moveRight, 50, 140);
    String reload = "RELOAD      R";
    text(reload, 50, 170);
    String swap = "SWAP PRIMARY & SECONDARY      1, 2";
    text(swap, 50, 200);
    String swapFloor = "SWAP GUNS ON FLOOR       E";
    text(swapFloor, 50, 230);
  }

  //Quits the game
  if (stage == 4) {
    exit();
  }
  // User can add to highscore
  if (stage == 5) {
    inMenu = false;
    screen.getScoreName();
  }
}
