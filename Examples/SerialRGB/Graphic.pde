class Graphic {
  PGraphics canvas;
  int x, y;

  Graphic(PGraphics _canvas) {
    canvas = _canvas;
    y = 0;
    x = 0;
  }

  void update() { 

    canvas.fill(0, 1);
    canvas.noStroke();
    canvas.rect(0, 0, canvas.width, canvas.height);

    //calculate a probability between 0 and 100% based on total events
    float prob = (float)selectedEvents.size()/(float)events.size();
    //println("Probability : " + prob);

    //get a random floating point value between 0 and 1
    float r = random(1);   

    //test the random value against the probability and trigger an event
    if (r < prob) {
      canvas.pushStyle();
      canvas.stroke(255);
      canvas.point(x, y);
      canvas.popStyle();
    }

    // X and Y walk through a grid
    x = (x + 1) % canvas.width;
    if (x == 0) y = (y + 1) % canvas.height;
    if (y== 63 && x == 63) reset();
  }
  void reset() {
    println("reset");
    canvas.beginDraw();
    canvas.background(0);
    canvas.endDraw();
    x = y = 0;
  }
}
