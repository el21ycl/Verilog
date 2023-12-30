module control (
      input clk,
		input rst,
		input Key_2 ,
	   input Key_0 ,
	   output [6:0] hex4 , //that is a count for single digits
	   output [6:0] hex5   //that is a count for tens digits
) ;

      wire [3:0] cnt_0;         //Controller connection counter output
		wire [3:0] cnt_1;
		
		
		// Instantiate the module
		count countinst (
		  .clk          (clk),         //Used to connect clk
		  .rst          (rst),         //Used to connect rst
		  .Key_2        (Key_2),       //Used to connect input K2
		  .Key_0        (Key_0),       //Used to connect input K0
		  .cnt_0        (cnt_0),       //Used to connect output c0
		  .cnt_1        (cnt_1)        //Used to connect output c1
		);
		
		
		// Instantiate the module
		Bcd7seg_1 Bcd7seg_1inst_1 (
		   .B (cnt_1), //Connect the output of the counter to the input of 7 segments
			.hex5 (hex5)//Used to connect output hex5
		);
		
		// Instantiate the module
		Bcd7seg_0 Bcd7seg_0inst_0 (
		   .A (cnt_0), //Connect the output of the counter to the input of 7 segments
			.hex4 (hex4)//Used to connect output hex4
		);	
endmodule 