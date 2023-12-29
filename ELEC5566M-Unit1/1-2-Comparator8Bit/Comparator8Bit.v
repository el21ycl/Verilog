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
 * built in Verilog using Behavioural design and continuous
 * assign statements.
 *
 */

module Comparator8Bit ( 
    input  [7:0] a, 
    input  [7:0] b, 
    output       a_lt_b,
    output       a_gt_b,
    output       a_eq_b
);
assign a_lt_b = (a < b);  //If a < b then this will set the LT output high
assign a_gt_b = (a > b);  //If a > b then this will set the GT output high
assign a_eq_b = (a == b); //If a == b then this will set the EQ output high
endmodule
