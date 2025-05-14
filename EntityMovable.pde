public class EntityMovable 
{
    protected int centreX,centreY;
    protected int step;
    protected int diameter;
    protected color fillColor,strokeColor;
    protected int eyeX,eyeY;
    protected int eyediameter;
    protected color eyeColor=color(255,0,255); // Default eye color
    protected Room currentRoom; // The current Room of the Entity


    public EntityMovable(int centreX,int centreY, int diameter, Room currentRoom, color fillColor, color strokeColor) {
        this.centreX = centreX;
        this.centreY = centreY;
        this.diameter = diameter;
        this.currentRoom = currentRoom; // Set the current Room of the Entity
        this.fillColor = fillColor;
        this.strokeColor = strokeColor;
        this.step = 5; // Default step size
        this.eyeX=centreX+diameter/2; // Default eye X position
        this.eyeY=centreY;
        this.eyediameter = 5; // Default eye diameter
    }

    public void setStep(int step) {
        this.step = step;
    }   

    public PVector getEntityVisionVector(){
        PVector v = new PVector(eyeX-centreX,eyeY-centreY);
        return v;
    }

    public void drawEntityWithEye(){ 
        fill(fillColor);
        stroke(strokeColor);
        circle(centreX, centreY, diameter); // Draw the player as a circle

        fill(eyeColor); // Set the eye color
        noStroke(); // Disable stroke for the eye
        circle(eyeX, eyeY, eyediameter); // Draw the eye as a circle
    }

     public void drawEntityWithoutEye(){
        
        fill(fillColor);
        stroke(strokeColor);
        circle(centreX, centreY, diameter); // Draw the player as a circle
    }

}