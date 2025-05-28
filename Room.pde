
class Room
{
  int centreX;
  int centreY; // The centre of the Room
  int width; 
  int height; // The width and height of the Room
  int x1;
  int y1; // The top left corner of the Room
  int x2;
  int y2; // The bottom right corner of the Room
  color fillColor; // The fill color of the Room
  boolean isDungeon; // Whether the Room is a dungeon or not
  Room subRoom;

  Room(int x1, int y1, int x2, int y2, boolean isDungeon) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.isDungeon = isDungeon;
    width = x2 - x1;
    height = y2 - y1;
    centreX = x1 + width / 2;
    centreY = y1 + height / 2;
    fillColor = color(229, 255, 204); // Default fill color
  }

  public Room getSubRoom(){
    return this.subRoom;
  }

  public boolean isInside(int x, int y) {
    // Check if the point (x, y) is inside the Room
    return (x >= x1 && x <= x2 && y >= y1 && y <= y2);
  }

  public Room[] divideRooms()
  {
    Room r1=this;
    Room r2,r3,r4;
    int ranVal = (int) random(3, 5);  // Random value to divide the larger dimension
    if (width > height) 
    {
        // If width (width) is larger, split along the x-axis (vertically)
        int splitX = r1.x1 + ranVal * r1.width / 10;  // Divide along the width

        // Define the two new Arooms (r2 and r3)
        r2 = new Room(r1.x1, r1.y1, splitX-10*ranVal, r1.y2,true);  // Left Room
        r3 = new Room(splitX+10*ranVal, r1.y1, r1.x2, r1.y2,true);  // Right Room
        r4 = new Room(r2.centreX, r2.centreY-15, r3.centreX, r3.centreY+15,false); //tunnel horizontal
    } else 
    {
        // If height (height) is larger, split along the y-axis (horizontally)
        int splitY = r1.y1 + ranVal * r1.height / 10;  // Divide along the height

        // Define the two new Arooms (r2 and r3)
        r2 = new Room(r1.x1, r1.y1, r1.x2, splitY-10*ranVal,true);  // Top Room
        r3 = new Room(r1.x1, splitY+10*ranVal, r1.x2, r1.y2,true);  // Bottom Room
        r4= new Room(r2.centreX-15, r2.centreY, r3.centreX+15, r3.centreY,false); //tunnel vertical
      }
    return new Room[]{r2, r3, r4};
  }

  public void createSubRoomForDungeon(){
      if(this.isDungeon)
      {
        this.subRoom=new Room(this.x1+50, this.y1+50, this.x2-50, this.y2-50, false);
      }else
      this.subRoom=null;
  }
}
