import java.awt.*;
import java.awt.event.*;

import javax.swing.*;
import javax.swing.event.*;
import java.awt.geom.*;

public class Main extends JComponent implements Runnable, KeyListener, MouseListener{
	
	Map map;
	Pacman pacman;
	Menu menu;
	Player2 player2;
	Ghost ghost1;
	Ghost ghost2;
	Ghost ghost3;
	Ghost ghost4;
	
	static Thread thread = null;
	
	// strings of text diplay initializations
	String sPauseGame = "PAUSE";
	String sLostGame = "YOU LOST";
	String sPlayer2Win = "Player 2 Won !";
	int nextDirection = 0; // nextDirection of pacman and of player2.
	int nextDirection2 = 0;
	int bonusTime = 0; //Bonus time used to let the bonus during a specific number of frames.
	static boolean lostGame = false; // setted only if the lost
	static boolean player2Win = false; // setted only if the player 2 won
	boolean endGame = false; //setted if the game is finished, either if player 1 won, or lost, or player 2 won.
	boolean win = false;
	boolean pauseGame = false; //flag to know if the game is paused
	boolean twoPlayers = false; //flag to know if 2 players mode has been activated.
	boolean bonusTimer = false; //flag used to display ghots only once every two frames (depending on the difficulty mode applied)
	//flags setting difficulty. When we launch the game, easy mode is activated.
	boolean easyModeActivated = true; 
	boolean normalModeActivated = false;
	boolean hardModeActivated = false;
	int     modeActivated = 0; //gives the mode activated. 0 = easy, 1 = normal, 2 = hard.
	
	public Main()
	{
		super();
		setFocusable(true);
		addKeyListener(this);
		addMouseListener(this);
		map = new Map();
		setup();

	}
	
	public void setup()
	{
		nextDirection = 0; //each time we reset the game, the next directions has to be setted back to 0 to avoid having packman moving from the last game.
		nextDirection2 = 0;
		pauseGame = false;
		lostGame = false;
		player2Win = false;
		map.init();
		menu = new Menu();
		pacman = new Pacman(map.map, menu);
		ghost1 = new Ghost(map.map, 185, 205, pacman); //call our ghost class as many times as we want to have many ghosts.
		ghost2 = new Ghost(map.map, 365, 205, pacman);
		ghost3 = new Ghost(map.map, 185, 325, pacman);
		if (twoPlayers == false) //Since player 2 is the fourth ghost, if 2 player mode is activated, we only create 3 ghosts.
			ghost4 = new Ghost(map.map, 365, 325, pacman);
		else
			player2 = new Player2(map.map, 365, 325, pacman);
	}
	
	private void update() 
	{
		  if (endGame != true && pauseGame != true) //pacman move is stopped if the game is finished or if the game is paused.
		  {  
		  // Key Event

			  if (nextDirection == 1) // if the user dont press any key, and if nextdirection has already been setted, pacman keeps moving on.
			    pacman.moveLeft();
			  else if (nextDirection == 2)
			    pacman.moveRight();
			  else if (nextDirection == 3)
			    pacman.moveUp();
			  else if (nextDirection == 4)
			    pacman.moveDown();
		  }

		  if (twoPlayers == true) //check for the player 2 controles. Same way as the pacman handling.
		  {
			  if (nextDirection2 == 1)
			    player2.moveLeft();
			  else if (nextDirection2 == 2)
			    player2.moveRight();
			  else if (nextDirection2 == 3)
			    player2.moveUp();
			  else if (nextDirection2 == 4)
			    player2.moveDown();
		  }

		  
		  
		    // Restart Button check
		  
		     /*
		  if (frameRate > 150) // Framerate timer check, if the bonus has been used, it will last for 2000 frames.
		  {
		    bonusTime++;
		    if (bonusTime > 2000)
		    {
		      bonusTime = 0;
		      pacman.stopBonus();
		    }
		  }*/
	}

