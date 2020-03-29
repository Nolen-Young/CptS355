/******************************************************************************
 *  Compilation:  javac BallGame.java
 *  Execution:    java BallGame n
 *  Dependencies: BasicBall.java StdDraw.java
 *
 *  Creates a BasicBall and animates it
 *
 *  Part of the animation code is adapted from Computer Science:   An Interdisciplinary Approach Book
 *  
 *  Run the skeleton code with arguments : 1  basic  0.08
 *******************************************************************************/
import java.awt.Color;
import java.awt.Font;
import java.util.ArrayList;

public class BallGame { 

    public static void main(String[] args) {
  
    	// number of bouncing balls
    	int numBalls = Integer.parseInt(args[0]);
    	//ball types
    	String ballTypes[] = new String[numBalls];
    	//sizes of balls
    	double ballSizes[] = new double[numBalls];
    	
    	//retrieve ball types
    	int index =1;
    	for (int i=0; i<numBalls; i++) {
    		ballTypes[i] = args[index];
    		index = index+2;
    	}
    	//retrieve ball sizes
    	index = 2;
    	for (int i=0; i<numBalls; i++) {
    		ballSizes[i] = Double.parseDouble(args[index]);
    		index = index+2;
    	}
     
    	//TO DO: create a Player object and initialize the player game stats.  
    	Player player = new Player();
    	
    	//number of active balls
    	int numBallsinGame = 0;
        StdDraw.enableDoubleBuffering();

        StdDraw.setCanvasSize(800, 800);
        // set boundary to box with coordinates between -1 and +1
        StdDraw.setXscale(-1.0, +1.0);
        StdDraw.setYscale(-1.0, +1.0);

        // create colored balls 
        //TO DO: Create "numBalls" balls (of types given in "ballTypes" with sizes given in "ballSizes") and store them in an Arraylist
        ArrayList <BasicBall> ballsInGame = new ArrayList<BasicBall>();
        for (int i = 0; i < ballTypes.length; i++) {
            if (ballTypes[i].equals("basic")) {
                BasicBall ball = new BasicBall(ballSizes[i],Color.RED);
                ballsInGame.add(ball);
            }
            else if (ballTypes[i].equals("shrink")) {
                ShrinkBall ball = new ShrinkBall(ballSizes[i],Color.BLUE);
                ballsInGame.add(ball);
            }
            else if (ballTypes[i].equals("bounce")) {
                BounceBall ball = new BounceBall(ballSizes[i],Color.YELLOW);
                ballsInGame.add(ball);
            }
            else if (ballTypes[i].equals("split")) {
                SplitBall ball = new SplitBall(ballSizes[i],Color.BLACK);
                ballsInGame.add(ball);
            }
            else {
                BasicBall ball = new BasicBall(ballSizes[i],Color.RED);
                ballsInGame.add(ball);
            } 
            //TO DO: initialize the numBallsinGame
            numBallsinGame++;
        }
        
        // do the animation loop
        StdDraw.enableDoubleBuffering();
        while (numBallsinGame > 0) {

        	// TODO: move all balls
            for (int i = 0; i < ballsInGame.size(); i++){
                ballsInGame.get(i).move();
            }
            
            //Check if the mouse is clicked
            if (StdDraw.isMousePressed()) {
                double x = StdDraw.mouseX();
                double y = StdDraw.mouseY();
                //TODO: check whether a ball is hit. Check each ball. 
                for (int i = 0; i < ballsInGame.size(); i++){
                    if (ballsInGame.get(i).isHit(x,y)) {
                        ballsInGame.get(i).reset();
                        //TO DO: Update player statistics
                        if (ballsInGame.get(i) instanceof ShrinkBall) {
                            player.updateNumberOfTimesHitShrinkBall();
                            player.addScore(20);
                        }
                        else if (ballsInGame.get(i) instanceof BounceBall) {
                            player.updateNumberOfTimesHitBounceBall();
                            player.addScore(15);
                        } 
                        else if (ballsInGame.get(i) instanceof SplitBall) {
                        	SplitBall ball = new SplitBall(ballsInGame.get(i).getRadius(),Color.BLACK);
                        	ballsInGame.add(ball);
                            player.updateNumberOfTimesHitSplitBall();
                            numBallsinGame++;
                            player.addScore(10);
                        }
                        else if (ballsInGame.get(i) instanceof BasicBall) {
                            player.updateNumberOfTimesHitBasic();
                            player.addScore(25);
                        }
                        else {
                            player.updateNumberOfTimesHitBasic();
                            player.addScore(25);
                        }
                    }
                }
            }
                
            numBallsinGame = 0;
            // draw the n balls
            StdDraw.clear(StdDraw.GRAY);
            StdDraw.setPenColor(StdDraw.BLACK);
            
            //TO DO: check each ball and see if they are still visible. numBallsinGame should hold the number of visible balls in the game. 
            for (int i = 0; i < ballsInGame.size(); i++){
                if (ballsInGame.get(i).isOut == false) { 
                    ballsInGame.get(i).draw();
                    numBallsinGame++;
                }
            }
            //Print the game progress
            StdDraw.setPenColor(StdDraw.YELLOW);
            StdDraw.line(.15,-.15,.15,.15);
            StdDraw.line(-.15,.15,.15,.15);
            StdDraw.line(.15,-.15,-.15,-.15);
            StdDraw.line(-.15,.15,-.15,-.15);
            Font font = new Font("Arial", Font.BOLD, 20);
            StdDraw.setFont(font);
            StdDraw.text(-0.65, 0.90, "Number of balls in game: "+ String.valueOf(numBallsinGame));
            //TO DO: print the rest of the player statistics
            StdDraw.text(-0.65, .85, "Most Hit Ball: "+ player.mostHitBall());
            StdDraw.text(-0.65, .8, "Score: "+ String.valueOf(player.getScore()));
            StdDraw.show();
            StdDraw.pause(20);
        }
        while (true) {
        	StdDraw.clear(StdDraw.GRAY);
            StdDraw.setPenColor(StdDraw.BLUE);
            Font font = new Font("Arial", Font.BOLD, 60);
            StdDraw.setFont(font);
            StdDraw.text(0, 0, "GAME OVER");
            //TO DO: print the rest of the player statistics
            font = new Font("Arial", Font.BOLD, 40);
            StdDraw.setFont(font);
            StdDraw.text(0, -.2, "Most Hit Ball: "+ player.mostHitBall());
            StdDraw.text(0, -.4, "Score: "+ String.valueOf(player.getScore()));
            StdDraw.show();
            StdDraw.pause(10);           
        }
        	
        
    }
}
