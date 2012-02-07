library ieee;
use ieee.std_logic_1164.all;

entity foo is
    port (
        clk, rst, start : in std_logic;
        din : in std_logic_vector(7 downto 0);
        do1 : out std_logic_vector(7 downto 0);
        do2 : out std_logic_vector(7 downto 0)
    );
end foo;

architecture foo of foo is
    type state is (a, b, c);
    signal current_state, next_state : state;
    signal current, nxt : state;

    signal wren1,wren2 : std_logic;

begin

    process(clk, rst, din, start)
    begin
        if rst = '1' then
            current <= a;
        elsif clk'event and clk = '1' then
            current <= nxt;

            case current is
                when a =>
                    if start = '1' then
                        wren2 <= '1';
                        nxt <= b;
                    else
                        wren2 <= '0';
                        nxt <= a;
                    end if;
                when b =>
                    wren2 <= '0';
                    nxt <= c;
                when c =>
                    wren2 <= '0';
                    nxt <= a;
                when others =>
                    wren2 <= '0';
                    nxt <= a;
            end case;
        end if;
    end process;

    process(clk, rst, wren1, din)
    begin
        if rst = '1' then
            current_state <= a;
        elsif clk'event and clk = '1' then
            current_state <= next_state;

            if wren1 = '1' then
                do1 <= din;
            end if;

            if wren2 = '1' then
                do2 <= din;
            end if;
        end if;
    end process;

    process(current_state, start)
    begin
        case current_state is
            when a =>
                wren1 <= '0';

                if start = '1' then
                    next_state <= b;
                else
                    next_state <= a;
                end if;

            when b =>
                wren1 <= '1';
                next_state <= c;
            when c =>
                wren1 <= '0';
                next_state <= a;
            when others =>
                wren1 <= '0';
                next_state <= a;
        end case;
    end process;


end foo;
