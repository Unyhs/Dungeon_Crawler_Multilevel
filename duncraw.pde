Game game;

public void setup(){
    size(960,640);
    game=new Game(); // Create a new instance of the Game class
    game.initialize(); 
}

public void draw(){
    game.update(); // Call the update method of the Game instance   
}

void mousePressed() {
    game.mousePressed(); // Call the mousePressed method of the Game instance
}

void keyPressed() {
    game.keyPressed(); // Call the keyPressed method of the Game instance
}