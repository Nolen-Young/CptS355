
public class Player
{
	
	private int score;
	private int numberOfTimesHitBasic;
	private int numberOfTimesHitBounceBall;
	private int numberOfTimesHitShrinkBall;
    private int numberOfTimesHitSplitBall;
	public int scoreConstant = 10;	

	
	public Player(){
		score = 0;
        numberOfTimesHitBasic = 0;
        numberOfTimesHitBounceBall = 0;
        numberOfTimesHitShrinkBall = 0;
	}

	public int getScore (){
		return score;
	}
	
	public int getNumberOfTimesHitBasic (){
		return numberOfTimesHitBasic;
	}
	
	public int getNumberOfTimesHitBounceBall (){
		return numberOfTimesHitBounceBall;
	}
	
	public int getNumberOfTimesHitShrinkBall (){
		return numberOfTimesHitShrinkBall;
	}
    
    public int getNumberOfTimesHitSplitBall (){
		return numberOfTimesHitSplitBall;
	}
    
	public void addScore (int plus){
		score += plus;
	}
    
	public void updateNumberOfTimesHitBasic (){
		numberOfTimesHitBasic++;
	}
	
	public void updateNumberOfTimesHitBounceBall () {
		numberOfTimesHitBounceBall++;
	}
	
	public void updateNumberOfTimesHitShrinkBall (){
		numberOfTimesHitShrinkBall++;
	}
    
    public void updateNumberOfTimesHitSplitBall (){
		numberOfTimesHitSplitBall++;
	}
	
	public String mostHitBall () {
		if (numberOfTimesHitBasic > numberOfTimesHitBounceBall && numberOfTimesHitBasic > numberOfTimesHitShrinkBall && numberOfTimesHitBasic > numberOfTimesHitSplitBall){
            return "Basic Ball";
        }
		else if (numberOfTimesHitBounceBall > numberOfTimesHitBasic && numberOfTimesHitBounceBall > numberOfTimesHitShrinkBall && numberOfTimesHitBounceBall > numberOfTimesHitSplitBall){
            return "Bounce Ball";
        }
        else if (numberOfTimesHitShrinkBall > numberOfTimesHitBasic && numberOfTimesHitShrinkBall > numberOfTimesHitBounceBall && numberOfTimesHitShrinkBall > numberOfTimesHitSplitBall){
            return "Shrink Ball";
        }
        else if (numberOfTimesHitSplitBall > numberOfTimesHitBasic && numberOfTimesHitSplitBall > numberOfTimesHitShrinkBall && numberOfTimesHitSplitBall > numberOfTimesHitBounceBall){
            return "Split Ball";
        }
        else {
            return "ERROR BALL";
        }
	}
}