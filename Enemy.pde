abstract public class Enemy extends EntityMovable 
{
    protected double velocityX;
    protected double velocityY;
    protected double chaseStep;

    Enemy(int centreX,int centreY, int radius,Room currentRoom, color fillColor, color strokeColor, double step, double chaseStep)
    {
        super(centreX,centreY,radius,currentRoom,fillColor,strokeColor,step); // Call the constructor of EntityMovable with player style colors
        this.chaseStep = chaseStep; // Set the chase step size for the entity
    }

    public abstract void move();

    public boolean isEnemytoEnemyCollisionDetected(ArrayList <Enemy> enemies){

        for(Enemy e:enemies)
        {
            if(e!=this)
            {
                float distance = dist(e.centreX, e.centreY, this.centreX, this.centreY);

                if(distance<=this.radius+e.radius) 
                {
                    return true;
                }
            }
        }
        return false;
    }

    public boolean isEnemytoPlayerCollisionDetected(){

        Player p=game.getPlayer();
        float distance = dist(p.centreX, p.centreY, this.centreX, this.centreY);
        return (distance<=this.radius+p.radius) ? true:false;
    }

    protected void initializeRandomVelocity(){
        double random=Math.random();
        double angle= 2* Math.PI * random;
        double cosine=Math.cos(angle);
        double sine=Math.sin(angle);

        velocityX=step*cosine;
        velocityY=step*sine;
    }

    protected void chasePlayer()
    {

        Player p=game.getPlayer();
        float dx = p.centreX - centreX;
        float dy = p.centreY - centreY;

        // Normalize the direction vector
        PVector direction = new PVector(dx, dy);
        direction.normalize();

        // Set velocity based on the direction and speed (step)
        velocityX = direction.x *chaseStep;
        velocityY = direction.y *chaseStep;

    }

    protected boolean isPlayerinFOV(){

        Player p=game.getPlayer();

        if(p.currentRoom!=this.currentRoom) return false;
        PVector enemyVector=this.getEntityVisionVector();
        PVector enemyToPlayerVector=new PVector(p.centreX-this.centreX,p.centreY-this.centreY);

        float angleInRadians = PVector.angleBetween(enemyVector, enemyToPlayerVector);
        float angleInDegrees=degrees(angleInRadians);

        return (angleInDegrees<=30)? true : false; //120 degrees FOV
    }

    protected boolean isEnemyToWallCollisionX(){
        
        return(centreX-radius+velocityX < currentRoom.x1 || centreX + radius+velocityX >currentRoom.x2);
    }

    protected boolean isEnemyToWallCollisionY(){
        
        return(centreY-radius+velocityY < currentRoom.y1 || centreY + radius+velocityY >currentRoom.y2);     
    }

    public void dieOnBulletCollision(){
        // to do later
    }
}