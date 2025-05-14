public class EnemyGuard extends Enemy{

    EnemyGuard(int centreX,int centreY, int diameter,Room currentRoom)
    {
        super(centreX,centreY,diameter,currentRoom,color(20),color(128)); // Call the constructor of EntityMovable with respective style colors
        this.setStep(5); // Set the step size for the entity
    }

    public void move(){
    // to do later
    }

}