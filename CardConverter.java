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
	Process tr = Runtime.getRuntime().exec(String.format("asy %s.asy", name));
	} catch (IOException e) {}
    }

    public static void main ( String[] args ) {
	String name = args[0];
	Card test = new Card(1,2,1,0);
	convert(test,name);
    }
}
