public class Game{

    private int currLevel;
    private library.GameStage currStage;
    private Level level;
    private ArrayList <Button> buttons;
    private boolean isBetweenLevels;
    private boolean isPaused;
    private Player player;


    Game() {
        this.currLevel = 0; // Initialize the current level to 0
        this.currStage = library.GameStage.START; // Initialize the game stage to START
        this.buttons = new ArrayList<Button>(); // Initialize the buttons list
        this.level = null; // Initialize the level to null
        this.isBetweenLevels=false; // Initialize the flag to false
        this.isPaused=false; // Initialize the flag to false
        this.player = null;
    }

    public Level getLevel() {
        return level;
    }

    public int getCurrLevel() {
        return currLevel;
    }

    public void setCurrLevel(int currLevel) {
        this.currLevel = currLevel;
    }

    public library.GameStage getCurrStage() {
        return currStage;
    }

    public void setCurrStage(library.GameStage currStage) {
        this.currStage = currStage;
    }

    public void initialize() {
        background(0, 102, 204);

        Button startGameButton=new Button(480,320,200,100,"Start Game");

        buttons.clear(); // Clear the buttons list before adding new buttons
        buttons.add(startGameButton); // Add the button to the list

        for(Button b:buttons) b.drawButton(); // Draw each button   
    }

    public void terminate(){
        background(0, 102, 204);

        Button endGameButton=new Button(300,300,200,100,"End Game");
        Button restartGameButton=new Button(600,300,200,100,"Restart Game");

        buttons.clear(); // Clear the buttons list before adding new buttons
        buttons.add(endGameButton); // Add the button to the list
        buttons.add(restartGameButton); // Add the button to the list

        for(Button b:buttons) b.drawButton(); // Draw each button   
    }

    public void betweenLevels(){
        background(0, 102, 204);

        Button nextLevelButton=new Button(480,320,200,100,"Go to Next Level");

        buttons.clear(); // Clear the buttons list before adding new buttons
        buttons.add(nextLevelButton); // Add the button to the list

        for(Button b:buttons) b.drawButton(); // Draw each button   
    }

    public void pause(){


        color overlayColor = color(0, 0, 0, 5); // Semi-transparent gray
        fill(overlayColor);
        rectMode(CORNERS); // Set rectMode to CENTER
        rect(0, 0, 960, 640); // Draw the overlay rectangle

        textSize(30);
        fill(0, 408, 612);
        textAlign(CENTER, TOP);
        text("Press P to resume playing", 480, 320); 
    }

    public void update(){
        switch (currStage) {
            case START:
            {
                for(Button b:buttons)
                {
                    if(b.label.equals("Start Game") && b.mousePressed) {
                        currLevel = 1; // Start at level 1
                        currStage = library.GameStage.PLAYING; // Change to PLAYING stage
                    }
                    b.setMousePressed(false); // Reset mousePressed state for the button
                }

                break;
            }

            case PLAYING:
            {
               if(level!=null && level.isLevelCompleted() && level.getLevelNo()==library.noOfLevels)
               {
                    terminate(); // Call terminate method to end the game
                    currStage=library.GameStage.END; // Change to END stage
                    currLevel=Integer.MAX_VALUE; // Set level to maximum value
               }else
               {
                    if(level==null || level.getLevelNo()!=currLevel) 
                    {
                        level = new Level(currLevel); // Create a new level instance
                        currLevel = level.getLevelNo(); // Update the current level
                        level.createDungeons(); // Create dungeons for the current level
                        Room currRoom = level.getFirstDungeon(); // Get the current room
                        player=new Player(currRoom.centreX,currRoom.centreY,20,currRoom); // Create a new player instance

                    }else if (level.isLevelCompleted() && level.getLevelNo()<library.noOfLevels) 
                    {
                        isBetweenLevels=true;
                        currStage = library.GameStage.BETWEEN_LEVELS; // Change to BETWEEN_LEVELS stage
                    }
                    level.drawLevel(); // Draw the dungeons on the screen
                    player.drawEntityWithEye(); // Draw the player on the screen
               }
               break;
            }

            case BETWEEN_LEVELS:
            {
                // Handle the transition between levels here
                //execute the betweenLevels method once the level is completed  

                if(isBetweenLevels)
                {
                    betweenLevels(); // Call the betweenLevels method to show the button
                    isBetweenLevels=false; // Reset the flag
                }
                
                for(Button b:buttons)
                {
                    if(b.label.equals("Go to Next Level") && b.mousePressed) {
                        currStage = library.GameStage.PLAYING; // Change to PLAYING stage
                        currLevel+= 1; // Start at level 1
                    }
                    b.setMousePressed(false); // Reset mousePressed state for the button
                }
                break;
            }

            case PAUSE:
            {
                // Handle the pause state here
                pause(); // Call the pause method to show the button
                break;
            }

            case END:
            {
                for(Button b:buttons)
                {
                    if(b.label.equals("End Game") && b.mousePressed) 
                    {
                        exit();
                    }else if(b.label.equals("Restart Game") && b.mousePressed) 
                    {
                        currStage=library.GameStage.RESTART;  
                    }
                    b.setMousePressed(false); // Reset mousePressed state for the button
                }
                
                break;
            }

            case RESTART:
            {
                currLevel=0; // Reset the level to 0
                level=null; // Reset the level instance
                this.initialize(); // Reinitialize the game
                currStage=library.GameStage.START; // Change to START stage
                break;
            }

            default :
            {
                throw new RuntimeException("Game Stage not chosen correctly");
            } 
        }  
    }

    public void mousePressed() 
    {
        for(Button b:buttons) 
        {  
            b.handleMousePressed(); // Call the handleMousePressed method for each button
        } 
    }

    public void keyPressed() 
    {
        if (key=='p'|| key=='P')
        {
            if(isPaused)
            {
                isPaused=false; // Unpause the game
                currStage=library.GameStage.PLAYING; // Change to PLAYING stage
            }else
            {
                isPaused=true; // Pause the game
                currStage=library.GameStage.PAUSE; // Change to PAUSE stage
            }
        }else if(key=='a'|| key=='A')
        {
            player.move('a'); // Move the player left
        }else if(key=='d'|| key=='D')
        {
            player.move('d'); // Move the player right
        }else if(key=='w'|| key=='W')
        {
            player.move('w'); // Move the player up
        }else if(key=='s'|| key=='S')
        {
            player.move('s'); // Move the player down  
        }
    }
}