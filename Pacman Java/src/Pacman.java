import java.awt.Color;
import java.awt.Graphics2D;


public class Pacman {

	Menu menu;
	int map[][] = null;
	int pacmanSize = 14;
	int x, y; //Global coordonates on the map
	int currentDirection = 0; //used to know in witch direction pacman is moving
	int inMovement = 0; //used to handle the pacman display when it is not in movement
	int open = 0; int close = 0; //used to handle the switch between open or closed mouth of pacman
	
	public Pacman(int _map[][], Menu _menu) 
	{
		map = _map;
		menu = _menu;
		int i = 0; int j = 0;
		while(i < 28)  //this while allows us to know the beginning position of pacman, setted in the map
		{
			j = 0;
			while (j < 30)
			{
				if (map[i][j] == 'P') // When we see Pacman on the map, we take his coordinate and convert it into pixel coordinate
				{
					x = j * 20 + 5;
					y = i * 20 + 5;
				}
				j++;
			}
			i++;
		}
	}

	void draw(Graphics2D g2d)
	{
		g2d.setColor(Color.yellow);
		g2d.fillOval(x, y, pacmanSize, pacmanSize);
	}
	
	void checkLose(int xGhost, int yGhost, int player2) // Check if a ghost touched the Pacman. Also check if the winning ghost is the player 2 or not, to display differants messages.
	  {
	     if (xGhost == x && yGhost == y && player2 == 0)
	     {
	    	 Main.lostGame = true; //Player 1 has been toutched by a ghost so everyone loose.
	     }
	     else if (xGhost == x && yGhost == y && player2 == 1)
	     {
	    	 Main.player2Win = true; //Player 1 has been toutched by player 2 do player 2 wins.
	    	 x = 0;
	    	 y = 0;
	     }     
	  }
	
	void continueMoving() //This is called if the player switch to an impossible direction. while the next direction is not possible, the pacman will keep moving on the current direction.
{
    if (currentDirection == 1) //Pacman keeps walking on the left
    	moveLeft();
	else if (currentDirection == 2) //Pacman keeps walking on the right
		moveRight();
	else if (currentDirection == 3) //Pacman keeps walking on the top
		moveUp();
	else if (currentDirection == 4) //Pacman keeps walking on the bottom
		moveDown();    
}
	
	void moveUp()
	{
		if (map[(y - 6) / 20][(x - 5) / 20] != 'X' && (((x-5)%20)==0)) //check if pacman can move on the top, using map coordonates. 
	    //X is a wall, E is the symbol of the end of the map. The check %20 is used to allow pacman to switch direction only if its Y coordonate is exactly equal to 30 or 50 or 70... this avoid collisions.
	    {
	      y -= 1; //Pacman position on the X axe is incremented by 1 each frame moves pacman by 1 pixel
	      inMovement = 1; //Since pacman moved, the inMovement value has to be set to display the pacman we want.
	      currentDirection = 3; //Set the current direction to the value corresponding to the right to display the pacman we want and to know in which direction pacman has to move if the next direction is not possible.
	    }
		else if (currentDirection != 3)
	      continueMoving();
	    else
	    	inMovement = 0;
	    if (map[(y - 3) / 20][(x) / 20] == 'B' && ((y - 5) % 20) == 0)
	    {
	      menu.addScore(50);
	      //frameRate(200);
	      //bonusTime = 0;
	      map[(y - 3) / 20][(x) / 20] = ' ';

	    }
	    if (map[(y - 3) / 20][(x) / 20] == 'C' && ((y - 1) % 20) == 0)
	    {
	      menu.addScore(10);
	      map[(y - 3) / 20][(x) / 20] = ' ';
	    }
	}	
	
	void moveDown()
	{
		if (map[(y + pacmanSize +1) / 20][(x-5) / 20] != 'X' && (((x-5)%20==0)))
	    {
			y += 1;
			inMovement = 1;
			currentDirection = 4;
	    }
	    else if (currentDirection != 4)
	    	continueMoving();
	    else
	    	inMovement = 0;
		if (map[(y + pacmanSize) / 20][(x) / 20] == 'B' && ((y + 5) % 20) == 0)
		{
			menu.addScore(50);
			//frameRate(200);
			//bonusTime = 0;
			map[(y + pacmanSize) / 20][(x) / 20] = ' ';
		}
		if (map[(y + pacmanSize) / 20][(x) / 20] == 'C' && ((y + 1) % 20) == 0)
		{
			menu.addScore(10);
			map[(y + pacmanSize) / 20][(x) / 20] = ' ';
		}
	}
	
	void moveLeft()
	{
		if (map[(y) / 20][(x -6) / 20] != 'X' && (((y-5)%20)==0) && x > 10)
	    {
			x -= 1;
			currentDirection = 1;
			inMovement = 1;
	    }
		else if (x < 12)
			x = 540;
	    else if (currentDirection != 1)
	    	continueMoving();
	    else
	    	inMovement = 0;      
	    if (map[(y) / 20][(x - 3) / 20] == 'B' && ((x - 5) % 20) == 0)
	    {
	      menu.addScore(50);
	      //frameRate(200);
	      //bonusTime = 0;
	    	map[((int)y - pacmanSize - 3) / 20][(x - pacmanSize - 4) / 20] = ' ';
	    }
	    if (map[(y) / 20][(x - 3) / 20] == 'C' && ((x - 1) % 20) == 0)
	    {
	      menu.addScore(10);
	    	map[(y) / 20][(x - 3) / 20] = ' ';
	    }
	}
	
	void moveRight()
	{
		if (map[(y) / 20][(x + pacmanSize+1) / 20] != 'X' && (((y-5)%20)==0)  && map[(y) / 20][(x + pacmanSize) / 20] != 'E')
	    {
	      x += 1; 
	      inMovement = 1;
	      currentDirection = 2;
	    }
		else if (map[(y) / 20][(x + pacmanSize) / 20] == 'E') //Check if pacman gets out of the map, if yes pacman position is setted to the opposite position.
		      x = 20;
	    else if (currentDirection != 2) //If we were not abe to walk on the right for any reason, and if currentdirection is not also right, we call the method to keep walking on the current direction.
	      continueMoving();
	    else // if pacman is stoped, then the inMovement value used to check on the mouth gesture is setted to 0
	    	inMovement = 0;
	    if (map[(y) / 20][(x + pacmanSize) / 20] == 'B' && ((x + 5) % 20) == 0) //check for Bonus. As soon as pacman hit the bonus (1 specific pixel checked thanks to the %20 check), we delete it from the sreen to avoid having an incomplete cercle.
	    {
	      menu.addScore(50); //Bonus adds 50 points to the score.
	      //frameRate(200); // speed bonus is applied
	      //bonusTime = 0; //bonus timer is cleared, so that is we already had the bonus, the time is reseted.
	      map[(y) / 20][(x + pacmanSize) / 20] = ' '; //our map is modified, to avoid having several times the same bonus on the same map coordonate.
	    }
	    if (map[(y) / 20][(x + pacmanSize) / 20] == 'C' && ((x + 1) % 20) == 0) //check for coins, and implement the score. Same systeme than the bonus.
	    {
	      menu.addScore(10);
	      map[(y) / 20][(x + pacmanSize) / 20] = ' ';
	    }
	}
	

}
