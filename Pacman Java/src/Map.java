import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Shape;
import java.awt.geom.Rectangle2D;


public class Map 
{
	int blockSize = 20; // Each block of our map is represented on 20 by 20 pixels on the screen
	int bonusSize = 6;
	int coinSize = 3;
	int x = 0;  int y = 0;
	int map[][] = null;
	int Y_MAX = 28;
	int X_MAX = 30;
	int leveldata[] =
	    { 	'X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','E',
			'X','P','C','C','C','C','C','C','C','C','C','C','C','X','X','C','C','C','C','C','C','C','C','C','C','C','C','X','E',
			'X','C','X','X','X','X','C','X','X','X','X','X','C','X','X','C','X','X','X','X','X','C','X','X','X','X','C','X','E',
			'X','C','X','X','X','X','C','X','X','X','X','X','C','X','X','C','X','X','X','X','X','C','X','X','X','X','C','X','E',
			'X','C','X','X','X','X','C','X','X','X','X','X','C','X','X','C','X','X','X','X','X','C','X','X','X','X','C','X','E',
			'X','C','C','C','C','C','C','C','C','C','C','C','C','C','B','C','C','C','C','C','C','C','C','C','C','C','C','X','E',
			'X','C','X','X','X','X','C','X','X','C','X','X','X','X','X','X','X','X','C','X','X','C','X','X','X','X','C','X','E',
			'X','C','X','X','X','X','C','X','X','C','X','X','X','X','X','X','X','X','C','X','X','C','X','X','X','X','C','X','E',
			'X','C','C','C','C','C','C','X','X','C','C','C','C','X','X','C','C','C','C','X','X','C','C','C','C','C','C','X','E',
			'X','X','X','X','X','X','C','X','X','X','X','X',' ','X','X',' ','X','X','X','X','X','C','X','X','X','X','X','X','E',
			' ',' ',' ',' ',' ','X','C','X','X',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','X','X','C','X',' ',' ',' ',' ',' ','E',
			' ',' ',' ',' ',' ','X','C','X','X',' ','X','X','X','X','X','X','X','X',' ','X','X','C','X',' ',' ',' ',' ',' ','E',
			'X','X','X','X','X','X','C','X','X',' ','X',' ',' ',' ',' ',' ',' ','X',' ','X','X','C','X','X','X','X','X','X','E',
			' ',' ',' ',' ',' ',' ','B',' ',' ',' ','X',' ',' ',' ',' ',' ',' ','X',' ',' ',' ','B',' ',' ',' ',' ',' ',' ','E',
			'X','X','X','X','X','X','C','X','X',' ','X',' ',' ',' ',' ',' ',' ','X',' ','X','X','C','X','X','X','X','X','X','E',
			' ',' ',' ',' ',' ','X','C','X','X',' ','X','X','X','X','X','X','X','X',' ','X','X','C','X',' ',' ',' ',' ',' ','E',
			' ',' ',' ',' ',' ','X','C','X','X',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','X','X','C','X',' ',' ',' ',' ',' ','E',
			'X','X','X','X','X','X','C','X','X',' ','X','X','X','X','X','X','X','X',' ','X','X','C','X','X','X','X','X','X','E',
			'X','C','C','C','C','C','C','C','C','C','C','C','C','X','X','C','C','C','C','C','C','C','C','C','C','C','C','X','E',
			'X','C','X','X','X','X','C','X','X','X','X','X','C','X','X','C','X','X','X','X','X','C','X','X','X','X','C','X','E',
			'X','C','X','X','X','X','C','X','X','X','X','X','C','X','X','C','X','X','X','X','X','C','X','X','X','X','C','X','E',
			'X','C','C','C','X','X','C','C','C','C','C','C','C','C','C','C','C','C','C','C','C','C','X','X','C','C','C','X','E',
			'X','X','X','C','X','X','C','X','X','C','X','X','X','X','X','X','X','X','C','X','X','C','X','X','C','X','X','X','E',
			'X','C','C','C','C','C','C','X','X','C','C','C','C','X','X','C','C','C','C','X','X','C','C','C','C','C','C','X','E',
			'X','C','X','X','X','X','X','X','X','X','X','X','C','X','X','C','X','X','X','X','X','X','X','X','X','X','C','X','E',
			'X','C','X','X','X','X','X','X','X','X','X','X','C','X','X','C','X','X','X','X','X','X','X','X','X','X','C','X','E',
			'X','C','C','C','C','C','C','C','C','C','C','C','C','B','C','C','C','C','C','C','C','C','C','C','C','C','C','X','E',
			'X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','X','E' };
	
	void init() // called each time setup fonction is called, to clear the map back to the initial values.
	{
		int nbLine = 0;
		int i = 0;
	    int j = 0;
	    int nbData = 0;
	    map = new int[Y_MAX][];
	    while (nbLine < Y_MAX) //for each line of our map.txt file, we create a new line.
	    {
	    	int nbColumn = 0;
	    	i = 0;
	    	map[j] = new int[X_MAX];
	      
	    	while (leveldata[nbData] != 'E') //checks to have the same values in our map than in the map.txt file.
	    	{
	    		map[j][i] = leveldata[nbData];
	    		nbColumn++;
	    		nbData++;
	    		i++;
	    		map[j][i] = 'E';
	    	}
	    	if (leveldata[nbData] == 'E')
	    		nbData++;
	    	j++;
	    	nbLine++;
	    }
	}
	
	void draw(Graphics2D g2d)
	{
		int x = 0;
		int y = 0;
		int i = 0;
		int j = 0;
		while (j < Y_MAX)
		{
			x = 0;
			i = 0;
			while (i < X_MAX)
			{
				if (map[j][i] == 'X')
				{
					g2d.setColor(Color.blue);
					g2d.drawRect(x, y, blockSize, blockSize);
				}
				if (map[j][i] == 'C')
				{
					g2d.setColor(Color.yellow);
					g2d.fillOval(x + 10, y + 10, coinSize, coinSize);
				}
				if (map[j][i] == 'B')
				{
					g2d.setColor(Color.green);
					g2d.fillOval(x + 10, y + 10, bonusSize, bonusSize);
				}
				x += 20;
				i++;
			}
			y += 20;
			j++;
		}
	}
}
