library verilog;
use verilog.vl_types.all;
entity count is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        Key_2           : in     vl_logic;
        Key_0           : in     vl_logic;
        cnt_0           : out    vl_logic_vector(3 downto 0);
        cnt_1           : out    vl_logic_vector(3 downto 0)
    );
end count;
