public class Door{
    private int centreX;
    private int centreY;
    private int width;
    private int height;
    private color fillColor;
    private color strokeColor;
    private int strokeWeight;

    public Door(int centreX, int centreY, int width,int height) {
        this.centreX = centreX;
        this.centreY = centreY;
        this.width = width;
        this.height = height;
        this.fillColor = color(229, 0, 204); // Default fill color
        this.strokeColor = color(0); // Default stroke color
        this.strokeWeight = 1; // Default stroke weight
    }

    public void draw() {
        noStroke();
        rectMode(CENTER);
        fill(fillColor);
        rect(centreX, centreY, width, height, 20);
    }

    public boolean isPlayerInExit(int x1, int y1, int x2, int y2) {
        return (x1 < centreX + width / 2 && x2 > centreX - width / 2 &&
                y1 < centreY + height / 2 && y2 > centreY - height / 2);
    }
}