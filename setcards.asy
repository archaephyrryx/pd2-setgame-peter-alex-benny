import graph;
import patterns;

size(5inch,7inch);
pen redcol = red;
pen greencol = heavygreen;
pen purplecol = purple;
real thickness = 5;
real hatchwidth = 3;
real hatchsep = 3mm;
real weave=0.8;
real warp=3/4;
real weft=49/64;
real xdiff=2;
real ydiff=1;


pair origin=(0,0);

path diamond(pair c, real x, real y)
{
    return (c+(x,0))--(c+(0,y))--(c+(-x,0))--(c+(0,-y))--cycle;
}
path oval(pair c, real x, real y)
{
    return ((c+(-x+y,y))--(c+(x-y,y)){right}..(c+(x-y,-y)){left}--(c+(-x+y,-y)){left}..cycle);
}
path wave(pair c, real x, real y)
{
    return scale(weave)*((c+(x*weft,y))..(c+(x*weft-(y/2),-y))..(c+(-x*weft+(y/2),-(warp*y)))..(c+(-x*weft,-y))..(c+(-x*weft+(y/2),y))..(c+(x*weft-(y/2),warp*y))..cycle);
}
void generate(int shape, int color, int number, int fill) {
    path border = (-xdiff-1,4+ydiff)--(xdiff+1,4+ydiff)--(xdiff+1,-4-ydiff)--(-xdiff-1,-4-ydiff)--cycle;
    filldraw(border,white);

    path image;
    pen hue;
    int i;
    if (shape%3 == 0) {
	image = oval(origin,xdiff,ydiff);
    } else if (shape%3 == 1) {
	image = diamond(origin,xdiff,ydiff);
    } else {
	image = wave(origin,xdiff,ydiff);
    }
    if (color%3 == 0) {
	hue = redcol;
    } else if (color%3 == 1) {
	hue = greencol;
    } else if (color%3 == 2) {
	hue = purplecol;
    }
    for (i = 0; i < (number%3)+1; ++i) {
	real n = ((number%3)/2);
	    draw(shift(0,3*(i-n))*image,hue+thickness);
	if (fill % 3 == 1) {
	    add("hatch",hatch(hatchsep,N,hue+hatchwidth));
	    filldraw(shift(0,3*(i-n))*image,pattern("hatch"));
	} else if (fill % 3 == 2) {
	    filldraw(shift(0,3*(i-n))*image,hue);
	}
    }
}
