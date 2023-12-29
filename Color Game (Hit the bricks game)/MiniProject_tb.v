//                                                             /*!\notex{
// MiniProject Test Bench
// ---------------------------
// By: Thomas Carpenter
// For: University of Leeds
// Date: 19th May 2022 
//
// Short Description
// -----------------
// This is a simple test bench module to test the 8-Bit Comparator.
// module with a few stimulii.
//


//                                                             }!*/
// Timescale indicates unit of delays.
//  `timescale  unit / precision
// Where delays are given as:
//   #unit.precision                                           /*!\notex{
//
// Let's stick with a "unit" of 1ns. You may choose the "precision".
//
// e.g for `timescale 1ns/100ps then:
//   #1 = 1ns
//   #1.5 = 1.5ns
//   #1.25 = 1.3ns (rounded to nearest precision)
//                                                             }!*/
`timescale 1 ns/100 ps
// Test bench module declaration
// Always end test bench module names with _tb for clarity, and use no port list
module MiniProject_tb;
// Test Bench Generated Signals
reg clock;
reg reset;
reg key_R;
reg key_G;
reg key_B;
reg Switch;
reg r;
// DUT Output Signals
wire start;
wire P;
wire G;

// Device Under Test. Instance typically named "dut", or "ModuleName_dut".
MiniProject MiniProject_dut (
  .clock      ( clock      ),
  .reset      ( reset      ),
  .key_R      ( key_R      ),
  .key_G      ( key_G      ),
  .key_B      ( key_B      ),
  .r          ( r          ),
  .Switch     ( Switch     ),
  .start      ( start      ),
  .P          ( P          ),
  .G          ( G          ) 
  
);

wire score;
wire [4:0] state_c;

LT24 LT24_dut(
        .start        (start    ),
        .P            (P        ),
		  .key_R        (key_R    ),// button_R    ),
		  .key_G        (key_G    ),// button_G    ),
		  .key_B        (key_B    ),// button_B    ),
        .clock        (clock    ),
		  .score        (score       ),
		  .state_c      (state_c     )
	 );
	 
wire [7:0] count_one;
wire [7:0] count_ten;
 
Timer #(
        .Time (50_000_000),    // The number of times required to change 50MHz to 1 second
	     .ones (5),
	     .tens (1)
) Timer_dut(
        .start   (start ),
		  .Switch  (Switch),
        .clock   (clock ),
		  .reset   (reset ),
		  .count_ten  (count_ten ),
		  .count_one  (count_one )
	 );	 
wire [7:0] one;
wire [7:0] ten;
wire [7:0] High_one;
wire [7:0] High_ten;

score Therecord_dut(
        .score   (score     ),
		  .r       (r         ),
		  .clock   (clock     ),
		  .reset   (reset     ),
		  .one     (one       ),
		  .ten     (ten       ),
		  .High_one (High_one ),
		  .High_ten (High_ten )
	 );

// 50MHz = 0.02 x 10^-6 s = 20 ns
	always #20 clock =~clock;
// Test Bench Logic
initial begin
   //Print to console that the simulation has started. $time is the current sim time.
   $display("%d ns\tSimulation Started",$time);  
   //Monitor changes to any values listed, and automatically print to the console 
   //when they change. There can only be one $monitor per simulation.
   $monitor("%d ns\t reset=%d\t key_R=%d\t key_G=%d\t key_B=%d\t r=%d\t Switch=%d\t start=%d\t P=%d\t G=%d\t",$time,reset,key_R,key_G,key_B,r,Switch,start,P,G);
	$monitor("%d ns\t score=%d\t state_c=%d\t ",$time,score,state_c);
	$monitor("%d ns\t count_ten=%d\t count_one=%d\t ",$time,count_ten,count_one);
	$monitor("%d ns\t ten=%d\t one=%d\t High_ten=%d\t High_one=%d\t",$time,ten,one,High_ten,High_one);
	//Initialise reset and d to 0.
	clock = 1'b0;
   reset = 1'b1;   //key0
   key_R = 1'b0;
	key_G = 1'b0;
	key_B = 1'b0;
	r = 1'b0;
	Switch = 1'b0;
   #60; //Wait 3 units.
   reset = 1'b0;
	#60; //Wait 3 units
	Switch = 1'b1;
	#60; //Wait 3 units
	@(posedge clock); //At the rising edge of the clock
   key_R = 1'b0;
	key_G = 1'b0;
	key_B = 1'b1;    // key1
	@(posedge clock); //At the rising edge of the clock
   key_R = 1'b0;     // key3
	key_G = 1'b1;
	key_B = 1'b0;    // key1
	@(posedge clock); //At the rising edge of the clock
   key_R = 1'b1;     // key3
	key_G = 1'b0;   //key2
	key_B = 1'b0;    // key1
	@(posedge clock); //At the rising edge of the clock
   key_R = 1'b0;     // key3
	key_G = 1'b0;   //key2
	key_B = 1'b1;    // key1
	@(posedge clock); //At the rising edge of the clock
   key_R = 1'b0;     // key3
	key_G = 1'b1;   //key2
	key_B = 1'b0;    // key1
	@(posedge clock); //At the rising edge of the clock
   key_R = 1'b1;     // key3
	key_G = 1'b0;   //key2
	key_B = 1'b0;    // key1
	@(posedge clock); //At the rising edge of the clock
   key_R = 1'b0;     // key3
	key_G = 1'b0;   //key2
	key_B = 1'b1;    // key1
	@(posedge clock); //At the rising edge of the clock
   key_R = 1'b0;     // key3
	key_G = 1'b1;   //key2
	key_B = 1'b0;    // key1
	@(posedge clock); //At the rising edge of the clock
   key_R = 1'b1;     // key3
	key_G = 1'b0;   //key2
	key_B = 1'b0;    // key1
   $display("%d ns\tSimulation Finished",$time); //Finished
   //There are no other processes running in this testbench, so "run -all" in 
   //ModelSim will finish the simulation automatically now.
   //We can also use $stop(); to finish the simulation whenever we want.
	# 3200
	$stop;
end
endmodule
