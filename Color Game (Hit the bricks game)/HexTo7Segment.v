/* 
* Hexadecimal to 7-segment Encoder module declaration 
*/
module HexTo7Segment ( //Display the single digit on DE1 board
  input [7:0] hex ,
  output reg [6:0] seg7
   
 ) ;          
  
// When a bit in the output is high, the corresponding LED will be lit.
      always @(* )             //when hex is active
      begin
          seg7 = 7'b0111111;
          case (hex )            //Assign value according to the value of A
			                          //gfedcba
             8'b00000000: seg7 = 7'b1000000; // 0    Seg7
             8'b00000001: seg7 = 7'b1111001; // 1    - a -
             8'b00000010: seg7 = 7'b0100100; // 2   |     |
             8'b00000011: seg7 = 7'b0110000; // 3   f     b
             8'b00000100: seg7 = 7'b0011001; // 4   |     |
             8'b00000101: seg7 = 7'b0010010; // 5    - g -
             8'b00000110: seg7 = 7'b0000010; // 6   |     |
             8'b00000111: seg7 = 7'b1111000; // 7   e     c
             8'b00001000: seg7 = 7'b0000000; // 8   |     |
             8'b00001001: seg7 = 7'b0010000; // 9    - d -
			    8'b00001010: seg7 = 7'b1110111; // A
				 8'b00001011: seg7 = 7'b1111100; // b
				 8'b00001100: seg7 = 7'b1011000; // c
				 8'b00001101: seg7 = 7'b1011110; // d
				 8'b00001110: seg7 = 7'b1111001; // E
				 8'b00001111: seg7 = 7'b1110001; // F
                  default: seg7 = 7'b0111111;
          endcase
      end
		
 endmodule  