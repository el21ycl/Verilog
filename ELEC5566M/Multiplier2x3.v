/*
 * 2-Bit by 3-Bit Multiplier 
 * ----------------
 *
 * The module is a 2-Bit by 3-Bit Multiplier  which has been
 * built in Verilog using MultiplierfirstRow and MultiplierremainRow.
 *
 */
module Multiplier2x3 (
    // Declare input and output ports
    input  [1:0] m,
    input  [2:0] q,

    output [4:0] p
);

    // Internal wire connection
    wire [3:0] r1;
	 wire [2:0] r2;
	 wire [1:0] r3;
	 // Declare AND gate primitive with inputs m[0] and q[0] with output p[0]	 
	 and (p[0],m[0],q[0]);

	  // Instantiate MultiplierfirstRow
MultiplierFirstRow mfr_0(
	     .cIn  (0      ),
        .m    (m      ),
		  .mOut(r1[3]   ),
		  .q    (q      ),
        .qOut(r1      ),
        .s   (p[1]    ),
        .cOut(r1[2]   )
	 );
	 
	 // Internal wire connection
	 wire [1:0] f;
	 // Set the input m of the second MultiplierfirstRow
	 assign f[0] = m[1];
	 assign f[1] = 1'b0;
	 
MultiplierFirstRow mfr_1(
	     .cIn (r1[2]   ),
        .m    (f      ),
		  .mOut(r2[1]   ),
		  .q    (r1     ),
        .s   (r2[2]    ),
        .cOut(r2[0]   )
	 );
	 
	 // Instantiate MultiplierRemainRow
	  MultiplierRemainRow mrr_0(
	     .cIn (0       ),
		  .m   (r1[3]   ),
		  .q   (q2      ),
		  .qOut (r3[0]  ),  
        .pp   (r2[2]  ),
        .s   (p[2]    ),
        .cOut(r3[1]   )
	 );
	 
	  MultiplierRemainRow mrr_1(
	     .cIn (r3[1]   ),
		  .m   (r2[1]   ),
		  .q   (r3[0]   ), 
        .pp   (r2[0]  ),
        .s   (p[3]    ),
        .cOut(p[4]    )
	 );
endmodule // End of module

