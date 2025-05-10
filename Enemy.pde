public class Enemy extends EntityMovable 
{
    Enemy(int centreX,int centreY, int diameter,Room currentRoom)
    {
        super(centreX,centreY,diameter,currentRoom,color(255),color(128)); // Call the constructor of EntityMovable with player style colors
        this.setStep(5); // Set the step size for the player
    }
}