/*
 * Submodule for Remaining Row of Multiplier
 * ----------------
 *
 * The module is a Remaining Row of Multiplier which has been
 * built in Verilog using Gate-Level 1-bit full adders.
 *
 */
module MultiplierRemainRow (
    // Declare input and output ports
    input      pp,
    input       m,
    input       q,
    input     cIn,
    
    output qOut,
    output cOut,
    output mOut,
    output s
);

    // Internal wire connection
    wire A,B;
	 // Declare AND gate primitive with inputs A and m with output A 
	 and(A,m,q);
	  
	 // Instantiate Remaining Row of Multiplier for bit1
    Adder1Bit bit1 (
        .cin (cIn     ),
        .a   (A       ),
        .b   (pp      ),
        .sum (s       ),
        .cout(cOut    )
    );
	  

endmodule // End of module
