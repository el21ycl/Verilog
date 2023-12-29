module NBitAdder_Subtractor (
    // Declare input and output ports
	 (*chip_pin = "AD10"*)
    input        cin,
	 (*chip_pin = "AF10, AF9, AC12, AB12"*)
    input  [3:0] a,
	 (*chip_pin = "AC9, AE11, AD12, AD11"*)
	 input  [3:0] b,
	 (*chip_pin = "AE12"*)
	 input        enable,
	 input  [3:0] hex,
	 (*chip_pin = "AA25, AA26, AB26, AB27, Y27, AA28, V25"*)
	 output [6:0] HEX5,
	 (*chip_pin = "W25, V23, W24, W22, Y24, Y23, AA24"*)
	 output [6:0] HEX4,
	 (*chip_pin = "AB22, AB25, AB28, AC25, AD25, AC27, AD26"*)
	 output [6:0] HEX3,
	 (*chip_pin = "AC30, AC29, AD30, AC28, AD29, AE29, AB23"*)
	 output [6:0] HEX2,
	 (*chip_pin = "AD27, AF30, AF29, AG30, AH30, AH29, AJ29"*)
	 output [6:0] HEX1,
	 (*chip_pin = "AH28, AG28, AF28, AG27, AE28, AE27, AE26"*)
	 output [6:0] HEX0,
	 (*chip_pin = "V18, V17, W16, V16"*)
    output [3:0] sum,
	 (*chip_pin = "W17"*)
    output       cout
);
reg e;
reg [3:0] b2;

 always @(*) begin
   e <= 0;
	if(enable == 1)begin
	  b2 <= ~b + 1;
	end
	else if(enable==0)begin
	  b2 <= b;
	end
end
 
AdderNBit theAdder (
   .cin (cin ),
   .a   (a   ),
   .b   (b2  ),
   .sum (sum ),
   .cout(cout)
);

HexTo7Segment thea (
   .hex (a ),
   .seg(HEX5)
);

HexTo7Segment theb (
	.hex (b2 ),
   .seg(HEX4)
);

HexTo7Segment thesum (
	.hex (sum ),
   .seg(HEX0)
);

HexTo7Segment thecin (
	.hex (cin ),
   .seg(HEX3)
);

HexTo7Segment thecout (
	.hex (cout ),
   .seg(HEX1)
);

HexTo7Segment theequal (
   .hex (e ),
   .seg(HEX2)
);

endmodule // End of module