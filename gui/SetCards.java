import java.io.*;

public class SetCards {
    public static final String ASYCODE = "import graph;\nimport patterns;\n\nsize(5inch,7inch);\npen redcol = red;\npen greencol = heavygreen;\npen purplecol = heavymagenta;\nreal thickness = 3;\nreal hatchwidth = 3;\nreal hatchsep = 3mm;\nreal warp=3/4;\nreal xdiff=2;\nreal ydiff=1;\n\n\npair origin=(0,0);\n\npath diamond(pair c, real x, real y)\n{\n    return (c+(x,0))--(c+(0,y))--(c+(-x,0))--(c+(0,-y))--cycle;\n}\npath oval(pair c, real x, real y)\n{\n    return ((c+(-x+y,y))--(c+(x-y,y)){right}..(c+(x-y,-y)){left}--(c+(-x+y,-y)){left}..cycle);\n}\npath wave(pair c, real x, real y)\n{\n    return (c+(x,y))..(c+(x-(y/2),-y))..(c+(-x+(y/2),-(warp*y)))..(c+(-x,-y))..(c+(-x+(y/2),y))..(c+(x-(y/2),warp*y))..cycle;\n}\nvoid generate(int shape, int color, int number, int fill) {\n    path border = (-xdiff-1,4+ydiff)--(xdiff+1,4+ydiff)--(xdiff+1,-4-ydiff)--(-xdiff-1,-4-ydiff)--cycle;\n    filldraw(border,white);\n\n    path image;\n    pen hue;\n    int i;\n    if (shape%3 == 0) {\n  image = oval(origin,xdiff,ydiff);\n    } else if (shape%3 == 1) {\n  image = diamond(origin,xdiff,ydiff);\n    } else {\n  image = wave(origin,xdiff,ydiff);\n    }\n    if (color%3 == 0) {\n  hue = redcol;\n    } else if (color%3 == 1) {\n  hue = greencol;\n    } else if (color%3 == 2) {\n  hue = purplecol;\n    }\n    for (i = 0; i < number+1; ++i) {\n  real n = (number/2);\n      draw(shift(0,3*(i-n))*image,hue+thickness);\n  if (fill % 3 == 1) {\n      add(\"hatch\",hatch(hatchsep,N,hue+hatchwidth));\n      filldraw(shift(0,3*(i-n))*image,pattern(\"hatch\"));\n  } else if (fill % 3 == 2) {\n      filldraw(shift(0,3*(i-n))*image,hue);\n  }\n    }\n}\n\n";
  
  public static boolean genasy() {
    Writer writer = null;
    try {
      writer = new BufferedWriter(new OutputStreamWriter(
      new FileOutputStream("setcards.asy"), "utf-8"));
      writer.write(ASYCODE);
  } catch (IOException ex) {
     return false;
  } finally {
      try {writer.close();} catch (Exception ex) {return false;}
  }
  return true;
  }
}


