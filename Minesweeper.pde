

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
int row = 20;
int col = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; 

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
  bombs = new ArrayList <MSButton> ();
  buttons = new MSButton[row][col];

  for (int i = 0; i<row; i++)
    for (int j = 0; j<col; j++)

        buttons[i][j]= new MSButton(i,j);
    
    
    setBombs();
}
public void setBombs()
{
  while (bombs.size()<60)
  {
    int rows = (int)(Math.random()*row);
    int cols = (int)(Math.random()*col);
    if (!bombs.contains(buttons[rows][cols]))
    {
      bombs.add(buttons[rows][cols]);
    }
  }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
     for (int i =0; i< bombs.size(); i++) {
    if (bombs.get(i).isMarked() == false) {
      return false;
    }
  }
  return true;
}
public void displayLosingMessage()
{
     buttons[9][6].setLabel("Y");
  buttons[9][7].setLabel("O");
  buttons[9][8].setLabel("U");
  buttons[9][9].setLabel(" ");
  buttons[9][10].setLabel("L");
  buttons[9][11].setLabel("O");
  buttons[9][12].setLabel("S");
  buttons[9][13].setLabel("T");
  for (int i =0; i < bombs.size(); i++) {
    bombs.get(i).marked = false;
    bombs.get(i).clicked = true;
}
}
public void displayWinningMessage()
{
buttons[9][6].setLabel("Y");
  buttons[9][7].setLabel("O");
  buttons[9][8].setLabel("U");
  buttons[9][9].setLabel(" ");
  buttons[9][10].setLabel("W");
  buttons[9][11].setLabel("O");
  buttons[9][12].setLabel("N");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/col;
        height = 400/row;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
  
    
    public void mousePressed () 
  {
    clicked = true;
    if (mouseButton == RIGHT) {
      marked = !marked;
    } else if (bombs.contains(this)) {
      displayLosingMessage();
    } else if ( countBombs(r, c) > 0) {fill(255); 
      setLabel(str(countBombs(r, c)));
    } else {
      if (isValid(r, c-1) && buttons[r][c-1].isClicked() == false) {
        buttons[r][c-1].mousePressed();
      }
      if (isValid(r, c+1) && buttons[r][c+1].isClicked() == false) {
        buttons[r][c+1].mousePressed();
      }
      if (isValid(r-1, c-1) && buttons[r-1][c-1].isClicked() == false) {
        buttons[r-1][c-1].mousePressed();
      }
      if (isValid(r-1, c) && buttons[r-1][c].isClicked() == false) {
        buttons[r-1][c].mousePressed();
      }
      if (isValid(r-1, c+1) && buttons[r-1][c+1].isClicked() == false) {
        buttons[r-1][c+1].mousePressed();
      }
      if (isValid(r+1, c) && buttons[r+1][c].isClicked() == false) {
        buttons[r+1][c].mousePressed();
      }
      if (isValid(r+1, c+1) && buttons[r+1][c+1].isClicked() == false) {
        buttons[r+1][c+1].mousePressed();
      }
      if (isValid(r+1, c-1) && buttons[r+1][c-1].isClicked() == false) {
        buttons[r+1][c-1].mousePressed();
      }
    }
  }


    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        return r >= 0 && r < row && c >= 0 && c < col;  
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if (isValid(r, c+1) && bombs.contains(buttons[r][c+1]))
            numBombs++;
        if (isValid(r, c-1) && bombs.contains(buttons[r][c-1]))
            numBombs++;
        if (isValid(r+1, c) && bombs.contains(buttons[r+1][c]))
            numBombs++;
        if (isValid(r-1, c) && bombs.contains(buttons[r-1][c]))
            numBombs++;
        if (isValid(r+1, c+1) && bombs.contains(buttons[r+1][c+1]))
            numBombs++;
        if (isValid(r+1, c-1) && bombs.contains(buttons[r+1][c-1]))
            numBombs++;
        if (isValid(r-1, c+1) && bombs.contains(buttons[r-1][c+1]))
            numBombs++;
        if (isValid(r-1, c-1) && bombs.contains(buttons[r-1][c-1]))
            numBombs++;
        return numBombs;
    }
}



