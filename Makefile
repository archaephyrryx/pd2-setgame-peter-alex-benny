PROPS = Color.java Count.java Shape.java Fill.java

OBJS = $(PROPS:%.java=%.class)

.SUFFIXES: .java .class

.java.class:
	javac $<

all: Main.class $(OBJS)

Card.class: Card.java $(OBJS)
	javac Card.java

Deck.class: Deck.java
	javac Deck.java

Set.class: Set.java Card.java Deck.java
	javac Set.java

Main.class: Main.java Set.java Card.java

clean:
	$(RM) *.class
