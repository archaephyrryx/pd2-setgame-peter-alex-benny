PShape squiggle;

void setup() {
  size(700, 560, P2D);
  squiggle = loadShape("squiggle.svg");
} 

void draw(){
  background(255);
  shape(squiggle);
}
