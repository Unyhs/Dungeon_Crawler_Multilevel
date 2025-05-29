public class EnemyRandom extends Enemy{

    EnemyRandom(Room currentRoom)
    {
        super(currentRoom.x1+50, currentRoom.y1+50,10,currentRoom,color(40),color(128),2.0, 2.0); // Call the constructor of EntityMovable with respective style colors
        initializeRandomVelocity();
    }

    public void move()
    {
        if(isEnemytoPlayerCollisionDetected()) 
        {
            game.getPlayer().setIsDead(true);
        }
        else if(isEnemytoEnemyCollisionDetected(game.getLevel().getEnemies()))
        { 
           initializeRandomVelocity();
        }
        else if(isEnemyToWallCollisionX()) 
        {
            velocityX = -velocityX;
        }else if(isEnemyToWallCollisionY()) 
        { 
            velocityY = -velocityY;
        }
        else{
            if(Math.abs(velocityX) <1.1 || Math.abs(velocityY) <1.1 || 
               Math.abs(velocityX) > 2.0 || Math.abs(velocityY) >2.0) 
                // If the velocity is too small or zero, reinitialize to avoid getting stuck
            {
                initializeRandomVelocity();
            }
        }
        
        centreX += velocityX;
        centreY += velocityY;  
    }

}