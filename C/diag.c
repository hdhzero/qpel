#include <stdio.h>

int main() {
    int i = 0;
    int j;

    printf("library ieee;\n");
    printf("use ieee.std_logic_1164.all;\n");
    printf("use ieee.numeric_std.all;\n\n");

    printf("entity diag_interpolator is\n");
    printf("    port (\n");
    printf("        sel : in std_logic;\n");
    printf("        a : in std_logic_vector(151 downto 0);\n");
    printf("        b : in std_logic_vector(151 downto 0);\n");
    printf("        s : out std_logic_vector(143 downto 0)\n");
    printf("    );\n");
    printf("end diag_interpolator;\n\n");

    printf("architecture diag_interpolator of diag_interpolator is\n");
    printf("    component filter is\n");
    printf("    port (\n");
    printf("        a : in std_logic_vector(7 downto 0);\n");
    printf("        b : in std_logic_vector(7 downto 0);\n");
    printf("        s : out std_logic_vector(7 downto 0)\n");
    printf("    );\n");
    printf("    end component filter;\n\n");

    printf("    signal s0 : std_logic_vector(143 downto 0);\n");
    printf("    signal s1 : std_logic_vector(143 downto 0);\n");

    printf("begin\n");

    printf("    process(a, b, sel)\n");
    printf("    begin\n");
    printf("        case sel is\n");
    printf("            when '0' =>\n");

    j = 0;
    for (i = 0; i < 144; i += 8) {
        if (j % 2 == 0) {
            printf("                s0(%i downto %i) <= a(%i downto %i);\n", 
                i + 7, i, i + 7, i);
            printf("                s1(%i downto %i) <= b(%i downto %i);\n",
                i + 7, i, i + 15, i + 8);
        }
        else {
            printf("                s0(%i downto %i) <= a(%i downto %i);\n", 
                i + 7, i, i + 15, i + 8);
            printf("                s1(%i downto %i) <= b(%i downto %i);\n",
                i + 7, i, i + 7, i);
        }
        j++;
    }

    printf("            when others =>\n");
    j = 0;

    for (i = 0; i < 144; i += 8) {
        if (j % 2 == 0) {
            printf("                s0(%i downto %i) <= a(%i downto %i);\n", 
                i + 7, i, i + 15, i + 8);
            printf("                s1(%i downto %i) <= b(%i downto %i);\n",
                i + 7, i, i + 7, i);
        }
        else {
            printf("                s0(%i downto %i) <= a(%i downto %i);\n", 
                i + 7, i, i + 7, i);
            printf("                s1(%i downto %i) <= b(%i downto %i);\n",
                i + 7, i, i + 15, i + 8);
        }
        j++;

    }

    printf("        end case;\n");
    printf("    end process;\n\n");

    i = 0;
    for (j = 0; j < 144; j += 8) {
        if (i < 10) 
            printf("    fir_0%i : filter\n", i);
        else
            printf("    fir_%i : filter\n", i);

        printf("    port map (s0(%i downto %i), s1(%i downto %i), s(%i downto %i));\n\n",
            j + 7, j, j + 7, j, j + 7, j);

        ++i;
    }

    printf("end diag_interpolator;\n");

    return 0;
}

