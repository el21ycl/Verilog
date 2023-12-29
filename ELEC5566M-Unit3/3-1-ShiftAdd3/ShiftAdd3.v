module ShiftAdd3 (
    // Declare input and output ports
	 (*chip_pin = "AF14"*)
	 inout        clock,
	 (*chip_pin = "AC9, AE11, AD12, AD11, AF10, AF9, AC12, AB12"*)
    input  [7:0] a,
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
    output reg [7:0] BCD
);
reg [15:0] T;
reg [3:0] Units;
reg [3:0] Tens;
reg e;
integer i;

 always @(posedge clock ) begin
   e <= 0;
	for(i=0; i<16; i=i+1)begin
	 T[i] = 1'b0;
	end
	T[10:3] = a;
	for (i=0; i<5; i=i+1)begin
	  if (T[11:8] > 4) begin
	    T[11:8] = T[11:8] + 4'b0011;
	  end
	  if (T[15:12] > 4) begin
	    T[15:12] = T[15:12] + 4'b0011;
	  end
	  T = T<<1;
	end
	BCD <= T[15:8];
	Units = T[11:8];
	Tens = T[15:12];
end
 


HexTo7Segment theten (
	.hex (Tens ),
   .seg(HEX1)
);

HexTo7Segment theunit (
	.hex (Units ),
   .seg(HEX0)
);


HexTo7Segment theequal (
   .hex (e ),
   .seg(HEX2)
);

endmodule // End of module