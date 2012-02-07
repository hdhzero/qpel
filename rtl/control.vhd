library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control is
    port (
        clock     : in  std_logic;
        reset     : in  std_logic;
        start     : in  std_logic;
        hp_y      : in  std_logic_vector(2 downto 0);
        pel_wren  : out std_logic;
        row_wren  : out std_logic;
        col_wren  : out std_logic;
        diag_wren : out std_logic;
        pel_addr  : out std_logic_vector(2 downto 0);
        row_addr  : out std_logic_vector(4 downto 0);
        col_addr  : out std_logic_vector(4 downto 0);
        diag_addr : out std_logic_vector(4 downto 0);
        row_sel   : out std_logic;
        diag_sel  : out std_logic;
        compare   : out std_logic;
        line_buffer_wren : out std_logic;
        interpolator_sel : out std_logic
    );
end control;

architecture control of control is
    type state is (idle, loading0, loading1, loading2, sad0);

    signal current_state : state;
    signal next_state    : state;

    signal pel_addr_s    : std_logic_vector(2 downto 0);
    signal pel_addr_reg  : std_logic_vector(2 downto 0);
    signal row_addr_s    : std_logic_vector(4 downto 0);
    signal row_addr_reg  : std_logic_vector(4 downto 0);
    signal col_addr_s    : std_logic_vector(4 downto 0);
    signal col_addr_reg  : std_logic_vector(4 downto 0);
    signal diag_addr_s   : std_logic_vector(4 downto 0);
    signal diag_addr_reg : std_logic_vector(4 downto 0);

    signal counter_s   : integer;
    signal counter_reg : integer;

    signal addr_wren : std_logic;
    signal col_up    : std_logic_vector(4 downto 0);
    signal col_dw    : std_logic_vector(4 downto 0);
    signal row_up    : std_logic_vector(4 downto 0);

