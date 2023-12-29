/*
 * 4-Bit Full Adder
 * ----------------
 *
 * The module is a simple 4-bit Full Adder which has been
 * built in Verilog using Gate-Level 1-bit full adders.
 *
 */
 
module Adder4Bit (
    // Declare input and output ports
    input        cin,
    input  [3:0] a,
    input  [3:0] b,
    output [3:0] sum,
    output       cout
);

    // Internal carry signal between full adders
    wire [2:0] carry;
    
    // Instantiate full adders for bits 0 to 3
    Adder1Bit bit0 (
        .cin (cin     ),
        .a   (a    [0]),
        .b   (b    [0]),
        .sum (sum  [0]),
        .cout(carry[0])
    );
    
    Adder1Bit bit1 (
        .cin (carry[0]),
        .a   (a    [1]),
        .b   (b    [1]),
        .sum (sum  [1]),
        .cout(carry[1])
    );
    
    Adder1Bit bit2 (
        .cin (carry[1]),
        .a   (a    [2]),
        .b   (b    [2]),
        .sum (sum  [2]),
        .cout(carry[2])
    );
    
    Adder1Bit bit3 (
        .cin (carry[2]),
        .a   (a    [3]),
        .b   (b    [3]),
        .sum (sum  [3]),
        .cout(cout    )
    );

endmodule
