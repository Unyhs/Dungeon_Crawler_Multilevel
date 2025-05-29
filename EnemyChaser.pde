public class EnemyChaser extends Enemy{

    //move randomly like EnemyRandom
    //if player is in FOV -chase until it leaves currentRoom
    //when player leaves currentroom, it goes back to random movement
    //on Player to Enemy Collision - Player dies
    //on enemy to enemy  or enemy to wall collision - it changes direction

    private double velocityX;
    private double velocityY;
    private int eyeOffset=radius;
    private double chaseStep=2.5;

    EnemyChaser(Room currentRoom)
    {
        super(currentRoom.x1+50, currentRoom.y1+50,10,currentRoom,color(30),color(128)); // Call the constructor of EntityMovable with respective style colors
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
         
         System.out.println("VelocityX: " + velocityX + ", VelocityY: " + velocityY);
        centreX += velocityX;
        centreY += velocityY;  

        PVector currentVelocity = new PVector((float) velocityX, (float) velocityY);
        currentVelocity.normalize();
        eyeX = (int) (centreX + currentVelocity.x * eyeOffset);
        eyeY = (int) (centreY + currentVelocity.y * eyeOffset);
    }

    public boolean isPlayerinFOV(){

        Player p=game.getPlayer();

        if(p.currentRoom!=this.currentRoom) return false;
        PVector enemyVector=this.getEntityVisionVector();
        PVector enemyToPlayerVector=new PVector(p.centreX-this.centreX,p.centreY-this.centreY);

        float angleInRadians = PVector.angleBetween(enemyVector, enemyToPlayerVector);
        float angleInDegrees=degrees(angleInRadians);

        return (angleInDegrees<=30)? true : false; //120 degrees FOV
    }

    private boolean isEnemyToWallCollisionX(){
        
        return(centreX-radius+velocityX < currentRoom.x1 || centreX + radius+velocityX >currentRoom.x2);
    }

    private boolean isEnemyToWallCollisionY(){
        
        return(centreY-radius+velocityY < currentRoom.y1 || centreY + radius+velocityY >currentRoom.y2);     
    }

    private void chasePlayer()
    {
        Player p=game.getPlayer();
        float dx = p.centreX - centreX;
        float dy = p.centreY - centreY;

        // Normalize the direction vector
        PVector direction = new PVector(dx, dy);
        direction.normalize();

        // Set velocity based on the direction and speed (step)
        velocityX = direction.x * chaseStep;
        velocityY = direction.y * chaseStep;
    }
}