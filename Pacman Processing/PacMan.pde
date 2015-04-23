/////////////////////////////////////  PACMAN PROCESSING VERSION BY BENOIT BONNET AND THIBAULT LEFEBVRE  ///////////////////////////////////////////////
/////////////////////////////////////    RUC INTRODUCTION TO GRAPHIC ANIMATION PROJECT N°1 10/30/2013    ///////////////////////////////////////////////

// This is our Pacman Class. It is used to handle everything about pacman gesture.

float x, y; //Global coordonates on the map
int currentDirection = 0; //used to know in witch direction pacman is moving
int inMovement = 0; //used to handle the pacman display when it is not in movement
int open = 0; int close = 0; //used to handle the switch between open or closed mouth of pacman

class Pacman
{  
  //each time we create a new pacman, theses values have to be setted
    Map Map; 
    int inMovement = 0;
    int currentDirection = 0;
    int pacmanSize = 7;
    int eyeSize = 1;
    int map[][] = null;

    
 // Constructeur
    Pacman(int _map[][]) 
    {
      map = _map;
      int i = 0; int j = 0;
      while(i < 28)  //this while allows us to know the beginning position of pacman, setted in the map.txt
        {
          j = 0;
          while (j < 30)
          {
            if (map[i][j] == 'P')
             display(j * 20, i * 20); // display pacman using coordonates of the map, * 20 to have the pixel coordonates
            j++;
          }
        i++;
      }
    }
  
  void checkLose(int xGhost, int yGhost, int player2) // Check if a ghost touched the Pacman. Also check if the winning ghost is the player 2 or not, to display differants messages.
  {
     if (xGhost == x && yGhost == y && player2 == 0)
     {
      lostGame = true; //Player 1 has been toutched by a ghost so everyone loose.
      fill(0, 0, 0);
      ellipse(x , y, pacmanSize, pacmanSize); //We erase pacman
     }
     else if (xGhost == x && yGhost == y && player2 == 1)
     {
      player2Win = true; //Player 1 has been toutched by player 2 do player 2 wins.
      fill(0, 0, 0);
      ellipse(x , y, pacmanSize, pacmanSize); //We erase pacman
      x = 0;
      y = 0;
     }     
  }
  
  void display(int X, int Y) //First display method. Only used once at the begining of the game, to display pacman on a specific coordonates
  {
    fill(255, 255, 51);
    ellipse(X + 10 , Y + 10, pacmanSize, pacmanSize); 
    x = X + 10; //Switch x and y to the middle of the rectangle corresponding to the map coordonates since map coordonates gives us the top left point of the block.
    y = Y + 10;
    fill(255,0,0);
    noStroke();
    ellipse(x + 2 , y - 2, eyeSize, eyeSize); 
    ellipse(x - 2 , y - 2, eyeSize, eyeSize); 
    stroke(0); 
    fill(255, 255, 255);
  }

