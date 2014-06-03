public enum Count {
    ONE, TWO, THREE;

    public static Count toEnum(int i) {
        switch (i % 3) {
            case 0: return ONE;
            case 1: return TWO;
            case 2: return THREE;
        }
        return null;
    }

    public static int fromEnum(Count c) {
        switch (c) {
            case ONE: return 0;
            case TWO: return 1;
            case THREE: return 2;
        }
        return 0;
    }

    public static Count complement(Count a, Count b) {
        return toEnum((6 - fromEnum(a) - fromEnum(b))%3);
    }
}