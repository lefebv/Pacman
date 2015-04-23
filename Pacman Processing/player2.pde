/////////////////////////////////////  PACMAN PROCESSING VERSION BY BENOIT BONNET AND THIBAULT LEFEBVRE  ///////////////////////////////////////////////
/////////////////////////////////////    RUC INTRODUCTION TO GRAPHIC ANIMATION PROJECT N°1 10/30/2013    ///////////////////////////////////////////////

// This class is used to handle the player 2, it works mainly as the pacman class and the ghost class.

int currentDirection2 = 0;
int inMovement2 = 0; //used to handle the player2 display when it is not in movement
int open2 = 0; int close2 = 0; //used to handle the switch between open or closed mouth of player2

class Player2
{
  int map[][] = null;
  int x;
  int y;
  int ghostSize = 7;
  int eyeSize = 1;
  int currentDirection2 = 0;
  
  Player2 (int _map[][], int _x, int _y)
  {
    map = _map;
    x = _x;
    y = _y;
    display(x - 10,y - 10);
  }
  
  
  void erase() //Because of our chose not to delate the background on each frame, we have to delate our ghost before displaing the new one.
  {
    fill(0, 0, 0);
    ellipse(x, y, ghostSize+2, ghostSize+2); 
    fill(255, 255, 255);
  }
  
  void display(int X, int Y) //First display option. Only used once at the begining of the game, to display pacman on a specific coordonates
  {
    fill(94, 47, 222);
    ellipse(X + 10 , Y + 10, ghostSize, ghostSize); 
    x = X + 10; //Switch x and y to the middle of the rectangle corresponding to the map coordonates
    y = Y + 10;
    fill(255,0,0);
    noStroke();
    ellipse(x + 2 , y - 2, eyeSize, eyeSize); 
    ellipse(x - 2 , y - 2, eyeSize, eyeSize); 
    stroke(0); 
    fill(255, 255, 255);
  }
  
