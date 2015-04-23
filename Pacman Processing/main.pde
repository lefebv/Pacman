/////////////////////////////////////  PACMAN PROCESSING VERSION BY BENOIT BONNET AND THIBAULT LEFEBVRE  ///////////////////////////////////////////////
/////////////////////////////////////    RUC INTRODUCTION TO GRAPHIC ANIMATION PROJECT N°1 10/30/2013    ///////////////////////////////////////////////

//Class initializations
Pacman pacman;
Map map;
Player2 player2;
Menu menu;
Ghost ghost1;
Ghost ghost2;
Ghost ghost3;
Ghost ghost4;
Ghost ghost5;
// strings of text diplay initializations
String sPauseGame = "PAUSE";
String sLostGame = "YOU LOST";
String sPlayer2Win = "Player 2 Won !";
BufferedReader reader; // bufferReader, used to read the map.txt
String line; // line used to move in the map.txt
int nextDirection = 0; // nextDirection of pacman and of player2.
int nextDirection2 = 0;
int bonusTime = 0; //Bonus time used to let the bonus during a specific number of frames.
boolean lostGame = false; // setted only if the lost
boolean player2Win = false; // setted only if the player 2 won
boolean endGame = false; //setted if the game is finished, either if player 1 won, or lost, or player 2 won.
boolean pauseGame = false; //flag to know if the game is paused
boolean twoPlayers = false; //flag to know if 2 players mode has been activated.
boolean bonusTimer = false; //flag used to display ghots only once every two frames (depending on the difficulty mode applied)
//flags setting difficulty. When we launch the game, easy mode is activated.
boolean easyModeActivated = true; 
boolean normalModeActivated = false;
boolean hardModeActivated = false;
int     modeActivated = 0; //gives the mode activated. 0 = easy, 1 = normal, 2 = hard.


void setup()
{
  frameRate(100); // each time we call the setup fonction, we set the framerate to 100, stopping eventual bonus of the last game.
  nextDirection = 0; //each time we reset the game, the next directions has to be setted back to 0 to avoid having packman moving from the last game.
  nextDirection2 = 0;
  reader = createReader("map.txt");   // We read our map.txt file.
  size(700,560); //We set the height and lenght of our game.
  smooth(); // Anti-aliased edges to improve quality.
  ellipseMode(RADIUS);
  map = new Map(); //call of our map class
  // varaibles setted above are to reset these values if the setup method is called during to game.
  pauseGame = false;
  lostGame = false;
  player2Win = false;
  background(0); // We only call background(0) once, to improve display performances.
  map.init(); // initialization of our map.
  menu = new Menu(); //call our menu class
  pacman = new Pacman(map.map); // call our pacman class 
  
  ghost1 = new Ghost(map.map, 190, 210); //call our ghost class as many times as we want to have many ghosts.
  ghost2 = new Ghost(map.map, 370, 210);
  ghost3 = new Ghost(map.map, 190, 330);
  if (twoPlayers == false) //Since player 2 is the fourth ghost, if 2 player mode is activated, we only create 3 ghosts.
  ghost4 = new Ghost(map.map, 370, 330);
  else
  player2 = new Player2(map.map, 370, 330); 
  if (hardModeActivated == true) // if hard mode is activated, we create 1 more ghost.
  ghost5 = new Ghost(map.map, 530, 530);
}

