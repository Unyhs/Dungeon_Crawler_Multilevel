import java.util.ArrayList;
import java.util.Comparator;    
import java.util.PriorityQueue;
import java.util.Collections;

public class Level{
    private int levelNo; // The level number
    private int noOfDungeons;
    private ArrayList<Room> RoomsAll; // List of Rooms in the level
    ArrayList<Room> dungeons = new ArrayList<Room>(); // List to store Rooms containing the coordinates
    private boolean isLevelCompleted; // Flag to check if the level is completed
    private Door exitDoor; // Door object for the level
    private ArrayList <Enemy> enemies=new ArrayList<>();
    
    // Constructor to initialize the level with a level number
    public Level(int levelNo) 
    {
        this.levelNo = levelNo; // Set the level number
        this.noOfDungeons =library.levelConfig[levelNo][library.levelConfig_noOfDungeons]; // Get the number of dungeons from the level configuration  ; 
        RoomsAll = new ArrayList<Room>(); // Initialize the list of Rooms   
        isLevelCompleted = false; // Initialize the level completion status to false
    }

    public ArrayList<Enemy> getEnemies(){
        return enemies;
    }

    public void setExitDoor(){
        exitDoor=new Door(dungeons.get(noOfDungeons-1).centreX, dungeons.get(noOfDungeons-1).centreY, 50,50); // Create a new door object at the centre of the first dungeon
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

    public Room getDungeon(int x, int y){

        for (Room r : dungeons) 
        {
            if (r.isInside(x, y)) return r; // Check if the coordinates are inside the Room
        }
        return null; // Return null if no Room contains the coordinates
    }

    public ArrayList<Room> getRooms(int x, int y){

        ArrayList<Room> rooms1=new ArrayList<>();

        for (Room r : RoomsAll) 
        {
            if (r.isInside(x, y)) rooms1.add(r); // Check if the coordinates are inside the Room
        }
        return rooms1; // Return null if no Room contains the coordinates
    }

    public Room getPlayerRoom() {
        return dungeons.get(0); // Return the Room where the player is currently located
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

        for(Room r: RoomsAll)
        {
            if(r.isDungeon) // Check if the Room is the first dungeon
            {
                r.createSubRoomForDungeon();
                dungeons.add(r); // Add the Room to the list of dungeons
            }
        }

        Collections.sort(dungeons, new Comparator<Room>() {
            public int compare(Room r1, Room r2) {
                return (r1.x2==r2.x2) ? r1.y2-r2.y2 : r1.x2-r2.x2; // Sort by x2 coordinate if y2 coordinates are equal
            }
        });
    }

    public void createEnemies(){

        int noOfEnemyRandom=library.levelConfig[levelNo][library.levelConfig_noOfEnemyRandom];

        for(int i=0;i<noOfEnemyRandom;i++)
        {
            Room r=dungeons.get((int)random(0, noOfDungeons-1)); 
            enemies.add(new EnemyRandom(r));
        }

        int noOfEnemyGuard=library.levelConfig[levelNo][library.levelConfig_noOfEnemyGuard];

        for(int i=0;i<noOfEnemyGuard;i++)
        {
            Room r=dungeons.get((int)random(0, noOfDungeons-1)); 
            enemies.add(new EnemyGuard(r));
        }

        int noOfEnemyChaser=library.levelConfig[levelNo][library.levelConfig_noOfEnemyChaser];

        for(int i=0;i<noOfEnemyChaser;i++)
        {
            Room r=dungeons.get((int)random(0, noOfDungeons-1)); 
            enemies.add(new EnemyChaser(r));
        }
    }

    public void createDoor(){
        setExitDoor();
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

    public void drawEnemies(){

        for(Enemy e: enemies)
        {
            if (e instanceof EnemyRandom) {
                // Handle EnemyRandom type
                e.drawEntityWithoutEye();
                
            } else {
                // Handle EnemmyGuard & Enemy Chaser type
                e.drawEntityWithEye();
            } 

            e.move();
        }
    }

    public void drawPlayer(){
        game.getPlayer().drawEntityWithEye(); // Draw the player on the screen
    }

    public void createLevel(){
        createDungeons(); // Create dungeons for the current level
        createDoor();
        createEnemies();
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
        drawPlayer();
        drawDoor(); // Draw the door on the screen
        drawEnemies();
    }

}