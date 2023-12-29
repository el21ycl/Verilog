//                                                             /*!\notex{
// 8-Bit Comparator Test Bench
// ---------------------------
// By: Thomas Carpenter
// For: University of Leeds
// Date: 29th December 2017 
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
module DFlipFlop_tb;
// Test Bench Generated Signals
reg clock;
reg reset;
reg d;
// DUT Output Signals
wire q;

// Device Under Test. Instance typically named "dut", or "ModuleName_dut".
DFlipFlopWithAclr DFlipFlopWithAclr_dut (
  .clock      ( clock      ),
  .reset      ( reset      ),
  .d          ( d ),
  .q          ( q )
);

	always #10 clock =~clock;
	always #6 d =~d;
// Test Bench Logic
initial begin
   //Print to console that the simulation has started. $time is the current sim time.
   $display("%d ns\tSimulation Started",$time);  
   //Monitor changes to any values listed, and automatically print to the console 
   //when they change. There can only be one $monitor per simulation.
   $monitor("%d ns\t reset=%d\t d=%d\t q=%d\t",$time,reset,d,q);
	//Initialise reset and d to 0.
	clock = 1'b0;
   reset = 1'b1;
   d = 1'b0;
   #30; //Wait 10 units.
   reset = 1'b0;
   $display("%d ns\tSimulation Finished",$time); //Finished
   //There are no other processes running in this testbench, so "run -all" in 
   //ModelSim will finish the simulation automatically now.
   //We can also use $stop(); to finish the simulation whenever we want.
	# 400
	$stop;
end
endmodule
