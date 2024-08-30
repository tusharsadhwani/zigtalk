// gcc chart.c -o chart -Wall -lplplot -L/opt/homebrew/Cellar/plplot/5.15.0_4/lib -I/opt/homebrew/Cellar/plplot/5.15.0_4/include/plplot && ./chart && open out.png
#include "plplot.h"

void draw_bar(double x, double y)
{
    double xbox[] = {x, x, x + 1, x + 1};
    double ybox[] = {0, y, y, 0};
    plfill(4, xbox, ybox);

    char* label_str = (char*)malloc(20);
    char* value_str = (char*)malloc(20);
    sprintf(label_str, "%.0f", x);
    sprintf(value_str, "%.0f", y);
    plptex((x + .5), (y + 1.), 1.0, 0.0, .5, value_str);
    plcol1(0.5);  // Black text
    plmtex("b", 1.0, ((x - 1980. + 1) * .1 - .05), 0.5, label_str);
}

int main()
{

    plsdev("png");
    plsfnam("out.png");
    plscolbg(255, 255, 255);
    plinit();

    pladv(0);
    plvsta();
    plwind(1980.0, 1990.0, 0.0, 35.0);
    plcol1(0.5);  // Black text
    pllab("Year", "Widget Sales (millions)", NULL);

    double data[] = {5, 15, 12, 24, 28, 30, 20, 8, 12, 3};
    for (int i = 0; i < 10; i++)
    {
        plcol1(i / 9.0);  // 0 - 1 shifts from purple to black to red
        draw_bar((1980. + i), data[i]);
    }

    plend();
}
