import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;


public class Menu {
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
  
  Menu() // The constructor is only called from the setup method. Each time we play again, we set the score back to 0.
  {
    score = 0;
  }
  
  boolean draw(boolean twoPlayers, int modeActivated, Graphics2D g2d) //Display the menu. Since the number of players or the difficulty of the games matter for the menu display, we need theses parameters.
  {
    //Restart button handling. (using a rectangle, and the text setted above)
	g2d.setColor(Color.lightGray);
	g2d.fillRect(565, 20, 135, 50);
	g2d.setColor(new Color(255, 0, 255));
	g2d.setFont(new Font("Calibri", Font.PLAIN, 22)); 
	g2d.drawString(sRestart, 585, 50);
    sScore = "Score = " + score;
	g2d.drawString(sScore, 585, 170);
	if (score == 2510) //Check for victory. This display method is called from the draw method. As soon has the player gets the last coin, he has the maximum score, and this means that he won.
    {
		g2d.setColor(Color.red);
		g2d.setFont(new Font("Calibri", Font.PLAIN, 40)); 
		if (twoPlayers == false) //If the player is solo, the message will not be the same as if he plays against someone else.
			g2d.drawString(sVictorySinglePlayer, 200, 260);
		else
			g2d.drawString(sVictory2Players, 160, 260);
		g2d.drawString(sVictoryRestart, 50, 300);
		return (true);
    }
    
    
    //Pause information handling
    //No rectangle because this is not a button. It just gives the player the information he needs to pause the game.
	g2d.setColor(Color.red);
	g2d.setFont(new Font("Calibri", Font.PLAIN, 20)); 
	g2d.drawString(sPause, 575, 220);
	g2d.drawString(sPauseb, 575, 240);
  
    
    //Two players button handling
    // We switch the text depending on the number of player.
    if (twoPlayers == false)
    {
    	g2d.setColor(Color.lightGray);
    	g2d.fillRect(565, 90, 135, 50);
    	g2d.setColor(new Color(255, 0, 255));
    	g2d.setFont(new Font("Calibri", Font.PLAIN, 20)); 
    	g2d.drawString(sTwoPlayers, 575, 110); //Let the player knows that if he clics on the button, 2 players mode is going to be activated.
    	g2d.drawString(sTwoPlayersb, 575, 130);
    }
    else if (twoPlayers = true)
    {
    	g2d.setColor(Color.lightGray);
    	g2d.fillRect(565, 90, 135, 50);
    	g2d.setColor(new Color(255, 0, 255));
    	g2d.setFont(new Font("Calibri", Font.PLAIN, 20)); 
    	g2d.drawString(sSinglePlayer, 575, 110); // Let the player know that if he clics on the button, game will be switched back to 1 player mode.
    	g2d.setFont(new Font("Calibri", Font.PLAIN, 16)); 
    	g2d.drawString(sSinglePlayerb, 575, 130);

    	//Explain commands of player 2 Only if 2 players mode is activated, we display the commands for the player 2.
    	g2d.setColor(Color.red);
    	g2d.setFont(new Font("Calibri", Font.PLAIN, 18)); 
    	g2d.drawString(sCommands, 575, 280); // Let the player know that if he clics on the button, game will be switched back to 1 player mode.
    	g2d.setFont(new Font("Calibri", Font.PLAIN, 14)); 
    	g2d.drawString(sCommandsR, 575, 300); // Let the player know that if he clics on the button, game will be switched back to 1 player mode.
    	g2d.drawString(sCommandsL, 575, 320); // Let the player know that if he clics on the button, game will be switched back to 1 player mode.
    	g2d.drawString(sCommandsU, 575, 340); // Let the player know that if he clics on the button, game will be switched back to 1 player mode.
    	g2d.drawString(sCommandsD, 575, 360); // Let the player know that if he clics on the button, game will be switched back to 1 player mode.

    }

  return(false);
  }

  void addScore(int nbPoints) //method used to add the score. Called by pacman if it hits a coin or a bonus.
  {
    score += nbPoints; 
  }

}