void draw()
{
  endGame = menu.display(twoPlayers, modeActivated); //the endgame is setted if the players has the maximum score, checked in the display method of the menu class.
  if (lostGame == false && player2Win == false && endGame == false) //if the game is lost or if the player 2 won, we don't display pacman anymore.
    pacman.display(0);
    else
     {
     pacman.erase();
     pacman.display(-3000,-3000);
     }
  if ((normalModeActivated == true && ((frameRate > 150 && bonusTimer == true) || frameRate < 150)) || (hardModeActivated == true) || (easyModeActivated == true && bonusTimer == true)) //check for the display of the ghosts
  //Depending on the mode activated, the ghosts are displayed only once over two frames. also check if the bonus is activated or not because in the normal mode, pacman don't share the bonus with ghosts.
  {
    if(pauseGame == true) //check if the game is paused to stop ghosts if it is.
    {
      ghost1.display(true);
      ghost2.display(true);
      ghost3.display(true);
      if (twoPlayers == false)
      ghost4.display(true);
      else
      player2.display(true);
      if (hardModeActivated == true)
      ghost5.display(true);
     }
     else
     { 
     ghost1.display(false);
     ghost2.display(false);
     ghost3.display(false);
     if (twoPlayers == false)
     ghost4.display(false);
     else
     player2.display(false);
     if (hardModeActivated == true)
     ghost5.display(false);
     }
     bonusTimer = false; //we set this to false so that on the next frame, ghosts wont be displayed.
  }
  else
  {
  bonusTimer = true; // switched back to true to display ghosts again.
  ghost1.checkLose(); // check is pacman hits a ghost even if ghosts display methods are not called.
  ghost2.checkLose();
  ghost3.checkLose();
  if (twoPlayers == false)
  ghost4.checkLose();
  }

  if (lostGame == true) // if player(s) lost, we stop pacman display and move.
  {
  fill(255, 0, 0);
  textSize(39);
  text(sLostGame, 180, 280);
  endGame = true;
  }
  
  if (player2Win == true) // same, we stop pacman move and display if player 2 won.
  {
  fill(255, 0, 0);
  textSize(39);
  text(sPlayer2Win, 160, 280);
  endGame = true;
  }
  
  if (endGame != true && pauseGame != true) //pacman move is stopped if the game is finished or if the game is paused.
  {  
  // Key Event
  if (keyPressed && key == CODED) // check for the key pressed to make pacman move. This sets the next direction of the pacman
  {
    if (keyCode == LEFT) {
      nextDirection = 1;
    } else if (keyCode == RIGHT) {
      nextDirection = 2;
    } else if (keyCode == UP) {
      nextDirection = 3;
    } else if (keyCode == DOWN) {
      nextDirection = 4;
    }
  }    
  if (nextDirection == 1) // if the user dont press any key, and if nextdirection has already been setted, pacman keeps moving on.
    pacman.moveLeft();
  else if (nextDirection == 2)
    pacman.moveRight();
  else if (nextDirection == 3)
    pacman.moveUp();
  else if (nextDirection == 4)
    pacman.moveDown();


  if (twoPlayers == true) //check for the player 2 controles. Same way as the pacman handling.
  {
  if (keyPressed) 
  {
    if (key == 'q') {
      nextDirection2 = 1;
    } else if (key == 'd') {
      nextDirection2 = 2;
    } else if (key == 'z') {
      nextDirection2 = 3;
    } else if (key == 's') {
      nextDirection2 = 4;
    }
  }    
  if (nextDirection2 == 1)
    player2.moveLeft();
  else if (nextDirection2 == 2)
    player2.moveRight();
  else if (nextDirection2 == 3)
    player2.moveUp();
  else if (nextDirection2 == 4)
    player2.moveDown();
  }
  }
  
  else if (pauseGame == true) //If the game is paused, we display a sceen message.
  {
  fill(255, 0, 0);
  textSize(39);
  text(sPauseGame, 220, 280);
  }
  
  
    // Restart Button check
  if (mousePressed && mouseX >= 565 && mouseX <= 700 && mouseY >= 20 && mouseY <= 70)
     setup();
     
  if (frameRate > 150) // Framerate timer check, if the bonus has been used, it will last for 2000 frames.
  {
    bonusTime++;
    if (bonusTime > 2000)
    {
      bonusTime = 0;
      pacman.stopBonus();
    }
  }
}

// keyPressed and mousePressed are out of the draw method, otherwise if the user hits a key or clic for more than one frame, it wouldn't work.

void keyPressed()
{
  if(key == ' ') //Check for the space key to activate or disactivate pause mode.
  {
    if(pauseGame == true)
    {
    pauseGame = false;
    fill(0, 0, 0);
    rect(220,240,120,60);
    }
    else if (endGame == false) //If the game is finished, user can not pause anymore to avoid display issues.
    {
    pauseGame = true;
    fill(255, 0, 0);
    textSize(39);
    text(sPauseGame, 220, 280);
    }
  }
}


void mousePressed()
{
  if (mouseX >= 565 && mouseX <= 700 && mouseY >= 90 && mouseY <= 140) // check is the user want to switch the number of players.
  {
    if (twoPlayers == false)
    twoPlayers = true;
    else if (twoPlayers == true)
    twoPlayers = false;    
    setup();
  }
  if (mouseX >= 565 && mouseX <= 700 && mouseY >= 420 && mouseY <= 450) // Check easy mode button location
  {
    easyModeActivated = true;
    normalModeActivated = false;
    hardModeActivated = false;
    modeActivated = 0;
    setup();
  }
  if (mouseX >= 565 && mouseX <= 700 && mouseY >= 470 && mouseY <= 500) // Check normal mode button location
  {
    normalModeActivated = true;
    easyModeActivated = false;
    hardModeActivated = false;
    modeActivated = 1;
    setup();
  }
  if (mouseX >= 565 && mouseX <= 700 && mouseY >= 520 && mouseY <= 550) // Check hard mode button location
  {
    hardModeActivated = true;
    easyModeActivated = false;
    normalModeActivated = false;
    modeActivated = 2;
    setup();
  }
}
