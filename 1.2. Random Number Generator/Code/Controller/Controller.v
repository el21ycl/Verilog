module Controller (
      input clk,           //clock will choose 50M Hz
		input rst,
		input Key_2 ,        //Button level signal
	   input Key_0 ,        //Button level signal
	   output [6:0] hex4 ,  //that is a random for single digits
	   output [6:0] hex5    //that is a random for tens digits
) ;
      wire [2:0] start;
      wire [7:0] R_b;
		wire [3:0] Z;
		wire [2:0] t;
		wire [7:0] R_n;
      wire [3:0] d_0;         //Controller connection Bcd output
		wire [3:0] d_1;
  // Start module
		Key Keyinst (
		  .clk          (clk),         //Used to connect clk
		  .rst          (rst),         //Used to connect rst
		  .Key_2        (Key_2),       //Used to connect input Key_2
		  .Key_0        (Key_0),       //Used to connect input Key_0
		  .start        (start),       //Used to connect output start
		  .Z            (Z)           //Used to connect output Z
		);
		
  // Timing module
		Time Timeinst (
		  .clk          (clk),         //Used to connect clk
		  .rst          (rst),         //Used to connect rst
		  .Key_0        (Key_0),       //Used to connect input Key_0
		  .t            (t)            //Used to connect output t
		);

  // Random module
		Random Randominst (
		  .clk          (clk),         //Used to connect clk
		  .rst          (rst),         //Used to connect rst
		  .start        (start),       //Used to connect input start
		  .R            (R),           //Used to connect output R
		  .R_b          (R_b)          //Used to connect output R_b
		);   

  //Number module
		Number Numberinst (
		  .clk          (clk),         //Used to connect clk
		  .rst          (rst),         //Used to connect rst
		  .t            (t),           //Used to connect input t
		  .Z            (Z),           //Used to connect input Z
		  .R_b          (R_b),         //Used to connect input R_b
		  .R_n          (R_n)          //Used to connect output R_n
		);   
		
  // Binary to Bcd module
		Bcd Bcdinst (
		  .clk          (clk),         //Used to connect clk
		  .rst          (rst),         //Used to connect rst
		  .R_n          (R_n),         //Used to connect input R_b
		  .d_0          (d_0),         //Used to connect output d_0
		  .d_1          (d_1)          //Used to connect output d_1
		);

  // 7 segment tens module
		Bcd7seg_1 Bcd7seg_1inst_1 (
		   .B (d_1), //Connect the output of the counter to the input of 7 segments
			.hex5 (hex5)//Used to connect output hex5
		);
		
	// 7 segment ones module
		Bcd7seg_0 Bcd7seg_0inst_0 (
		   .A (d_0), //Connect the output of the counter to the input of 7 segments
			.hex4 (hex4)//Used to connect output hex4
		);
		
endmodule 