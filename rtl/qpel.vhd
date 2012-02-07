library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity qpel is
    port (
        clock  : in  std_logic;
        reset  : in  std_logic;
        start  : in  std_logic;
        hp_sad : in  std_logic_vector(14 downto 0);
        hp_x   : in  std_logic_vector(2 downto 0);
        hp_y   : in  std_logic_vector(2 downto 0);
        hp_mb  : in  std_logic_vector(151 downto 0);
        pel_mb : in  std_logic_vector(63 downto 0);
        done   : out std_logic;
        qp_sad : out std_logic_vector(14 downto 0);
        qp_x   : out std_logic_vector(2 downto 0);
        qp_y   : out std_logic_vector(2 downto 0)
    );
end qpel;

architecture qpel of qpel is
    component control is
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
    end component control;

    component line_buffer is
        port (
            clock : in  std_logic;
            reset : in  std_logic;
            wren  : in  std_logic;
            din   : in  std_logic_vector(151 downto 0);
            line0 : out std_logic_vector(151 downto 0);
            line1 : out std_logic_vector(151 downto 0)
        );
    end component line_buffer;

    component interpolator is
        port (
            sel   : in  std_logic;
            line0 : in  std_logic_vector(151 downto 0);
            line1 : in  std_logic_vector(151 downto 0);
            row   : out std_logic_vector(143 downto 0);
            col   : out std_logic_vector(135 downto 0);
            diag  : out std_logic_vector(143 downto 0)
        );
    end component interpolator;

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

    component comparator is
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
    end component comparator;

    component sad is
    port (
        clock : in std_logic;
        reset : in std_logic;
        start : in std_logic;
        line0 : in std_logic_vector(63 downto 0);
        line1 : in std_logic_vector(63 downto 0);
        sadv  : out std_logic_vector(14 downto 0)
    );
    end component sad;

    component row_mux is
    port (
        vec  : in std_logic_vector(2 downto 0);
        sel  : in std_logic;
        din  : in std_logic_vector(143 downto 0);
        dout : out std_logic_vector(63 downto 0)
    );
    end component row_mux;

    component diag_mux is
    port (
        vec : in std_logic_vector(2 downto 0);
        sel  : in std_logic;
        din  : in std_logic_vector(143 downto 0);
        dout : out std_logic_vector(63 downto 0)
    );
    end component diag_mux;

    component col_mux is
    port (
        sel  : in std_logic_vector(2 downto 0);
        din  : in std_logic_vector(135 downto 0);
        dout : out std_logic_vector(63 downto 0)
    );
    end component col_mux;



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

    signal line_buffer_wren : std_logic;
    signal interpolator_sel : std_logic;
    signal line0 : std_logic_vector(151 downto 0);
    signal line1 : std_logic_vector(151 downto 0);

    signal sad_start : std_logic;
    signal row_sel   : std_logic;
    signal diag_sel  : std_logic;
    signal compare   : std_logic;
    signal hp_x_reg  : std_logic_vector(2 downto 0);
    signal row_64    : std_logic_vector(63 downto 0);
    signal col_64    : std_logic_vector(63 downto 0);
    signal diag_64   : std_logic_vector(63 downto 0);
    signal row_sad   : std_logic_vector(14 downto 0);
    signal col_sad   : std_logic_vector(14 downto 0);
    signal diag_sad  : std_logic_vector(14 downto 0);
    signal row_vec   : std_logic_vector(5 downto 0);
    signal col_vec   : std_logic_vector(5 downto 0);
    signal diag_vec  : std_logic_vector(5 downto 0);



begin
    pel_din <= pel_mb;

    col_mux_u : col_mux
    port map (hp_x_reg, col_dout, col_64);

    row_mux_u : row_mux
    port map (hp_x_reg, row_sel, row_dout, row_64);

    diag_mux_u : diag_mux
    port map (hp_x_reg, diag_sel, diag_dout, diag_64);



    control_u : control
    port map (
        clock     => clock,
        reset     => reset,
        start     => start,
        hp_y      => hp_y,
        pel_wren  => pel_wren,
        row_wren  => row_wren,
        col_wren  => col_wren,
        diag_wren => diag_wren,
        pel_addr  => pel_addr,
        row_addr  => row_addr,
        col_addr  => col_addr,
        diag_addr => diag_addr,
        row_sel   => row_sel,
        diag_sel  => diag_sel,
        compare   => compare,
        line_buffer_wren => line_buffer_wren,
        interpolator_sel => interpolator_sel
    );

    line_buffer_u : line_buffer
    port map (clock, reset, line_buffer_wren, hp_mb, line0, line1);

    interpolator_u : interpolator
    port map (interpolator_sel, line0, line1, row_din, col_din, diag_din);

    mb_buffer_u : mb_buffer
    port map (
        clock, reset, pel_wren, row_wren, col_wren, diag_wren, pel_addr,
        row_addr, col_addr, diag_addr, pel_din, row_din, col_din, diag_din,
        pel_dout, row_dout, col_dout, diag_dout
    );

    row_sad_u : sad
    port map (clock, reset, sad_start, pel_dout, row_64, row_sad);

    col_sad_u : sad
    port map (clock, reset, sad_start, pel_dout, col_64, col_sad);

    diag_sad_u : sad
    port map (clock, reset, sad_start, pel_dout, diag_64, diag_sad);

       
    comparator_u : comparator
    port map (
        clock    => clock,
        reset    => reset,
        start    => start,
        compare  => compare,
        hp_sad   => hp_sad,
        row_sad  => row_sad,
        col_sad  => col_sad,
        diag_sad => diag_sad,
        row_vec  => row_vec,
        col_vec  => col_vec,
        diag_vec => diag_vec,
        sad      => qp_sad,
        vector(2 downto 0) => qp_y,
        vector(5 downto 3) => qp_x
    );
end qpel;