  void display(boolean gamePaused) //Second display option. used to display player 2 even is a ghost goes thoug it when player 2 is not moving.
  {
    if (gamePaused != true)
    {
    fill(94, 47, 222);
    ellipse(x , y, ghostSize, ghostSize); 
    fill(255,0,0);
    noStroke();
    ellipse(x + 2 , y - 2, eyeSize, eyeSize); 
    ellipse(x - 2 , y - 2, eyeSize, eyeSize); 
    stroke(0); 
    fill(255, 255, 255);
    }
  }  
  void display(int currentDirection2) //Third display fonction, called from the draw methode
  {
    if (currentDirection2 == 2 && open2 < 20 && inMovement2 == 1) //Current direction is right, and the mouth is open
    {
    fill(94, 47, 222);
    ellipse(x, y, ghostSize, ghostSize); 
    fill(0, 0, 0);
    triangle(x, y, x + 9, y - 9, x + 9, y + 9);
    fill(255,0,0);
    noStroke();
    ellipse(x, y - 4, eyeSize, eyeSize); 
    stroke(0); 
    fill(255, 255, 255);
    open2++; //We increment open, so that every 20 frames, the status of the mouth switch
    if (open2 >= 20) //if open = 20, status of the mouth must switch
    close2 = 0;
    }
    else if (currentDirection2 == 1 && open2 < 20 && inMovement2 == 1) //Current direction is left, and the mouth is open same comments as above.
    {
     fill(94, 47, 222);
    ellipse(x, y, ghostSize, ghostSize); 
    fill(0, 0, 0);
    triangle(x, y, x - 9, y - 9, x - 9, y + 9);
    fill(255,0,0);
    noStroke();
    ellipse(x, y - 4, eyeSize, eyeSize); 
    stroke(0); 
    fill(255, 255, 255);
    open2++;
    if (open2 >= 20)
    close2 = 0;
    }
    else if (currentDirection2 == 4 && open2 < 20 && inMovement2 == 1) //Current direction is down, and the mouth is open same comments as above.
    {
    fill(94, 47, 222);
    ellipse(x, y, ghostSize, ghostSize); 
    fill(0, 0, 0);
    triangle(x, y, x - 9, y + 9, x + 9, y + 9);
    fill(255,0,0);
    noStroke();
    ellipse(x - 4, y, eyeSize, eyeSize); 
    stroke(0); 
    fill(255, 255, 255);
    open2++;
    if (open2 >= 20)
    close2 = 0;
    }
    else if (currentDirection2 == 3 && open2 < 20 && inMovement2 == 1) //Current direction is up, and the mouth is open same comments as above.
    {
    fill(94, 47, 222);
    ellipse(x, y, ghostSize, ghostSize); 
    fill(0, 0, 0);
    triangle(x, y, x - 9, y - 9, x + 9, y - 9);
    fill(255,0,0);
    noStroke();
    ellipse(x - 4, y, eyeSize, eyeSize); 
    stroke(0); 
    fill(255, 255, 255);
    open2++;
    if (open2 >= 20)
    close2 = 0;
    }
    else if (currentDirection2 == 2 && close2 < 20 && inMovement2 == 1) //Current direction is right, and the mouth is closed same comments as above.
    {
    fill(94, 47, 222);
    ellipse(x, y, ghostSize, ghostSize); 
    fill(0, 0, 0);
    triangle(x, y, x + 9, y - 3, x + 9, y + 3);
    fill(255,0,0);
    noStroke();
    ellipse(x, y - 4, eyeSize, eyeSize); 
    stroke(0); 
    fill(255, 255, 255);
    close2++;
    if (close2 >= 20)
    open2 = 0;
    }
    else if (currentDirection2 == 1 && close2 < 20 && inMovement2 == 1) //Current direction is left, and the mouth is closed same comments as above.
    { 
    fill(94, 47, 222);
    ellipse(x, y, ghostSize, ghostSize); 
    fill(0, 0, 0);
    triangle(x, y, x - 9, y - 3, x - 9, y + 3);
    fill(255,0,0);
    noStroke();
    ellipse(x, y - 4, eyeSize, eyeSize); 
    stroke(0); 
    fill(255, 255, 255);
    close2++;
    if (close2 >= 20)
    open2 = 0;
    }
    else if (currentDirection2 == 4 && close2 < 20 && inMovement2 == 1) //Current direction is down, and the mouth is closed same comments as above.
    {
    fill(94, 47, 222);
    ellipse(x, y, ghostSize, ghostSize); 
    fill(0, 0, 0);
    triangle(x, y, x - 3, y + 9, x + 3, y + 9);
    fill(255,0,0);
    noStroke();
    ellipse(x - 4, y, eyeSize, eyeSize);
    stroke(0); 
    fill(255, 255, 255);
    close2++;
    if (close2 >= 20)
    open2 = 0;
    }
    else if (currentDirection2 == 3 && close2 < 20 && inMovement2 == 1) //Current direction is up, and the mouth is cloed same comments as above.
    {
    fill(94, 47, 222);
    ellipse(x, y, ghostSize, ghostSize); 
    fill(0, 0, 0);
    triangle(x, y, x - 3, y - 9, x + 3, y - 9);
    fill(255,0,0);
    noStroke();
    ellipse(x - 4, y, eyeSize, eyeSize); 
    stroke(0); 
    fill(255, 255, 255);
    close2++;
    if (close2 >= 20)
    open2 = 0;
    }
    else //If current direction is not setted (at the begining of the game for exemple, or if close and open are over 20 (meaning that pacman is on a wall)).
    {
    fill(94, 47, 222);
    ellipse(x, y, ghostSize, ghostSize); 
    fill(255,0,0);
    noStroke();
    ellipse(x + 2 , y - 2, eyeSize, eyeSize); 
    ellipse(x - 2 , y - 2, eyeSize, eyeSize); 
    stroke(0); 
    fill(255, 255, 255);
    }
  }
  
