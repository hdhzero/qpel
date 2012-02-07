library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sad is
    port (
        clock : in std_logic;
        reset : in std_logic;
        start : in std_logic;
        line0 : in std_logic_vector(63 downto 0);
        line1 : in std_logic_vector(63 downto 0);
        sadv  : out std_logic_vector(13 downto 0);
        done  : out std_logic
    );
end sad;

architecture sad of sad is
    component sad_tree is
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
    end component sad_tree;

    signal sres   : std_logic_vector(10 downto 0);
    signal sadv_s : std_logic_vector(13 downto 0);

begin
    process(clock, reset)
    begin
        if reset = '1' then
            current_state <= idle;
        elsif clock'event and clock = '1' then
            current_state <= next_state;
        end if;
    end process;

    process(current_state, start)
    begin
        case current_state is
            when idle =>
                if start = '1' then
                    next_state <= loading;
                else
                    next_state <= idle;
                end if;

            when loading =>
                
    end process;

    sad_tree_u : sad_tree
    port map (clock, reset, line0(7 downto 0), line0(15 downto 8, line0(23 downto 16),
        line0(31 downto 24), line0(39 downto 32), line0(47 downto 40), line0(55 downto 48),
        line0(63 downto 56), line1(7 downto 0), line1(15 downto 8, line1(23 downto 16),
        line1(31 downto 24), line1(39 downto 32), line1(47 downto 40), line1(55 downto 48),
        line1(63 downto 56), sres);


end sad;

