library verilog;
use verilog.vl_types.all;
entity Random_vlg_check_tst is
    port(
        R               : in     vl_logic_vector(7 downto 0);
        R_b             : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end Random_vlg_check_tst;
