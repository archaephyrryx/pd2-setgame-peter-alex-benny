public enum Fill {
    EMPTY, SHADED, FILLED;

    public static Fill toEnum(int i) {
        switch (i % 3) {
            case 0: return EMPTY;
            case 1: return SHADED;
            case 2: return FILLED;
        }
        return null;
    }

    public static int fromEnum(Fill f) {
        switch (f) {
            case EMPTY: return 0;
            case SHADED: return 1;
            case FILLED: return 2;
        }
        return 0;
    }

    public static Fill complement(Fill a, Fill b) {
        return toEnum((6 - fromEnum(a) - fromEnum(b))%3);
    }
}
