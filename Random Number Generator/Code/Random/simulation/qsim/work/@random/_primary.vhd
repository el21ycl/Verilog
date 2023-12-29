library verilog;
use verilog.vl_types.all;
entity Random is
    port(
        R_b             : out    vl_logic_vector(7 downto 0);
        R               : out    vl_logic_vector(7 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start           : in     vl_logic
    );
end Random;
