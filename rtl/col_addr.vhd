library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity col_addr is
    port (
        clock : in  std_logic;
        reset : in  std_logic;
        start : in  std_logic;
        save  : in  std_logic;
        vecx  : in  std_logic_vector(2 downto 0);
        vecy  : in  std_logic_vector(2 downto 0);
        addr  : out std_logic_vector(3 downto 0)
    );
end col_addr;
