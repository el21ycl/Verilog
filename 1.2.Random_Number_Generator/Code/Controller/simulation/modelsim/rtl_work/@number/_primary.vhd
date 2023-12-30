library verilog;
use verilog.vl_types.all;
entity Number is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        R_b             : in     vl_logic_vector(7 downto 0);
        Z               : in     vl_logic_vector(3 downto 0);
        t               : in     vl_logic;
        R_n             : out    vl_logic_vector(7 downto 0)
    );
end Number;
