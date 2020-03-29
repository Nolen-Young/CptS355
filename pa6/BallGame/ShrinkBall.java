import java.awt.Color;
import java.util.Random;

public class ShrinkBall extends BasicBall { 
	protected double initialRadius;
	public ShrinkBall(double r, Color c) {
		super(r, c);
		initialRadius = r;
	}
	
	public int reset() {
        Random rand = new Random();
        rx = 0.0;
        ry = 0.0;  	
        vx = (rand.nextInt(200) - 100) / 10000.0;
        vy = (rand.nextInt(200) - 100) / 10000.0;
        radius = radius * .66667;
        if (radius <= initialRadius / 4.0) {
        	radius = initialRadius;
        }
        return 1;
    }
}