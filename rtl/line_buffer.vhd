library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity line_buffer is
    port (
        clock : in  std_logic;
        reset : in  std_logic;
        wren  : in  std_logic;
        din   : in  std_logic_vector(151 downto 0);
        line0 : out std_logic_vector(151 downto 0);
        line1 : out std_logic_vector(151 downto 0)
    );
end line_buffer;

architecture line_buffer of line_buffer is
    signal line0_s : std_logic_vector(151 downto 0);
    signal line1_s : std_logic_vector(151 downto 0);
begin
    line0 <= line0_s;
    line1 <= line1_s;

    process(clock, reset, wren, din)
    begin
        if reset = '1' then
            line0_s <= (others => '0');
            line1_s <= (others => '0');
        elsif clock'event and clock = '1' then
            if wren = '1' then
                line0_s <= din;
                line1_s <= line0_s;
            end if;
        end if;
    end process;
end line_buffer;
        
