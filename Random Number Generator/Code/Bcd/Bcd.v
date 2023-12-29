module Bcd(
     input clk ,
	  input rst ,
	  input [7:0] R_n ,
     output reg [3:0] d_0 = 4'd0 , //The output is the single digit that needs to be displayed
     output reg [3:0] d_1 = 4'd0   //The output is the tens digit that needs to be displayed 
) ;
     integer i ;
	  reg [2:0] r;
	  
	  
	always @ (posedge clk)
   begin
    if (rst)                  //If rst is active it will reset
	  begin
	  d_0 <= 4'd0;
	  d_1 <= 4'd0;
	  end
	 else
	  begin
	  if(r == 0)
	   begin 
		 d_0 = 4'd0;
	    d_1 = 4'd0;
		 r <= 1;
		end
		 for (i=7;i>=0;i=i-1)
	    begin                    //add 3 to columns >=5
		  if(i==0)
		   r <= 0;
		  if(d_1 >=5)
		   d_1 = d_1 + 3;
		  if(d_0 >=5)
		   d_0 = d_0 + 3;
		 
		  d_1 = d_1 << 1;        //shift left one
		  d_1[0] = d_0[3];
		  d_0 = d_0 << 1;
		  d_0[0] = R_n[i];
		 end
	  end
	 end
endmodule

		 
		  
	  