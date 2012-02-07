library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator is
    port (
        clock    : in  std_logic;
        reset    : in  std_logic;
        start    : in  std_logic;
        compare  : in  std_logic;
        hp_sad   : in  std_logic_vector(14 downto 0);
        row_sad  : in  std_logic_vector(14 downto 0);
        col_sad  : in  std_logic_vector(14 downto 0);
        diag_sad : in  std_logic_vector(14 downto 0);
        row_vec  : in  std_logic_vector(5 downto 0);
        col_vec  : in  std_logic_vector(5 downto 0);
        diag_vec : in  std_logic_vector(5 downto 0);
        sad      : out std_logic_vector(14 downto 0);
        vector   : out std_logic_vector(5 downto 0)
    );
end comparator;

architecture comparator of comparator is
    signal best_sad   : std_logic_vector(14 downto 0);
    signal best_vec   : std_logic_vector(5 downto 0);
    signal best_sad_s : std_logic_vector(14 downto 0);
    signal best_vec_s : std_logic_vector(5 downto 0);
    signal rcd_sad    : std_logic_vector(14 downto 0);
    signal rcd_vec    : std_logic_vector(5 downto 0);
    signal rc_sad     : std_logic_vector(14 downto 0);
    signal rc_vec     : std_logic_vector(5 downto 0);
begin
    sad    <= best_sad;
    vector <= best_vec;

    process(clock, reset, start, compare, hp_sad)
    begin
        if reset = '1' then
            best_sad <= (others => '1');
            best_vec <= "010010";
        elsif clock'event and clock = '1' then
            if start = '1' then
                best_sad <= hp_sad;
                best_vec <= "010010";
            elsif compare = '1' then
                best_sad <= best_sad_s;
                best_vec <= best_vec_s;
            end if;
        end if;
    end process;

    best_sad_s <= best_sad when best_sad < rcd_sad else rcd_sad;
    rcd_sad    <= diag_sad when diag_sad < rc_sad else rc_sad;
    rc_sad     <= col_sad  when col_sad  < row_sad else row_sad;

    best_vec_s <= best_vec when best_sad < rcd_sad else rcd_vec;
    rcd_vec    <= diag_vec when diag_sad < rc_sad else rc_vec;
    rc_vec     <= col_vec  when col_sad  < row_sad else row_vec;

end comparator;
