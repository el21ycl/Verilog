/*
 * Quartus Software Test Design
 * ----------------------------
 * By: Thomas Carpenter
 * For: University of Leeds
 * Date: 28th December 2017
 *
 * Description
 * ------------
 * The module is a simple 4-bit Full Adder which has been
 * built in Verilog using Gate-Level 1-bit full adders.
 *
 */

module QuartusTest (
    // Declare input and output ports
    input        cin,
    input  [3:0] a,
    input  [3:0] b,
    output [3:0] sum,
    output       cout
);

Adder4Bit theAdder (
   .cin (cin ),
   .a   (a   ),
   .b   (b   ),
   .sum (sum ),
   .cout(cout)
);

endmodule // End of module
