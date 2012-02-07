#include <stdio.h>

int main() {
    int i = 0;
    int j;

    printf("library ieee;\n");
    printf("use ieee.std_logic_1164.all;\n");
    printf("use ieee.numeric_std.all;\n\n");

    printf("entity row_interpolator is\n");
    printf("    port (\n");
    printf("        a : in std_logic_vector(151 downto 0);\n");
    printf("        s : out std_logic_vector(143 downto 0)\n");
    printf("    );\n");
    printf("end row_interpolator;\n\n");

    printf("architecture row_interpolator of row_interpolator is\n");
    printf("    component filter is\n");
    printf("    port (\n");
    printf("        a : in std_logic_vector(7 downto 0);\n");
    printf("        b : in std_logic_vector(7 downto 0);\n");
    printf("        s : out std_logic_vector(7 downto 0)\n");
    printf("    );\n");
    printf("    end component filter;\n");

    printf("begin\n");


    for (j = 0; j < 144; j += 8) {
        if (i < 10) {
            printf("    fir_0%i : filter\n", i);
        }
        else
            printf("    fir_%i : filter\n", i);

        printf("    port map (a(%i downto %i), a(%i downto %i), s(%i downto %i));\n\n",
            j + 15, j + 8, j + 7, j, j + 7, j);

        ++i;
    }

    printf("end row_interpolator;\n");

    return 0;
}

