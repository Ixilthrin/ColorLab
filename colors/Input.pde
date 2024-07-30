void mousePressed()
{
  int x = mouseX;
  int y = mouseY;
  if (mouseButton == LEFT)
  {
    app_global.mutableState.isLeftMouseDown = true;
    app_global.mutableState.isRightMouseDown = false;

    // If holding something then we are done here.
    if (app_global.mutableState.heldObject != null)
      return;

    app_global.mutableState.mouseDownX = x;
    app_global.mutableState.mouseDownY = y;

    ISceneObject objectToFront = null;

    for (int i = app_global.getScene().size() - 1; i >= 0; --i)
    {
      ISceneObject sceneObject = app_global.getScene().get(i);
      if (sceneObject.contains(x, y))
      {
        app_global.mutableState.heldObject = sceneObject;
        objectToFront = sceneObject;
        break;
      }
    }

    if (objectToFront != null)
      app_global.currentScene.bringToFront(objectToFront);
  }
  if (mouseButton == RIGHT)
  {
    app_global.mutableState.isRightMouseDown = true;
    app_global.mutableState.isLeftMouseDown = false;
    app_global.mutableState.selectX = x;

    app_global.mutableState.selectY = y;
  }
  app_global.mutableState.selectWidth = 0;
  app_global.mutableState.selectHeight = 0;
}

void mouseMoved()
{
}

void mouseReleased()
{
  app_global.mutableState.isRightMouseDown = false;
  app_global.mutableState.isLeftMouseDown = false;
  app_global.mutableState.heldObject = null;
}

void mouseDragged()
{
  int x = mouseX;
  int y = mouseY;

  if (app_global.mutableState.isRightMouseDown)
  {
    app_global.mutableState.selectWidth = x - app_global.mutableState.selectX;
    app_global.mutableState.selectHeight = y - app_global.mutableState.selectY;
  } else if (app_global.mutableState.isLeftMouseDown && app_global.mutableState.heldObject != null)
  {
    app_global.mutableState.heldObject.incrementX(x - app_global.mutableState.mouseDownX);
    app_global.mutableState.heldObject.incrementY(y - app_global.mutableState.mouseDownY);
    app_global.mutableState.mouseDownX = x;
    app_global.mutableState.mouseDownY = y;
  }
}

void mouseWheel(MouseEvent event) {
  app_global.mutableState.selectWidth = 0;
  app_global.mutableState.selectHeight = 0;

  float count = event.getCount();

  int x = mouseX;
  int y = mouseY;
  for (int i = app_global.getScene().size() - 1; i >= 0; --i)
  {
    ISceneObject sceneObject = app_global.getScene().get(i);
    if (sceneObject.contains(x, y))
    {
      app_global.currentScene.bringToFront(sceneObject);
      sceneObject.incrementSize((int)count * -10);
      break;
    }
  }
}


void keyPressed()
{
  if ((int)key == 10 || (int)key == 9)  // enter or tab
  {
  }

  if ((int)key == 111) // O
  {
    app_global.addNewImage();
  }

  if ((int)key == 112)  // P key
  {
  }

  if ((int)key == 120)  // X key
  {
    int x = mouseX;
    int y = mouseY;
    for (int i = app_global.getScene().size() - 1; i >= 0; --i)
    {
      ISceneObject sceneObject = app_global.getScene().get(i);
      if (sceneObject.contains(x, y))
      {
        app_global.remove(sceneObject);
        break;
      }
    }
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
  //println((int)key);
}

// Don't use this event because it is called after mousePressed() and mouseReleased()
// and this leads to duplicated event handling.
void mouseClicked()
{
  // DON'T USE THIS METHOD
}
