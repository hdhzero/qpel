#include <stdio.h>

int main(int argc, char** argv) {
    int i;
    int j;

    j = 31;
    for (i = 0; i < 64; i += 8) {
        printf("dout(%i downto %i) <= din(%i downto %i);\n", 
            i + 7, i, j, j - 7);
        j += 16;
    }

    return 0;
}
