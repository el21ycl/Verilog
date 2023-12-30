library verilog;
use verilog.vl_types.all;
entity control_vlg_sample_tst is
    port(
        Key_0           : in     vl_logic;
        Key_2           : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end control_vlg_sample_tst;
