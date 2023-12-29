/* 
*  In order to output 'Error' to 7-segment
*  Hexadecimal to 7-segment Encoder module declaration 
*/
module ErrorTo7Segment ( //Display the single digit on DE1 board
  input Error ,

  
  output reg [6:0] E,
  output reg [6:0] r0, 
  output reg [6:0] r1, 
  output reg [6:0] o, 
  output reg [6:0] r2  
 ) ;          
  
// When a bit in the output is high, the corresponding LED will be lit.
      always @(* ) begin          //when hex is active
        if (Error) begin
		         //gfedcba
          E = 7'b1111001;
          r0 = 7'b1010000;      // 0    Seg7
          r1 = 7'b1010000;      // 1    - a -
          o = 7'b1011100;       // 2   |     |
          r2 = 7'b1010000;      // 3   f     b
         end                    // 4   |     |
         else begin             // 5    - g -
          E = 7'b1000000;       // 6   |     |
          r0 = 7'b1000000;      // 7   e     c
          r1 = 7'b1000000;      // 8   |     |
          o = 7'b1000000;       // 9    - d -
          r2 = 7'b1000000; 
         end			 
      end
 endmodule  
