public class EnemyRandom extends Enemy{

    EnemyRandom(int centreX,int centreY, int diameter,Room currentRoom)
    {
        super(centreX,centreY,diameter,currentRoom,color(10),color(128)); // Call the constructor of EntityMovable with respective style colors
        this.setStep(1); // Set the step size for the entity
        this.setCurrentDirection('d');
    }

    public boolean checkMove(int x1, int y1, int x2, int y2){
        Room room1=game.getLevel().getDungeon(x1, y1); // Check if the new coordinates are within the current Room
        Room room2=game.getLevel().getDungeon(x2, y2); // Check if the new coordinates are within the current Room

        return (room1!=null && room2!=null) ? true : false; // Check if the new coordinates are within the same Room
    }

    public void move()
    {
        int delta=diameter/2+step;
        //if E2E collision detected
        if(isEnemytoEnemyCollisionDetected(game.getLevel().getEnemies()))
        { 
            switch(currentDirection)
            {
                case 'a':
                {
                    this.setCurrentDirection('d');
                    break;
                }

                case 'd':
                {
                    this.setCurrentDirection('a');
                    break;
                }

                case 'w':
                {
                    this.setCurrentDirection('s');
                    break;
                }

                case 's':
                {
                    this.setCurrentDirection('w');
                    break;
                }

            }
        }
        //check if next move is not in the same Dungeon
        else if((currentDirection=='a' && centreX-delta<currentRoom.x1) || (currentDirection=='d' && centreX+delta>currentRoom.x2) || 
                (currentDirection=='w' && centreY-delta<currentRoom.y1) || (currentDirection=='s' && centreY+delta>currentRoom.y2))
            {
                System.out.print("Line 57");
                changeRandomDirection();
            }
        else
        {
            switch(currentDirection)
            {
                case 'a':
                {
                    centreX=centreX-step;
                    break;
                }

                case 'd':
                {
                    centreX=centreX+step;
                    break;
                }

                case 'w':
                {
                    centreY=centreY-step;
                    break;
                }

                case 's':
                {
                    centreY=centreY+step;
                    break;
                }

            }
        }       
            
    }

    public void changeRandomDirection(){
        char []directions=new char [] {'a','w','s','d'};

        char newDirection=currentDirection;

        while(currentDirection==newDirection)
        {
            newDirection=directions[(int) random(0,3)];
        }

        currentDirection=newDirection;
        System.out.print("Line 102 "+currentDirection+" ");
    }



}