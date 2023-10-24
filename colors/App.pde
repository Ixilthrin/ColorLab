import javax.swing.*; 

public class App
{
  int MAX_IMAGE_WIDTH = 960;
  int MAX_IMAGE_HEIGHT = 540;
  PImage theImage;
  PFont font;
  color currentColor;
  ColorChooserEnum chooser = ColorChooserEnum.Point;

  final JFileChooser fc = new JFileChooser();
  int returnVal = fc.showOpenDialog(null);
  public void setup()
  {
    if (returnVal == JFileChooser.APPROVE_OPTION) {
      File file = fc.getSelectedFile();
      String myInputFile = file.getAbsolutePath();
      theImage = loadImage(myInputFile);
    } else {
      println("Cancelled.");
      theImage = loadImage("lake.png");
    }

    font = createFont("Arial Bold", 16, true); // Arial, 16 point, anti-aliasing on
    size(1200, 1000);
    frameRate(30);
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
      if (selectWidth > 0 || selectHeight > 0)
      {
        x = selectX + (int)(.01f * i * (float)selectWidth);
        y = selectY + (int)(.01f * i * (float)selectHeight);
      }
      color c = get(x, y);
      int r = (c >> 16) & 0xFF;
      int g = (c >> 8) & 0xFF;
      int b = c & 0xFF;
      stroke(255, 0, 0);
      rect(posX + i * 2, posY + 270 - r, 2, 2);
      stroke(0, 255, 0);
      rect(posX + i * 2, posY + 270 - g, 2, 2);
      stroke(0, 0, 255);
      rect(posX + i * 2, posY + 270 - b, 2, 2);
    }
  }

  public color getColor()
  {
    if (selectWidth == 0 || selectHeight == 0)
    {
      return get(mouseX, mouseY);
    }

    int startX = min(selectX, selectX + selectWidth);
    int endX = max(selectX, selectX + selectWidth);
    int startY = min(selectY, selectY + selectHeight);
    int endY = max(selectY, selectY + selectHeight);

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
    image(theImage, 50, 50, renderWidth, renderHeight);

    if (chooser == ColorChooserEnum.Point)
    {
      showPointColor();
    }

    drawRGBGraph(250, 630);

    fill(0, 0, 0, 0);
    stroke(255, 255, 255);
    if (selectWidth > 0 || selectHeight > 0)
      rect(selectX, selectY, selectWidth, selectHeight);
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
}
