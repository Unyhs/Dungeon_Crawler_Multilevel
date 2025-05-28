abstract public class Enemy extends EntityMovable 
{
    protected char currentDirection;

    //a-left
    //w-up
    //d-right
    //s-down

    Enemy(int centreX,int centreY, int diameter,Room currentRoom, color fillColor, color strokeColor)
    {
        super(centreX,centreY,diameter,currentRoom,fillColor,strokeColor); // Call the constructor of EntityMovable with player style colors
    }

    public char getCurrentDirection(){
        return currentDirection;
    }

    public void setCurrentDirection(char currentDirection){
        this.currentDirection=currentDirection;
    }

    public abstract void move();

    public boolean isEnemytoEnemyCollisionDetected(ArrayList <Enemy> enemies){

        for(Enemy e:enemies)
        {
            if(e!=this)
            {
                float distance = dist(e.centreX, e.centreY, this.centreX, this.centreY);

                if(distance<=this.diameter/2+e.diameter/2) 
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
        return (distance<=this.diameter/2+p.diameter/2) ? true:false;
    }

    public void dieOnBulletCollision(){
        // to do later
    }
}