library verilog;
use verilog.vl_types.all;
entity control_vlg_check_tst is
    port(
        hex4            : in     vl_logic_vector(6 downto 0);
        hex5            : in     vl_logic_vector(6 downto 0);
        sampler_rx      : in     vl_logic
    );
end control_vlg_check_tst;
