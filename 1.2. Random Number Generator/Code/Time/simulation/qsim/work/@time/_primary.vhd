library verilog;
use verilog.vl_types.all;
entity Time is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        Key_0           : in     vl_logic;
        t               : out    vl_logic
    );
end Time;
