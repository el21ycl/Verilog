module Random (R_b,R,clk,rst,start);
  parameter  Length = 8;
  parameter  initial_state = 8'b1000_1001;
  parameter  [Length-1:0]  Tap_Coefficient = 8'b1111_0011;
  
  input clk, rst,start;
  output reg [Length-1:0] R = 8'b1000_1001;
  output reg [7:0] R_b = 8'd0 ; 
  
  // Random number generation module   
  always @ (posedge clk)
    if (rst)                  //If rst is active it will reset
	   begin
	   R <= initial_state;
		end
	 else                      //Generate a random number
	   begin
		  R[0] <= R[7];
		  R[1] <= Tap_Coefficient[1] ? R[0] ^ R[7] : R[0];
		  R[2] <= Tap_Coefficient[2] ? R[1] ^ R[7] : R[1];
		  R[3] <= Tap_Coefficient[3] ? R[2] ^ R[7] : R[2];
		  R[4] <= Tap_Coefficient[4] ? R[3] ^ R[7] : R[3];
		  R[5] <= Tap_Coefficient[5] ? R[4] ^ R[7] : R[4];
		  R[6] <= Tap_Coefficient[6] ? R[5] ^ R[7] : R[5];
		  R[7] <= Tap_Coefficient[7] ? R[6] ^ R[7] : R[6];
		end	
	
	  
// Condition of display		
  always @ (posedge clk)
   begin
    if (rst)                  //If rst is active it will reset
	   begin
		 R_b <= 1'd0;
		end
	 else if	(start)
	  begin
	  if(R[7:0] > 8'd0 && R[7:0] <= 8'd73 )
	   begin                    //Filter random numbers[1-73]
	    R_b <=  R[7:0];
		end
	  end
	 else
	  R_b <= 1'd0;
   end

endmodule 