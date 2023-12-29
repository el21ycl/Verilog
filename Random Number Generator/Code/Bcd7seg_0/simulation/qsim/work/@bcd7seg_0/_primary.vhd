library verilog;
use verilog.vl_types.all;
entity Bcd7seg_0 is
    port(
        A               : in     vl_logic_vector(3 downto 0);
        test            : out    vl_logic_vector(3 downto 0);
        hex4            : out    vl_logic_vector(6 downto 0)
    );
end Bcd7seg_0;
