library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sad_tb is
end sad_tb;

architecture sad_tb of sad_tb is
    component sad is
    port (
        clock : in std_logic;
        reset : in std_logic;
        start : in std_logic;
        line0 : in std_logic_vector(63 downto 0);
        line1 : in std_logic_vector(63 downto 0);
        sadv  : out std_logic_vector(14 downto 0)
    );
    end component sad;

    signal clock : std_logic;
    signal reset : std_logic;
    signal start : std_logic;
    signal line0 : std_logic_vector(63 downto 0);
    signal line1 : std_logic_vector(63 downto 0);
    signal sadv  : std_logic_vector(14 downto 0);

begin
    sad_u : sad
    port map (clock, reset, start, line0, line1, sadv);

    process
    begin
        clock <= '1';
        wait for 5 ns;
        clock <= '0';
        wait for 5 ns;
    end process;

    process
    begin
        reset <= '0';
        start <= '0';
        line0 <= (others => '0');
        line1 <= (others => '0');
        wait until clock'event and clock = '1';

        reset <= '1';
        start <= '0';
        line0 <= (others => '0');
        line1 <= (others => '0');
        wait until clock'event and clock = '1';

        reset <= '0';
        start <= '1';
        line0 <= (others => '0');
        line1 <= (others => '0');
        wait until clock'event and clock = '1';

        reset <= '0';
        start <= '0';
        line0 <= (1 => '1', others => '0');
        line1 <= (others => '0');
        wait until clock'event and clock = '1';

        reset <= '0';
        start <= '0';
        line0 <= (1 => '1', others => '0');
        line1 <= (others => '0');
        wait until clock'event and clock = '1';

        reset <= '0';
        start <= '0';
        line0 <= (1 => '1', others => '0');
        line1 <= (others => '0');
        wait until clock'event and clock = '1';

        reset <= '0';
        start <= '0';
        line0 <= (1 => '1', others => '0');
        line1 <= (others => '0');
        wait until clock'event and clock = '1';

        reset <= '0';
        start <= '0';
        line0 <= (1 => '1', others => '0');
        line1 <= (others => '0');
        wait until clock'event and clock = '1';

        reset <= '0';
        start <= '0';
        line0 <= (1 => '1', others => '0');
        line1 <= (others => '0');
        wait until clock'event and clock = '1';

        reset <= '0';
        start <= '0';
        line0 <= (1 => '1', others => '0');
        line1 <= (others => '0');
        wait until clock'event and clock = '1';

        reset <= '0';
        start <= '0';
        line0 <= (1 => '1', others => '0');
        line1 <= (others => '0');
        wait until clock'event and clock = '1';

        reset <= '0';
        start <= '0';
        line0 <= (others => '0');
        line1 <= (others => '0');
        wait until clock'event and clock = '1';

        reset <= '0';
        start <= '0';
        line0 <= (others => '0');
        line1 <= (others => '0');
        wait until clock'event and clock = '1';

        reset <= '0';
        start <= '0';
        line0 <= (others => '0');
        line1 <= (others => '0');
        wait until clock'event and clock = '1';

        reset <= '0';
        start <= '0';
        line0 <= (others => '0');
        line1 <= (others => '0');
        wait until clock'event and clock = '1';

        reset <= '0';
        start <= '0';
        line0 <= (others => '0');
        line1 <= (others => '0');
        wait until clock'event and clock = '1';

        reset <= '0';
        start <= '0';
        line0 <= (others => '0');
        line1 <= (others => '0');
        wait until clock'event and clock = '1';

        reset <= '0';
        start <= '1';
        line0 <= (others => '0');
        line1 <= (others => '0');
        wait until clock'event and clock = '1';

        reset <= '0';
        start <= '0';
        line0 <= (others => '0');
        line1 <= (others => '0');
        wait until clock'event and clock = '1';

        wait;

    end process;
end sad_tb;
