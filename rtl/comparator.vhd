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
    type state is (idle, loading, comparing0, comparing1);

    signal current_state : state;
    signal next_state    : state;

    signal best_sad   : std_logic_vector(14 downto 0);
    signal best_vec   : std_logic_vector(5 downto 0);
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
            rc_sad   <= (others => '1');
            rc_vec   <= "010010";
            current_state <= idle;
        elsif clock'event and clock = '1' then
            case current_state is
                when idle =>
                    if start = '1' then
                        current_state <= loading;
                    elsif compare = '1' then
                        current_state <= comparing0;
                    else
                        current_state <= idle;
                    end if;

                when loading =>
                    best_sad <= hp_sad;
                    best_vec <= "010010";
                    current_state <= idle;

                when comparing0 =>
                    if unsigned(row_sad) < unsigned(col_sad) then
                        rc_sad <= row_sad;
                        rc_vec <= row_vec;
                    else
                        rc_sad <= col_sad;
                        rc_vec <= col_vec;
                    end if;

                    if unsigned(best_sad) < unsigned(diag_sad) then
                        best_sad <= best_sad;
                        best_vec <= best_vec;
                    else
                        best_sad <= diag_sad;
                        best_vec <= diag_vec;
                    end if;

                    current_state <= comparing1;

                when comparing1 =>
                    if unsigned(best_sad) < unsigned(rc_sad) then
                        best_sad <= best_sad;
                        best_vec <= best_vec;
                    else
                        best_sad <= rc_sad;
                        best_vec <= rc_vec;
                    end if;

                    current_state <= idle;
            end case;
        end if;
    end process;
end comparator;
