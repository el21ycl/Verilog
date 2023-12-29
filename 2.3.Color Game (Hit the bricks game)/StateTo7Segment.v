module StateTo7Segment ( //Display the single digit on DE1 board
  input [4:0] hex ,
  output reg [6:0] seg7
   
 ) ;          
  
// When a bit in the output is high, the corresponding LED will be lit.
      always @(* )             //when hex is active
      begin
          seg7 = 7'b0111111;
          case (hex )            //Assign value according to the value of A
			                          //gfedcba
             5'b000000000: seg7 = 7'b1000000; // 0    Seg7
             5'b000000001: seg7 = 7'b1111001; // 1    - a -
             5'b000000010: seg7 = 7'b0100100; // 2   |     |
             5'b000000011: seg7 = 7'b0110000; // 3   f     b
             5'b000000100: seg7 = 7'b0011001; // 4   |     |
             5'b000000101: seg7 = 7'b0010010; // 5    - g -
             5'b000000110: seg7 = 7'b0000010; // 6   |     |
             5'b000000111: seg7 = 7'b1111000; // 7   e     c
             5'b000001000: seg7 = 7'b0000000; // 8   |     |
             5'b000001001: seg7 = 7'b1101111; // 9    - d -
			    5'b000001010: seg7 = 7'b1110111; // A
				 5'b000001011: seg7 = 7'b1111100; // b
				 5'b000001100: seg7 = 7'b1011000; // c
				 5'b000001101: seg7 = 7'b1011110; // d
				 5'b000001111: seg7 = 7'b1111001; // E
				 5'b000010000: seg7 = 7'b1110001; // F
                  default: seg7 = 7'b0111111;
          endcase
      end
		
 endmodule  