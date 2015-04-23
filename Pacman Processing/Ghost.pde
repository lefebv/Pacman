/////////////////////////////////////  PACMAN PROCESSING VERSION BY BENOIT BONNET AND THIBAULT LEFEBVRE  ///////////////////////////////////////////////
/////////////////////////////////////    RUC INTRODUCTION TO GRAPHIC ANIMATION PROJECT N°1 10/30/2013    ///////////////////////////////////////////////

// This is our Ghost Class. It is used to handle everything about ghost gesture.

class Ghost
{
  int map[][] = null;
  int x; int y;
  int ghostSize = 7;
  int rand; //this is used to handle the random movement of the ghosts.
  boolean checkRand = true;
  
  Ghost (int _map[][], int _x, int _y) //When we call the constructor, we specify the position of the ghost directly.
  {
    map = _map;
    x = _x;
    y = _y;
  }
  
  void erase() //Because of our chose not to delate the background on each frame, we have to delate our ghost before displaing the new one.
  {
    fill(0, 0, 0);
    ellipse(x, y, ghostSize+2, ghostSize+2); 
    fill(255, 255, 255);
  }
  
  void checkLose() // This methode is called from the draw method. Because of the differant difficulty modes, sometimes, ghosts display are called only once on two frames so the check about pacman position is not done
  // In this specific case, this method is called from the draw method to check on pacman position even if the ghost display method had not been called. 
  {
    pacman.checkLose(x, y, 0);    //Send the actual coordonates of the specific ghost, and a 0 to let the checkLose method know that it is not the player two, but a simple ghost.
  }
  
  void display(boolean gamePaused) //Display method for the ghosts.
  {
   if(gamePaused == false) //If the game is paused, then the ghost should not move.
   {
   erase();
   fill(255, 0, 255);
   ellipse(x , y, ghostSize, ghostSize); //Displays ghost
   fill(0,0,0);
   triangle(x+1, y-1, x+3, y, x+3, y-3); //Displays ghost's eyes.
   triangle(x-1, y-1, x-3, y, x-3, y-3);
   if (checkRand == true) // Get a random number to get a random direction
     rand = (int)random(4 + 1);
   if (rand == 1)
     if ((map[((int)y + ghostSize + 3) / 20][((int)x - ghostSize - 3) / 20] != 'X') && ((((int)x - 10) % 20) == 0)) // Check if ghost hits a wall; DOWN
       moveDown();
     else
       checkRand = true; // If it does, we switch rand to make the ghost change direction each time it hits a wall.
   if (rand == 2)
     if (map[((int)y - ghostSize - 3) / 20][((int)x + ghostSize + 3) / 20] != 'X' && ((((int)y - 10) % 20) == 0)) // RIGHT
       moveRight();
     else
       checkRand = true;
   if (rand == 3)
     if (map[((int)y - ghostSize - 3) / 20][((int)x - ghostSize - 4) / 20] != 'X' && ((((int)y - 10) % 20) == 0) && (int)x > 10)  //  LEFT
       moveLeft();
     else
       checkRand = true;
   if (rand == 4)
     if ((map[((int)y - ghostSize - 4) / 20][((int)x - ghostSize - 3) / 20] != 'X') && ((((int)x - 10) % 20) == 0))   // UP
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
      erase();
      x = 540;
    }
    x -= 1;
    checkRand = false; //Until the ghost hits a wall, he keeps going on the same direction.
    if ((map[((int)y - ghostSize - 4) / 20][((int)x - ghostSize - 3) / 20] != 'X') && ((((int)x - 10) % 20) == 0))   // Theses too checks are used to manage a switch direction even if the ghost hasn't hit a wall. check if the upper block is not a wall.
      if ((int)random(2) == 0)
        rand = 4;
    if ((map[((int)y + ghostSize + 3) / 20][((int)x - ghostSize - 3) / 20] != 'X') && ((((int)x - 10) % 20) == 0)) // Same for the DOWN direction.
      if ((int)random(2) == 0)
        rand = 1;
    if ((map[((int)y - ghostSize - 3) / 20][((int)x + ghostSize + 4) / 20] == 'C' && (((int)x + 2) % 20) == 0)) //Check if the ghost went over a coins. If yes, just after passing it, this re-display the coin.
    {
     fill(255, 255, 51);
     ellipse(x + 12, y, 3, 3);
    }
    if ((map[((int)y - ghostSize - 3) / 20][((int)x + ghostSize + 4) / 20] == 'B' && (((int)x + 6) % 20) == 0)) //Same for the bonus.
    {
     fill(0, 255, 0);
     ellipse(x + 16, y, 6, 6);
    }
    pacman.checkLose(x, y, 0); //After moving, we check on the pacman position again.
  }
  
