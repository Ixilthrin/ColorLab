import javax.swing.*;

public class App
{
  MutableState mutableState = new MutableState();
  Scene imageScene = null;
  Scene currentScene = null;
  int MAX_IMAGE_WIDTH = 960;
  int MAX_IMAGE_HEIGHT = 540;
  PFont font;
  color currentColor;
  ColorChooserEnum chooser = ColorChooserEnum.Point;

  final JFileChooser fc = new JFileChooser();
  int returnVal = 0;
  public void setup()
  {
    fc.setMultiSelectionEnabled(true);
    imageScene = new Scene("images", null);
    currentScene = imageScene;

    font = createFont("Arial Bold", 16, true); // Arial, 16 point, anti-aliasing on
    size(1600, 1000);
    frameRate(30);
  }

  public Scene getScene()
  {
    return imageScene;
  }

  public void addNewImage()
  {
    PImage theImage;
    int returnVal = fc.showOpenDialog(null);

    if (returnVal == JFileChooser.APPROVE_OPTION) {
      File []files = fc.getSelectedFiles();
      for (int i = 0; i < files.length; ++i)
      {
        String myInputFile = files[i].getAbsolutePath();
        theImage = loadImage(myInputFile);
        float renderWidth = 0;
        float renderHeight = 0;
        float widthRatio = (float)theImage.width / (float) MAX_IMAGE_WIDTH;
        float heightRatio = (float)theImage.height / (float) MAX_IMAGE_HEIGHT;

        if (widthRatio - 1.0f > heightRatio - 1.0f)
        {
          renderWidth = (float) MAX_IMAGE_WIDTH;
          renderHeight = theImage.height / widthRatio;
        } else
        {
          renderWidth = theImage.width / heightRatio;
          renderHeight = (float) MAX_IMAGE_HEIGHT;
        }
        imageScene.add(new Box(50, 50, (int)renderWidth, (int)renderHeight, theImage));
      }
    }
  }

  public void remove(ISceneObject o)
  {
    for (int i = 0; i < imageScene.size(); ++i)
    {
      if (o == imageScene.get(i))
      {
        imageScene.remove(o);
        return;
      }
    }
  }

  public void drawRGBGraph(int posX, int posY)
  {
    fill(255, 255, 255);
    text("RGB Graph", posX, posY);
    stroke(255, 255, 255);
    fill(0, 0, 0);
    rect(posX, posY + 270, 200, -255);
    for (int i = 0; i < 100; ++i)
    {
      int x = mouseX;
      int y = mouseY;
      if (app_global.mutableState.selectWidth > 0 || app_global.mutableState.selectHeight > 0)
      {
        x = app_global.mutableState.selectX + (int)(.01f * i * (float)app_global.mutableState.selectWidth);
        y = app_global.mutableState.selectY + (int)(.01f * i * (float)app_global.mutableState.selectHeight);
      }
      color c = get(x, y);
      int r = (c >> 16) & 0xFF;
      int g = (c >> 8) & 0xFF;
      int b = c & 0xFF;
      stroke(255, 0, 0);
      fill(255, 0, 0);
      rect(posX + i * 2, posY + 270 - r, 2, 2);
      stroke(0, 255, 0);
      fill(0, 255, 0);
      rect(posX + i * 2, posY + 270 - g, 2, 2);
      stroke(0, 0, 255);
      fill(0, 0, 255);
      rect(posX + i * 2, posY + 270 - b, 2, 2);
    }
  }

  public void drawHSVGraph(int posX, int posY)
  {
    fill(255, 255, 255);
    text("HSV Graph", posX, posY);
    stroke(255, 255, 255);
    fill(0, 0, 0);
    rect(posX, posY + 270, 200, -255);
    for (int i = 0; i < 100; ++i)
    {
      int x = mouseX;
      int y = mouseY;
      if (app_global.mutableState.selectWidth > 0 || app_global.mutableState.selectHeight > 0)
      {
        x = app_global.mutableState.selectX + (int)(.01f * i * (float)app_global.mutableState.selectWidth);
        y = app_global.mutableState.selectY + (int)(.01f * i * (float)app_global.mutableState.selectHeight);
      }
      color c = getColor();//get(x, y);



      color theColor = get(x, y);//getColor();//get(mouseX, mouseY);
      int a = (theColor >> 24) & 0xFF;
      int r = (theColor >> 16) & 0xFF;
      int g = (theColor >> 8) & 0xFF;
      int b = theColor & 0xFF;


      float f_r = (float) r / 255.0f;
      float f_g = (float) g / 255.0f;
      float f_b = (float) b / 255.0f;
      float hsv[] = Converter.convertRGBToHSV(f_r, f_g, f_b);

      int h = (int)(hsv[0] * (255.0f) / (360.0f));
      int s = (int)(hsv[1] * 255.0f);
      int v = (int)(hsv[2] * 255.0f);

      float rgb[] = Converter.convertHSVToRGB(hsv[0], 1.0f, 1.0f);

      stroke(rgb[0] * 255, rgb[1] * 255, rgb[2] * 255);
      fill(rgb[0] * 255, rgb[1] * 255, rgb[2] * 255);
      rect(posX + i * 2, posY + 270 - h, 2, 2);
      stroke(150, 150, 150);
      fill(150, 150, 150);
      rect(posX + i * 2, posY + 270 - s, 2, 2);
      stroke(255, 255, 255);
      fill(255, 255, 255);
      rect(posX + i * 2, posY + 270 - v, 2, 2);
    }
  }

