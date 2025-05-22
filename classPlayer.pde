class Player {
  int x, y; // Members: data stored for a player object
  PImage img;


  Player(int x, int y) { // Constructor
    this.x = x;
    this.y = y;
    img = loadImage("Player.png");
    img.resize(60, 60);
  }

  // Methods
  void display() {
    imageMode(CENTER); // Draw all PImage from centre
    image(img, x, y); 
  }

  boolean collidesWith(Obstacle1 other) {
    return dist(this.x, this.y, other.x, other.y) < 30;
  }

  boolean collidesWith(Obstacle2 other) {
    return dist(this.x, this.y, other.x, other.y) < 30;
  }
}
