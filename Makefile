PROPS = Color.java Count.java Shape.java Fill.java

OBJS = $(PROPS:%.java=%.class)

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

clean:
	$(RM) *.class *.png
