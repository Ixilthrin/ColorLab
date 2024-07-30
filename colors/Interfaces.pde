public interface ISelectable
{
  boolean select(int x, int y);
}

public interface IDrawable
{
  void update();
  void draw();
}

public interface ISceneObject extends ISelectable, IDrawable
{
  void incrementX(int deltaX);
  void incrementY(int deltaY);
  void incrementSize(int delta);
  boolean contains(int x, int y);
}
