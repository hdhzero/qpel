library ieee;
use ieee.std_logic_1164.all;

entity foo_tb is
end foo_tb;

architecture foo_tb of foo_tb is
    component foo is
    port (
        clk, rst, start : in std_logic;
        din : in std_logic_vector(7 downto 0);
        do1 : out std_logic_vector(7 downto 0);
        do2 : out std_logic_vector(7 downto 0)
    );
    end component foo;

    signal clk, rst, start : std_logic;
    signal din, do1, do2 : std_logic_vector(7 downto 0);
    type st is (a, b, c);
    signal cc, nn : st;

begin
    foo_u : foo
    port map (clk, rst, start, din, do1, do2);

    process
    begin
        clk <= '1';
        wait for 5 ns;
        clk <= '0';
        wait for 5 ns;
    end process;


    process(clk, rst)
    begin
        if rst = '1' then
            cc <= a;
            nn <= a;
        elsif clk'event and clk = '1' then
            cc <= nn;

            case cc is
                when a =>
                    din <= x"00";
                    start <= '0';
                    nn <= b;

                when b =>
                    din <= x"00";
                    start <= '1';
                    nn <= c;

                when c =>
                    din <= x"FA";
                    start <= '0';
                    nn <= a;

                when others =>
                    din <= x"00";
                    start <= '0';
                    nn <= a;
            end case;
        end if;
    end process;

    process
    begin
        rst <= '0';
        wait until clk'event and clk = '1';

        rst <= '1';
        wait until clk'event and clk = '1';

        rst <= '0';
        wait until clk'event and clk = '1';

        rst <= '0';
        wait until clk'event and clk = '1';

        rst <= '0';
        wait until clk'event and clk = '1';

        wait;
    end process;
end foo_tb;

