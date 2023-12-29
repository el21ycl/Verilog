module Key(
     input clk ,
	  input rst ,
	  input Key_2 ,              //Button level signal
	  input Key_0 ,              //Button level signal
     output reg start = 1'd0 ,    //Record whether the Key_2 is pressed
  	  output reg [3:0] Z = 4'd0       //Record the number of times the Key_0 is pressed
) ;



// Count the number of keystrokes
   always@(posedge clk )
	  begin                                     
	    if(rst)                      //If rst is active it will reset
		    begin
			 start <= 1'd0;
			 Z <= 4'd0;
			 end
		 else if(Key_2 || Key_0)    //If Key _2 or Key_0 is pressed count will active
		 begin
		  if(Key_2)
		   start <= 1'd1;
		  else if(Key_0)  
		    begin
			   if(Z== 4'd3)  //It returns to 0 when the Key_0 is pressed the fourth time
			     begin
				  Z <= 4'd0;
				  start <= 1'd0;
				  end
			   else 
			     begin
				  Z <= Z + 1'd1;       //Press at least 4 times
				  end
			 end
		 end  
	  end
endmodule 