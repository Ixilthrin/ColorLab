public static class Converter
{
  public static float[] convertRGBToHSV(float r, float g, float b)
  {
    float values[] = new float[3];
    float max = max(r, g, b);
    float min = min(r, g, b);
    float delta = max - min;
    float value = max;
    float saturation = max > 0 ? (max - min) / max : 0;
    float hue = 0;
    if (saturation == 0)
    {
      hue = -1;
    } else {
      if (r == max)
      {
        hue = (g - b) / delta;
      }
      else if (g == max)
      {
        hue = 2.0 + (b - r) / delta;
      }
      else if (b == max)
      {
        hue = 4.0 + (r - g) / delta;
      }
      hue *= 60.0f;
      if (hue < 0)
      {
        hue += 360.0f;
      }
    }
    values[0] = hue;
    values[1] = saturation;
    values[2] = value;
    return values;
  }
  public static float[] convertHSVToRGB(float hue, float sat, float val)
  {
    float values[] = new float[3];
    float red = 0;
    float green = 0;
    float blue = 0;
    if (sat == 0.0f)
    {
      if (hue == -1)
      {
        red = val;
        green = val;
        blue = val;
      }
      else 
      {
        red = 0;
        green = 0;
        blue = 0;
      }
    }
    else
    {
      float f, p, q, t;
      int i;
      
      if (hue == 360.0f)
          hue = 0;
      hue /= 60.0f;
      i = floor(hue);
      f = hue - i;
      p = val * (1.0f - sat);
      q = val * (1.0f - (sat * f));
      t = val * (1.0f - (sat * (1.0f - f)));
      switch (i) {
        case 0: 
          red = val;
          green = t;
          blue = p;
          break;
          case 1:
          red = q; 
          green = val;
          blue = p;
          break;
          case 2:
          red = p;
          green = val;
          blue = t;
          break;
          case 3:
          red = p;
          green = q;
          blue = val;
          break;
          case 4:
          red = t;
          green = p;
          blue = val;
          break;
          case 5:
          red = val;
          green = p;
          blue = q;
          break;
      }
          
    }
    values[0] = red;
    values[1]= green;
    values[2] = blue;
    return values;
  }
}