  void moveRight() // Same as the moveLeft method
  {
    pacman.checkLose(x, y, 0);
    if (map[((int)y - ghostSize - 3) / 20][((int)x + ghostSize + 3) / 20] == 'E') //Check if ghost gets out of the map, if yes ghost position is setted to the opposite position.
    {
      erase();
      x = 0;
    }
    x += 1;
    checkRand = false;
    if ((map[((int)y - ghostSize - 4) / 20][((int)x - ghostSize - 3) / 20] != 'X') && ((((int)x - 10) % 20) == 0))   // UP
      if ((int)random(2) == 0)
        rand = 4;
    if ((map[((int)y + ghostSize + 3) / 20][((int)x - ghostSize - 3) / 20] != 'X') && ((((int)x - 10) % 20) == 0)) // DOWN
      if ((int)random(2) == 0)
        rand = 1;
        
    if (map[((int)y - ghostSize - 3) / 20][((int)x - ghostSize - 4) / 20] == 'C' && (((int)x - 2) % 20) == 0)
    {
     fill(255, 255, 51);
     ellipse(x - 12, y, 3, 3);
    }
    if (map[((int)y - ghostSize - 3) / 20][((int)x - ghostSize - 4) / 20] == 'B' && (((int)x - 6) % 20) == 0)
    {
     fill(0, 255, 0);
     ellipse(x - 16, y, 6, 6);
    }
    pacman.checkLose(x, y, 0);
  }
  
  void moveUp() // Same as the moveLeft method without the out-of-map check because pacman cannot leave from the top or the bottom of the map.
  {
    pacman.checkLose(x, y, 0);
    y -= 1;
    checkRand = false;
    if (map[((int)y - ghostSize - 3) / 20][((int)x + ghostSize + 3) / 20] != 'X' && ((((int)y - 10) % 20) == 0)) // RIGHT
      if ((int)random(2) == 0)
        rand = 2;
    if (map[((int)y - ghostSize - 3) / 20][((int)x - ghostSize - 4) / 20] != 'X' && ((((int)y - 10) % 20) == 0) && (int)x > 10)  //  LEFT
      if ((int)random(2) == 0)
        rand = 3;
    if (map[((int)y + ghostSize + 4) / 20][((int)x - ghostSize - 3) / 20] == 'C' && (((int)y + 2) % 20) == 0)
    {
     fill(255, 255, 51);
     ellipse(x, y + 12, 3, 3);
     }  
    if (map[((int)y + ghostSize + 4) / 20][((int)x - ghostSize - 3) / 20] == 'B' && (((int)y + 6) % 20) == 0)
    {
     fill(0, 255, 0);
     ellipse(x, y + 16, 6, 6);
     }
     pacman.checkLose(x, y, 0);
  }
  
  void moveDown() // Same as the moveUp method
  {
    pacman.checkLose(x, y, 0);
    y += 1;
    checkRand = false;
    if (map[((int)y - ghostSize - 3) / 20][((int)x + ghostSize + 3) / 20] != 'X' && ((((int)y - 10) % 20) == 0)) // RIGHT
      if ((int)random(2) == 0)
        rand = 2;
    if (map[((int)y - ghostSize - 3) / 20][((int)x - ghostSize - 4) / 20] != 'X' && ((((int)y - 10) % 20) == 0) && (int)x > 10)  //  LEFT
      if ((int)random(2) == 0)
        rand = 3;
    if (map[((int)y - ghostSize - 4) / 20][((int)x - ghostSize - 3) / 20] == 'C' && (((int)y - 2) % 20) == 0)
    {
     fill(255, 255, 51);
     ellipse(x, y - 12, 3, 3);
    }
    if (map[((int)y - ghostSize - 4) / 20][((int)x - ghostSize - 3) / 20] == 'B' && (((int)y - 6) % 20) == 0)
    {
     fill(0, 255, 0);
     ellipse(x, y - 16, 6, 6);
    }
    pacman.checkLose(x, y, 0);
  }
}
