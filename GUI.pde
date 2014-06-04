
PImage img;

void setup (){
  size (700,550,P3D);
  background(150);
  img = loadImage("projidea.jpg");
}

void draw(){
  image(img, 0, 0,700,550);
  fill(#FFFFFF);
  translate(350, 225, 100); 
  rotateX(PI/3.5);
  box(100,150,5);
  
  
}

