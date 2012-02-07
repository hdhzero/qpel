library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity interpolator_tb is
end interpolator_tb;

architecture interpolator_tb of interpolator_tb is
    component interpolator is
    port (
        clock : in std_logic;
        reset : in std_logic;
        start : in std_logic;
        din   : in std_logic_vector(151 downto 0);
        row_addr  : in std_logic_vector(4 downto 0);
        col_addr  : in std_logic_vector(4 downto 0);
        diag_addr : in std_logic_vector(4 downto 0);
        row   : out std_logic_vector(143 downto 0);
        col   : out std_logic_vector(135 downto 0);
        diag  : out std_logic_vector(143 downto 0)
    );
    end component interpolator;

    signal clock : std_logic;
    signal reset : std_logic;
    signal start : std_logic;
    signal din   : std_logic_vector(151 downto 0);
    signal row_addr  : std_logic_vector(4 downto 0);
    signal col_addr  : std_logic_vector(4 downto 0);
    signal diag_addr : std_logic_vector(4 downto 0);
    signal row   : std_logic_vector(143 downto 0);
    signal col   : std_logic_vector(135 downto 0);
    signal diag  : std_logic_vector(143 downto 0);

begin
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
        din   <= (others => '0');
        row_addr  <= (others => '0');
        diag_addr <= (others => '0');
        col_addr  <= (others => '0');

        wait until clock'event and clock = '1';
        reset <= '1';
        start <= '0';
        din   <= (others => '0');
        row_addr  <= (others => '0');
        diag_addr <= (others => '0');
        col_addr  <= (others => '0');

        wait until clock'event and clock = '1';
        reset <= '0';
        start <= '0';
        din   <= (others => '0');
        row_addr  <= (others => '0');
        diag_addr <= (others => '0');
        col_addr  <= (others => '0');

        wait until clock'event and clock = '1';
        reset <= '0';
        start <= '1';
        din   <= (others => '0');
        row_addr  <= (others => '0');
        diag_addr <= (others => '0');
        col_addr  <= (others => '0');

        wait until clock'event and clock = '1';
        start <= '0';
        din <= x"FC15CCA62079BB28A76D7A7CB812D9553B02C3";

        wait until clock'event and clock = '1';
        din <= x"36F0CBBE716E5CF8BFF44E7AF063469683C051";

        wait until clock'event and clock = '1';
        din <= x"AB67BE26E47638BDCC73BF8FA9AF5B6721C9C3";

        wait until clock'event and clock = '1';
        din <= x"1988B76702A8CA493E4E0990F9704E1F54C558";

        wait until clock'event and clock = '1';
        din <= x"1291CBD12075817BDCA245A0BBCD5722D0FFEC";

        wait until clock'event and clock = '1';
        din <= x"193E3A22CE34921C53E7E1ABF97277CA93EC4B";

        wait until clock'event and clock = '1';
        din <= x"0EC8ED5368A821C0CAF1BFB70AFDF12CCB25BE";

        wait until clock'event and clock = '1';
        din <= x"E879A5C9249E3C9B69CF87B4DD50A231B84A52";

        wait until clock'event and clock = '1';
        din <= x"78154338CC4D35BD7901E337E95CDDB2807BEE";

        wait until clock'event and clock = '1';
        din <= x"1CE4BDA3999BF33BCCAC851E249A615C66AE92";

        wait until clock'event and clock = '1';
        din <= x"242793075E7C633B2EE3B71DFF9BDAA3347596";

        wait until clock'event and clock = '1';
        din <= x"6F4142F55F678FC0C3F66E551A95E821F46484";

        wait until clock'event and clock = '1';
        din <= x"2F9367E6B067828A0AB600A02641E31BA14AAA";

        wait until clock'event and clock = '1';
        din <= x"610DA0D063BA654BDB59B05F8943C76FF32EF1";

        wait until clock'event and clock = '1';
        din <= x"7D38A87DD8CEBFBBE9600593C113349176EEF7";

        wait until clock'event and clock = '1';
        din <= x"C1CA507129D9B4F049A71E3A2556E2A22FB061";

        wait until clock'event and clock = '1';
        din <= x"EA99C1F02D83036114794F0B3A195CAC433560";

        wait until clock'event and clock = '1';
        din <= x"337E0852B92DA89BCFD74C31C2E5F2B21275B5";

        wait until clock'event and clock = '1';
        din <= x"738A2EC39568DCF1141F277553A57DA55EAA4D";

        wait until clock'event and clock = '1';
        din <= (others => '0');

        wait;

    end process;

    interpolator_u : interpolator
    port map (clock, reset, start, din, row_addr, col_addr, diag_addr, row, col, diag);
end interpolator_tb;
