void mousePressed() {
  if (mouseButton == RIGHT) {
    toggleGrid();
  } else {
    pressedUI();
  }
}

void mouseMoved() {
  movedUI();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      forward();
    } else if (keyCode == LEFT) {
      backward();
    }
  }
  if (key == 'g')
    toggleGrid();

  if (key == ' ')
    play = !play;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e > 0) {
    forward();
  } else {
    backward();
  }
}
