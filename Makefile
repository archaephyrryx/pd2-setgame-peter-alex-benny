PROPS = Color.java Count.java Shape.java Fill.java

OBJS = $(PROPS:%.java=%.class)

.SUFFIXES: .java .class

.java.class:
	javac $<

all: Main.class $(OBJS) image-stamp

Deck.class: Deck.java Card.java
	javac Deck.java

Card.class: Card.java $(OBJS)
	javac Card.java

Set.class: Set.java Card.java Deck.java
	javac Set.java

Main.class: Main.java Set.java Card.java
	javac Main.java

image-stamp: setcards.asy 
	./asy-gen.sh
	for i in $$(seq 0 80); do asy -f png -o gui/data "$$i.asy"; done
	touch image-stamp

clean:
	$(RM) *.class *.png ?.asy ??.asy
