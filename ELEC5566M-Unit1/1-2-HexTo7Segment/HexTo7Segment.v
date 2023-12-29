/* 
* Hexadecimal to 7-segment Encoder module declaration 
*/
module HexTo7Segment ( //Display the single digit on DE1 board
  input [3:0] hex ,

  
  output reg [6:0] seg7  
 ) ;          
  
// When a bit in the output is high, the corresponding LED will be lit.
      always @(hex )             //when hex is active
      begin
          seg7 = 7'b1000000;
          case (hex )            //Assign value according to the value of A
			                          //gfedcba
                  4'b0000: seg7 = 7'b0111111; // 0    Seg7
                  4'b0001: seg7 = 7'b0000110; // 1    - a -
                  4'b0010: seg7 = 7'b1011011; // 2   |     |
                  4'b0011: seg7 = 7'b1001111; // 3   f     b
                  4'b0100: seg7 = 7'b1100110; // 4   |     |
                  4'b0101: seg7 = 7'b1101101; // 5    - g -
                  4'b0110: seg7 = 7'b1111101; // 6   |     |
                  4'b0111: seg7 = 7'b0000111; // 7   e     c
                  4'b1000: seg7 = 7'b1111111; // 8   |     |
                  4'b1001: seg7 = 7'b1101111; // 9    - d -
                  default: seg7 = 7'b1000000;
          endcase
      end
 endmodule  
