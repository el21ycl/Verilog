/* 
* Display of keys on a 7-segment display
* Hexadecimal to 7-segment Encoder module declaration 
*/
module KeyTo7Segment ( //Display the single digit on DE1 board
  input [3:0] key ,

  
  output reg [6:0] button
 ) ;          
  
// When a bit in the output is high, the corresponding LED will be lit.
      always @(*)             //when hex is active
      begin
          button = 7'b1000000;
          case (key)            //Assign value according to the value of A
			                          //gfedcba
                  4'b0001: button = 7'b0111111; // 0    Seg7
                  4'b0010: button = 7'b0000110; // 1    - a -
                  4'b0100: button = 7'b1011011; // 2   |     |
                  4'b1000: button = 7'b1001111; // 3   f     b
                                                // 4   |     |
                                                // 5    - g -
                                                // 6   |     |
                                                // 7   e     c
                                                // 8   |     |
                                                // 9    - d -
                  default: button = 7'b1000000;
          endcase
      end
 endmodule  