  public color getColor()
  {
    if (app_global.mutableState.selectWidth == 0 || app_global.mutableState.selectHeight == 0)
    {
      return get(mouseX, mouseY);
    }

    int startX = min(app_global.mutableState.selectX, app_global.mutableState.selectX + app_global.mutableState.selectWidth);
    int endX = max(app_global.mutableState.selectX, app_global.mutableState.selectX + app_global.mutableState.selectWidth);
    int startY = min(app_global.mutableState.selectY, app_global.mutableState.selectY + app_global.mutableState.selectHeight);
    int endY = max(app_global.mutableState.selectY, app_global.mutableState.selectY + app_global.mutableState.selectHeight);

    int colorCount = 0;
    int totalRed = 0;
    int totalGreen = 0;
    int totalBlue = 0;
    for (int x = startX; x <= endX; ++x)
    {
      for (int y = startY; y <= endY; ++y)
      {
        colorCount++;
        color theColor = get(x, y);
        //int a = (theColor >> 24) & 0xFF;
        int r = (theColor >> 16) & 0xFF;
        int g = (theColor >> 8) & 0xFF;
        int b = theColor & 0xFF;
        totalRed += r;
        totalGreen += g;
        totalBlue += b;
      }
    }
    int red = (int) ((float)totalRed / (float)colorCount);
    int green = (int) ((float)totalGreen / (float)colorCount);
    int blue = (int) ((float)totalBlue / (float)colorCount);

    return color(red, green, blue);
  }

  public void draw()
  {
    clear();
    background(50, 50, 50);
    textFont(font, 24);

    for (int i = 0; i < imageScene.size(); ++i)
    {
      imageScene.get(i).draw();
    }

    if (chooser == ColorChooserEnum.Point)
    {
      showPointColor();
    }

    drawRGBGraph(250, 630);
    drawHSVGraph(920, 630);

    fill(0, 0, 0, 0);
    stroke(255, 255, 255);
    if (app_global.mutableState.selectWidth > 0 || app_global.mutableState.selectHeight > 0)
      rect(app_global.mutableState.selectX, app_global.mutableState.selectY, app_global.mutableState.selectWidth, app_global.mutableState.selectHeight);
  }

  void showPointColor()
  {
    color theColor = getColor();//get(mouseX, mouseY);
    int a = (theColor >> 24) & 0xFF;
    int r = (theColor >> 16) & 0xFF;
    int g = (theColor >> 8) & 0xFF;
    int b = theColor & 0xFF;
    fill(theColor);
    stroke(255, 255, 255);
    rect(50, 650, 100, 100);
    fill(255, 255, 255);
    text("Red:", 50, 800);
    text(r, 150, 800);
    text("Green: ", 50, 830);
    text(g, 150, 830);
    text("Blue: ", 50, 860);
    text(b, 150, 860);

    float f_r = (float) r / 255.0f;
    float f_g = (float) g / 255.0f;
    float f_b = (float) b / 255.0f;
    float hsv[] = Converter.convertRGBToHSV(f_r, f_g, f_b);
    float rgb[] = Converter.convertHSVToRGB(hsv[0], 1.0f, 1.0f);

    fill(255, 255, 255);
    text("Hue", 500, 640);
    fill(rgb[0] * 255, rgb[1] * 255, rgb[2] * 255);
    rect(500, 650, 100, 100);
    fill(255, 255, 255);
    text((int)hsv[0], 500, 780);
    fill(255, 255, 255);
    text("Saturation", 630, 640);
    fill(hsv[1] * 255, hsv[1] * 255, hsv[1] * 255);
    rect(630, 650, 100, 100);
    fill(255, 255, 255);
    text(hsv[1], 630, 780);
    fill(255, 255, 255);
    text("Value", 770, 640);
    fill(hsv[2] * 255, hsv[2] * 255, hsv[2] * 255);
    rect(770, 650, 100, 100);
    fill(255, 255, 255);
    text(hsv[2], 770, 780);
  }
} // End class App



class Scene
{
  String name;
  PImage backgroundImage = null;
  String background;
  ArrayList<ISceneObject> list = null;

  public Scene(String name, String background)
  {
    list = new ArrayList<ISceneObject>();
    this.name = name;
    this.background = background;
  }
  public void setup()
  {
    backgroundImage = loadImage(background);
  }

  public void add(ISceneObject o)
  {
    list.add(o);
  }

  public void remove(ISceneObject o)
  {
    list.remove(o);
  }

  public ISceneObject get(int index)
  {
    return list.get(index);
  }
  public int size()
  {
    return list.size();
  }
  public void bringToFront(ISceneObject o)
  {
    list.remove(o);
    list.add(o);
  }
} // End class Scene



public class MutableState
{
  ISceneObject heldObject = null;

  boolean isRightMouseDown = false;
  boolean isLeftMouseDown = false;
  int mouseDownX = 0;
  int mouseDownY = 0;
  int oldMouseY = 0;
  int oldMouseX = 0;

  int selectX = 0;
  int selectY = 0;
  int selectWidth = 0;
  int selectHeight = 0;
} // End class MutableState
