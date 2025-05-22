// Global variables
Player player; // object variable of class Player
ArrayList<Obstacle1> enemies1List; // ArrayList of enemies1
ArrayList<Obstacle2> enemies2List; // ArrayList of enemies2

PImage backGround; // background variables
int bgX = 0;

// variables to represent state of the game
final int PLAYING = 0;
final int FINISHED = 1;
int gameMode = PLAYING;

// obstacles2 timer and interval
int timer = 0;
int interval = 120;
int startMillis;

void setup() {
  size(600, 600);
  frameRate(60);
  startUp();
  startMillis = millis();
}

void startUp() {
  backGround = loadImage("Background.png");
  backGround.resize(width, height);

  player = new Player(width / 2, height / 2);
  enemies1List = new ArrayList<Obstacle1>();
  enemies2List = new ArrayList<Obstacle2>();

  // Initialize obstacles
  for (int i = 0; i < 5; i++) { // 5 obstacles
    enemies1List.add(new Obstacle1((int) random(825, 1000), (int) random(380)));
  }
}

void draw() {
  if (gameMode == PLAYING) {
    scrollBackground();
    player.display();
    updateEnemies();
    if ((millis() - startMillis) > 10000) { // 10 seconds
      addObstaclesOverTime();
    }
  } else if (gameMode == FINISHED) {
    println("Collided!!");
  }
}

void addObstaclesOverTime() {
  timer++;
  if (timer % interval == 0) {
    enemies2List.add(new Obstacle2((int) random(825, 1000), (int) random(380)));
  }
}

void updateEnemies() {
  ArrayList<Obstacle1> hitEnemies1 = new ArrayList<>();
  ArrayList<Obstacle2> hitEnemies2 = new ArrayList<>();

  for (Obstacle1 enemy1 : enemies1List) {
    enemy1.move();
    enemy1.display();
    if (player.collidesWith(enemy1)) {
      hitEnemies1.add(enemy1); // Add hit obstacle to temporary list
    }
  }

  for (Obstacle2 enemy2 : enemies2List) {
    enemy2.move();
    enemy2.display();
    if (player.collidesWith(enemy2)) {
      hitEnemies2.add(enemy2); // Add hit obstacle to temporary list
    }
  }

  // Remove hit obstacles from original lists
  enemies1List.removeAll(hitEnemies1);
  enemies2List.removeAll(hitEnemies2);

  // Stop the game if there's a collision
  if (!hitEnemies1.isEmpty() || !hitEnemies2.isEmpty()) {
    gameMode = FINISHED;
    println("Collided!!");
    noLoop(); // Stop the draw loop
  }
}

void keyPressed() {
  boolean moveDown = (keyCode == UP);
  boolean moveUp = (keyCode == DOWN);
  boolean moveRight = (keyCode == LEFT);
  boolean moveLeft = (keyCode == RIGHT);
  for (Obstacle1 enemy1 : enemies1List) {
    if (moveDown) enemy1.moveInDirection(0, 5);
    if (moveUp) enemy1.moveInDirection(0, -5);
    if (moveRight) enemy1.moveInDirection(5, 0);
    if (moveLeft) enemy1.moveInDirection(-5, 0);
  }
  for (Obstacle2 enemy2 : enemies2List) {
    if (moveDown) enemy2.moveInDirection(0, 5);
    if (moveUp) enemy2.moveInDirection(0, -5);
    if (moveRight) enemy2.moveInDirection(5, 0);
    if (moveLeft) enemy2.moveInDirection(-5, 0);
  }
}

void scrollBackground() {
  imageMode(CORNER); // draw background from top left
  image(backGround, bgX, 0); // draw background twice
  image(backGround, bgX + backGround.width, 0);
  bgX -= 4; // move background 4 pixels to left
  if (bgX == -backGround.width) {
    bgX = 0; // wrap background
  }
}
