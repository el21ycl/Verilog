library verilog;
use verilog.vl_types.all;
entity Bcd is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        R_n             : in     vl_logic_vector(7 downto 0);
        d_0             : out    vl_logic_vector(3 downto 0);
        d_1             : out    vl_logic_vector(3 downto 0)
    );
end Bcd;
