public class EnemyRandom extends Enemy{

    private double velocityX;
    private double velocityY;

    EnemyRandom(Room currentRoom)
    {
        super(currentRoom.x1+50, currentRoom.y1+50,20,currentRoom,color(40),color(128)); // Call the constructor of EntityMovable with respective style colors
        this.setStep(2); // Set the step size for the entity
        initializeRandomVelocity();
    }

    public void initializeRandomVelocity(){
        double random=Math.random();
        double angle= 2* Math.PI * random;
        double cosine=Math.cos(angle);
        double sine=Math.sin(angle);

        velocityX=step*cosine;
        velocityY=step*sine;
    }

    public void move()
    {
        int rad=diameter/2;
        if(isEnemytoPlayerCollisionDetected()) 
        {
            game.getPlayer().setIsDead(true);
        }
        else if(isEnemytoEnemyCollisionDetected(game.getLevel().getEnemies()))
        { 
           initializeRandomVelocity();
        }
        else 
        {
        double random=0.2;
            if(centreX-rad+velocityX < currentRoom.x1 || centreX + rad+velocityX >currentRoom.x2)
            {
                velocityX = -velocityX;
                velocityY+= random;
            }

            if(centreY-rad+velocityY < currentRoom.y1 || centreY + rad+velocityY >currentRoom.y2)
            {
                velocityY = -velocityY;
                velocityX+= random;
            }
        }
        
        centreX += velocityX;
        centreY += velocityY;  
    }



}