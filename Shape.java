public enum Shape {
    OVAL, DIAMOND, WAVE;

    public static Shape toEnum(int i) {
        switch (i % 3) {
            case 0: return OVAL;
            case 1: return DIAMOND;
            case 2: return WAVE;
        }
        return null;
    }

    public static int fromEnum(Shape s) {
        switch (s) {
            case OVAL: return 0;
            case DIAMOND: return 1;
            case WAVE: return 2;
        }
        return 0;
    }

    public static Shape complement(Shape a, Shape b) {
        return toEnum((6 - fromEnum(a) - fromEnum(b))%3);
    }
}
