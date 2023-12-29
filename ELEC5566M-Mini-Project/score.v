/* 
*  In order to output score
*  
*/

module score (
  input  score,                 // start to record the score
  input  r,                     // switch for reset the Highest score
  input  clock,
  input  reset,
  output reg [7:0] one,        //ones 
  output reg [7:0] ten,        //Tens
  output reg [7:0] High_one,   //ones 
  output reg [7:0] High_ten    //Tens
);


always @(posedge score or negedge reset) begin
    if (!reset)begin
	   one     <= {(32){1'b0}};
	   ten     <= {(32){1'b0}};
	 end
	 else begin
		// record the ones
		 if (one == 9)begin
		   ten <= ten + 1'b1;
		    one <= 1'b0;
		  end
		  else begin
		   one <= one + 1'b1;
			ten <= ten;
		  end
    end
  end

// Highest record 
 always @(posedge clock) begin
       if (r) begin
		   High_one     <= {(32){1'b0}};
	      High_ten     <= {(32){1'b0}};
		 end
       else if ((ten == High_ten) && (one >= High_one)) begin
	          High_ten <= ten;
				 High_one <= one;
		 end
		 else if (ten > High_ten) begin
		       High_ten <= ten;
				 High_one <= one;
		 end
		 else begin
		       High_ten <= High_ten;
				 High_one <= High_one;
		 end
end

endmodule
