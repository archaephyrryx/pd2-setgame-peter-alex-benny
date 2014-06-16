import java.util.*;

public class Card implements Comparable<Card> {
    public Color color;
    public Count count;
    public Shape shape;
    public Fill fill;

    public Card (Color color, Count count, Fill fill, Shape shape) {
        this.color = color;
        this.count = count;
        this.shape = shape;
        this.fill = fill;
    }

    public Card (int i, int j, int k, int l) {
        this.color = Color.toEnum(i);
        this.count = Count.toEnum(j);
        this.shape = Shape.toEnum(k);
        this.fill = Fill.toEnum(l);
    }

    public Card(int n) {
        this(n, (n/3), (n/9), (n/27));
    }

    public Card(Card a, Card b) {
        this.color = Color.complement(a.color, b.color);
        this.count = Count.complement(a.count, b.count);
        this.shape = Shape.complement(a.shape, b.shape);
        this.fill = Fill.complement(a.fill, b.fill);
    }

    public int colorInt() { return Color.fromEnum(color); }
    public int countInt() { return Count.fromEnum(count); }
    public int shapeInt() { return Shape.fromEnum(shape); }
    public int fillInt() { return Fill.fromEnum(fill); }


    public int number() {
        return (1*Color.fromEnum(color) +
                3*Count.fromEnum(count) +
                9*Shape.fromEnum(shape) +
                27*Fill.fromEnum(fill));
    }

    public int compareTo(Card other) {
        return (this.number() - other.number());
    }

    public boolean equals(Card other) {
        return (this.compareTo(other) == 0);
    }

    public String toString() {
	return (String.format("%s %s %s %s", this.count, this.fill, this.color, this.shape));
    }

    public static int indexIn(Card c, ArrayList<Card> a) {
        for (int i = 0; i < a.size(); ++i) {
            if (a.get(i).number() == c.number()) {
              return i;
            }
        }
        return -1;
    }
}


