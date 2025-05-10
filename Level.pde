import java.util.ArrayList;
import java.util.Comparator;    
import java.util.PriorityQueue;
import java.util.Collections;

public class Level{
    private int levelNo; // The level number
    private int noOfDungeons;
    private ArrayList<Room> RoomsAll; // List of Rooms in the level
    private boolean isLevelCompleted; // Flag to check if the level is completed
    private Door exitDoor; // Door object for the level
    
    // Constructor to initialize the level with a level number
    public Level(int levelNo) 
    {
        this.levelNo = levelNo; // Set the level number
        this.noOfDungeons =library.levelConfig[levelNo][library.levelConfig_noOfDungeons]; // Get the number of dungeons from the level configuration  ; 
        RoomsAll = new ArrayList<Room>(); // Initialize the list of Rooms   
        isLevelCompleted = false; // Initialize the level completion status to false
    }

    public Door getExitDoor() {
        return exitDoor; // Return the exit door object
    }

    public int getLevelNo() {
        return levelNo;
    }

    public boolean isLevelCompleted() {
        return isLevelCompleted;
    }

    public void setIsLevelCompleted(boolean isLevelCompleted) {
        this.isLevelCompleted = isLevelCompleted;
    }

    public ArrayList<Room> getRoom(int x, int y){

        ArrayList<Room> rooms = new ArrayList<Room>(); // List to store Rooms containing the coordinates
        for (Room r : RoomsAll) 
        {
            if (r.isInside(x, y)) rooms.add(r); // Check if the coordinates are inside the Room
        }
        return rooms; // Return null if no Room contains the coordinates
    }

    public Room getFirstDungeon(){

        int minx2=960;
        int miny2=640;

        ArrayList<Room> dungeons = new ArrayList<Room>(); // List to store Rooms containing the coordinates
    
        for(Room r: RoomsAll)
        {
            if(r.isDungeon) // Check if the Room is the first dungeon
            {
                dungeons.add(r); // Add the Room to the list of dungeons
            }
        }

        Collections.sort(dungeons, new Comparator<Room>() {
            public int compare(Room r1, Room r2) {
                return (r1.x2==r2.x2) ? r1.y2-r2.y2 : r1.x2-r2.x2; // Sort by x2 coordinate if y2 coordinates are equal
            }
        });

        exitDoor=new Door(dungeons.get(noOfDungeons-1).centreX, dungeons.get(noOfDungeons-1).centreY, 50,50); // Create a new door object at the centre of the first dungeon

        return dungeons.get(0); // Return null if no dungeon is found
    }

    public void createDungeons() {
        // Create dungeons and add them to the Rooms list
        PriorityQueue<Room> RoomsAllPQ = new PriorityQueue<Room>(new Comparator <Room> () {
            
            public int compare(Room r1,Room r2){
                return r2.width*r2.height-r1.width*r1.height;
            }
        }); // Priority queue to sort Rooms by area in descending order

        RoomsAllPQ.add(new Room(30, 140, 930, 620, true)); // Add the initial Room to the list
        int dungeonsCreated = 1;

        while(dungeonsCreated<noOfDungeons && !RoomsAllPQ.isEmpty()) {
            Room room = RoomsAllPQ.peek(); // Get the Room with the largest area
            Room [] newRooms=room.divideRooms();
            Room r2=newRooms[0];
            Room r3=newRooms[1];
            Room r4=newRooms[2];

            if(r2.height*r2.width>10000 && r3.height*r3.width>10000) // Check if the new Rooms are large enough
            {
                RoomsAllPQ.poll(); // Remove the Room from the priority queue
                RoomsAllPQ.add(r2); // Add the new Room to the priority queue for further division
                RoomsAllPQ.add(r3);
                RoomsAllPQ.add(r4); // Add the tunnel Room to the priority queue
                dungeonsCreated++;
            }
        }

        RoomsAll = new ArrayList<>(RoomsAllPQ); // Convert the priority queue to a list
    }     

    public void drawDungeons(){
        for (int i = 0; i <RoomsAll.size(); i++) 
        {
            Room r1 =RoomsAll.get(i); 
            noStroke();
            rectMode(CENTER);
            fill(229, 255, 204);
            rect(r1.centreX, r1.centreY, r1.width, r1.height,20);
        }    
    }

    public void drawDoor(){
        exitDoor.draw(); // Draw the door on the screen
    }

    public void drawLevel(){
        background(0, 102, 204);

        //create level caption
        textSize(48);
        fill(0, 408, 612);
        textAlign(CENTER, TOP);
        text("Welcome to Level "+""+levelNo, 480, 20); 

        //create level sub caption
        
        textSize(24);
        fill(229, 255, 204);
        textAlign(CENTER, TOP);
        text("Press P to pause/resume ", 480, 80); 

        drawDungeons(); // Draw the dungeons on the screen
        drawDoor(); // Draw the door on the screen
    }

}