import java.util.*;

public class Set {
    private boolean[][] present = {{false,false,false}, // RGB
                                   {false,false,false}, // 123
                                   {false,false,false}, // ODW
                                   {false,false,false}}; // ESF

    public void readIn(ArrayList<Card> cards) {
        for (Card c : cards) {
            if (!present[0][Color.fromEnum(c.color)])
                present[0][Color.fromEnum(c.color)] =  true;
            if (!present[1][Count.fromEnum(c.count)])
                present[1][Count.fromEnum(c.count)] =  true;
            if (!present[2][Shape.fromEnum(c.shape)])
                present[2][Shape.fromEnum(c.shape)] =  true;
            if (!present[3][Fill.fromEnum(c.fill)])
                present[3][Fill.fromEnum(c.fill)] =  true;
        }
    }

    public boolean spansColor() { return (present[0][0] && present[0][1] && present[0][2]); }
    public boolean spansCount() { return (present[1][0] && present[1][1] && present[1][2]); }
    public boolean spansShape() { return (present[2][0] && present[2][1] && present[2][2]); }
    public boolean spansFill()  { return (present[3][0] && present[3][1] && present[3][2]); }


    public ArrayList<Triple> sets(ArrayList<Card> cards) {
        ArrayList<Triple> sets = new ArrayList<Triple>();
        for (int i = 0; i < cards.size(); ++i) {
            Card x = cards.get(i);
            for (int j = i+1; j < cards.size(); ++j) {
                Card y = cards.get(j);
                Pair xy = new Pair(x,y);
                if ((spansColor() || xy.sameColor()) && (spansCount() || xy.sameCount()) &&
                    (spansShape() || xy.sameShape()) && (spansFill() || xy.sameFill())) {
                    for (int k = j+1; k < cards.size(); ++k) {
                        if (xy.last().equals(cards.get(k))) {
                            sets.add(new Triple(xy));
                        }
                    }
                }
            }
        }
        return sets;
    }
}
class Pair {
    public final Card a;
    public final Card b;

    public Pair(Card x, Card y) {
        a = x;
        b = y;
    }

    public Card last() {
        return (new Card(a,b));
    }

    public final boolean sameColor() { return (a.color == b.color); }
    public final boolean sameCount() { return (a.count == b.count); }
    public final boolean sameFill() { return (a.fill == b.fill); }
    public final boolean sameShape() { return (a.shape == b.shape); }
}

class Triple {
    public Card a;
    public Card b;
    public Card c;

    public Triple(Pair p) {
        a = p.a;
        b = p.b;
        c = p.last();
    }
}
