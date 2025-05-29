public class EnemyGuard extends Enemy{

    //move along dungeon subRoom 
    //if player is in FOV -chase until it leaves currentRoom
    //when player leaves currentroom, it goes back to origin
    //on Player to Enemy Collision - Player dies
    //on enemy to enemy collision - it pauses till path is clear

    private Room subRoom;
    private int originX;
    private int originY;
    private library.GuardState currentState=library.GuardState.PATROLLING;
    private int eyeOffset=radius;

    EnemyGuard(Room currentRoom)
    {
        super(currentRoom.getSubRoom().x1, currentRoom.getSubRoom().y1,10,currentRoom,color(20),color(128), 1.5, 2.5); // Call the constructor of EntityMovable with respective style colors
        this.subRoom=currentRoom.getSubRoom();
        this.originX=subRoom.x1;
        this.originY=subRoom.y1;
        initializeRandomVelocity();
    }

    public void initializeRandomVelocity(){
        velocityX=step*0;
        velocityY=step*0;
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
                        Player p=game.getPlayer();
                        //chase player till Player leaves currentRoom
                        if(!p.currentRoom.equals(this.currentRoom))
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
        centreY += velocityY;  

        PVector currentVelocity = new PVector((float) velocityX, (float) velocityY);
        currentVelocity.normalize();
        eyeX = (int) (centreX + currentVelocity.x * eyeOffset);
        eyeY = (int) (centreY + currentVelocity.y * eyeOffset);
    }

    private void patrol(){
        if(centreX == subRoom.x2 && centreY==subRoom.y1)
        {
 
            velocityX=step*0;
            velocityY=step*1;
            
        }else if(centreX == subRoom.x2 && centreY==subRoom.y2)
        {   
            velocityX=step*-1;
            velocityY=step*0;
           
        }else if(centreX == subRoom.x1 && centreY==subRoom.y2)
        {
      
            velocityX=step*0;
            velocityY=step*-1;
            
        }else if(centreX == subRoom.x1 && centreY==subRoom.y1)
        {
     
            velocityX=step*1;
            velocityY=step*0;
            
        }
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

}