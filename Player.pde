public class Player extends EntityMovable 
{
    private boolean isDead;

    Player(int centreX,int centreY, int radius,Room currentRoom)
    {
        super(centreX,centreY,radius,currentRoom,color(255),color(128)); // Call the constructor of EntityMovable with player style colors
        this.setStep(5); // Set the step size for the player
        this.isDead=false;
    }

    public void setIsDead(boolean isDead)
    {
        this.isDead=isDead;
    }

    public void updatePlayer(int centreX, int centreY, Room currentRoom)
    {
        this.centreY=centreY; // Update the centre Y coordinate of the player
        this.centreX = centreX; // Set the centre X coordinate of the player
        this.eyeX = centreX+radius; // Update the eye X coordinate
        this.centreY = centreY; // Set the centre Y coordinate of the player
        this.currentRoom = currentRoom; // Update the current Room of the player
        this.isDead=false; // Reset the isDead flag
    }

    public void move(char direction) 
    {
        isPlayerToEnemyCollisionDetected(game.getLevel().getEnemies());
       
        if (direction == 'w')
        {
            if(game.getLevel().getExitDoor().isPlayerInExit(this.centreX-radius,
                                this.centreY-radius-1*step,
                                this.centreX+radius,
                                this.centreY-radius-1*step))
            {
                game.getLevel().setIsLevelCompleted(true); // Check if the player is in the exit door
            }
            else if(checkMove(this.centreX-radius,
                                this.centreY-radius-1*step,
                                this.centreX+radius,
                                this.centreY-radius-1*step))
            {
                centreY=centreY - step; // Move up
                eyeX=centreX; // Move the eye up
                eyeY=centreY-radius; // Move the eye up
            }
        }
        else if (direction == 's')
        {
            if(game.getLevel().getExitDoor().isPlayerInExit(this.centreX-radius,
                                    this.centreY+radius+1*step,
                                    this.centreX+radius,
                                    this.centreY+radius+1*step))
            {
                game.getLevel().setIsLevelCompleted(true); // Check if the player is in the exit door
            }
            else if(checkMove(this.centreX-radius,
                                    this.centreY+radius+1*step,
                                    this.centreX+radius,
                                    this.centreY+radius+1*step))
            {
                centreY=centreY + step; // Move down
                eyeX=centreX; // Move the eye down
                eyeY=centreY +radius; // Move the eye down
            }
        }    
        else if (direction == 'a')
        { 
            if(game.getLevel().getExitDoor().isPlayerInExit(centreX-radius-1*step,
                                centreY-radius,
                                centreX-radius-1*step,
                                centreY+radius))
            {
                game.getLevel().setIsLevelCompleted(true); // Check if the player is in the exit door
            }
            else if(checkMove(centreX-radius-1*step,
                                centreY-radius,
                                centreX-radius-1*step,
                                centreY+radius))
            {
                centreX=centreX - step; // Move left
                eyeX=centreX-radius; // Move the eye left
                eyeY=centreY; // Move the eye left
            }
            
        }
        else if (direction == 'd')
        {
            if(game.getLevel().getExitDoor().isPlayerInExit(centreX+radius+1*step,
                                centreY-radius,
                                centreX+radius+1*step,
                                centreY+radius))
            {
                game.getLevel().setIsLevelCompleted(true); // Check if the player is in the exit door
            }
            else if(checkMove(centreX+radius+1*step,
                                centreY-radius,
                                centreX+radius+1*step,
                                centreY+radius))
            {
                centreX=centreX + step; // Move right
                eyeX=centreX+radius; // Move the eye left
                eyeY=centreY; // Move the eye left
            }
        }       
        updateCurrentRoom(); // Update the current Room after moving 
    }

    public void updateCurrentRoom() {
        // Check if the new position is within the bounds of the current Room
        //a player can only be in two rooms at any time: either in a dungeon or a room that is not a dungeon, or in both
        // not inside a dungeon, hence inside a tunnel, rooms1 will only fetch one room
        
        if(game.getLevel().getDungeon(centreX, centreY) == null) 
        {
            ArrayList<Room> rooms1=game.getLevel().getRooms(centreX,centreY); 
            this.currentRoom=rooms1.get(0); 
        }
        else  //inside a dungeon, rooms 1 can fetch two rooms but we need to update with the dungeon room
        {
           this.currentRoom=game.getLevel().getDungeon(centreX, centreY);
        }
    }

    public boolean checkMove(int x1, int y1, int x2, int y2){
        ArrayList<Room> rooms1=game.getLevel().getRooms(x1, y1); // Check if the new coordinates are within the current Room
        ArrayList<Room> rooms2=game.getLevel().getRooms(x2, y2); // Check if the new coordinates are within the current Room

        return (!rooms1.isEmpty() && !rooms2.isEmpty()) ? true : false; // Check if the new coordinates are within the same Room
    }

    public void isPlayerToEnemyCollisionDetected(ArrayList <Enemy> enemies){
        for(Enemy e:enemies)
        {
            float distance = dist(e.centreX, e.centreY, this.centreX, this.centreY);

            if(distance<=this.radius+e.radius) 
            {
                this.isDead=true;
                break;
            }
        }
    }

    
}