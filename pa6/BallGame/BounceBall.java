import java.awt.Color;
import java.util.Random;

public class BounceBall extends BasicBall {
	protected int maxBounces;
	protected int bounces;
	public BounceBall(double r, Color c) {
		super(r, c);
		maxBounces = 3;
		bounces = 0;
	}
	
	public void move() {
        rx = rx + vx;
        ry = ry + vy;
        if ((Math.abs(rx) > 1.0 || Math.abs(ry) > 1.0) && bounces == maxBounces) {
        	isOut = true;
		}
		else if (Math.abs(rx) > 1.0 && Math.abs(ry) < 1.0 && bounces < maxBounces) {
			vx = -vx;
        	bounces++;
        }
		else if (Math.abs(rx) < 1.0 && Math.abs(ry) > 1.0 && bounces < maxBounces) {
			vy = -vy;
        	bounces++;
        }
    }
	
	public void draw() { 
    	if ((Math.abs(rx) <= 1.0) && (Math.abs(ry) <= 1.0)) {
    		StdDraw.setPenColor(color);
    		StdDraw.filledCircle(rx, ry, radius);
    	}
    	
    }
	
	public int reset() {
        Random rand = new Random();
        rx = 0.0;
        ry = 0.0;  	
        // TO DO: assign a random speed
        vx = (rand.nextInt(200) - 100) / 10000.0;
        vy = (rand.nextInt(200) - 100) / 10000.0;
        bounces = 0;
        return 1;
    }
}