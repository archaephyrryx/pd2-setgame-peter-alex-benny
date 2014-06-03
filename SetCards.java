public class Card implements Comparable<Card> {
    public Color color;
    public Count count;
    public Fill fill;
    public Shape shape;

    public Card (Color color, Count count, Fill fill, Shape shape) {
        this.color = color;
        this.count = count;
        this.fill = fill;
        this.shape = shape;
    }

    public Card (int i, int j, int k, int l) {
        this.color = Color.toEnum(i);
        this.count = Count.toEnum(j);
        this.fill = Fill.toEnum(k);
        this.shape = Shape.toEnum(l);
    }

    public Card(int n) {
        this(i, (i/3), (i/9), (i/27));
    }

    public Card(Card a, Card b) {
        this.color = Color.complement(a.color, b.color);
        this.count = Count.complement(a.count, b.count);
        this.fill = Fill.complement(a.fill, b.fill);
        this.shape = Shape.complement(a.shape, b.shape);
    }

    public int number() {
        return (1*Color.fromEnum(color) +
                3*Count.fromEnum(count) +
                9*Fill.fromEnum(fill) +
                27*Shape.fromEnum(shape));
    }

    public int compareTo(Card other) {
        return (this.number() - other.number());
    }

    public boolean equals(Card other) {
        return (this.compareTo(other) == 0);
    }

}

public enum Color  {
    RED, GREEN, PURPLE;

    public Color toEnum(int i) {
        switch (i % 3) {
            case 0: return RED;
            case 1: return GREEN;
            case 2: return PURPLE;
        }
    }

    public int fromEnum(Color c) {
        switch (c) {
            case RED: return 0;
            case GREEN: return 1;
            case PURPLE: return 2;
        }
    }

    public Color complement(Color a, Color b) {
        return toEnum((6 - fromEnum(a) - fromEnum(b))%3);
    }
}

public enum Count {
    ONE, TWO, THREE;

    public Count toEnum(int i) {
        switch (i % 3) {
            case 0: return ONE;
            case 1: return TWO;
            case 2: return THREE;
        }
    }

    public int fromEnum(Count c) {
        switch (c) {
            case ONE: return 0;
            case TWO: return 1;
            case THREE: return 2;
        }
    }

    public Count complement(Count a, Count b) {
        return toEnum((6 - fromEnum(a) - fromEnum(b))%3);
    }
}

public enum Fill {
    EMPTY, SHADED, FILLED;

    public Fill toEnum(int i) {
        switch (i % 3) {
            case 0: return EMPTY;
            case 1: return SHADED;
            case 2: return FILLED;
        }
    }

    public int fromEnum(Fill f) {
        switch (f) {
            case EMPTY: return 0;
            case SHADED: return 1;
            case FILLED: return 2;
        }
    }

    public Fill complement(Fill a, Fill b) {
        return toEnum((6 - fromEnum(a) - fromEnum(b))%3);
    }
}

public enum Shape {
    OVAL, DIAMOND, WAVE;

    public Shape toEnum(int i) {
        switch (i % 3) {
            case 0: return OVAL;
            case 1: return DIAMOND;
            case 2: return WAVE;
        }
    }

    public int fromEnum(Shape s) {
        switch (s) {
            case OVAL: return 0;
            case DIAMOND: return 1;
            case WAVE: return 2;
        }
    }

    public Shape complement(Shape a, Shape b) {
        return toEnum((6 - fromEnum(a) - fromEnum(b))%3);
    }
}
