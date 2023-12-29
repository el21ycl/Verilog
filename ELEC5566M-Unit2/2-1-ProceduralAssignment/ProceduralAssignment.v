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
module ProceduralAssignment;
// Test Bench Generated Signals
reg clock;
reg D;
// DUT Output Signals
wire Q1;
wire Q2;

// Device Under Test. Instance typically named "dut", or "ModuleName_dut".
NonBlockingExample NonBlockingExample_dut (
  .clock      ( clock      ),
  .D          ( D ),
  .Q1         ( Q1 ),
  .Q2         ( Q2 )
);

	always #10 clock =~clock;
	always #6 D =~D;
// Test Bench Logic
initial begin
   //Print to console that the simulation has started. $time is the current sim time.
   $display("%d ns\tSimulation Started",$time);  
   //Monitor changes to any values listed, and automatically print to the console 
   //when they change. There can only be one $monitor per simulation.
   $monitor("%d ns\t D=%d\t Q2=%d\t Q2=%d\t",$time,D,Q1,Q2);
	//Initialise reset and d to 0.
	clock = 1'b0;
   D = 1'b0;
   $display("%d ns\tSimulation Finished",$time); //Finished
   //There are no other processes running in this testbench, so "run -all" in 
   //ModelSim will finish the simulation automatically now.
   //We can also use $stop(); to finish the simulation whenever we want.
	# 400
	$stop;
end
endmodule