  void display(int currentDirection) //Second display fonction, called from the draw methode
  {
    if (currentDirection == 2 && open < 20 && inMovement == 1) //Current direction is right, the mouth is open and pacman is moving
    {
    fill(255, 255, 51);
    ellipse(x, y, pacmanSize, pacmanSize); 
    fill(0, 0, 0);
    triangle(x, y, x + 9, y - 9, x + 9, y + 9);
    fill(255,0,0);
    noStroke();
    ellipse(x, y - 4, eyeSize, eyeSize); 
    stroke(0); 
    fill(255, 255, 255);
    open++; //We increment open, so that every 20 frames, the status of the mouth switch
    if (open >= 20) //if open = 20, status of the mouth must switch
    close = 0;
    }
    else if (currentDirection == 1 && open < 20 && inMovement == 1) //Current direction is left, and the mouth is open same comments as above.
    {
    fill(255, 255, 51);
    ellipse(x, y, pacmanSize, pacmanSize); 
    fill(0, 0, 0);
    triangle(x, y, x - 9, y - 9, x - 9, y + 9);
    fill(255,0,0);
    noStroke();
    ellipse(x, y - 4, eyeSize, eyeSize); 
    stroke(0); 
    fill(255, 255, 255);
    open++;
    if (open >= 20)
    close = 0;
    }
    else if (currentDirection == 4 && open < 20 && inMovement == 1) //Current direction is down, and the mouth is open same comments as above.
    {
    fill(255, 255, 51);
    ellipse(x, y, pacmanSize, pacmanSize); 
    fill(0, 0, 0);
    triangle(x, y, x - 9, y + 9, x + 9, y + 9);
    fill(255,0,0);
    noStroke();
    ellipse(x - 4, y, eyeSize, eyeSize); 
    stroke(0); 
    fill(255, 255, 255);
    open++;
    if (open >= 20)
    close = 0;
    }
    else if (currentDirection == 3 && open < 20 && inMovement == 1) //Current direction is up, and the mouth is open same comments as above.
    {
    fill(255, 255, 51);
    ellipse(x, y, pacmanSize, pacmanSize); 
    fill(0, 0, 0);
    triangle(x, y, x - 9, y - 9, x + 9, y - 9);
    fill(255,0,0);
    noStroke();
    ellipse(x - 4, y, eyeSize, eyeSize); 
    stroke(0); 
    fill(255, 255, 255);
    open++;
    if (open >= 20)
    close = 0;
    }
    else if (currentDirection == 2 && close < 20 && inMovement == 1) //Current direction is right, and the mouth is closed same comments as above.
    {
    fill(255, 255, 51);
    ellipse(x, y, pacmanSize, pacmanSize); 
    fill(0, 0, 0);
    triangle(x, y, x + 9, y - 3, x + 9, y + 3);
    fill(255,0,0);
    noStroke();
    ellipse(x, y - 4, eyeSize, eyeSize); 
    stroke(0); 
    fill(255, 255, 255);
    close++;
    if (close >= 20)
    open = 0;
    }
    else if (currentDirection == 1 && close < 20 && inMovement == 1) //Current direction is left, and the mouth is closed same comments as above.
    { 
    fill(255, 255, 51);
    ellipse(x, y, pacmanSize, pacmanSize); 
    fill(0, 0, 0);
    triangle(x, y, x - 9, y - 3, x - 9, y + 3);
    fill(255,0,0);
    noStroke();
    ellipse(x, y - 4, eyeSize, eyeSize); 
    stroke(0); 
    fill(255, 255, 255);
    close++;
    if (close >= 20)
    open = 0;
    }
    else if (currentDirection == 4 && close < 20 && inMovement == 1) //Current direction is down, and the mouth is closed same comments as above.
    {
    fill(255, 255, 51);
    ellipse(x, y, pacmanSize, pacmanSize); 
    fill(0, 0, 0);
    triangle(x, y, x - 3, y + 9, x + 3, y + 9);
    fill(255,0,0);
    noStroke();
    ellipse(x - 4, y, eyeSize, eyeSize);
    stroke(0); 
    fill(255, 255, 255);
    close++;
    if (close >= 20)
    open = 0;
    }
    else if (currentDirection == 3 && close < 20 && inMovement == 1) //Current direction is up, and the mouth is cloed same comments as above.
    {
    fill(255, 255, 51);
    ellipse(x, y, pacmanSize, pacmanSize); 
    fill(0, 0, 0);
    triangle(x, y, x - 3, y - 9, x + 3, y - 9);
    fill(255,0,0);
    noStroke();
    ellipse(x - 4, y, eyeSize, eyeSize); 
    stroke(0); 
    fill(255, 255, 255);
    close++;
    if (close >= 20)
    open = 0;
    }
    else //If current direction is not setted (at the begining of the game for exemple, or if close and open are over 20 (meaning that pacman is on a wall)), we display a specific pacman.
    {
    fill(255, 255, 51);
    ellipse(x, y, pacmanSize, pacmanSize); 
    fill(255,0,0);
    noStroke();
    ellipse(x + 2 , y - 2, eyeSize, eyeSize); 
    ellipse(x - 2 , y - 2, eyeSize, eyeSize); 
    stroke(0); 
    fill(255, 255, 255);
    }
  }
  
