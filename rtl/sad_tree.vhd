library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sad_tree is
    port (
        clk : in std_logic;
        rst : in std_logic;

        a0 : in std_logic_vector(7 downto 0);
        b0 : in std_logic_vector(7 downto 0);
        c0 : in std_logic_vector(7 downto 0);
        d0 : in std_logic_vector(7 downto 0);
        e0 : in std_logic_vector(7 downto 0);
        f0 : in std_logic_vector(7 downto 0);
        g0 : in std_logic_vector(7 downto 0);
        h0 : in std_logic_vector(7 downto 0);

        a1 : in std_logic_vector(7 downto 0);
        b1 : in std_logic_vector(7 downto 0);
        c1 : in std_logic_vector(7 downto 0);
        d1 : in std_logic_vector(7 downto 0);
        e1 : in std_logic_vector(7 downto 0);
        f1 : in std_logic_vector(7 downto 0);
        g1 : in std_logic_vector(7 downto 0);
        h1 : in std_logic_vector(7 downto 0);

        s : out std_logic_vector(10 downto 0)
    );
end sad_tree;

architecture sad_tree of sad_tree is
    signal a, b, c, d, e, f, g, h : unsigned(7 downto 0);
    signal ab, cd, ef, gh         : unsigned(8 downto 0);
    signal abcd, efgh             : unsigned(9 downto 0);
begin
    a <= unsigned(a0) - unsigned(a1) when a0 > a1 else 
         unsigned(a1) - unsigned(a0);

    b <= unsigned(b0) - unsigned(b1) when b0 > b1 else 
         unsigned(b1) - unsigned(b0);

    c <= unsigned(c0) - unsigned(c1) when c0 > c1 else 
         unsigned(c1) - unsigned(c0);

    d <= unsigned(d0) - unsigned(d1) when d0 > d1 else 
         unsigned(d1) - unsigned(d0);

    e <= unsigned(e0) - unsigned(e1) when e0 > e1 else 
         unsigned(e1) - unsigned(e0);

    f <= unsigned(f0) - unsigned(f1) when f0 > f1 else 
         unsigned(f1) - unsigned(f0);

    g <= unsigned(g0) - unsigned(g1) when g0 > g1 else 
         unsigned(g1) - unsigned(g0);

    h <= unsigned(h0) - unsigned(h1) when h0 > h1 else 
         unsigned(h1) - unsigned(h0);

    abcd <= ('0' & ab) + ('0' & cd);
    efgh <= ('0' & ef) + ('0' & gh);

    process(clk, rst, a, b, c, d, e, f, g, h, abcd, efgh)
    begin
        if rst = '1' then
            ab  <= (others => '0');
            cd  <= (others => '0');
            ef  <= (others => '0');
            gh  <= (others => '0');
            s   <= (others => '0');
        elsif clk'event and clk = '1' then
            ab <= ('0' & a) + ('0' & b);
            cd <= ('0' & c) + ('0' & d);
            ef <= ('0' & e) + ('0' & f);
            gh <= ('0' & g) + ('0' & h);
            s  <= std_logic_vector(('0' & abcd) + ('0' & efgh));
        end if;
    end process;    
end sad_tree;
--15 outubro 2005
