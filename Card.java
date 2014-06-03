import java.awt.*;

public class Card{
    private Color color;
    private String shape, fill;
    private int number;

    public Card(int n, Color c, String s, String f){
	number = n;
	color = c;
	shape = s;
	fill = f;
    }

    public int getNum(){
	return number;
    }

    public Color getColor(){
	return color;
    }

    public String getFill(){
	return fill;
    }

    public String getShape(){
	return shape;
    }




}
