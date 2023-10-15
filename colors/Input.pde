int selectX = 0;
int selectY = 0;
int selectWidth = 0;
int selectHeight = 0;
boolean mouseDown = false;
void mousePressed()
{
  mouseDown = true;
  int x = mouseX;
  selectX = x;
  selectWidth = 0;

  int y = mouseY;
  selectY = y;
  selectHeight = 0;
  if (mouseButton == RIGHT)
  {
  }
}

void mouseReleased()
{
  mouseDown = false;
  int x = mouseX;
  int y = mouseY;
}

void mouseDragged()
{
  int x = mouseX;
  int y = mouseY;
  selectWidth = x - selectX;
  selectHeight = y - selectY;
}

void mouseMoved()
{
  int x = mouseX;
  int y = mouseY;
}


void keyPressed()
{

  if ((int)key == 10 || (int)key == 9)  // enter or tab
  {
  }

  if ((int)key == 112)  // P key
  {
  }

  if ((int)key == 44) // , key
  {
  }

  if ((int)key == 46) // . key
  {
  }

  if ((int)key == 32) // space
  {
  }
  println((int)key);
}
