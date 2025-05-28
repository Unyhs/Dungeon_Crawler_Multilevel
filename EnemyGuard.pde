public class EnemyGuard extends Enemy{

    //move along dungeon subRoom 
    //if player is in FOV -chase until it leaves currentRoom
    //when player leaves currentroom, it goes back to origin
    //on Player to Enemy Collision - Player dies
    //on enemy to enemy collision - it pauses till path is clear


    private double velocityX;
    private double velocityY;
    private Room subRoom;
    private int originX;
    private int originY;
    private library.GuardState currentState=library.GuardState.PATROLLING;
    private int eyeOffset=diameter/2;

    EnemyGuard(Room currentRoom)
    {
        super(currentRoom.getSubRoom().x1, currentRoom.getSubRoom().y1,20,currentRoom,color(20),color(128)); // Call the constructor of EntityMovable with respective style colors
        this.setStep(1); // Set the step size for the entity
        this.subRoom=currentRoom.getSubRoom();
        this.originX=subRoom.x1;
        this.originY=subRoom.y1;
    }
 
    public void move()
    {
        if(isEnemytoPlayerCollisionDetected()) 
        {
            game.getPlayer().setIsDead(true);
            currentState = library.GuardState.RETURNING;
        }
        else if(isEnemytoEnemyCollisionDetected(game.getLevel().getEnemies()))
        { 
           velocityX=0;
           velocityY=0;
           currentState = library.GuardState.PAUSED;
        }
        else 
        {
            switch (currentState) {
                case PATROLLING:
                    {
                        patrol();
                        if(isPlayerinFOV()) 
                        { 
                            currentState=library.GuardState.CHASING;
                        }
                        
                        break;
                    }
                
                case CHASING:
                    {   
                        chasePlayer();
                        //chase player till Player leaves currentRoom
                        if(!game.getPlayer().currentRoom.equals(this.currentRoom))
                        {
                            currentState=library.GuardState.RETURNING;
                        }
                        break;
                    }

                case RETURNING:
                    {
                        //return to origin X and origin Y
                        goToOrigin();                        
                        if(centreX==originX && centreY==originY) currentState=library.GuardState.PATROLLING;
                        break;
                    }

                case PAUSED:

                    {
                        if(!isEnemytoEnemyCollisionDetected(game.getLevel().getEnemies())) 
                        currentState=library.GuardState.RETURNING;
                    }
            
                default:
                    break;
            }
        }
        centreX += velocityX;
        eyeX+=velocityX;
        centreY += velocityY;  
        eyeY+=velocityY;
    }

    private void patrol(){


        if(centreX == subRoom.x2 && centreY==subRoom.y1)
        {
 
            velocityX=step*0;
            velocityY=step*1;
            eyeX=centreX;
            eyeY=centreY+diameter/2;
        }else if(centreX == subRoom.x2 && centreY==subRoom.y2)
        {   
  
            velocityX=step*-1;
            velocityY=step*0;
            eyeX=centreX-diameter/2;
            eyeY=centreY;
        }else if(centreX == subRoom.x1 && centreY==subRoom.y2)
        {
      
            velocityX=step*0;
            velocityY=step*-1;
            eyeX=centreX;
            eyeY=centreY-diameter/2;
        }else if(centreX == subRoom.x1 && centreY==subRoom.y1)
        {
     
            velocityX=step*1;
            velocityY=step*0;
            eyeX=centreX+diameter/2;
            eyeY=centreY;
        }
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
        velocityX = direction.x * step*2;
        velocityY = direction.y * step*2;

    }

    private void goToOrigin()
    {
        Player p=game.getPlayer();
        float dx = originX - centreX;
        float dy = originY - centreY;
        PVector direction = new PVector(dx, dy);
        direction.normalize();

        // Set velocity based on the direction and speed (step)
        velocityX = direction.x * step;
        velocityY = direction.y * step;
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

}