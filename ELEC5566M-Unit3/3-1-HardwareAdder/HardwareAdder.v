module HardwareAdder (
    // Declare input and output ports
	 input        INVERT_OUTPUT,
    input        cin,
    input  [3:0] a,
	 input  [3:0] b,
	 input  [3:0] hex,
	 output [6:0] HEX5,
	 output [6:0] HEX4,
	 output [6:0] HEX3,
	 output [6:0] HEX2,
	 output [6:0] HEX1,
	 output [6:0] HEX0,
    output [3:0] sum,
    output       cout
);
reg e;

 always @(*) begin
   e <= 0;
end
 
Adder4Bit theAdder (
   .cin (cin ),
   .a   (a   ),
   .b   (b  ),
   .sum (sum ),
   .cout(cout)
);

HexTo7Segment thea (
   .INVERT_OUTPUT(INVERT_OUTPUT),
   .hex (a ),
   .seg(HEX5)
);

HexTo7Segment theb (
   .INVERT_OUTPUT(INVERT_OUTPUT),
	.hex (b ),
   .seg(HEX4)
);

HexTo7Segment thesum (
   .INVERT_OUTPUT(INVERT_OUTPUT),
	.hex (sum ),
   .seg(HEX0)
);

HexTo7Segment thecin (
   .INVERT_OUTPUT(INVERT_OUTPUT),
	.hex (cin ),
   .seg(HEX3)
);

HexTo7Segment thecout (
   .INVERT_OUTPUT(INVERT_OUTPUT),
	.hex (cout ),
   .seg(HEX1)
);

HexTo7Segment theequal (
   .INVERT_OUTPUT(INVERT_OUTPUT),
   .hex (e ),
   .seg(HEX2)
);

endmodule // End of module