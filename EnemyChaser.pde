public class EnemyChaser extends Enemy{

    //move randomly like EnemyRandom
    //if player is in FOV -chase until it leaves currentRoom
    //when player leaves currentroom, it goes back to random movement
    //on Player to Enemy Collision - Player dies
    //on enemy to enemy  or enemy to wall collision - it changes direction

    private int eyeOffset=radius;

    EnemyChaser(Room currentRoom)
    {
        super(currentRoom.x1+50, currentRoom.y1+50,10,currentRoom,color(30),color(128),2.0,2.5); // Call the constructor of EntityMovable with respective style colors
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
        }else if (isPlayerinFOV()) 
        { 
            chasePlayer();
        }else 
        {
            if(Math.abs(velocityX) <1.1 || Math.abs(velocityY) <1.1 || 
               Math.abs(velocityX) > 2.0 || Math.abs(velocityY) >2.0) 
                // If the velocity is too small or zero, reinitialize to avoid getting stuck
            {
                initializeRandomVelocity();
            }
        }
         
        
        centreX += velocityX;
        centreY += velocityY;  

        PVector currentVelocity = new PVector((float) velocityX, (float) velocityY);
        currentVelocity.normalize();
        eyeX = (int) (centreX + currentVelocity.x * eyeOffset);
        eyeY = (int) (centreY + currentVelocity.y * eyeOffset);
    }
}