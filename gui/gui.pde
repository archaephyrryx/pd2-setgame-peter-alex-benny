// Layout
int rows = 3;
int cols = 4;
int num = 12;
int cardW = 120;
int cardH = 200;
int xBuff = 5;
int yBuff = 5;
// Cards and Images
Deck deck = new Deck();
ArrayList<Card> hand = deck.deal();
ArrayList<GameCard> cards;
// State
int dealtSets;
int disjointSets;
ArrayList<Card> foundSets = new ArrayList<Card>(0);;
int numClicked = 0;
int numFound = 0;

void restart() {
    numClicked = 0;
    numFound = 0;
    foundSets = new ArrayList<Card>(0);
    deck = new Deck();
    hand = deck.deal();
    setup();
}

void setup() {
    size(700,700);
    background(50, 127, 50);
    verify();
    render();
}

void render() {
    cards = new ArrayList<GameCard>(hand.size());
    num = hand.size();
    cols = num/rows;
    for (int i = 0; i < num; ++i) {
	int x = (int) (width/2 + ((i/rows) - (double)cols/2)*(cardW + xBuff));
	int y = (int) (height/2 + ((i%rows) - (double)rows/2)*(cardH + yBuff));
	cards.add(new GameCard(hand.get(i), i, x, y));
    } 
}


void draw() {
    background(50, 127, 50);
    if (dealtSets == 0) {
      textSize(20);
      text("No Sets Remaining. You Have Found "+numFound+" Sets.", 100, 30);
      text("Press N for New Game, or Q to Quit.", 100, 670);
      numClicked = 0;
      if (keyPressed) {
        if (key == 'n' || key == 'N') {
          restart();
        } else if (key == 'q' || key == 'Q') {
          exit();
        }
      }          
    } else {
        textSize(20);
        text("Sets found: "+numFound, 10, 680);
        text("Sets present: "+dealtSets, 10, 30);
        text("Most disjoint sets: "+disjointSets, 300, 30);
        update(mouseX, mouseY);
    
        noTint();
        if (numClicked > 3) {
            for (GameCard card : cards) {
             card.clicked = false;
            }
            numClicked = 0;
        } else if (keyPressed) {
            if (key == DELETE || key == BACKSPACE) {
                for (GameCard card : cards) {
                    card.clicked = false;
                }
                numClicked = 0;
            } else if (numClicked == 3 && (key == ENTER || key == RETURN)) {
                check();
            } else if (key == '?' || key == 'h') {
                clue();
            }
            if (key == 'n' || key == 'N') {
              restart();
            } else if (key == 'q' || key == 'Q') {
              exit();
            }
        }
    }
    for (GameCard card : cards) {
	if (card.clicked) {
	    card.tint = 205;
	} else if (card.over) {
	    card.tint = 230;
	} else {
	    card.tint = 255;
	}
	tint(card.tint);
	image(card.image, card.x, card.y, cardW, cardH);
    }
}

void update(int x, int y) {
    for (GameCard card : cards) {
	if (overCard(card.x, card.y, cardW, cardH)) {
	    card.over = true;
	} else {
	    card.over = false;
	}
    }
}

boolean overCard(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX <= x+width &&
	    mouseY >= y && mouseY <= y+height) {
	return true;
    } else {
	return false;
    }
}

void mouseClicked() {
    for (GameCard card : cards) {
	if (card.over) {
	    card.clicked = !(card.clicked);
	    if (card.clicked) {
		++numClicked;
	    } else {
		--numClicked;
	    }
	}
    }
}

void check() {
    Card triplet[] = new Card[3];
    for (int i = 0, j = 0; i < 3 && j < num; ++j) {
	if (cards.get(j).clicked) {
	    triplet[i] = cards.get(j).card;
	    ++i;
	}
    }
    Card a = triplet[0];
    Card b = triplet[1];
    Card c = triplet[2];

    if (c.equals(new Card(a,b))) {
        ++numFound;
        foundSets.add(a); foundSets.add(b); foundSets.add(c);
        if (hand.size() > 12) {
            hand.remove(a); hand.remove(b); hand.remove(c);
            deck.refill(hand);
        } else {
            ArrayList<Card> rem = new ArrayList<Card>(3);
            rem.add(a); rem.add(b); rem.add(c);
            deck.swapout(hand,rem);
        }
	   verify();
	   render();
    }
    for (GameCard card : cards) {
	card.clicked = false;
    }
    numClicked = 0;
}

void clue() {
    Set finder = new Set();
    finder.readIn(hand);
    ArrayList<Triple> sets = finder.sets(hand);
    ArrayList<Triple> disjoint = finder.disjointSets(hand);
    if (numClicked == 0) {
        Triple best = disjoint.get(0);

        for (GameCard card : cards) {
            if (best.member(card.card)) {
                card.clicked = true;
            }
        }
        numClicked = 3;
    } else if (numClicked == 1) {
        Card singlet = null;
        for (GameCard c : cards) {
            if (c.clicked) {
                singlet = c.card;
                break;
            }
        }
        for (Triple trip : sets) {
            if (trip.member(singlet)) {
                cards.get(hand.indexOf(trip.a)).clicked = true;
                cards.get(hand.indexOf(trip.b)).clicked = true;
                cards.get(hand.indexOf(trip.c)).clicked = true;
                break;
            }
        }
        numClicked = 3;
    } else if (numClicked == 2) {
        Card twin[] = new Card[2];
        for (int i = 0, j = 0; i < 2 && j < num; ++j) {
            if (cards.get(j).clicked) {
                twin[i] = cards.get(j).card;
                ++i;
            }
        }
        for (Triple trip : sets) {
            if (trip.member(twin[0]) && trip.member(twin[1])) {
                cards.get(hand.indexOf(trip.a)).clicked = true;
                cards.get(hand.indexOf(trip.b)).clicked = true;
                cards.get(hand.indexOf(trip.c)).clicked = true;
                break;
            }
        }
        numClicked = 3;
    }
}

void verify() {
    do {
	Set tester = new Set();
	tester.readIn(hand);
        dealtSets = tester.sets(hand).size();
        disjointSets = tester.disjointSets(hand).size();
	if (tester.sets(hand).size() > 0) {
	    break;
	}
	deck.fillTo(hand, hand.size()+3);
    } while (deck.remaining() > 0);
}


class GameCard {
    PImage image;
    Card card;
    int x;
    int y;
    int tint;
    boolean over;
    boolean clicked;

    GameCard(Card card, int index, int x, int y) {
	this.card = card;
	this.image = loadImage(card.number()+".png");
	this.x = x;
	this.y = y;
	this.tint = 255;
	this.over = false;
	this.clicked = false;
    }

}
