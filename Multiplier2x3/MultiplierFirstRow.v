/*
 * Submodule for First Row of Multiplier
 * ----------------
 *
 * The module is a First Row of Multiplier which has been
 * built in Verilog using Gate-Level 1-bit full adders.
 *
 */
module MultiplierFirstRow (
    // Declare input and output ports
    input  [1:0] m,
    input  [1:0] q,
    input        cIn,
    
    output [1:0] qOut,
    output       cOut,
    output       mOut,
    output       s
);

     // Internal wire connection
     wire A,B;

	  // Declare AND gate primitive with inputs m[0] and q[1] with output A
	  and(A,m[0],q[1]);
	  // Declare AND gate primitive with inputs m[1] and q[0] with output B
	  and(B,m[1],q[0]);
	  
	 // Instantiate First Row of Multiplier for 1bit Adder
    Adder1Bit bit (
        .cin (cIn     ),
        .a   (A       ),
        .b   (B       ),
        .sum (s       ),
        .cout(cOut    )
    );
	  
	  

endmodule // End of module
