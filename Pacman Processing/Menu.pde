/////////////////////////////////////  PACMAN PROCESSING VERSION BY BENOIT BONNET AND THIBAULT LEFEBVRE  ///////////////////////////////////////////////
/////////////////////////////////////    RUC INTRODUCTION TO GRAPHIC ANIMATION PROJECT N°1 10/30/2013    ///////////////////////////////////////////////

// This class is used to handle everything about the menu display.

class Menu
{
  int score; // Actual value of the score.
  // All the Sting variables here are  used to display the text we want and are only called when the conditions are checked.
  String sScore;
  String sRestart = "RESTART";
  String sPause = "Press SPACE";
  String sPauseb = "To Pause";
  String sCommands = "Player 2 keys:";
  String sCommandsR = "Right  = \"D\"";
  String sCommandsL = "Left    = \"Q\"";
  String sCommandsU = "UP      = \"Z\"";
  String sCommandsD = "Down  = \"S\"";
  String sVictorySinglePlayer = "You won!!";
  String sVictory2Players = "Player 1 Won !!";
  String sVictoryRestart = "Press RESTART to play again !";
  String sTwoPlayers = "Click here";
  String sTwoPlayersb = "For 2 Players";
  String sSinglePlayer = "Click here";
  String sSinglePlayerb = "For Solo Game";
  String sEasyMode = "Easy Mode";
  String sNormalMode = "Normal Mode";
  String sHardMode = "Hard Mode";


  Menu() // The constructor is only called from the setup method. Each time we play again, we set the score back to 0.
  {
    score = 0;
  }
  
  boolean display(boolean twoPlayers, int modeActivated) //Display the menu. Since the number of players or the difficulty of the games matter for the menu display, we need theses parameters.
  {
    
    //Restart button handling. (using a rectangle, and the text setted above)
    fill(50, 50, 50);
    rect(565, 20, 135, 50);
    fill(255, 0, 255);
    textSize(22);
    text(sRestart, 585, 50);
    textSize(15);
    sScore = "Score = " + score;
    text(sScore, 585, 170);
    if (score == 2510) //Check for victory. This display method is called from the draw method. As soon has the player gets the last coin, he has the maximum score, and this means that he won.
    {
      fill(255, 0, 0);
      textSize(40);
      if (twoPlayers == false) //If the player is solo, the message will not be the same as if he plays against someone else.
      text(sVictorySinglePlayer, 200, 260);
      else
      text(sVictory2Players, 160, 260);
      text(sVictoryRestart, 50, 300);
      return (true);
    }
    
    
    //Pause information handling
    //No rectangle because this is not a button. It just gives the player the information he needs to pause the game.
    fill(255, 0, 0);
    textSize(20);
    text(sPause, 575, 220);
    text(sPauseb, 575, 240);
    
    
    //Two players button handling
    // We switch the text depending on the number of player.
    if (twoPlayers == false)
    {
    fill(50, 50, 50);
    rect(565, 90, 135, 50);
    fill(255, 0, 255);
    textSize(20);
    text(sTwoPlayers, 575, 110); //Let the player knows that if he clics on the button, 2 players mode is going to be activated.
    text(sTwoPlayersb, 575, 130);
    }
    else if (twoPlayers = true)
    {
    fill(50, 50, 50);
    rect(565, 90, 135, 50);
    fill(255, 0, 255);
    textSize(20);
    text(sSinglePlayer, 575, 110); // Let the player know that if he clics on the button, game will be switched back to 1 player mode.
    textSize(16);
    text(sSinglePlayerb, 575, 130); 


    //Explain commands of player 2 Only if 2 players mode is activated, we display the commands for the player 2.
      fill(255, 0, 0);
      textSize(18);
      text(sCommands, 575, 280);
      textSize(14);
      text(sCommandsR, 575, 300);
      text(sCommandsL, 575, 320);
      text(sCommandsU, 575, 340);
      text(sCommandsD, 575, 360);  
    }
    
    //Difficulties buttons


    //Eazy Mode
    fill(50, 50, 50);
    rect(565, 420, 135, 30);
    fill(255, 0, 255);
    textSize(18);
    text(sEasyMode, 575, 440);
    if (modeActivated == 0) // this is used to know on witch difficutly the player wants to play, it makes a red rectangle around the selected difficulty.
    {
    fill(0,0);
    stroke(255,0,0);
    rect(563, 418, 137, 34);
    stroke(0);
    }
    
    
    //Normal Mode
    fill(50, 50, 50);
    rect(565, 470, 135, 30);
    fill(255, 0, 255);
    textSize(18);
    text(sNormalMode, 575, 490);
    if (modeActivated == 1)
    {
    fill(0,0);
    stroke(255,0,0);
    rect(563, 468, 137, 34);
    stroke(0);
    }
    
    
    //Hard Mode
    fill(50, 50, 50);
    rect(565, 520, 135, 30);
    fill(255, 0, 255);
    textSize(18);
    text(sHardMode, 575, 540);
    if (modeActivated == 2)
    {
    fill(0,0);
    stroke(255,0,0);
    rect(563, 518, 137, 34);
    stroke(0);
    }

  return(false);
  }
  
  void addScore(int nbPoints) //method used to add the score. Called by pacman if it hits a coin or a bonus.
  {
    fill(0, 0, 0);
    rect(585, 150, 100, 50); //before displaying the new score, we erase the last score.
    score += nbPoints; 
  }

}
