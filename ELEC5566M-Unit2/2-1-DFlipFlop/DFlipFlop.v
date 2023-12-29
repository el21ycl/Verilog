/*
 * D-Type Flip Flop
 * ================
 *
 * A simple D-Type Flip Flop Example
 *
 */

module DFlipFlop (
    input clock,
    input d, 
    output reg q
);

always @( posedge clock ) begin //At to rising edge of clock
	    q <= d; //Load the input value d onto the output q.
end
endmodule
