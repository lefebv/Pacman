import java.awt.Color;
import java.awt.Graphics2D;


public class Player2 {

	Menu menu;
	Pacman pacman;
	int map[][] = null;
	int pacmanSize = 14;
	int x, y; //Global coordonates on the map
	int currentDirection = 0; //used to know in witch direction pacman is moving
	int inMovement = 0; //used to handle the pacman display when it is not in movement
	int open = 0; int close = 0; //used to handle the switch between open or closed mouth of pacman
	
	public Player2(int _map[][], int _x, int _y, Pacman _pacman)
	{
		map = _map;
		x = _x;
	    y = _y;
	    pacman = _pacman;
	}

	void draw(Graphics2D g2d)
	{
		g2d.setColor(Color.green);
		g2d.fillOval(x, y, pacmanSize, pacmanSize);

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
	    pacman.checkLose(x, y, 1);
	    if (map[(y - 6) / 20][(x - 5) / 20] != 'X' && (((x-5)%20)==0))//check if pacman can move on the top, using map coordonates. 
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
	    pacman.checkLose(x, y, 1);
	}
	
	void moveDown()
	{
	    pacman.checkLose(x, y, 1);
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
	    pacman.checkLose(x, y, 1);
	}
	
	void moveLeft()
	{
	    pacman.checkLose(x, y, 1);
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
	    pacman.checkLose(x, y, 1);
	}
	
	void moveRight()
	{
	    pacman.checkLose(x, y, 1);
	    if (map[(y) / 20][(x + pacmanSize+1) / 20] != 'X' && (((y-5)%20)==0)  && map[(y) / 20][(x + pacmanSize) / 20] != 'E')
	    {
	      x += 1; 
	      inMovement = 1;
	      currentDirection = 2;
	    }
		else if (map[(y) / 20][(x + pacmanSize) / 20] == 'E') //Check if pacman gets out of the map, if yes pacman position is setted to the opposite position.
		      x = 0;
	    else if (currentDirection != 2) //If we were not abe to walk on the right for any reason, and if currentdirection is not also right, we call the method to keep walking on the current direction.
	      continueMoving();
	    else // if pacman is stoped, then the inMovement value used to check on the mouth gesture is setted to 0
	    	inMovement = 0;
	    pacman.checkLose(x, y, 1);
	}
}
