#include <stdio.h>

int main() {
    int i = 0;
    int j;

    for (j = 0; j < 152; j += 8) {
        if (i < 10) {
            printf("fir_0%i : filter\n", i);
        }
        else
            printf("fir_%i : filter\n", i);

        printf("port map (a(%i downto %i), b(%i downto %i), s(%i downto %i));\n\n",
            j + 7, j, j + 7, j, j + 7, j);

        ++i;
    }

    return 0;
}