  void continueMoving() //This is called if the player switch to an impossible direction. while the next direction is not possible, the pacman will keep moving on the current direction.
  {
    if (currentDirection2 == 1) //Pacman keeps walking on the left
      player2.moveLeft();
    else if (currentDirection2 == 2) //Pacman keeps walking on the right
      player2.moveRight();
    else if (currentDirection2 == 3) //Pacman keeps walking on the top
      player2.moveUp();
    else if (currentDirection2 == 4) //Pacman keeps walking on the bottom
      player2.moveDown();    
  }
  
  void moveRight() //nearly the same method as the pacman one, ecxept for the checkLose and the check for coins or bonus, which are the same as ghosts methods.
  {
    pacman.checkLose(x, y, 1);
    erase();
    if (map[((int)y - ghostSize - 3) / 20][((int)x + ghostSize + 3) / 20] != 'X' && ((((int)y - 10) % 20) == 0) && map[((int)y - ghostSize - 3) / 20][((int)x + ghostSize + 3) / 20] != 'E') //check if pacman can move on the right, using map coordonates.
    {
      x = x + 1;
      inMovement2 = 1;
      currentDirection2 = 2; //Set the current direction to the value corresponding to the right
    }
    else if (map[((int)y - ghostSize - 3) / 20][((int)x + ghostSize + 3) / 20] == 'E')
      x = 0;
    else if (currentDirection2 != 2) //If we were not abe to walk on the right for any reason, and if currentdirection is not also right, we call the method to keep walking on the current direction.
      continueMoving();
    else
    inMovement2 = 0;
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
    display(currentDirection2); //finaly, we display the packman.
    pacman.checkLose(x, y, 1);
  }  
  
  
  void moveLeft()
  {
    pacman.checkLose(x, y, 1);
    erase();
    if (map[((int)y - ghostSize - 3) / 20][((int)x - ghostSize - 4) / 20] != 'X' && ((((int)y - 10) % 20) == 0) && (int)x > 10) //&& (map[((int)y - pacmanSize) / 20][((int)x - pacmanSize - 3) / 20] != 'X'))
    {
      x = x - 1;
      currentDirection2 = 1;
      inMovement2 = 1;
    }
    else if ((int)x < 12)
     x = 540;
    else if (currentDirection2 != 1)
     continueMoving();
    else
    inMovement2 = 0;
    if ((map[((int)y - ghostSize - 3) / 20][((int)x + ghostSize + 4) / 20] == 'C' && (((int)x + 2) % 20) == 0))
    {
     fill(255, 255, 51);
     ellipse(x + 12, y, 3, 3);
    }
    if ((map[((int)y - ghostSize - 3) / 20][((int)x + ghostSize + 4) / 20] == 'B' && (((int)x + 6) % 20) == 0))
    {
     fill(0, 255, 0);
     ellipse(x + 16, y, 6, 6);
    }
    display(currentDirection2);
    pacman.checkLose(x, y, 1);
  }
  
  
  void moveUp()
  {
    erase();
    pacman.checkLose(x, y, 1);
    if ((map[((int)y - ghostSize - 4) / 20][((int)x - ghostSize - 3) / 20] != 'X') && ((((int)x - 10) % 20) == 0)) //(map[((int)y - pacmanSize - 3) / 20][((int)x - pacmanSize) / 20] != 'X'))
    {
      y = y - 1;
      currentDirection2 = 3;
      inMovement2 = 1;
    }
    else if (currentDirection2 != 3)
      continueMoving();
    else
    inMovement2 = 0;
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
     display(currentDirection2);
     pacman.checkLose(x, y, 1);
  }
  
  void moveDown()
  {
    erase();
    pacman.checkLose(x, y, 1);
    if ((map[((int)y + ghostSize + 3) / 20][((int)x - ghostSize - 3) / 20] != 'X') && ((((int)x - 10) % 20) == 0))//&&(map[((int)y + pacmanSize + 2) / 20][((int)x - pacmanSize -2) / 20] != 'X'))
    {
      y = y + 1;
      currentDirection2 = 4;
      inMovement2 = 1;
    }
    else if (currentDirection2 != 4)
      continueMoving();
    else
    inMovement2 = 0;
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
    display(currentDirection2);
    pacman.checkLose(x, y, 1);
  }
}

