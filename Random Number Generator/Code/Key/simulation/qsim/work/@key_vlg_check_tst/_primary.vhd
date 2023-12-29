library verilog;
use verilog.vl_types.all;
entity Key_vlg_check_tst is
    port(
        Z               : in     vl_logic_vector(3 downto 0);
        start           : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end Key_vlg_check_tst;