begin

    pel_addr  <= pel_addr_reg;
    row_addr  <= row_addr_reg;
    col_addr  <= col_addr_reg;
    diag_addr <= diag_addr_reg;
    addr_wren <= '1' when current_state = loading0 else '0';

    process(clock, reset)
    begin
        if reset = '1' then
            current_state <= idle;
            pel_addr_reg  <= (others => '0');
            row_addr_reg  <= (others => '0');
            col_addr_reg  <= (others => '0');
            diag_addr_reg <= (others => '0');
            counter_reg   <= 0;
        elsif clock'event and clock = '1' then
            current_state <= next_state;
            pel_addr_reg  <= pel_addr_s;
            row_addr_reg  <= row_addr_s;
            col_addr_reg  <= col_addr_s;
            diag_addr_reg <= diag_addr_s;
            counter_reg   <= counter_s;
        end if;
    end process;

    process(clock, reset, addr_wren, hp_y)
    begin
        if reset = '1' then
            col_up <= "00000";
            col_dw <= "00000";
            row_up <= "00000";
        elsif clock'event and clock = '1' then
            if addr_wren = '1' then
                case hp_y is
                    when "001" =>
                        col_up <= "00000";
                        col_dw <= "00001";
                        row_up <= "00000";
                    when "010" =>
                        col_up <= "00001";
                        col_dw <= "00010";
                        row_up <= "00001";
                    when others =>
                        col_up <= "00010";
                        col_dw <= "00011";
                        row_up <= "00010";
                end case;
            end case;
        end if;
    end process;

    process(current_state, start, counter_reg, row_addr_reg, col_addr_reg, diag_addr_reg)
    begin
        case current_state is
            when idle =>
                row_sel   <= '0';
                diag_sel  <= '0';
                compare   <= '0';
                pel_wren  <= '0';
                row_wren  <= '0';
                col_wren  <= '0';
                diag_wren <= '0';
                line_buffer_wren <= '0';
                interpolator_sel <= '0';

                pel_addr_s  <= "000";
                row_addr_s  <= "00000";
                col_addr_s  <= "00000";
                diag_addr_s <= "00000";

                counter_s   <= 0;

                if start = '1' then
                    next_state <= loading0;
                else
                    next_state <= idle;
                end if;

            when loading0 =>
                row_sel   <= '0';
                diag_sel  <= '0';
                compare   <= '0';
                pel_wren  <= '1';
                row_wren  <= '0';
                col_wren  <= '0';
                diag_wren <= '0';
                line_buffer_wren <= '1';
                interpolator_sel <= '0';

                pel_addr_s  <= std_logic_vector(unsigned(pel_addr_reg) + "1");
                row_addr_s  <= "00000";
                col_addr_s  <= "00000";
                diag_addr_s <= "00000";

                counter_s   <= 0;

                next_state  <= loading1;

            when loading1 =>
                row_sel   <= '0';
                diag_sel  <= '0';
                compare   <= '0';
                pel_wren  <= '1';
                row_wren  <= '0';
                col_wren  <= '0';
                diag_wren <= '0';
                line_buffer_wren <= '1';
                interpolator_sel <= '0';

                pel_addr_s  <= std_logic_vector(unsigned(pel_addr_reg) + "1");
                row_addr_s  <= "00000";
                col_addr_s  <= "00000";
                diag_addr_s <= "00000";

                counter_s   <= 0;

                next_state  <= loading2;

            when loading2 =>
                row_sel   <= '0';
                diag_sel  <= '0';
                compare   <= '0';
                counter_s <= counter_reg + 1;

                if counter_reg < 6 then
                    pel_wren   <= '1';
                    pel_addr_s <= std_logic_vector(unsigned(pel_addr_reg) + "1");
                else
                    pel_wren   <= '0';
                    pel_addr_s <= "000";
                end if;

                if counter_reg < 17 then
                    row_wren   <= '1';
                    row_addr_s <= std_logic_vector(unsigned(row_addr_reg) + "1");
                else
                    row_wren   <= '0';
                    row_addr_s <= "00000";
                end if;

                if counter_reg < 18 then
                    col_wren  <= '1';
                    diag_wren <= '1';
                    line_buffer_wren <= '1';
                    interpolator_sel <= diag_addr_reg(0);

                    col_addr_s  <= std_logic_vector(unsigned(col_addr_reg) + "1");
                    diag_addr_s <= std_logic_vector(unsigned(diag_addr_reg) + "1");

                    next_state  <= loading2;
                else
                    col_wren  <= '0';
                    diag_wren <= '0';
                    line_buffer_wren <= '0';
                    interpolator_sel <= '0';

                    col_addr_s  <= "00000";
                    diag_addr_s <= "00000";

                    next_state  <= sad0;
                end if;

            when sad0 =>
                row_sel   <= '0';
                diag_sel  <= '0';
                compare   <= '0';
                pel_wren  <= '0';
                row_wren  <= '0';
                col_wren  <= '0';
                diag_wren <= '0';
                line_buffer_wren <= '0';
                interpolator_sel <= '0';
                counter_s <= 0;

                pel_addr_s  <= "000";
                row_addr_s  <= row_up;
                col_addr_s  <= col_up;
                diag_addr_s <= col_up;

                next_state <= sad1;

            when sad1 =>
                row_sel   <= '0';
                diag_sel  <= '0';
                compare   <= '0';
                pel_wren  <= '0';
                row_wren  <= '0';
                col_wren  <= '0';
                diag_wren <= '0';
                line_buffer_wren <= '0';
                interpolator_sel <= '0';
                counter_s <= counter_reg + 1;

                pel_addr_s  <= std_logic_vector(unsigned(pel_addr_reg) + "1");
                row_addr_s  <= std_logic_vector(unsigned(row_addr_reg) + "10");
                col_addr_s  <= std_logic_vector(unsigned(col_addr_reg) + "10");
                diag_addr_s <= std_logic_vector(unsigned(diag_addr_reg) + "10");

                if counter_reg < 8 then
                    next_state <= sad1;
                else
                    next_state <= sad2;
                end if;

            when sad2 =>
                row_sel   <= '0';
                diag_sel  <= '0';
                compare   <= '1';
                pel_wren  <= '0';
                row_wren  <= '0';
                col_wren  <= '0';
                diag_wren <= '0';
                line_buffer_wren <= '0';
                interpolator_sel <= '0';
                counter_s <= 0;

                pel_addr_s  <= "000";
                row_addr_s  <= row_up;
                col_addr_s  <= col_up;
                diag_addr_s <= col_up;

                next_state <= sad3;

            when sad3 =>
                row_sel   <= '1';
                diag_sel  <= '1';
                compare   <= '0';
                pel_wren  <= '0';
                row_wren  <= '0';
                col_wren  <= '0';
                diag_wren <= '0';
                line_buffer_wren <= '0';
                interpolator_sel <= '0';
                counter_s <= counter_reg + 1;

                pel_addr_s  <= std_logic_vector(unsigned(pel_addr_reg) + "1");
                row_addr_s  <= std_logic_vector(unsigned(row_addr_reg) + "10");
                col_addr_s  <= std_logic_vector(unsigned(col_addr_reg) + "10");
                diag_addr_s <= std_logic_vector(unsigned(diag_addr_reg) + "10");

                if counter_reg < 8 then
                    next_state <= sad3;
                else
                    next_state <= sad4;
                end if;

            when sad4 =>
                row_sel   <= '0';
                diag_sel  <= '0';
                compare   <= '1';
                pel_wren  <= '0';
                row_wren  <= '0';
                col_wren  <= '0';
                diag_wren <= '0';
                line_buffer_wren <= '0';
                interpolator_sel <= '0';
                counter_s <= 0;

                pel_addr_s  <= "000";
                row_addr_s  <= row_up;
                col_addr_s  <= col_dw;
                diag_addr_s <= col_dw;

                next_state <= sad5;

            when sad5 =>
                row_sel   <= '0';
                diag_sel  <= '0';
                compare   <= '0';
                pel_wren  <= '0';
                row_wren  <= '0';
                col_wren  <= '0';
                diag_wren <= '0';
                line_buffer_wren <= '0';
                interpolator_sel <= '0';
                counter_s <= counter_reg + 1;

                pel_addr_s  <= std_logic_vector(unsigned(pel_addr_reg) + "1");
                row_addr_s  <= std_logic_vector(unsigned(row_addr_reg) + "10");
                col_addr_s  <= std_logic_vector(unsigned(col_addr_reg) + "10");
                diag_addr_s <= std_logic_vector(unsigned(diag_addr_reg) + "10");

                if counter_reg < 8 then
                    next_state <= sad5;
                else
                    next_state <= sad6;
                end if;

            when sad6 =>
                row_sel   <= '0';
                diag_sel  <= '0';
                compare   <= '1';
                pel_wren  <= '0';
                row_wren  <= '0';
                col_wren  <= '0';
                diag_wren <= '0';
                line_buffer_wren <= '0';
                interpolator_sel <= '0';
                counter_s <= 0;

                pel_addr_s  <= "000";
                row_addr_s  <= row_up;
                col_addr_s  <= col_dw;
                diag_addr_s <= col_dw;

                next_state <= sad7;

            when sad7 =>
                row_sel   <= '1';
                diag_sel  <= '1';
                compare   <= '0';
                pel_wren  <= '0';
                row_wren  <= '0';
                col_wren  <= '0';
                diag_wren <= '0';
                line_buffer_wren <= '0';
                interpolator_sel <= '0';
                counter_s <= counter_reg + 1;

                pel_addr_s  <= std_logic_vector(unsigned(pel_addr_reg) + "1");
                row_addr_s  <= std_logic_vector(unsigned(row_addr_reg) + "10");
                col_addr_s  <= std_logic_vector(unsigned(col_addr_reg) + "10");
                diag_addr_s <= std_logic_vector(unsigned(diag_addr_reg) + "10");

                if counter_reg < 8 then
                    next_state <= sad7;
                else
                    next_state <= sad8;
                end if;

            when sad8 =>
                row_sel   <= '0';
                diag_sel  <= '0';
                compare   <= '1';
                pel_wren  <= '0';
                row_wren  <= '0';
                col_wren  <= '0';
                diag_wren <= '0';
                line_buffer_wren <= '0';
                interpolator_sel <= '0';
                counter_s <= 0;

                pel_addr_s  <= "000";
                row_addr_s  <= "00000";
                col_addr_s  <= "00000";
                diag_addr_s <= "00000";

                next_state <= finished;

            when finished =>
                row_sel   <= '0';
                diag_sel  <= '0';
                compare   <= '1';
                pel_wren  <= '0';
                row_wren  <= '0';
                col_wren  <= '0';
                diag_wren <= '0';
                line_buffer_wren <= '0';
                interpolator_sel <= '0';
                counter_s <= 0;

                pel_addr_s  <= "000";
                row_addr_s  <= "00000";
                col_addr_s  <= "00000";
                diag_addr_s <= "00000";

                next_state <= idle;

            when others =>
                pel_wren  <= '0';
                row_wren  <= '0';
                col_wren  <= '0';
                diag_wren <= '0';
                line_buffer_wren <= '0';
                interpolator_sel <= '0';

                pel_addr_s  <= "000";
                row_addr_s  <= "00000";
                col_addr_s  <= "00000";
                diag_addr_s <= "00000";

                counter_s   <= 0;
                next_state  <= idle;
                
        end case;
    end process;
end control;
