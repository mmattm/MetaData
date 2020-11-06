// A random walker class!

class Walker {
  PVector position;

  PVector noff;

  Walker() {
    position = new PVector(width/2, height/2);
    noff = new PVector(random(1000),random(1000));
  }

  void display(String address, String date) {
    canvas.pushStyle();
    canvas.text(address + " \n" +  date, position.x,position.y);
    canvas.popStyle();
  }

  // Randomly move up, down, left, right, or stay in one place
  void walk() {
    
    position.x = map(noise(noff.x),0,1,0,width);
    position.y = map(noise(noff.y),0,1,0,height);
    
    noff.x += 0.001;
    noff.y += 0.001;
  }
}
