public class EnemyChaser extends Enemy{

     EnemyChaser(int centreX,int centreY, int diameter,Room currentRoom)
    {
        super(centreX,centreY,diameter,currentRoom,color(30),color(128)); // Call the constructor of EntityMovable with respective style colors
        this.setStep(1); // Set the step size for the entity
    }

    public void move(){
        centreX=centreX+step;
    }
}