class Obstacle2 {
  int x, y; // data members
  PImage img;

  Obstacle2(int x, int y) { // constructor
    this.x = x; //initialize x in the constructor
    this.y = y;
    img = loadImage("Obstacle2.png");
    img.resize(60, 60);
  }

  // methods
  void move() { // to auto move the obstacles
    x -= random(2, 5);
    if (x < 0 - img.width) { // If obstacle goes off screen, reset the x to width

      x = width;
    }
  }

  void moveInDirection(int deltaX, int deltaY) {
    x += deltaX;
    y += deltaY;
  }

  void display() {
    imageMode(CENTER); // Draw all PImage from centre
    image(img, x, y);
  }

}
