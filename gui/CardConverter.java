import java.io.*;

public class CardConverter {
    public static void convert(Card c, String name) {
        if (!SetCards.genasy()) { System.err.println("FAIL"); return; }
	int i = c.shapeInt();
	int j = c.colorInt();
	int k = c.countInt();
	int l = c.fillInt();
	Writer writer = null;
	try {
	    writer = new BufferedWriter(new OutputStreamWriter(
			new FileOutputStream(name+".asy"), "utf-8"));
	    writer.write("import setcards;");
	    writer.write(String.format("generate(%d,%d,%d,%d);", i, j, k, l));
	} catch (IOException ex) {
	    // report
	} finally {
	    try {writer.close();} catch (Exception ex) {}
	}
	try {
	Process tr = Runtime.getRuntime().exec(String.format("asy -f png %s.asy -o data/%s.png", name, name));
	} catch (IOException e) {}
    }
}
