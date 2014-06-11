int rows = 3;
int cols = 4;
int num = rows*cols;
int rectX[] = new int[num];
int rectY[] = new int[num];
int rectSize = 90;
int numClicked = 0;

color rectColor[] = new color[num];
boolean rectOver[] = new boolean[num];
boolean rectClicked[] = new boolean[num];

void setup() {
    size(1000,500);
    for (int i = 0; i < num; ++i) {
      rectColor[i] = color(0,0,0);
      rectOver[i] = false;
      rectClicked[i] = false;
      rectX[i] = ((i%cols)+1)*width/(cols + 1) - rectSize/2 + 10*(cols/2 - (i%cols));
      rectY[i] = ((i/cols)+1)*height/(rows + 1) - rectSize/2 + 10*(rows/2 - (i/cols));
    }
}


void draw() {
    update(mouseX, mouseY);

    noStroke();
    if (numClicked > 3) {
      for (int i = 0; i < num; ++i) {
        rectClicked[i] = false;
      }
      numClicked = 0;
    }
    for (int i = 0; i < num; ++i) {
      if (rectClicked[i]) {
  	rectColor[i] = color(0,255,0);
      } else if (rectOver[i]) {
  	rectColor[i] = color(255,255,0);
      } else {
  	rectColor[i] = color(0,0,0);
      }
       stroke(rectColor[i]);
       fill(127);
       rect(rectX[i], rectY[i], rectSize, rectSize);
    }
}

void update(int x, int y) {
  for (int i = 0; i < num; ++i) {
    if (overRect(rectX[i], rectY[i], rectSize, rectSize)) {
	rectOver[i] = true;
    } else {
	rectOver[i] = false;
    }
  }
}

boolean overRect(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX <= x+width &&
	mouseY >= y && mouseY <= y+height) {
	return true;
    } else {
	return false;
    }
}

void mouseClicked() {
  for (int i = 0; i < num; ++i) {
    if (rectOver[i]) {
      rectClicked[i] = !(rectClicked[i]);
      if (rectClicked[i]) {
        ++numClicked;
      } else {
        --numClicked;
      }
    }
  }
}
