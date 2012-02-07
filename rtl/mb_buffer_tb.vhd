library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mb_buffer_tb is
end mb_buffer_tb;

architecture mb_buffer_tb of mb_buffer_tb is
    component mb_buffer is
    port (
        clock     : in  std_logic;
        reset     : in  std_logic;
        pel_wren  : in  std_logic;
        row_wren  : in  std_logic;
        col_wren  : in  std_logic;
        diag_wren : in  std_logic;
        pel_addr  : in  std_logic_vector(2 downto 0);
        row_addr  : in  std_logic_vector(4 downto 0);
        col_addr  : in  std_logic_vector(4 downto 0);
        diag_addr : in  std_logic_vector(4 downto 0);
        pel_din   : in  std_logic_vector(63 downto 0);
        row_din   : in  std_logic_vector(143 downto 0);
        col_din   : in  std_logic_vector(135 downto 0);
        diag_din  : in  std_logic_vector(143 downto 0);
        pel_dout  : out std_logic_vector(63 downto 0);
        row_dout  : out std_logic_vector(143 downto 0);
        col_dout  : out std_logic_vector(135 downto 0);
        diag_dout : out std_logic_vector(143 downto 0)
    );
    end component mb_buffer;

    signal clock     : std_logic;
    signal reset     : std_logic;
    signal pel_wren  : std_logic;
    signal row_wren  : std_logic;
    signal col_wren  : std_logic;
    signal diag_wren : std_logic;
    signal pel_addr  : std_logic_vector(2 downto 0);
    signal row_addr  : std_logic_vector(4 downto 0);
    signal col_addr  : std_logic_vector(4 downto 0);
    signal diag_addr : std_logic_vector(4 downto 0);
    signal pel_din   : std_logic_vector(63 downto 0);
    signal row_din   : std_logic_vector(143 downto 0);
    signal col_din   : std_logic_vector(135 downto 0);
    signal diag_din  : std_logic_vector(143 downto 0);
    signal pel_dout  : std_logic_vector(63 downto 0);
    signal row_dout  : std_logic_vector(143 downto 0);
    signal col_dout  : std_logic_vector(135 downto 0);
    signal diag_dout : std_logic_vector(143 downto 0);

    signal tmp : std_logic_vector(143 downto 0);

begin

    tmp(143 downto 64) <= (others => '0');
    tmp(63 downto 0) <= pel_dout;

    process
    begin
        clock <= '1';
        wait for 5 ns;
        clock <= '0';
        wait for 5 ns;
    end process;

    process
    begin
        reset     <= '0';
        pel_wren  <= '0';
        row_wren  <= '0';
        col_wren  <= '0';
        diag_wren <= '0';
        pel_addr  <= "000";
        row_addr  <= "00000";
        col_addr  <= "00000";
        diag_addr <= "00000";
        pel_din   <= (others => '0');
        row_din   <= (others => '0');
        col_din   <= (others => '0');
        diag_din  <= (others => '0');

        wait until clock'event and clock = '1';
        reset     <= '1';
        pel_wren  <= '0';
        row_wren  <= '0';
        col_wren  <= '0';
        diag_wren <= '0';
        pel_addr  <= "000";
        row_addr  <= "00000";
        col_addr  <= "00000";
        diag_addr <= "00000";
        pel_din   <= (others => '0');
        row_din   <= (others => '0');
        col_din   <= (others => '0');
        diag_din  <= (others => '0');

        wait until clock'event and clock = '1';
        reset     <= '0';
        pel_wren  <= '0';
        row_wren  <= '0';
        col_wren  <= '0';
        diag_wren <= '0';
        pel_addr  <= "000";
        row_addr  <= "00000";
        col_addr  <= "00000";
        diag_addr <= "00000";
        pel_din   <= (others => '0');
        row_din   <= (others => '0');
        col_din   <= (others => '0');
        diag_din  <= (others => '0');

        wait until clock'event and clock = '1';
        reset     <= '0';
        pel_wren  <= '1';
        row_wren  <= '0';
        col_wren  <= '0';
        diag_wren <= '0';
        pel_addr  <= "000";
        row_addr  <= "00000";
        col_addr  <= "00000";
        diag_addr <= "00000";
        pel_din   <= (1 => '1', others => '0');
        row_din   <= (1 => pel_dout(1), others => '0');
        col_din   <= (others => '0');
        diag_din  <= (others => '0');

        wait until clock'event and clock = '1';
        reset     <= '0';
        pel_wren  <= '0';
        row_wren  <= '0';
        col_wren  <= '0';
        diag_wren <= '0';
        pel_addr  <= "001";
        row_addr  <= "00000";
        col_addr  <= "00000";
        diag_addr <= "00000";
        pel_din   <= (others => '0');
        row_din   <= (1 => pel_dout(1), others => '0');
        col_din   <= (others => '0');
        diag_din  <= (others => '0');

        wait until clock'event and clock = '1';
        reset     <= '0';
        pel_wren  <= '0';
        row_wren  <= '0';
        col_wren  <= '0';
        diag_wren <= '0';
        pel_addr  <= "001";
        row_addr  <= "00000";
        col_addr  <= "00000";
        diag_addr <= "00000";
        pel_din   <= (others => '0');
        row_din   <= (1 => pel_dout(1), others => '0');
        col_din   <= (others => '0');
        diag_din  <= (others => '0');

        wait until clock'event and clock = '1';
        reset     <= '0';
        pel_wren  <= '0';
        row_wren  <= '0';
        col_wren  <= '0';
        diag_wren <= '0';
        pel_addr  <= "001";
        row_addr  <= "00000";
        col_addr  <= "00000";
        diag_addr <= "00000";
        pel_din   <= (others => '0');
        row_din   <= (1 => pel_dout(1), others => '0');
        col_din   <= (others => '0');
        diag_din  <= (others => '0');


        wait until clock'event and clock = '1';
        reset     <= '0';
        pel_wren  <= '0';
        row_wren  <= '0';
        col_wren  <= '0';
        diag_wren <= '0';
        pel_addr  <= "000";
        row_addr  <= "00000";
        col_addr  <= "00000";
        diag_addr <= "00000";
        pel_din   <= (others => '0');
        row_din   <= (1 => pel_dout(1), others => '0');
        col_din   <= (others => '0');
        diag_din  <= (others => '0');

        wait until clock'event and clock = '1';
        reset     <= '0';
        pel_wren  <= '0';
        row_wren  <= '1';
        col_wren  <= '0';
        diag_wren <= '0';
        pel_addr  <= "001";
        row_addr  <= "00000";
        col_addr  <= "00000";
        diag_addr <= "00000";
        pel_din   <= (others => '0');
        row_din   <= (1 => pel_dout(1), others => '0');
        col_din   <= (others => '0');
        diag_din  <= (others => '0');

        wait until clock'event and clock = '1';
        reset     <= '0';
        pel_wren  <= '0';
        row_wren  <= '0';
        col_wren  <= '0';
        diag_wren <= '0';
        pel_addr  <= "001";
        row_addr  <= "00000";
        col_addr  <= "00000";
        diag_addr <= "00000";
        pel_din   <= (others => '0');
        row_din   <= (1 => pel_dout(1), others => '0');
        col_din   <= (others => '0');
        diag_din  <= (others => '0');

        wait;
    end process;

    mb_buffer_u : mb_buffer
    port map (clock, reset, pel_wren, row_wren, col_wren, diag_wren, pel_addr, row_addr,
        col_addr, diag_addr, pel_din, row_din, col_din, diag_din, pel_dout, row_dout, col_dout,
        diag_dout
    );

end mb_buffer_tb;


