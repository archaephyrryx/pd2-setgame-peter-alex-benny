// Layout
int rows = 3;
int cols = 4;
int num = 12;
int cardW = 90;
int cardH = 150;
int xBuff = 5;
int yBuff = 5;
// Cards and Images
Deck deck = new Deck();
ArrayList<Card> hand = deck.deal();
ArrayList<GameCard> cards;
// State
int numClicked = 0;
int setsFound = 0;
boolean anySets = false;

void setup() {
    size(500,500);
    background(50, 127, 50);
    verify();
    render();
}

void render() {
  cards = new ArrayList<GameCard>(hand.size());
  num = hand.size();
  cols = num/rows;
  for (int i = 0; i < num; ++i) {
    int x = (int) (width/2 + ((i%cols) - (double)cols/2)*(cardW + xBuff));
    int y = (int) (height/2 + ((i/cols) - (double)rows/2)*(cardH + yBuff));
    cards.add(new GameCard(hand.get(i), i, x, y));
  } 
}


void draw() {
    update(mouseX, mouseY);

    noTint();
    if (numClicked >= 3) {
      if (numClicked == 3) {
        if (keyPressed) {
          if (key == ENTER || key == RETURN) {
            check();
          }
          else if (key == ESC) {
            for (GameCard card : cards) {
              card.clicked = false;
            }
            numClicked = 0;
          }
        }
      } else {
          for (GameCard card : cards) {
            card.clicked = false;
          }
          numClicked = 0;
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
    ++setsFound;
    hand.remove(a);
    hand.remove(b);
    hand.remove(c);
    deck.refill(hand);
    verify();
    render();
  }
  for (GameCard card : cards) {
    card.clicked = false;
  }
  numClicked = 0;
}

void verify() {
  while (true) {
    Set tester = new Set();
    tester.readIn(hand);
    if (tester.sets(hand).size() > 0) {
      break;
    }
    deck.fillTo(hand, hand.size()+3);
  }
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
      String name = "c"+index;
      CardConverter.convert(card,name);
      this.image = loadImage(name+".png");
      this.x = x;
      this.y = y;
      this.tint = 255;
      this.over = false;
      this.clicked = false;
    }

}
