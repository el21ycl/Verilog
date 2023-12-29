module Bcd7seg_1 (        //Display the single digit on HEX5 of DE2 board
  input [3:0] B ,

  
  output reg [6:0] hex5  //Display the digit on HEX5
 ) ;          
  
      always @(B )              //when B is active
      begin
          hex5 = 7'b1111111;
          case (B )             //Assign value according to the value of B
			                          //gfedcba
                  4'b0000: hex5 = 7'b1000000; // 0    HEX5
                  4'b0001: hex5 = 7'b1111001; // 1    - a -
                  4'b0010: hex5 = 7'b0100100; // 2   |     |
                  4'b0011: hex5 = 7'b0110000; // 3   f     b
                  4'b0100: hex5 = 7'b0011001; // 4   |     |
                  4'b0101: hex5 = 7'b0010010; // 5    - g -
                  4'b0110: hex5 = 7'b0000010; // 6   |     |
                  4'b0111: hex5 = 7'b1111000; // 7   e     c
                  4'b1000: hex5 = 7'b0000000; // 8   |     |
                  4'b1001: hex5 = 7'b0010000; // 9    - d -
                  default: hex5 = 7'b0000000;
          endcase
      end
 endmodule  