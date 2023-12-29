library verilog;
use verilog.vl_types.all;
entity Key is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        Key_2           : in     vl_logic;
        Key_0           : in     vl_logic;
        start           : out    vl_logic;
        Z               : out    vl_logic_vector(3 downto 0)
    );
end Key;
