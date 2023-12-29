/* 
*  In order to output 'o&x' to 7-segment
*  Hexadecimal to 7-segment Encoder module declaration 
*/
module Segment7_ox ( //Display the single digit on DE1 board
  input o ,
  input x ,
  output reg [6:0] Hex5,
  output reg [6:0] Hex4,  
  output reg [6:0] Hex2,
  output reg [6:0] Hex0  
 ) ;          
  
// When a bit in the output is high, the corresponding LED will be lit.
      always @(* ) begin          //when hex is active
        if (o) begin
		            //gfedcba     // 0 is acticve
          Hex0 = 7'b0111111;
			 Hex2 = 7'b0100011;    // o
          Hex4 = 7'b1111001;    // 1    Seg7
          Hex5 = 7'b0001100;    // P    - a -
                                //     |     |
                                //     f     b
         end                    //     |     |
                                //      - g -
                                //     |     |
                                //     e     c
                                //     |     |
                                //      - d -
         else if (x) begin
     		 Hex0 = 7'b0001001;    //X
			 Hex2 = 7'b0111111;
			 Hex4 = 7'b0100100;    //2
			 Hex5 = 7'b0001100;    //P
			end
			else begin
			 Hex0 = 7'b0111111;
			 Hex2 = 7'b0111111;
			 Hex4 = 7'b0111111;
			 Hex5 = 7'b0111111;
			end
      end
 endmodule  