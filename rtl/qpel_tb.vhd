library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity qpel_tb is
end qpel_tb;

architecture qpel_tb of qpel_tb is
    component qpel is
    port (
        clock  : in  std_logic;
        reset  : in  std_logic;
        start  : in  std_logic;
        hp_sad : in  std_logic_vector(13 downto 0);
        hp_x   : in  std_logic_vector(2 downto 0);
        hp_y   : in  std_logic_vector(2 downto 0);
        hp_mb  : in  std_logic_vector(151 downto 0);
        pel_mb : in  std_logic_vector(63 downto 0);
        done   : out std_logic;
        qp_sad : out std_logic_vector(13 downto 0);
        qp_x   : out std_logic_vector(2 downto 0);
        qp_y   : out std_logic_vector(2 downto 0)
    );
    end component qpel;

    signal clock  : std_logic;
    signal reset  : std_logic;
    signal start  : std_logic;
    signal hp_sad : std_logic_vector(13 downto 0);
    signal hp_x   : std_logic_vector(2 downto 0);
    signal hp_y   : std_logic_vector(2 downto 0);
    signal hp_mb  : std_logic_vector(151 downto 0);
    signal pel_mb : std_logic_vector(63 downto 0);
    signal done   : std_logic;
    signal qp_sad : std_logic_vector(13 downto 0);
    signal qp_x   : std_logic_vector(2 downto 0);
    signal qp_y   : std_logic_vector(2 downto 0);

begin

    qpel_u : qpel
    port map (clock, reset, start, hp_sad, hp_x, hp_y, hp_mb, pel_mb, done, qp_sad, qp_x, qp_y);

    process
    begin
        clock <= '1';
        wait for 5 ns;
        clock <= '0';
        wait for 5 ns;
    end process;

    process
    begin
        reset  <= '0';
        start  <= '0';
        hp_mb  <= (others => '0');
        pel_mb <= (others => '0');
        wait until clock'event and clock = '1';

        reset  <= '1';
        start  <= '0';
        hp_mb  <= (others => '0');
        pel_mb <= (others => '0');
        wait until clock'event and clock = '1';

        reset  <= '0';
        start  <= '0';
        hp_mb  <= (others => '0');
        pel_mb <= (others => '0');
        wait until clock'event and clock = '1';

        reset  <= '0';
        start  <= '1';
        hp_mb  <= (others => '0');
        pel_mb <= (others => '0');
        wait until clock'event and clock = '1';

        reset  <= '0';
        start  <= '0';
        pel_mb <= (others => '0');
        hp_mb  <= x"DA8979A5701DB744169EA064CDEE7742BE6B64";

        wait until clock'event and clock = '1';
        reset  <= '0';
        start  <= '0';
        pel_mb <= (others => '0');
        hp_mb  <= x"4AEB377F8D7D6D541BA4C93B7E52B424C2D2DB";

        wait until clock'event and clock = '1';
        reset  <= '0';
        start  <= '0';
        pel_mb <= (others => '0');
        hp_mb  <= x"06E879A64C4794C489522FEE9C1A251CA8A289";

        wait until clock'event and clock = '1';
        reset  <= '0';
        start  <= '0';
        pel_mb <= (others => '0');
        hp_mb  <= x"FCBD2DC5F8AC17ADD0D97FABDF672585B46C1A";

        wait until clock'event and clock = '1';
        reset  <= '0';
        start  <= '0';
        pel_mb <= (others => '0');
        hp_mb  <= x"78F56CA7E309C208256AAAAE6667DB2C608743";

        wait until clock'event and clock = '1';
        reset  <= '0';
        start  <= '0';
        pel_mb <= (others => '0');
        hp_mb  <= x"0D571D8C03FCF32882A7949C1F8908C76D1189";

        wait until clock'event and clock = '1';
        reset  <= '0';
        start  <= '0';
        pel_mb <= (others => '0');
        hp_mb  <= x"7536F320E45987C085E747C9F49FE680A2E274";

        wait until clock'event and clock = '1';
        reset  <= '0';
        start  <= '0';
        pel_mb <= (others => '0');
        hp_mb  <= x"CA641B5E003BE70902541A8BCA517EEA35D771";

        wait until clock'event and clock = '1';
        reset  <= '0';
        start  <= '0';
        pel_mb <= (others => '0');
        hp_mb  <= x"F55D593D264DDC0CCE7EEE4248535DA653988D";

        wait until clock'event and clock = '1';
        reset  <= '0';
        start  <= '0';
        pel_mb <= (others => '0');
        hp_mb  <= x"5C9AE27725ACC8A396FD7B07F3D86030FEAE0C";

        wait until clock'event and clock = '1';
        reset  <= '0';
        start  <= '0';
        pel_mb <= (others => '0');
        hp_mb  <= x"0A7C8AF8BED24B1B789FB405FB4EE77274933A";

        wait until clock'event and clock = '1';
        reset  <= '0';
        start  <= '0';
        pel_mb <= (others => '0');
        hp_mb  <= x"17293892312B6A915B683F6772BBF16B79C3B6";

        wait until clock'event and clock = '1';
        reset  <= '0';
        start  <= '0';
        pel_mb <= (others => '0');
        hp_mb  <= x"953B554940519728C30BBBFE23E536B5166120";

        wait until clock'event and clock = '1';
        reset  <= '0';
        start  <= '0';
        pel_mb <= (others => '0');
        hp_mb  <= x"A7BC88E723FBA214661CD71CB11272FA52C391";

        wait until clock'event and clock = '1';
        reset  <= '0';
        start  <= '0';
        pel_mb <= (others => '0');
        hp_mb  <= x"7A869D3684C01BBA75311B95D8D71EBFFA1962";

        wait until clock'event and clock = '1';
        reset  <= '0';
        start  <= '0';
        pel_mb <= (others => '0');
        hp_mb  <= x"0E7F7EE59B2FF70D294AD0BAC45757FADB1715";

        wait until clock'event and clock = '1';
        reset  <= '0';
        start  <= '0';
        pel_mb <= (others => '0');
        hp_mb  <= x"968D46B1221F8940DE83594092D8BE7774ED6F";

        wait until clock'event and clock = '1';
        reset  <= '0';
        start  <= '0';
        pel_mb <= (others => '0');
        hp_mb  <= x"8116B952D17DA9287884408D1ACDD4CCEFF355";

        wait until clock'event and clock = '1';
        reset  <= '0';
        start  <= '0';
        pel_mb <= (others => '0');
        hp_mb  <= x"30D1D889126A62D0E2D6BE5157D40AA9A58752";

        wait until clock'event and clock = '1';
        wait;
    end process;
end qpel_tb;

