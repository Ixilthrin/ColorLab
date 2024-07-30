
public class Box implements ISceneObject
{
  int x;
  int y;
  int width;
  int height;
  PImage image;

  public Box(int x, int y, int width, int height, PImage image)
  {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.image = image;
  }

  public void incrementX(int deltaX)
  {
    x += deltaX;
  }

  public void incrementY(int deltaY)
  {
    y += deltaY;
  }

  public void incrementSize(int delta)
  {
    width += (float)width * (float)delta / 100.0f;
    height += (float)height * (float)delta / 100.0f;
  }

  public boolean select(int x, int y)
  {
    return false;
  }

  public void update()
  {
  }

  public void draw()
  {
    image(image, x, y, width, height);

    fill(255, 165, 0);
    stroke(255, 77, 0);
  }

  public boolean contains(int x, int y)
  {
    if (x < this.x)
    {
      return false;
    }
    if (x > this.x + width)
    {
      return false;
    }
    if (y < this.y)
    {
      return false;
    }
    if (y > this.y + height)
    {
      return false;
    }
    return true;
  }
}
