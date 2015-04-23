/////////////////////////////////////  PACMAN PROCESSING VERSION BY BENOIT BONNET AND THIBAULT LEFEBVRE  ///////////////////////////////////////////////
/////////////////////////////////////    RUC INTRODUCTION TO GRAPHIC ANIMATION PROJECT N°1 10/30/2013    ///////////////////////////////////////////////

// This class is used to initalize our map, using the map.txt

class Map
{
  int blockSize = 20; // Each block of our map is represented on 20 by 20 pixels on the screen
  int bonusSize = 6;
  int coinSize = 3;
  int x = 0;  int y = 0;
  int map[][] = null;
  int Y_MAX = 28;
  int X_MAX = 30;
  
  void init() // called each time setup fonction is called, to clear the map back to the initial values.
  {
    int nbLine = 0;
    int i = 0;
    int j = 0;
    map = new int[Y_MAX][];
    while (nbLine < Y_MAX) //for each line of our map.txt file, we create a new line.
    {
      int  check = 0;
      j = 0;
      int size = 0;
      char ligne[] = null;
      map[i] = new int[X_MAX];
      // Reading handling of the map.txt
      try {
      line = reader.readLine();
      } catch (IOException e) {
        e.printStackTrace();
        line = null;
      }
      if (line == null) {
      // Stop reading because of an error or file is empty
      noLoop();  
      } else {
      size = line.length();
      ligne = line.toCharArray();
      }
      while(check < size) //checks to have the same values in our map than in the map.txt file.
      {
        map[i][j] = ligne[check];
        if (ligne[check] == 'X')
        {
          fill(0, 0, 255);
          rect(x, y, blockSize, blockSize);
          fill(255, 255, 255);
        }
        if (ligne[check] == 'C')
        {
          fill(255, 255, 51);
          ellipse(x + 10, y + 10, coinSize, coinSize); 
          fill(255, 255, 255);
        }
        if (ligne[check] == 'B')
        {
          fill(0, 255, 0);
          ellipse(x + 10, y + 10, bonusSize, bonusSize); 
          fill(255, 255, 255);
        }
        x = x + 20;
        if (ligne[check] == 'E')
        {
          y = y + 20;
          x = 0;
        }
        check++;
        j++;
      }
      i++;
      nbLine++;
    }
  }

  Map() 
  {
  }
}
