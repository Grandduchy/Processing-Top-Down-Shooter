import java.io.*;

public class Screen {
  
  boolean isScoreScreen = false;
  
  public String name = "My name";
  public PrintWriter fout;
  public String message;
  
  public boolean getScoreName(int finalScore) {
    pushMatrix();
    background(gameOver);
    fill(255);
    textSize(25);
    textAlign(CENTER);
    text(message, width / 2, 100);
    text("Enter your name below", width / 2, 150);
  
    text(name, width / 2, 200);
    
    text("Final score : " + finalScore, width/2, 300);
  
    popMatrix();
    textSize(14);
    return isScoreScreen;
  }

  public boolean getScoreName() {
   return getScoreName(score); 
  }
  
  public void setScoreScreen(boolean b, String msg) {
   this.isScoreScreen = b; 
   this.message = msg;
  }
  
  public void keyInterpret(char i) {
    if (isScoreScreen) {
      if ((int)i == 8) { // backspace
        if (name != null && name.length() > 0)
          name = name.substring(0, name.length() - 1);
      }
      if ((int)i == 10) { // enter
        writeToFile(score);
        score = 0;
        isScoreScreen = false;
        stage = 2;
      }
      if (i >= 32 && i <= 126) { // a-zA-Z
        name += i;
      }
      
    }
  }
  
  public void writeToFile(String otherName, int finalScore) {
    try {
    if (fout == null) {
      fout = new PrintWriter(new FileOutputStream(sketchPath() + "\\data\\" + file.getName(), true) );
    }
    fout.println(otherName + "," + finalScore);
    fout.flush();
    } catch(Exception e) {
      println("Your recent score was not saved.");
    }
   }
  
  public void writeToFile(int finalScore) {
   writeToFile(this.name, finalScore); 
  }
  
}
