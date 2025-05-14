public static class library {
    
    public static enum GameStage{
        START,
        PLAYING,
        BETWEEN_LEVELS,
        PAUSE,
        END,
        RESTART
    };

    public static int levelConfig_noOfDungeons=0; // no of dungeons in the level
    public static int levelConfig_noOfEnemyRandom=1; // no of random enemies in the level
    public static int levelConfig_noOfEnemyGuard=2; // no of guard enemies in the level  
    public static int levelConfig_noOfEnemyChaser=3; // no of guard enemies in the level  

    public static int [][] levelConfig=new int [][]
    {
        //no of Dungeons, no of Enemy Random, no of Enemy Guard, no of Enemy Chaser
        {1,0,0,0}, // level 0
        {2,1,0,0}, // level 1
        {2,0,1,0}, // level 2
        {3,0,0,1}, // level 3
        {3,0,0,0}, // level 4
        {3,0,0,0}, // level 5
        {4,0,0,0}, // level 6
        {4,0,0,0}, // level 7
        {4,0,0,0}, // level 8
        {5,0,0,0}, // level 9
        {5,0,0,0}, // level 10
    };

    public static int noOfLevels=levelConfig.length-1; // no of levels in the game

    //public static color playerFillColor=color(255); // player fill color
    //public static color playerStrokeColor=color(128); // player stroke color        
    //public static color enemyChaserFillColor=color(255,0,0); // enemy fill color    
   // public static color enemyChaserStrokeColor=color(128,0,0); // enemy stroke color
    //public static color enemyGuardFillColor=color(0,255,0); // enemy fill color
    //public static color enemyGuardStrokeColor=color(0,128,0); // enemy stroke color
    //public static color enemyRandomFillColor=color(0,0,255); // enemy fill color
    //public static color enemyRandomStrokeColor=color(0,0,128); // enemy stroke color

}