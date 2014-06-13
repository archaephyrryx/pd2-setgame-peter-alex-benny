import java.io.*;

public class CardConverter {
    public static void convert(Card c, String name) {
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
	Process tr = Runtime.getRuntime().exec(String.format("asy -f png %s.asy", name));
	} catch (IOException e) {}
    }

    public static void main ( String[] args ) {
	for (int i = 0; i < args.length; ++i) {
	    String name = args[i];
	    Card test = new Card(i);
	    convert(test,name);
	}
    }
}
