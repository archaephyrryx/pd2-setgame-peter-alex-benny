import java.io.*;
import java.util.*;

public class Main {
    public static void main(String[] args) {
	BufferedReader reader = null;
	try {
	    reader = new BufferedReader(new FileReader(new File(args[0])));
	} catch (Exception e) {};
	ArrayList<Card> cards = new ArrayList<Card>(12);

	try {
	    String s = reader.readLine();
	    while ( s != null ) {
		cards.add(cardParse(s));
		s = reader.readLine();
	    }
	} catch (Exception e) {};
	
	Set setfinder = new Set();
	setfinder.readIn(cards);
	ArrayList<Triple> sets = setfinder.sets(cards);
	System.out.println("Individual sets:");
	for (Triple t : sets) {
	    System.out.printf("%s : %s : %s\n", t.a, t.b, t.c);
	}
	ArrayList<Triple> disjointsets = setfinder.disjointSets(cards);
	System.out.println("Biggest group:");
	for (Triple t : disjointsets) {
	    System.out.printf("%s : %s : %s\n", t.a, t.b, t.c);
	}
    }

    public static Card cardParse(String s) {
	return (new Card("RGP".indexOf(s.charAt(2)),
			 "123".indexOf(s.charAt(0)),
			 "ODW".indexOf(s.charAt(3)),
			 "ESF".indexOf(s.charAt(1))));
    }
}
