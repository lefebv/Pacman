import java.awt.Color;
import java.awt.Graphics2D;


public class Ghost {
	Pacman pacman;
	int map[][] = null;
	  int x; int y;
	  int ghostSize = 7;
	  int rand; //this is used to handle the random movement of the ghosts.
	  boolean checkRand = true;
	  
	  Ghost (int _map[][], int _x, int _y, Pacman _pacman) //When we call the constructor, we specify the position of the ghost directly.
	  {
		  pacman = _pacman;
		  map = _map;
		  x = _x;
		  y = _y;
	  }
	  
	  void checkLose() // This methode is called from the draw method. Because of the differant difficulty modes, sometimes, ghosts display are called only once on two frames so the check about pacman position is not done
	  // In this specific case, this method is called from the draw method to check on pacman position even if the ghost display method had not been called. 
	  {
	    pacman.checkLose(x, y, 0);    //Send the actual coordonates of the specific ghost, and a 0 to let the checkLose method know that it is not the player two, but a simple ghost.
	  }
	  
	  void display(boolean gamePaused, Graphics2D g2d) //Display method for the ghosts.
	  {
		  if(gamePaused == false) //If the game is paused, then the ghost should not move.
		   {
			   g2d.setColor(Color.pink);
			   g2d.fillOval(x+5, y+5, ghostSize, ghostSize); //Displays ghost
			   if (checkRand == true) // Get a random number to get a random direction
				   rand = 1 + (int)(Math.random() * ((4 - 1) + 1));
			   if (rand == 1)
				   if ((map[((int)y + 15) / 20][((int)x - 5) / 20] != 'X') && ((((int)x - 5) % 20) == 0)) // Check if ghost hits a wall; DOWN
					   moveDown();
				   else
					   checkRand = true; // If it does, we switch rand to make the ghost change direction each time it hits a wall.
			   if (rand == 2)
				   if (map[((int)y) / 20][((int)x +15) / 20] != 'X' && ((((int)y - 5) % 20) == 0)) // RIGHT
					   moveRight();
				   else
					   checkRand = true;
			   if (rand == 3)
				   if (map[((int)y) / 20][((int)x - 6) / 20] != 'X' && ((((int)y - 5) % 20) == 0))  //  LEFT
					   moveLeft();
				   else
					   checkRand = true;
			   if (rand == 4)
		     	if ((map[((int)y - 6) / 20][((int)x - 5) / 20] != 'X') && ((((int)x - 5) % 20) == 0))   // UP
		     		moveUp();
		     	else
		     		checkRand = true;
		   }
	  }
	  
	  void moveLeft()
	  {
	    pacman.checkLose(x, y, 0); //Before moving the ghost, we need to check if pacman had moved to the old position of the ghost.
	    if ((int)x < 12) //Check if ghost gets out of the map, if yes ghost position is setted to the opposite position.
	    {
	    	x = 540;
	    }
	    x -= 1;
	    checkRand = false; //Until the ghost hits a wall, he keeps going on the same direction.
	    if ((map[((int)y - 6) / 20][((int)x - 5) / 20] != 'X') && ((((int)x - 5) % 20) == 0))   // Theses too checks are used to manage a switch direction even if the ghost hasn't hit a wall. check if the upper block is not a wall.
	      if ((int)(Math.random() * ((2 - 1) + 1)) == 0)
	        rand = 4;
	    if ((map[((int)y + 15) / 20][((int)x - 5) / 20] != 'X') && ((((int)x - 5) % 20) == 0)) // Same for the DOWN direction.
	      if ((int)(Math.random() * ((2 - 1) + 1)) == 0)
	        rand = 1;
	    pacman.checkLose(x, y, 0); //After moving, we check on the pacman position again.
	  }
	  
	  void moveRight() // Same as the moveLeft method
	  {
	    pacman.checkLose(x, y, 0);
	    if (map[((int)y - ghostSize - 3) / 20][((int)x + ghostSize + 3) / 20] == 'E') //Check if ghost gets out of the map, if yes ghost position is setted to the opposite position.
	    {
	      x = 0;
	    }
	    x += 1;
	    checkRand = false;
	    if ((map[((int)y - 6) / 20][((int)x - 5) / 20] != 'X') && ((((int)x - 5) % 20) == 0))   // UP
	      if ((int)(Math.random() * ((2 - 1) + 1)) == 0)
	        rand = 4;
	    if ((map[((int)y + 15) / 20][((int)x - 5) / 20] != 'X') && ((((int)x - 5) % 20) == 0)) // DOWN
	      if ((int)(Math.random() * ((2 - 1) + 1)) == 0)
	        rand = 1;
	    pacman.checkLose(x, y, 0);
	  }
	  
	  void moveUp() // Same as the moveLeft method without the out-of-map check because pacman cannot leave from the top or the bottom of the map.
	  {
	    pacman.checkLose(x, y, 0);
	    y -= 1;
	    checkRand = false;
	    if (map[((int)y) / 20][((int)x +15) / 20] != 'X' && ((((int)y - 5) % 20) == 0)) // RIGHT
	      if ((int)(Math.random() * ((2 - 1) + 1)) == 0)
	        rand = 2;
	    if (map[((int)y) / 20][((int)x - 6) / 20] != 'X' && ((((int)y - 5) % 20) == 0))  //  LEFT
	      if ((int)(Math.random() * ((2 - 1) + 1)) == 0)
	        rand = 3;
	     pacman.checkLose(x, y, 0);
	  }
	  
	  void moveDown() // Same as the moveUp method
	  {
	    pacman.checkLose(x, y, 0);
	    y += 1;
	    checkRand = false;
	    if (map[((int)y) / 20][((int)x +15) / 20] != 'X' && ((((int)y - 5) % 20) == 0)) // RIGHT
	      if ((int)(Math.random() * ((2 - 1) + 1)) == 0)
	        rand = 2;
	    if (map[((int)y) / 20][((int)x - 6) / 20] != 'X' && ((((int)y - 5) % 20) == 0))  //  LEFT
	      if ((int)(Math.random() * ((2 - 1) + 1)) == 0)
	        rand = 3;
	    pacman.checkLose(x, y, 0);
	  }
}
