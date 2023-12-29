module BCDDigitAddition (
    // Declare input and output ports
	(*chip_pin = "AD10"*)
    input        cin,
	 (*chip_pin = "AF10, AF9, AC12, AB12"*)
    input  [3:0] a,
	 (*chip_pin = "AC9, AE11, AD12, AD11"*)
	 input  [3:0] b,
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
reg [3:0] BCDa;
reg [3:0] BCDb;
reg [3:0] BCDsum;
reg BCDcout;

 always @(*) begin
   e <= 0;
	if(a > 9) begin
	BCDa = a + 6;
	end
	else begin
	BCDa = a;
	end
	
	if(b > 9) begin
	BCDb = b + 6;
	end
	else begin
	BCDb = b;
	end
	
   if((sum > 9) || (cout ==1)) begin
	BCDsum = sum + 4'b0110;
	BCDcout = 1;
	end
	else begin
	BCDsum = sum;
	BCDcout = 0;
	end
end
 
AdderNBit theAdder (
   .cin (cin ),
   .a   (BCDa   ),
   .b   (BCDb   ),
   .sum (sum ),
   .cout(cout)
);

HexTo7Segment thea (
   .hex (BCDa ),
   .seg(HEX5)
);

HexTo7Segment theb (
	.hex (BCDb  ),
   .seg(HEX4)
);

HexTo7Segment thesum (
	.hex (BCDsum ),
   .seg(HEX0)
);

HexTo7Segment thecin (
	.hex (cin ),
   .seg(HEX3)
);

HexTo7Segment thecout (
	.hex (BCDcout ),
   .seg(HEX1)
);

HexTo7Segment theequal (
   .hex (e ),
   .seg(HEX2)
);

endmodule // End of module