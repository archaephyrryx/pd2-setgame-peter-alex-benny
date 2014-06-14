public enum Color  {
    RED, GREEN, PURPLE;

    public static Color toEnum(int i) {
        switch (i % 3) {
            case 0: return RED;
            case 1: return GREEN;
            case 2: return PURPLE;
        }
        return null;
    }

    public static int fromEnum(Color c) {
        switch (c) {
            case RED: return 0;
            case GREEN: return 1;
            case PURPLE: return 2;
        }
        return 0;
    }

    public static Color complement(Color a, Color b) {
        return toEnum((6 - fromEnum(a) - fromEnum(b))%3);
    }
}