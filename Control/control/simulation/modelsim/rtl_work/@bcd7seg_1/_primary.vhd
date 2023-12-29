library verilog;
use verilog.vl_types.all;
entity Bcd7seg_1 is
    port(
        B               : in     vl_logic_vector(3 downto 0);
        hex5            : out    vl_logic_vector(6 downto 0)
    );
end Bcd7seg_1;
