#include <stdio.h>
#include <stdlib.h>


int hp[19][19];
int qp[37][37];

void rand_hp() {
    int i;
    int j;

    for (i = 0; i < 19; ++i) {
        for (j = 0; j < 19; ++j) {
            hp[i][j] = rand() % 256;
        }
    }
}

void print_hp() {
    int i;
    int j;

    for (i = 0; i < 19; ++i) {
        for (j = 0; j < 19; ++j) {
            printf("%i\t", hp[i][j]);
        }
        printf("\n");
    }
}



void print_qp() {
    int i;
    int j;

    for (i = 0; i < 37; ++i) {
        for (j = 0; j < 37; ++j) {
            printf("%i\t", qp[i][j]);
        }
        printf("\n");
    }
}

void binary(int n) {
    int i;

    for (i = 7; i >= 0; --i) {
        printf("%c", (n & (1 << i)) ? '1' : '0');
    }
}

void hexa(int n) {
    if (n < 16) {
        printf("0%X", n);
    }
    else {
        printf("%X", n);
    }
}

void print_hpb() {
    int i;
    int j;

    for (i = 0; i < 19; ++i) {
        printf("        reset  <= '0';\n");
        printf("        start  <= '0';\n");
        printf("        pel_mb <= (others => '0');\n");
        printf("        hp_mb  <= x\"");

        for (j = 0; j < 19; ++j) {
            hexa(hp[i][j]);
        }

        printf("\";\n\n");
        printf("        wait until clock'event and clock = '1';\n");
    }

}

void interpolate() {
    int i;
    int j;
    int k;
    int l;
    int flag  = 0;
    int flag2 = 0;

    k = 0;
    l = 0;

    for (i = 0; i < 37; ++i) {
        l = 0;

        for (j = 0; j < 37; ++j) {
            if (i % 2 == 0 && j % 2 == 0) {
                qp[i][j] = hp[k][l];
                ++l;
            }
            else {
                qp[i][j] = 0;
            }
        }
        if (i % 2 == 0) ++k;
    }

    for (i = 0; i < 37; ++i) {
        if (i % 2 == 0) {
            flag  = flag2;
            flag2 = flag2 == 0 ? 1 : 0;
        }

        for (j = 0; j < 37; ++j) {
            if (i % 2 != 0 && j % 2 != 0) {
                if (flag == 0) {
                    qp[i][j] = (qp[i - 1][j + 1] + qp[i + 1][j - 1] + 1) >> 1;
                    flag = 1;
                }
                else {
                    qp[i][j] = (qp[i - 1][j - 1] + qp[i + 1][j + 1] + 1) >> 1;
                    flag = 0;
                }
            }
            else if (i % 2 != 0 && j % 2 == 0) {
                qp[i][j] = (qp[i - 1][j] + qp[i + 1][j] + 1) >> 1;
            }
            else if (i % 2 == 0 && j % 2 != 0) {
                qp[i][j] = (qp[i][j - 1] + qp[i][j + 1] + 1) >> 1;
            }
        }
    }

}

int main() {
    srand(time(NULL));
    rand_hp();

    interpolate();
    print_hp();
    print_qp();
    printf("\n\n");
    print_hpb();

    return 0;
}
