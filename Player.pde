public class Player extends EntityMovable 
{
    protected boolean isDead;

    Player(int centreX,int centreY, int diameter,Room currentRoom)
    {
        super(centreX,centreY,diameter,currentRoom,color(255),color(128)); // Call the constructor of EntityMovable with player style colors
        this.setStep(5); // Set the step size for the player
        this.isDead=false;
    }

    public void move(char direction) 
    {
        isPlayerToEnemyCollisionDetected(game.getLevel().getEnemies());
       
        if (direction == 'w')
        {
            if(game.getLevel().getExitDoor().isPlayerInExit(this.centreX-diameter/2,
                                this.centreY-diameter/2-1*step,
                                this.centreX+diameter/2,
                                this.centreY-diameter/2-1*step))
            {
                game.getLevel().setIsLevelCompleted(true); // Check if the player is in the exit door
            }
            else if(checkMove(this.centreX-diameter/2,
                                this.centreY-diameter/2-1*step,
                                this.centreX+diameter/2,
                                this.centreY-diameter/2-1*step))
            {
                centreY=centreY - step; // Move up
                eyeX=centreX; // Move the eye up
                eyeY=centreY-diameter/2; // Move the eye up
            }
        }
        else if (direction == 's')
        {
            if(game.getLevel().getExitDoor().isPlayerInExit(this.centreX-diameter/2,
                                    this.centreY+diameter/2+1*step,
                                    this.centreX+diameter/2,
                                    this.centreY+diameter/2+1*step))
            {
                game.getLevel().setIsLevelCompleted(true); // Check if the player is in the exit door
            }
            else if(checkMove(this.centreX-diameter/2,
                                    this.centreY+diameter/2+1*step,
                                    this.centreX+diameter/2,
                                    this.centreY+diameter/2+1*step))
            {
                centreY=centreY + step; // Move down
                eyeX=centreX; // Move the eye down
                eyeY=centreY +diameter/2; // Move the eye down
            }
        }    
        else if (direction == 'a')
        { 
            if(game.getLevel().getExitDoor().isPlayerInExit(centreX-diameter/2-1*step,
                                centreY-diameter/2,
                                centreX-diameter/2-1*step,
                                centreY+diameter/2))
            {
                game.getLevel().setIsLevelCompleted(true); // Check if the player is in the exit door
            }
            else if(checkMove(centreX-diameter/2-1*step,
                                centreY-diameter/2,
                                centreX-diameter/2-1*step,
                                centreY+diameter/2))
            {
                centreX=centreX - step; // Move left
                eyeX=centreX-diameter/2; // Move the eye left
                eyeY=centreY; // Move the eye left
            }
            
        }
        else if (direction == 'd')
        {
            if(game.getLevel().getExitDoor().isPlayerInExit(centreX+diameter/2+1*step,
                                centreY-diameter/2,
                                centreX+diameter/2+1*step,
                                centreY+diameter/2))
            {
                game.getLevel().setIsLevelCompleted(true); // Check if the player is in the exit door
            }
            else if(checkMove(centreX+diameter/2+1*step,
                                centreY-diameter/2,
                                centreX+diameter/2+1*step,
                                centreY+diameter/2))
            {
                centreX=centreX + step; // Move right
                eyeX=centreX+diameter/2; // Move the eye left
                eyeY=centreY; // Move the eye left
            }
        }       
        updateCurrentRoom(); // Update the current Room after moving 
    }

    public void updateCurrentRoom() {
        // Check if the new position is within the bounds of the current Room
        ArrayList<Room> rooms1=game.getLevel().getRooms(centreX,centreY); // Get the Rooms at the new position

        for(Room r: rooms1)
        {
            if(r.isDungeon)
            {
                currentRoom=r; // Update the current Room if it's a dungeon
                break;
            }
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

            if(distance<=this.diameter+e.diameter) 
            {
                this.isDead=true;
                break;
            }
        }
    }

    
}