  void erase() //Because of our chose not to delate the background on each frame, we have to delate our pacman before displaing the new one.
  {
    if (x != 0)
    {
    fill(0, 0, 0);
    ellipse(x, y, pacmanSize+2, pacmanSize+2); // +2 because otherwise pacman let somme colored pixels behind him when he moves.
    fill(255, 255, 255);
    }
  }
  
  void continueMoving() //This is called if the player switch to an impossible direction. while the next direction is not possible, the pacman will keep moving on the current direction.
  {
    if (currentDirection == 1) //Pacman keeps walking on the left
      pacman.moveLeft();
    else if (currentDirection == 2) //Pacman keeps walking on the right
      pacman.moveRight();
    else if (currentDirection == 3) //Pacman keeps walking on the top
      pacman.moveUp();
    else if (currentDirection == 4) //Pacman keeps walking on the bottom
      pacman.moveDown();    
  }
  
  void stopBonus() //Fonction called from the draw method, to stop the speed bonus.
  {
    frameRate(100); 
  }
  
  void moveRight() //Fonction called if the current direction is right, to make pacman move
  {
    erase(); // First, we erase the old pacman (because of the no background(0) in draw method
    if (map[((int)y - pacmanSize - 3) / 20][((int)x + pacmanSize + 3) / 20] != 'X' && ((((int)y - 10) % 20) == 0) && map[((int)y - pacmanSize - 3) / 20][((int)x + pacmanSize + 3) / 20] != 'E') //check if pacman can move on the right, using map coordonates. 
    //X is a wall, E is the symbol of the end of the map. The check %20 is used to allow pacman to switch direction only if its Y coordonate is exactly equal to 30 or 50 or 70... this avoid collisions.
    {
      x = x + 1; //Pacman position on the X axe is incremented by 1 each frame moves pacman by 1 pixel
      inMovement = 1; //Since pacman moved, the inMovement value has to be set to display the pacman we want.
      currentDirection = 2; //Set the current direction to the value corresponding to the right to display the pacman we want and to know in which direction pacman has to move if the next direction is not possible.
    }
    else if (map[((int)y - pacmanSize - 3) / 20][((int)x + pacmanSize + 3) / 20] == 'E') //Check if pacman gets out of the map, if yes pacman position is setted to the opposite position.
      x = 0;
    else if (currentDirection != 2) //If we were not abe to walk on the right for any reason, and if currentdirection is not also right, we call the method to keep walking on the current direction.
      continueMoving();
    else // if pacman is stoped, then the inMovement value used to check on the mouth gesture is setted to 0
    inMovement = 0;
    if (map[((int)y - pacmanSize - 3) / 20][((int)x + pacmanSize + 3) / 20] == 'B' && (((int)x + 5) % 20) == 0) //check for Bonus. As soon as pacman hit the bonus (1 specific pixel checked thanks to the %20 check), we delete it from the sreen to avoid having an incomplete cercle.
    {
      menu.addScore(50); //Bonus adds 50 points to the score.
      frameRate(200); // speed bonus is applied
      bonusTime = 0; //bonus timer is cleared, so that is we already had the bonus, the time is reseted.
      map[((int)y - pacmanSize - 3) / 20][((int)x + pacmanSize + 3) / 20] = ' '; //our map is modified, to avoid having several times the same bonus on the same map coordonate.
      fill(0, 0, 0); 
      ellipse(x + 14, y, 7, 7); //If pacman only touch the bonus, it still works, but we need to display a black cercle on it to erease it complitely.
    }
    if (map[((int)y - pacmanSize - 3) / 20][((int)x + pacmanSize + 3) / 20] == 'C' && (((int)x + 1) % 20) == 0) //check for coins, and implement the score. Same systeme than the bonus.
    {
      menu.addScore(10);
      map[((int)y - pacmanSize - 3) / 20][((int)x + pacmanSize + 3) / 20] = ' ';
      fill(0, 0, 0);
      ellipse(x + 11, y, 4, 4);
    }
    display(currentDirection); //finaly, we display the packman.
  }
  void moveLeft() //Exactly the same method than the moveRight() method using x coordonate instead of the check map "E" to handle the switching side of pacman.
  {
    erase();
    if (map[((int)y - pacmanSize - 3) / 20][((int)x - pacmanSize - 4) / 20] != 'X' && ((((int)y - 10) % 20) == 0) && (int)x > 10) 
    {
      x = x - 1;
      currentDirection = 1;
      inMovement = 1;
    }
    else if ((int)x < 12)
      x = 540;
    else if (currentDirection != 1)
      continueMoving();
    else
    inMovement = 0;      
    if (map[((int)y - pacmanSize - 3) / 20][((int)x - pacmanSize - 4) / 20] == 'B' && (((int)x - 5) % 20) == 0)
    {
      menu.addScore(50);
      frameRate(200);
      bonusTime = 0;
      map[((int)y - pacmanSize - 3) / 20][((int)x - pacmanSize - 4) / 20] = ' ';
      fill(0, 0, 0); 
      ellipse(x - 14, y, 7, 7); 
    }
    if (map[((int)y - pacmanSize - 3) / 20][((int)x - pacmanSize - 4) / 20] == 'C' && (((int)x - 1) % 20) == 0)
    {
      menu.addScore(10);
      map[((int)y - pacmanSize - 3) / 20][((int)x - pacmanSize - 4) / 20] = ' ';
      fill(0, 0, 0);
      ellipse(x - 11, y, 4, 4);
    }
    display(currentDirection);
  }
  
