#include <stdio.h>
#include <graphics.h>

// Bresenham line and circle drawing algorithms
// Uses integer math to draw lines (no floating point)
// https://circuitcellar.com/cc-blog/bresenhams-algorithm/

void drawline(int x0, int y0, int x1, int y1, int color)
{
    int x, y;
    int dx, dy;
    int sx, sy;
    int err, e2;

    dx = x1 >= x0 ? x1 - x0 : x0 - x1;
    dy = y1 >= y0 ? y0 - y1 : y1 - y0;
    sx = x0 < x1 ? 1 : -1;
    sy = y0 < y1 ? 1 : -1;
    err = dx + dy;
    x = x0;
    y = y0;

    while(1)
	{
		// plot(x,y,color);
		*(FrameBuffer + x + (y * 640)) = color;
        if((x == x1) && (y == y1)) break;
        e2 = 2 * err;
        if(e2 >= dy){ // step x
            err += dy;
            x += sx;
        }
        if(e2 <= dx){ // step y
            err += dx;
            y += sy;
        }
    }
}

// Code Fragment 4 - Circle drawing based on Bresenham
// https://circuitcellar.com/cc-blog/bresenhams-algorithm/
void drawCircle (int x0, int y0, int r, int color)
{
	int x, y;
	int err, temp;

	x = -r;
	y = 0;
	err = 2 - (2 * r);

	do 
	{
		*(FrameBuffer + (x0 - x) + ((y0 + y) * 640)) = color;
		*(FrameBuffer + (x0 - y) + ((y0 - x) * 640)) = color;
		*(FrameBuffer + (x0 + x) + ((y0 - y) * 640)) = color;
		*(FrameBuffer + (x0 + y) + ((y0 + x) * 640)) = color;
		// plot(x0 - x, y0 + y);
		// plot(x0 - y, y0 - x);
		// plot(x0 + x, y0 - y);
		// plot(x0 + y, y0 + x);
		temp = err;
		if(temp > x) err += ++x * 2 + 1;
		if(temp <= y) err += ++y * 2 + 1;
	} 
	while (x < 0);
}
 
int main()
{
	int gdriver=DETECT, gmode, error, x0, y0, x1, y1;
	initgraph(&gdriver, &gmode, "c:\\turboc3\\bgi");
 
	printf("Enter co-ordinates of first point: ");
	scanf("%d%d", &x0, &y0);
 
	printf("Enter co-ordinates of second point: ");
	scanf("%d%d", &x1, &y1);
	drawline(x0, y0, x1, y1);
 
	return 0;
}