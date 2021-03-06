import java.util.*;

public class Deck {
    private ArrayList<Card> deck = new ArrayList<Card>(81);

    public Deck() {
        for (int i = 0; i < 81; ++i) {
            deck.add(new Card(i));
        }
        Collections.shuffle(deck);
    }

    public ArrayList<Card> deal() {
        return deal(12);
    }

    public ArrayList<Card> deal(int i) {
        int j = (remaining() < i) ? remaining() : i;
        ArrayList<Card> hand = new ArrayList<Card>(deck.subList(0,j));
        for (Card c : hand) {
            deck.remove(c);
        }
        return hand;
    }

    public void swapout(ArrayList<Card> hand, ArrayList<Card> discard) {
        if (discard.size() == 0) {
            return;
        }
        ArrayList<Card> replace = deal(discard.size());
        for (int i = 0; i < discard.size(); ++i) {
            if (i < replace.size()) {
                hand.set(hand.indexOf(discard.get(i)), replace.get(i));
            } else {
                hand.remove(hand.indexOf(discard.get(i)));
            }
        }
    }

    public void refill(ArrayList<Card> hand) {
        fillTo(hand, 12);
    }

    public void fillTo(ArrayList<Card> hand, int to) {
        int deficit = to - hand.size();
        if (deficit == 0) {
            return;
        }
        hand.addAll(deal(deficit));
    }

    public int remaining() {
        return deck.size();
    }
}
