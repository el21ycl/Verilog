library verilog;
use verilog.vl_types.all;
entity Random is
    generic(
        Length          : integer := 8;
        initial_state   : vl_logic_vector(0 to 7) := (Hi1, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1);
        Tap_Coefficient : vl_logic_vector
    );
    port(
        R_b             : out    vl_logic_vector(7 downto 0);
        R               : out    vl_logic_vector;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start           : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of Length : constant is 1;
    attribute mti_svvh_generic_type of initial_state : constant is 1;
    attribute mti_svvh_generic_type of Tap_Coefficient : constant is 4;
end Random;