  void moveDown() //Exactly the same method than the moveRight() method
  {
    erase();
    if ((map[((int)y + pacmanSize + 3) / 20][((int)x - pacmanSize - 3) / 20] != 'X') && ((((int)x - 10) % 20) == 0))
    {
      y = y + 1;
      currentDirection = 4;
      inMovement = 1;
    }
    else if (currentDirection != 4)
      continueMoving();
    else
    inMovement = 0;
    if (map[((int)y + pacmanSize + 3) / 20][((int)x - pacmanSize - 3) / 20] == 'B' && (((int)y + 5) % 20) == 0)
    {
      menu.addScore(50);
      frameRate(200);
      bonusTime = 0;
      map[((int)y + pacmanSize + 3) / 20][((int)x - pacmanSize - 3) / 20] = ' ';
      fill(0, 0, 0); 
      ellipse(x, y + 14, 7, 7); 
    }
    if (map[((int)y + pacmanSize + 3) / 20][((int)x - pacmanSize - 3) / 20] == 'C' && (((int)y + 1) % 20) == 0)
    {
      menu.addScore(10);
      map[((int)y + pacmanSize + 3) / 20][((int)x - pacmanSize - 3) / 20] = ' ';
      fill(0, 0, 0);
      ellipse(x, y + 11, 4, 4);
    }
    display(currentDirection);
  }

  void moveUp() //Exactly the same method than the moveRight() method
  {
    erase(); 
    if ((map[((int)y - pacmanSize - 4) / 20][((int)x - pacmanSize - 3) / 20] != 'X') && ((((int)x - 10) % 20) == 0))
    {
      y = y - 1;
      currentDirection = 3;
      inMovement = 1;
    }
    else if (currentDirection != 3)
      continueMoving();
    else
    inMovement = 0;
    if (map[((int)y - pacmanSize - 4) / 20][((int)x - pacmanSize - 3) / 20] == 'B' && (((int)y - 5) % 20) == 0)
    {
      menu.addScore(50);
      frameRate(200);
      bonusTime = 0;
      map[((int)y - pacmanSize - 4) / 20][((int)x - pacmanSize - 3) / 20] = ' ';
      fill(0, 0, 0); 
      ellipse(x, y - 14, 7, 7); 
    }
    if (map[((int)y - pacmanSize - 4) / 20][((int)x - pacmanSize - 3) / 20] == 'C' && (((int)y - 1) % 20) == 0)
    {
      menu.addScore(10);
      map[((int)y - pacmanSize - 4) / 20][((int)x - pacmanSize - 3) / 20] = ' ';
      fill(0, 0, 0);
      ellipse(x, y - 11, 4, 4);
    }
    display(currentDirection);
  }
}

