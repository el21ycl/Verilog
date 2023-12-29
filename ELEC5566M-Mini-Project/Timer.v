/* 
*  In order to output 1 second countdown timer
*  
*/
// 50MHz = 0.02 x 10^-6 s = 20 ns
module Timer #(
// 20ns x 50_000_000 = 1s
   parameter Time = 50_000_000,    // The number of times required to change 50MHz to 1 second
	parameter ones = 0,
	parameter tens = 2
)(
  input  start,                    // start the game
  input  Switch,
  input  clock,
  input  reset,
  output reg [7:0] count_one,        //ones 
  output reg [7:0] count_ten         //Tens

);

reg [32:0] m;

always @(posedge clock or negedge reset) begin
    if (!reset)begin
	   m     <= {(32){1'b0}};
	   count_one <= ones;
		count_ten <= tens;
	 end
	 else if (start) begin
     if (m == Time) begin    // Reaching 1 second
	      m     <= {(32){1'b0}};
	//	Single digit countdown timer
		  if (count_one == 0) begin
		    count_one     <= 9;
	  // Ten digit countdown timer
           if (count_ten == 0) begin
		       count_ten     <= 0;
		     end
		     else begin
		       count_ten <= count_ten - 1'b1;
           end
		   end
		   else begin
		     count_one <= count_one - 1'b1;
         end
	  end
	  else begin
	   m     <= m + 1'b1;
	  end
   end
  end
endmodule
