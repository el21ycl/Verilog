module Time(
     input clk ,
	  input rst ,
	  input Key_0 ,              //Button level signal
     output reg t = 1'd0        //Whether to start timing
  
) ;
	  reg [31:0] Y = 32'd0 ;       //Record the number of seconds the Key_0 is pressed
	  
	  
// Display time of 4 seconds
 always @ (posedge clk)      //clk was choose 50Mhz
  begin
   if (rst)                  //If rst is active it will reset
	 begin
	  Y <= 4'd0;
	  t <= 1'd0;
	 end
	else if (Y >= 32'd4) //Counting to  200M times equal 4s
	  begin
	  Y <= 4'd0;
	  t <= 1'd0;             //Stop timing
	  end
	else if (Key_0)
	   t <= 1'd1;           //start timing
	else if (t == 1'd1)
	  begin
	   Y <= Y + 1'd1;
	  end
  end	
endmodule
