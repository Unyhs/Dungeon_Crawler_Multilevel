public class Button{
    int centreX, centreY, width, height; // Position and dimensions
    String label;
    color fillColor, strokeColor, hoverColor, clickColor;
    boolean mousePressed=false;

    // Constructor
    Button(int centreX, int centreY, int width, int height, String label) {
        this.centreX =centreX;
        this.centreY = centreY;
        this.width=width;
        this.height=height;
        this.label=label;
        fillColor = color(0, 408, 612); // Default fill color
        strokeColor = color(0);   // Default stroke color
        hoverColor = color(150);
        clickColor = color(100);
    }

  // Method to set colors
    void setColors(color fillColor, color strokeColor, color hoverColor, color clickColor) {
        this.fillColor = fillColor;
        this.strokeColor = strokeColor;
        this.hoverColor = hoverColor;
        this.clickColor = clickColor;
    }

    void handleMousePressed(){
        if(mouseX>centreX-width/2 && mouseX<centreX+width/2 && mouseY>centreY-height/2 && mouseY<centreY+height/2)
        {
            mousePressed=true;
        }
    }

    void setMousePressed(boolean mousePressed) {
        this.mousePressed = mousePressed;
    }

    void drawButton() {
        // Draw the button
        rectMode(CORNER); // Set rectMode to CORNER for correct positioning
        fill(fillColor);
        stroke(strokeColor);
        rect(centreX-width/2, centreY-height/2, width, height, 10); // Rounded corners

        fill(0); // Text color
        textSize(24); // Set text size
        textAlign(CENTER, CENTER);
        text(label, centreX, centreY); // Centered text
    }

}