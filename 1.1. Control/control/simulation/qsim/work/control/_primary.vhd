library verilog;
use verilog.vl_types.all;
entity control is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        Key_2           : in     vl_logic;
        Key_0           : in     vl_logic;
        hex4            : out    vl_logic_vector(6 downto 0);
        hex5            : out    vl_logic_vector(6 downto 0)
    );
end control;
