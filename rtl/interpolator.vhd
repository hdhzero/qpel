library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity interpolator is
    port (
        sel   : in  std_logic;
        line0 : in  std_logic_vector(151 downto 0);
        line1 : in  std_logic_vector(151 downto 0);
        row   : out std_logic_vector(143 downto 0);
        col   : out std_logic_vector(135 downto 0);
        diag  : out std_logic_vector(143 downto 0)
    );
end interpolator;

architecture interpolator of interpolator is
    component col_interpolator is
    port (
        a : in std_logic_vector(135 downto 0);
        b : in std_logic_vector(135 downto 0);
        s : out std_logic_vector(135 downto 0)
    );
    end component col_interpolator;

    component row_interpolator is
    port (
        a : in std_logic_vector(151 downto 0);
        s : out std_logic_vector(143 downto 0)
    );
    end component row_interpolator;

    component diag_interpolator is
    port (
        sel : in std_logic;
        a : in std_logic_vector(151 downto 0);
        b : in std_logic_vector(151 downto 0);
        s : out std_logic_vector(143 downto 0)
    );
    end component diag_interpolator;
begin
    col_interpolator_u : col_interpolator
    port map (line0(143 downto 8), line1(143 downto 8), col);

    row_interpolator_u : row_interpolator
    port map (line0, row);

    diag_interpolator_u : diag_interpolator
    port map (sel, line0, line1, diag);
end interpolator;

