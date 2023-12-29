library verilog;
use verilog.vl_types.all;
entity Bcd7seg_0_vlg_check_tst is
    port(
        hex4            : in     vl_logic_vector(6 downto 0);
        test            : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end Bcd7seg_0_vlg_check_tst;
