module Time #(
   parameter N = 4    //Number of bits in Key (default 4)
)(
     input clock ,
	  input reset ,
	  input [N-1:0] key ,              //Button level signal
     output reg t = 1'b0      //Whether to start timing
  
) ;
	  reg [31:0] Y = 32'd0 ;       //Record the number of seconds the key is pressed
	  
	  
// Display time of xx seconds
 always @ (posedge clock) begin    //clk was choose 1ns
   if (reset) begin                 //If rst is active it will reset
	  Y <= 4'd0;
	  t <= 1'b0;
	 end
   if (key) begin            //start timing
	   t <= 1'b0;           
      Y <= 4'd0;
	end
	else if (Y >= 32'd15)  begin //Counting to  15ns
     Y <= 4'd0;
	  t <= 1'b1;             //Stop timing
	end
	else begin
	   Y <= Y + 1'b1;
	end
  end	

endmodule