	public void paintComponent(Graphics g) 
	{ 
		Graphics2D g2d = (Graphics2D) g; 
    
		g.setColor(Color.BLACK);
		g.fillRect(0, 0, getWidth(), getHeight());
		map.draw(g2d);
		pacman.draw(g2d);
		win = menu.draw(twoPlayers, modeActivated, g2d);
		endGame = menu.draw(twoPlayers, modeActivated, g2d); //the endgame is setted if the players has the maximum score, checked in the display method of the menu class.
	    if(pauseGame == true && win == false) //check if the game is paused to stop ghosts if it is.
	    {
		      ghost1.display(true, g2d);
		      ghost2.display(true, g2d);
		      ghost3.display(true, g2d);
		      if (twoPlayers == false)
		    	  ghost4.display(true, g2d);
		      else
		    	  player2.draw(g2d);
	     }
	     else
	     { 
		     ghost1.display(false, g2d);
		     ghost2.display(false, g2d);
		     ghost3.display(false, g2d);
		     if (twoPlayers == false)
		    	 ghost4.display(false, g2d);
		     else
		    	 player2.draw(g2d);
	     }
		  if (lostGame == true) // if player(s) lost, we stop pacman display and move.
		  {
			  g2d.setColor(Color.red);
			  g2d.setFont(new Font("Calibri", Font.PLAIN, 39)); 
			  g2d.drawString(sLostGame, 180, 280);
			  endGame = true;
		  }
		  if (player2Win == true) // same, we stop pacman move and display if player 2 won.
		  {
			  g2d.setColor(Color.red);
			  g2d.setFont(new Font("Calibri", Font.PLAIN, 39)); 
			  g2d.drawString(sPlayer2Win, 180, 280);
			  endGame = true;
		  }
		  if (pauseGame == true && endGame == false) //If the game is paused, we display a screen message.
		  {
			  g2d.setColor(Color.red);
			  g2d.setFont(new Font("Calibri", Font.PLAIN, 39)); 
			  g2d.drawString(sPauseGame, 220, 280);
		  }
	}
	
	public void pause()
	{
		if (pauseGame == true)
		    pauseGame = false;
	    else //If the game is finished, user can not pause anymore to avoid display issues.
		    pauseGame = true;
	}
	
	public void keyPressed(KeyEvent e)
	{
		switch (e.getKeyCode())
		{
		case KeyEvent.VK_UP :
			nextDirection = 3;
			break;
		case KeyEvent.VK_RIGHT:
			nextDirection = 2;
			break;
		case KeyEvent.VK_DOWN :
			nextDirection = 4;
			break;
		case KeyEvent.VK_LEFT :
			nextDirection = 1;
			break; 
		case KeyEvent.VK_SPACE :
			pause();
			break;
		}
		
		if (twoPlayers == true)
		{
			switch (e.getKeyCode())
			{
			case KeyEvent.VK_Q :
			    nextDirection2 = 1;
				break;
			case KeyEvent.VK_D:
			    nextDirection2 = 2;
				break;
			case KeyEvent.VK_Z :
			    nextDirection2 = 3;
				break;
			case KeyEvent.VK_S :
			    nextDirection2 = 4;
				break; 
			}
		}
	}
	
	public void mouseClicked(MouseEvent e) {
		if (e.getX() >= 565 && e.getX() <= 700 && e.getY() >= 20 && e.getY() <= 70) // check if the button 'restart' has been clicked
			setup();
		if (e.getX() >= 565 && e.getX() <= 700 && e.getY() >= 90 && e.getY() <= 140) // check is the user want to switch the number of players.
		  {
		    if (twoPlayers == false)
		    	twoPlayers = true;
		    else if (twoPlayers == true)
		    	twoPlayers = false;    
		    setup();
		  }
	}

	public void run() 
	{

		// This is the animation loop: It runs forever
		while (true) 
		{
			update();  // update animation frame
			repaint(); // repaint animation frame: triggers a call to paintComponent
			try {
				thread.sleep(1000 / 100);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public static void main(String[] args) 
	{ 
		JFrame frame = new JFrame(); 
		frame.setSize(700, 700);     
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); 

		Main canvas = new Main();

		thread = new Thread(canvas);
		thread.start();
		
		frame.add(canvas);
		frame.setVisible(true);

	}

	public void mouseEntered(MouseEvent arg0) {		
	}

	public void mouseExited(MouseEvent arg0) {		
	}

	public void mousePressed(MouseEvent arg0) {		
	}

	public void mouseReleased(MouseEvent arg0) {		
	}
	
	public void keyReleased(KeyEvent arg0) {
	}

	public void keyTyped(KeyEvent arg0) {
	}


}