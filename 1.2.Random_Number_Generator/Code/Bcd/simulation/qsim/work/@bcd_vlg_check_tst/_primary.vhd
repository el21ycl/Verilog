library verilog;
use verilog.vl_types.all;
entity Bcd_vlg_check_tst is
    port(
        d_0             : in     vl_logic_vector(3 downto 0);
        d_1             : in     vl_logic_vector(3 downto 0);
        test            : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end Bcd_vlg_check_tst;
