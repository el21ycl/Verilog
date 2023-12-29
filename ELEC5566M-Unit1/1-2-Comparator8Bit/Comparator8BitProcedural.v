/*
 * 8-Bit Comparator
 * ----------------
 * By: Thomas Carpenter
 * For: University of Leeds
 * Date: 30th December 2017
 *
 * Description
 * -----------
 * The module is a simple 8-bit Comparator that has been
 * built in Verilog using Behavioural design and procedural
 * assignment using an always block.
 *
 */

module Comparator8BitProcedural ( 
    input  [7:0] a, 
    input  [7:0] b, 
    output reg   a_lt_b, //Notice that these are reg type outputs
    output reg   a_gt_b, //as we will be assigning them values in
    output reg   a_eq_b  //a procedural block.
);
always @ * begin //Whenever any signal in the always block (a or b) changes
    a_lt_b = (a < b);  //If a < b then this will set the LT output high
    a_gt_b = (a > b);  //If a > b then this will set the GT output high
    a_eq_b = (a == b); //If a == b then this will set the EQ output high
end
endmodule
