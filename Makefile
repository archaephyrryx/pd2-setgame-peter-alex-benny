PROPS = Color.java Count.java Shape.java Fill.java
NUMS = 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 


OBJS = $(PROPS:%.java=%.class)
IMGS = $(NUMS:%=gui/data/%.png)

.SUFFIXES: .java .class

.java.class:
	javac $<

all: Main.class CardConverter.class $(OBJS)

CardConverter.class: CardConverter.java Card.java
	javac CardConverter.java

Deck.class: Deck.java Card.java
	javac Deck.java

Card.class: Card.java $(OBJS)
	javac Card.java

Set.class: Set.java Card.java Deck.java
	javac Set.java

Main.class: Main.java Set.java Card.java CardConverter.java
	javac Main.java

$(IMGS): setcards.asy 
	java CardConverter; mv *.png gui/data/

clean:
	$(RM) *.class *.png ?.asy ??.asy
